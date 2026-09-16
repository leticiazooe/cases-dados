from pathlib import Path
import json, sqlite3, pandas as pd
BASE=Path(__file__).resolve().parents[1]; RAW=BASE/'dados_brutos'; OUT=BASE/'dados_tratados_pipeline'; REJ=BASE/'dados_rejeitados'
OUT.mkdir(exist_ok=True); REJ.mkdir(exist_ok=True); cfg=json.loads((BASE/'src/manifesto.json').read_text(encoding='utf-8')); frames={}; audit=[]
for table,r in cfg['tables'].items():
 d=pd.read_csv(RAW/f'{table}.csv',sep=';',decimal=',',low_memory=False); initial=len(d); reason=pd.Series('',index=d.index,dtype='object')
 for c in d.select_dtypes(include='object'): d[c]=d[c].map(lambda x:' '.join(str(x).split()) if pd.notna(x) else x)
 for c in r['numeric']: d[c]=pd.to_numeric(d[c],errors='coerce')
 for c in r['dates']:
  old=d[c].copy(); d[c]=pd.to_datetime(d[c],errors='coerce',format='mixed',dayfirst=True); reason=reason.mask(old.notna()&d[c].isna(),reason+'|data_invalida:'+c)
 dup=d.duplicated(r['pk'],keep='first'); reason=reason.mask(dup,reason+'|pk_duplicada')
 reason=reason.mask(d[r['pk']].isna(),reason+'|pk_nula')
 for c in r['nonnegative']: reason=reason.mask(d[c].notna()&(d[c]<0),reason+'|valor_negativo:'+c)
 bad=d[reason!=''].copy(); bad['motivo_rejeicao']=reason[reason!=''].str.strip('|'); bad.to_csv(REJ/f'{table}_rejeitados.csv',index=False)
 clean=d[reason==''].copy(); frames[table]=clean; audit.append({'tabela':table,'brutas':initial,'tratadas':len(clean),'rejeitadas':len(bad),'esperadas':r['expected']})
db=BASE/'dados_tratados_pipeline.sqlite'; db.unlink(missing_ok=True); con=sqlite3.connect(db)
for t,d in frames.items():
 for c in cfg['tables'][t]['dates']: d[c]=d[c].dt.strftime('%Y-%m-%d')
 d.to_csv(OUT/f'{t}.csv',index=False); d.to_sql(t,con,index=False)
con.close(); a=pd.DataFrame(audit); a['reconciliado']=a.tratadas==a.esperadas; a.to_csv(BASE/'documentacao/relatorio_pipeline.csv',index=False)
if not a.reconciliado.all(): raise SystemExit('Falha de reconciliacao')
print(a.to_string(index=False))
