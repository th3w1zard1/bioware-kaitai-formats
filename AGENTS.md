# Agent brief — BioWare Kaitai formats

This file is the **compact hand-off** for coding agents. **Full project rules** (compiler usage, layout, validation, commits) live in [`.cursorrules`](.cursorrules). **Do not duplicate** that document here.

## Goals (alignment)

- **Binary on-disk wire** in `formats/**/*.ksy` only; avoid modeling plaintext/XML/JSON/CSV interchange in Kaitai unless the maintainers explicitly expand scope.
- **`meta.xref` / `doc` citations** — Prefer **canonical upstreams** on **`master`** where line anchors are maintained:
  - Engine / Aurora: `https://github.com/xoreos/xoreos/blob/master/…` and `https://github.com/xoreos/xoreos-tools/blob/master/…`
  - PyKotor: `https://github.com/OpenKotOR/PyKotor/blob/master/…` (and `tree/master` for directory links)
  - Other established upstreams: `modawan/reone`, `KobaltBlu/KotOR.js`, `NickHugi/Kotor.NET`, etc.
- **Shared modules** under `formats/Common/` — `meta.id` and `meta.imports` last path segment must be **`lower_snake_case`** (schema + KSC on Windows).
- **Coverage matrix** — [`docs/XOREOS_FORMAT_COVERAGE.md`](docs/XOREOS_FORMAT_COVERAGE.md) tracks xoreos ↔ `.ksy` mapping and audit steps.

## URL tooling (order of operations)

| Script | Purpose |
|--------|---------|
| [`scripts/rewrite_canonical_github_urls.py`](scripts/rewrite_canonical_github_urls.py) | Rewrites known **fork / pin** URL prefixes in `formats/**/*.ksy` to the **canonical `master`** URLs above (run after a pin pass or when forks creep back in). |
| [`scripts/apply_github_pins.py`](scripts/apply_github_pins.py) | **Inverse:** replaces upstream `…/blob/master/` with **commit-pinned forks** per [`scripts/data/upstream_github_pins.json`](scripts/data/upstream_github_pins.json). Use only when you intentionally want SHAs for regression snapshots — then re-run `rewrite_canonical_github_urls.py` if the repo policy is canonical `master`. |
| [`scripts/verify_ksy_urls.py`](scripts/verify_ksy_urls.py) | **Always** scans `formats/**/*.ksy` for the `meta.xref` YAML footgun `some_key: >` followed by `note:` (folded scalar swallows `note` as string content; exit non-zero). Optional: `--check-xoreos-github-line-ranges` — validates `xoreos/xoreos` and `xoreos-tools` **`blob/master` `#L`** bands against `raw.githubusercontent.com`. `--check-github-blob-line-ranges` — validates **40-char commit** `blob/<sha>/…#L` anchors. `--verify` — slow HTTP `HEAD` over all extracted URLs. |
| [`scripts/check_vendor_xoreos_xref_lines.py`](scripts/check_vendor_xoreos_xref_lines.py) | After `git submodule update --init vendor/xoreos vendor/xoreos-tools vendor/xoreos-docs`, validates the same **`#L`** bands against **on-disk** `vendor/**` trees (fork SHA drift vs upstream `master` URLs). |

**Suggested check after `.ksy` edits:**

```text
python scripts/verify_ksy_urls.py --check-xoreos-github-line-ranges --also docs/XOREOS_FORMAT_COVERAGE.md
python scripts/check_vendor_xoreos_xref_lines.py --also docs/XOREOS_FORMAT_COVERAGE.md
python scripts/report_filetype_ksy_coverage.py
python -m pytest -q
```

Run these from the **repository root** (where [`pytest.ini`](pytest.ini) sets `pythonpath` / `testpaths`). The vendor line script needs populated `vendor/xoreos*` checkouts (`git submodule update --init vendor/xoreos vendor/xoreos-tools vendor/xoreos-docs`); if those trees are empty, it prints a note and still exits **0** for missing checkouts only.

**CI:** [`.github/workflows/ksy-verify.yml`](.github/workflows/ksy-verify.yml) runs the same three commands on push/PR (path-filtered; initializes the three `vendor/xoreos*` submodules in the job).

(`src/python/bioware_kaitai_formats/` is a small import shim so PyKotor can resolve Kaitai emitters from `kaitai_generated/` without installing the PyPI wheel. `pytest.ini` sets `pythonpath = src/python` and `testpaths = src/python/tests`.)

## Learned preferences

- On **Windows**, `uv run .\\scripts\\*.ps1` fails with **Win32 error 193** (`%1 is not a valid Win32 application`) because `uv run` tries to spawn the `.ps1` as an executable; use **`uv run pwsh -NoProfile -File .\\scripts\\….ps1`** or run the script **directly in PowerShell** (same pattern as other non-EXE launchers).
- Keep **wire** documentation on the owning type/enum; consumers link to **`formats/Common/`** instead of pasting duplicate upstream mirrors.
- For KotOR alignment, **observed behavior** in shipped executables (when documented) outranks wiki-only guesses when layout or enum semantics are ambiguous; mark **`TODO: VERIFY`** when the behavior is unclear.
- **Submodule / fork caveat:** `.gitmodules` may point `vendor/xoreos*` at forks; line numbers can diverge from `github.com/xoreos/xoreos` `master`. In-tree proof links still target **upstream `master`** unless a doc explicitly pins a SHA for a regression snapshot.
- When changing Kaitai syntax or compiler-facing constructs, **confirm against current Kaitai Struct compiler documentation** (for example via Context7); do not drop enum or xref detail purely to silence errors when the goal is exhaustive wire modeling.
- **`scripts/verify_ksy_urls.py`** exercises HTTP(S) GitHub (and similar) anchors it extracts; **relative `vendor/…` wiki paths and other local `doc` references are outside that checker**, so broken wiki filenames still need manual or separate validation.
- For documentation or `meta.xref` cleanup, **sweep `formats/**/*.ksy`** (not only a few high-churn formats) unless the task explicitly scopes a single file.
- **`meta.xref`** is a **flat scalar map** in `include/ksy_schema.json` (each value must be a string/number/boolean/null or an array of those). Do **not** nest maps under keys (invalid in the schema). For prose, use a **block scalar on the key** then indented lines. Also avoid `some_key: >` with the next non-blank line starting `note:` — YAML folded `>` treats that as one string, not a nested `note` key (`verify_ksy_urls.py` catches this).

## Root layout

Allowed root files include `README.md`, `.gitignore`, `.cursorrules`, **`AGENTS.md`**, `LICENSE` — see `.cursorrules` section 1. Keep scratch **`ksc`** output under `tmp_ksc*/` or `src/**/kaitai_generated/`, not the repo root.
