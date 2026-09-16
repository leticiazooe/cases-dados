from pathlib import Path
import json, sqlite3, unicodedata, re
import pandas as pd

BASE=Path(__file__).resolve().parents[1]
RAW=BASE/'dados_brutos'; OUT=BASE/'dados_tratados_pipeline'; REJ=BASE/'dados_rejeitados'
OUT.mkdir(exist_ok=True); REJ.mkdir(exist_ok=True)
cfg=json.loads((BASE/'src/manifesto_pipeline.json').read_text(encoding='utf-8'))
frames={}; audit=[]

def clean_text(v):
    if pd.isna(v): return v
    return re.sub(r'\s+',' ',str(v)).strip()

for table,rule in cfg['tables'].items():
    df=pd.read_csv(RAW/f'{table}.csv',sep=';',decimal=',',low_memory=False)
    initial=len(df); reasons=pd.Series('',index=df.index,dtype='object')
    df.columns=df.columns.str.strip()
    for c in rule['numeric_columns']:
        if c in df: df[c]=pd.to_numeric(df[c],errors='coerce')
    for c in rule['date_columns']:
        if c in df:
            original=df[c].copy(); df[c]=pd.to_datetime(df[c],errors='coerce',format='mixed',dayfirst=True)
            reasons=reasons.mask(original.notna() & df[c].isna(),reasons+'|data_invalida:'+c)
    for c in df.select_dtypes(include='object').columns:
        if c not in rule['date_columns']: df[c]=df[c].map(clean_text)
    pk=rule['primary_key']; dup=df.duplicated(pk,keep='first'); reasons=reasons.mask(dup,reasons+'|pk_duplicada')
    for c in rule['required_columns']:
        if c in df: reasons=reasons.mask(df[c].isna() | (df[c].astype(str).str.strip()==''),reasons+'|obrigatorio:'+c)
    for c in rule['nonnegative_columns']:
        if c in df: reasons=reasons.mask(df[c].notna() & (df[c]<0),reasons+'|negativo:'+c)
    rejected=df[reasons!=''].copy(); rejected['motivo_rejeicao']=reasons[reasons!=''].str.strip('|')
    clean=df[reasons==''].copy()
    frames[table]=clean
    rejected.to_csv(REJ/f'{table}_rejeitados.csv',index=False)
    audit.append({'tabela':table,'brutas':initial,'tratadas_pre_fk':len(clean),'rejeitadas':len(rejected),'duplicadas':int(dup.sum())})

# Integridade referencial em segunda passagem
for table,rule in cfg['tables'].items():
    df=frames[table]; invalid=pd.Series(False,index=df.index); detail=pd.Series('',index=df.index,dtype='object')
    for fk in rule['foreign_keys']:
        parents=set(frames[fk['parent_table']][fk['parent_column']].dropna())
        bad=df[fk['column']].notna() & ~df[fk['column']].isin(parents)
        invalid|=bad; detail=detail.mask(bad,detail+'|fk_invalida:'+fk['column'])
    if invalid.any():
        rej=df[invalid].copy(); rej['motivo_rejeicao']=detail[invalid].str.strip('|')
        rej.to_csv(REJ/f'{table}_rejeitados_fk.csv',index=False)
        df=df[~invalid].copy()
    frames[table]=df

db=BASE/'dados_tratados_pipeline.sqlite'
if db.exists(): db.unlink()
con=sqlite3.connect(db)
for table,df in frames.items():
    export=df.copy()
    for c in cfg['tables'][table]['date_columns']:
        if c in export: export[c]=export[c].dt.strftime('%Y-%m-%d')
    export.to_csv(OUT/f'{table}.csv',index=False)
    export.to_sql(table,con,index=False)
con.close()
for row in audit:
    table=row['tabela']; row['tratadas_finais']=len(frames[table]); row['esperadas']=cfg['tables'][table]['expected_rows']; row['reconciliado']=len(frames[table])==row['esperadas']
pd.DataFrame(audit).to_csv(BASE/'documentacao_pipeline/relatorio_execucao_pipeline.csv',index=False)
if not all(x['reconciliado'] for x in audit): raise SystemExit('Falha de reconciliacao; consulte o relatorio.')
print(pd.DataFrame(audit).to_string(index=False))
