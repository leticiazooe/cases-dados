from __future__ import annotations

from pathlib import Path
import re
import shutil
import unicodedata
import zipfile

EXPECTED_CASES = 24


def slug_from_zip(filename: str) -> str:
    base = Path(filename).stem
    base = re.sub(r"^Case_", "", base, flags=re.I)
    match = re.match(r"(\d+)[_-](.*)", base)

    if match:
        number, title = match.groups()
    else:
        number, title = "00", base

    title = unicodedata.normalize("NFKD", title)
    title = "".join(char for char in title if not unicodedata.combining(char))
    title = title.lower().replace("_", " ")
    title = re.sub(r"[^a-z0-9]+", "-", title).strip("-")

    return f"{int(number):02d}-{title}"


def safe_extract(zip_path: Path, destination: Path) -> None:
    destination_resolved = destination.resolve()

    with zipfile.ZipFile(zip_path) as archive:
        for info in archive.infolist():
            target = (destination / info.filename).resolve()
            if target != destination_resolved and destination_resolved not in target.parents:
                raise RuntimeError(
                    f"Caminho inseguro encontrado em {zip_path.name}: {info.filename}"
                )
        archive.extractall(destination)


def build_index(cases_dir: Path) -> None:
    directories = sorted(path for path in cases_dir.iterdir() if path.is_dir())

    if len(directories) != EXPECTED_CASES:
        raise RuntimeError(
            f"Validação falhou: esperados {EXPECTED_CASES} diretórios, "
            f"encontrados {len(directories)}."
        )

    lines = [
        "# Índice dos cases\n\n",
        "Os cases abaixo estão descompactados e podem ser explorados diretamente "
        "pelo GitHub. Os arquivos ZIP originais foram preservados em `../archives/`.\n\n",
        "| Case | Projeto |\n",
        "|---:|---|\n",
    ]

    for directory in directories:
        match = re.match(r"(\d+)-(.*)", directory.name)
        number = match.group(1) if match else "-"
        title = (match.group(2) if match else directory.name).replace("-", " ").title()
        lines.append(f"| {number} | [{title}]({directory.name}) |\n")

    (cases_dir / "README.md").write_text("".join(lines), encoding="utf-8")


def main() -> None:
    repo_root = Path(__file__).resolve().parents[1]
    cases_dir = repo_root / "cases"
    archives_dir = repo_root / "archives"

    if not cases_dir.exists():
        raise SystemExit("A pasta cases/ não foi encontrada.")

    zip_files = sorted(cases_dir.glob("Case_*.zip"))

    if len(zip_files) != EXPECTED_CASES:
        raise SystemExit(
            f"Esperados {EXPECTED_CASES} arquivos ZIP em cases/, "
            f"mas foram encontrados {len(zip_files)}. Nenhuma alteração foi feita."
        )

    archives_dir.mkdir(exist_ok=True)

    destinations = [cases_dir / slug_from_zip(zip_path.name) for zip_path in zip_files]
    duplicated = {path.name for path in destinations if destinations.count(path) > 1}
    if duplicated:
        raise SystemExit(f"Destinos duplicados detectados: {', '.join(sorted(duplicated))}")

    for zip_path, destination in zip(zip_files, destinations):
        if destination.exists():
            shutil.rmtree(destination)
        destination.mkdir(parents=True, exist_ok=True)

        safe_extract(zip_path, destination)
        shutil.move(str(zip_path), str(archives_dir / zip_path.name))
        print(f"OK  {zip_path.name} -> cases/{destination.name}/")

    build_index(cases_dir)

    migrated = sorted(path for path in cases_dir.iterdir() if path.is_dir())
    archived = sorted(archives_dir.glob("Case_*.zip"))

    if len(migrated) != EXPECTED_CASES or len(archived) != EXPECTED_CASES:
        raise RuntimeError(
            "Validação final falhou. Verifique cases/ e archives/ antes de fazer commit."
        )

    print()
    print("Migração concluída com sucesso.")
    print(f"Cases navegáveis: {len(migrated)}")
    print(f"ZIPs preservados: {len(archived)}")
    print("Índice criado em cases/README.md")


if __name__ == "__main__":
    main()
