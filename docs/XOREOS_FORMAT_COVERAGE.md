# xoreos ↔ in-tree `.ksy` coverage matrix

This document is the **maintainer index** for mapping **BioWare-family binary wire formats** in [`formats/`](../formats/) to upstream **runtime** ([xoreos/xoreos](https://github.com/xoreos/xoreos)), **tools** ([xoreos/xoreos-tools](https://github.com/xoreos/xoreos-tools)), **documentation** ([xoreos/xoreos-docs](https://github.com/xoreos/xoreos-docs)), **PyKotor**, **reone**, and optional **Ghidra** evidence (Cursor MCP `user-agdec-http`, Odyssey repository — see [`AGENTS.md`](../AGENTS.md)).

## Terminology: `ResourceType` vs `FileType` (xoreos `types.h`)

- **`Aurora::ResourceType`** — Small **media-class** enum (`kResourceImage`, `kResourceVideo`, …, `kResourceMAX`). **Not** the KEY/BIF/ERF numeric **restype** column. Mirrored in Kaitai as `xoreos_resource_category` in [`formats/Common/bioware_type_ids.ksy`](../formats/Common/bioware_type_ids.ksy).
- **`Aurora::FileType`** — Large **`kFileType*`** numeric ID table used in archives. Mirrored as `xoreos_file_type_id` in the same file. **Coverage gaps** and per-extension `.ksy` work target **this** enum (plus PyKotor tooling IDs in `bioware_resource_type_id`).

**Inventory:** run [`scripts/report_filetype_ksy_coverage.py`](../scripts/report_filetype_ksy_coverage.py) against [`formats/coverage/filetype_coverage.yaml`](../formats/coverage/filetype_coverage.yaml) to list `MISSING` / `DRIFT` rows (see script `--help`).

## 0. Local upstream trees (required for “no omissions” greps)

`.gitmodules` registers optional submodules (often **forks** under `th3w1zard1/`):

```bash
git submodule update --init \
  vendor/xoreos vendor/xoreos-tools vendor/xoreos-docs vendor/reone vendor/PyKotor \
  _upstream_refs/kotor.js _upstream_refs/reone _upstream_refs/northernlights reone_dds_scan
```

Until submodules are populated, **line-accurate** comparison against your checkout is impossible; this matrix still lists **canonical `master` URLs** on `github.com/xoreos/*` and `OpenKotOR/PyKotor` for agents. Use [`scripts/verify_ksy_urls.py`](../scripts/verify_ksy_urls.py) (HTTP `raw.githubusercontent.com` / upstream `master`) plus, when `vendor/xoreos*` is checked out, [`scripts/check_vendor_xoreos_xref_lines.py`](../scripts/check_vendor_xoreos_xref_lines.py) (on-disk line bands).

`_upstream_refs/*` and `reone_dds_scan` are **optional pinned mirrors** (KotOR.js, northernlights, reone) used in some `meta.xref` notes; they are registered in [`.gitmodules`](../.gitmodules) so `git submodule status` stays consistent with the index.

**Fork caveat:** Submodule SHAs may diverge from upstream `master`; re-run the verifier after upstream moves anchors.

## 1. Per-spec inventory (every `formats/**/*.ksy`)

Columns:

- **Runtime** — primary C++ reader in `xoreos/src/…` (Aurora/graphics/sound).
- **Tools** — CLI/converter in `xoreos-tools/src/…` when it exists separately from runtime.
- **Docs** — Torlack / specs under `xoreos-docs` when known.
- **PyKotor** — `Libraries/PyKotor/src/pykotor/resource/formats/…` tree or wiki.
- **reone** — `src/libs/…` or `include/reone/…` when commonly cited for KotOR.
- **Notes** — policy (`AGENTS.md`: plaintext/XML/JSON interchange may be out of scope), gaps, or `FileType` anchor in `types.h`.

| `.ksy` | Runtime (`xoreos`) | Tools (`xoreos-tools`) | Docs (`xoreos-docs`) | PyKotor | reone (typical) | Notes |
|--------|--------------------|--------------------------|------------------------|---------|------------------|--------|
| `formats/BIF/BIF.ksy` | `src/aurora/biffile.cpp` | `unkeybif.cpp` (KEY/BIF extract); companion texture tools under `src/images/` | Torlack BIF (if mirrored in docs tree) | `resource/formats/bif/` | `bifreader.cpp` | `kFileTypeBIF` / `9998` archive family |
| `formats/BIF/BZF.ksy` | `src/aurora/bzffile.cpp` | — | — | `resource/formats/bif/` (BZF path) | — | LZMA-compressed BIF (`kFileTypeBZF` / `26000` KotOR) |
| `formats/BIF/KEY.ksy` | `src/aurora/keyfile.cpp` | — | Torlack KEY | `resource/formats/key/` | `keyreader.cpp` | KEY/BIF pair |
| `formats/BWM/BWM.ksy` | `src/engines/kotorbase/path/walkmeshloader.cpp` (and related) | `README.md` inventory only (no BWM CLI) | — | wiki / `resource` loaders | walkmesh handling | `.wok`/BWM family |
| `formats/Common/bioware_common.ksy` | (shared primitives; see `src/common/types.h`) | `src/common/types.h` | — | `pykotor/common/` | many `include/reone/…` | **Central** numeric enums (language, etc.) |
| `formats/Common/bioware_gff_common.ksy` | `src/aurora/gff3file.cpp`, `gff4file.cpp`, headers | `src/xml/gffdumper.cpp`, `gffcreator.cpp` | — | `resource/formats/gff/` | `gffreader.cpp` | GFF3/GFF4 field wire |
| `formats/Common/bioware_mdl_common.ksy` | `src/graphics/aurora/model_kotor.cpp`, `mdlfile.cpp` | — | `doc/specs/torlack/*.html` (MDL) | MDL wiki | MDL loaders | Shared MDL/MDX constants |
| `formats/Common/bioware_ncs_common.ksy` | `src/aurora/nwscript/ncsfile.cpp` | — | — | `resource/formats/ncs/` | script VM | NCS opcodes |
| `formats/Common/bioware_type_ids.ksy` | **`src/aurora/types.h`** (`FileType`, `GameID`, …) | — | — | `resource/type.py` | `resource/types.h` | **Master ID map** — keep authoritative |
| `formats/Common/tga_common.ksy` | `src/graphics/images/tga.cpp` | `src/images/tga.cpp` | — | texture wiki / `formats/tpc/tga.py` | `tgareader.cpp` | Shared TGA header enums |
| `formats/Common/BioWare_Extraction.ksy` | `types.h` (`FileType` anchor in `meta.xref`) | — | — | `pykotor/extract/` | — | **Tooling** / install layout; not engine wire |
| `formats/Common/BioWare_TSLPatcher.ksy` | `types.h` (`FileType` anchor in `meta.xref`) | — | — | `pykotor/tslpatcher/` | — | **Tooling**; not engine wire |
| `formats/DA2S/DA2S.ksy` | `types.h` (game IDs) | — | — | — | — | Dragon Age 2 save; not KotOR stack |
| `formats/DAS/DAS.ksy` | `types.h` (game IDs) | — | — | — | — | DAO save |
| `formats/ERF/ERF.ksy` | `src/aurora/erffile.cpp` | — | — | `resource/formats/erf/` | `erfreader.cpp` | ERF / HAK / MOD family |
| `formats/GDA/GDA.ksy` | `src/aurora/gdafile.cpp`, `gff4file.cpp` | — | — | GDA / 2DA tooling | — | GFF4 `G2DA` |
| `formats/GFF/GFF.ksy` | `gff3file.cpp`, `gff4file.cpp`, template `*file.cpp` | XML tools under `src/xml/` | — | `resource/formats/gff/` | `gffreader.cpp` | Large surface area |
| `formats/LIP/LIP.ksy` | (lip sync consumed via engine paths; `types.h` `kFileTypeLIP`) | — | — | `resource/formats/lip/` | `lipreader.cpp` | Binary LIP wire |
| `formats/LTR/LTR.ksy` | `src/aurora/ltrfile.cpp` | — | — | — | — | Letter combos |
| `formats/MDL/MDL.ksy` | `mdlfile.cpp`, `model_kotor.cpp` | — | Torlack **binmdl** | wiki + MDLOps | — | Binary MDL |
| `formats/MDL/MDL_ASCII.ksy` | `types.h` + `model_kotor.h` (binary contrast anchors in `meta.xref`) | — | Torlack **ascii** | wiki | — | **Plaintext** MDL — policy: tooling / not binary wire |
| `formats/MDL/MDX.ksy` | `model_kotor.cpp` / mesh companions | — | Torlack (mesh) | wiki | — | Vertex buffer companion |
| `formats/NSS/NCS.ksy` | `ncsfile.cpp` | — | — | `resource/formats/ncs/` | — | **NCS** bytecode (NSS is source; out of scope as wire) |
| `formats/NSS/NSS.ksy` | `src/aurora/types.h` (`kFileTypeNSS`) | `src/nwscript/ncsfile.cpp` (bytecode tooling) | — | wiki / `ncs/` | `nsswriter.cpp` | **Plaintext** NWScript source — policy; see `.ksy` `doc` |
| `formats/ITP/ITP_XML.ksy` | `gff3file.cpp` (GFF3 on-disk family) | — | — | `itp` / GFF XML | — | **XML** ITP interchange — policy; binary ITP is GFF-shaped |
| `formats/PCC/PCC.ksy` | `types.h` (`FileType` anchor in `meta.xref`; **not** a PCC reader) | — | — | — | — | **Not** xoreos Aurora; documented as out-of-engine |
| `formats/PLT/PLT.ksy` | `src/graphics/aurora/pltfile.cpp` | — | Torlack PLT | — | — | NWN-centric; KotOR notes in `.ksy` |
| `formats/RIM/RIM.ksy` | `src/aurora/rimfile.cpp` | — | — | `resource/formats/rim/` | `rimreader.cpp` | KotOR RIM header nuance in `.ksy` |
| `formats/SSF/SSF.ksy` | `src/sound/ssffile.cpp` (or equivalent) | — | — | `resource/formats/ssf/` | — | `kFileTypeSSF` / `2060` |
| `formats/TPC/DDS.ksy` | `src/graphics/images/dds.cpp` | `src/images/dds.cpp` | — | `resource/formats/tpc/io_dds.py` | `TpcReader` / `CRes*` (Ghidra) | DDS + BioWare variant |
| `formats/TPC/TGA.ksy` | `src/graphics/images/tga.cpp` | `src/images/tga.cpp` | — | `tpc/tga.py`, `io_tga.py` | `tgareader.cpp` | Truevision TGA |
| `formats/TPC/TPC.ksy` | `src/graphics/images/tpc.cpp` | — | — | `resource/formats/tpc/` | `tpcreader.cpp` | KotOR native texture |
| `formats/TPC/TXI.ksy` | — (ASCII sidecar) | — | — | TXI modules | `txireader.cpp` | **Plaintext** — policy |
| `formats/TLK/TLK.ksy` | `src/aurora/talktable.cpp` | — | — | `resource/formats/tlk/` | `tlkreader.cpp` | TLK v3/v4 |
| `formats/TwoDA/TwoDA.ksy` | `src/aurora/twodafile.cpp` | `convert2da.cpp` (2DA/GDA/CSV interchange) | [`2DA_Format.pdf`](https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/2DA_Format.pdf) | `resource/formats/twoda/` | — | Binary `.2da` wire |
| `formats/WAV/WAV.ksy` | `src/sound/decoders/wave.cpp`, `src/sound/sound.cpp` | — | — | `resource/formats/wav/` | `wavreader.cpp` | RIFF + KotOR SFX prefix notes in `.ksy` |

## 2. `FileType` / resources in xoreos **without** a dedicated first-class `.ksy` in this repo

Many Aurora types exist in `src/aurora/types.h` and various `*file.cpp` loaders. The following are **examples** of formats commonly shipped in KotOR modules that may still be **plaintext**, **GFF-shaped**, or **policy-excluded** from Kaitai in this repository — track them here until a binary `.ksy` exists or scope explicitly excludes them:

- **`kFileTypeTXB` / `kFileTypeTXB2` / `kFileTypeBIP`** — texture / lipsync-adjacent IDs in `src/aurora/types.h`; wire often overlaps **`TPC.ksy`** / **`LIP.ksy`** until a dedicated capsule spec is added.
- **LYT, VIS** (ASCII tooling) — engine resources; often **not** modeled as standalone binary `.ksy` per `AGENTS.md`. **ITP** on-disk is GFF3-shaped (`GFF.ksy`); **ITP XML** interchange is `formats/ITP/ITP_XML.ksy` (plaintext policy).
- **NSS** — source text; **NCS** is the bytecode `.ksy`.
- **TXI** — ASCII sidecar (see `TPC/TXI.ksy` note).
- **GFF templates** (ARE, UTC, DLG, …) — on-disk wire is still **GFF3** (`GFF.ksy`). Per-template **capsule** `.ksy` files under `formats/GFF/Generics/<STEM>/` document template semantics + xrefs without duplicating the GFF3 grammar.

When adding a new binary spec, **update this table** and add `meta.xref` anchors on the **owning** type (prefer `formats/Common/` for shared enums).

## 3. Verification commands

From [`AGENTS.md`](../AGENTS.md):

```text
python scripts/verify_ksy_urls.py --check-xoreos-github-line-ranges --also docs/XOREOS_FORMAT_COVERAGE.md
python scripts/check_vendor_xoreos_xref_lines.py --also docs/XOREOS_FORMAT_COVERAGE.md
python scripts/report_filetype_ksy_coverage.py
python -m pytest -q
```

CI: `.github/workflows/ksy-verify.yml` runs the same three steps on push/PR (initializes `vendor/xoreos`, `vendor/xoreos-tools`, `vendor/xoreos-docs` only).

## 4. Ghidra (Odyssey) MCP

For KotOR PC **binary** consumption (resource managers, not plaintext), use **`user-agdec-http`** with Odyssey paths such as `/K1/k1_win_gog_swkotor.exe` (see per-`.ksy` `ghidra_odyssey_k1` or `ghidra_*` xref blocks). MCP transport and submodule checkout are environment-dependent; the matrix above still lists **canonical** upstreams for static review.

**Operational note:** `user-agdec-http` tools expect a **loaded / checked-out program** in the backing Ghidra project (for example after `sync-project` / `checkout-program`). If the MCP server responds but returns errors like no current program, finish that workflow first; static `github.com/xoreos/*` anchors remain valid without MCP.

---

**Maintainers:** extend section 1 rows when adding `formats/**/*.ksy` (each row’s first column must match a real on-disk path); extend section 2 when xoreos gains a parser you intentionally do not mirror in Kaitai.
