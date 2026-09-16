from pathlib import Path
import pandas as pd

ROOT = Path(__file__).resolve().parents[1]
RAW = ROOT / "dados_brutos"
OUT = ROOT / "dados_tratados_pipeline"
OUT.mkdir(exist_ok=True)

for path in sorted(RAW.glob("*.csv")):
    df = pd.read_csv(path)
    df.columns = [c.strip() for c in df.columns]
    df = df.drop_duplicates()
    df.to_csv(OUT / path.name, index=False)
    print(f"{path.name}: {len(df)} linhas")
