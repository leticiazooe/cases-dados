from pathlib import Path
import pandas as pd

BASE=Path(__file__).resolve().parents[1]
raw=pd.read_csv(BASE/'dados_brutos/vendas_brutas.csv',sep=';',decimal=',')
raw.columns=raw.columns.str.strip().str.lower()
raw['data_pedido']=pd.to_datetime(raw['data_pedido'],dayfirst=True,errors='coerce')
raw['status']=raw['status'].astype(str).str.strip().str.title()
clean=(raw.drop_duplicates('pedido_id').query('quantidade > 0').dropna(subset=['cliente_id','data_pedido']))
clean['margem']=clean['receita_liquida']-clean['custo_total']
clean['margem_pct']=clean['margem']/clean['receita_liquida'].replace(0,pd.NA)
clean.to_csv(BASE/'dados_tratados/fato_vendas_reprocessada.csv',index=False)
print({'brutas':len(raw),'tratadas':len(clean),'duplicadas':raw.duplicated('pedido_id').sum()})
