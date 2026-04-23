meta:
  id: bip
  title: BioWare BIP (binary LIP) placeholder
  license: MIT
  endian: le
  file-extension: bip
  imports:
    - ../Common/bioware_type_ids
  xref:
    repo_coverage_matrix: |
      Maintainer index: docs/XOREOS_FORMAT_COVERAGE.md (xoreos `kFileTypeBIP` **3028**; submodule section 0).
    xoreos_types_kfiletype_bip: https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/types.h#L197
    pykotor_lip_tree: https://github.com/OpenKotOR/PyKotor/tree/e03ea2c077f1be1d6704d228d156748a9cc3d0eb/Libraries/PyKotor/src/pykotor/resource/formats/lip
    github_openkotor_pykotor_resource_type_bip: |
      https://github.com/OpenKotOR/PyKotor — `Libraries/PyKotor/src/pykotor/resource/type.py`: **`ResourceType.BIP`** **1131–1137**
      (`type_id` **3028**, extensions **`bip` / `lips`**, comment *binary LIP*).
    reone_lipreader: https://github.com/modawan/reone/blob/61531089341caf5827abbc54346c8c959b03d449/src/libs/graphics/format/lipreader.cpp#L27-L41
    reone_restype_no_bip_note: |
      `modawan/reone` `ResType` lists **`Lip = 3004`** but **no** `Bip` / **3028** member — https://github.com/modawan/reone/blob/61531089341caf5827abbc54346c8c959b03d449/include/reone/resource/types.h#L89-L96
      — use **reone** for **LIP** (`LipReader`) wire; **BIP** type id **3028** is tracked in **xoreos** / **PyKotor** / this `.ksy`, not in reone's `ResType` table.
    xoreos_tools_readme_inventory: https://github.com/xoreos/xoreos-tools/blob/b2ebf4fb98b423d94adf5092fd2d10f5d128ffd3/README.md#L17-L43
    xoreos_lip_note: |
      xoreos documents BIP as binary LIP (`types.h`); compare with text `LIP ` / `V1.0` wire in `formats/LIP/LIP.ksy`.
    k1_bip_symbol_search: |
      **Observed behavior** on `k1_win_gog_swkotor.exe` (structures/classes/strings) for **`BIP`** / **`CResBIP`**: **no** **`CResBIP`**
      (see `formats/LIP/LIP.ksy` for related **`CResLIP`** notes). BIP on-disk layout stays **opaque** here until PyKotor
      or **observed behavior** pins fields.
    xoreos_docs_bioware_specs_tree: https://github.com/xoreos/xoreos-docs/tree/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware
doc: |
  **BIP** (`kFileTypeBIP` **3028**): **binary** lipsync payload per xoreos `types.h`. The ASCII **`LIP `** / **`V1.0`**
  framed wire lives in `LIP.ksy`.

  **TODO: VERIFY** full BIP layout against a KotOR PC build and PyKotor; until then this spec
  exposes a single opaque blob so the type id is tracked and tooling can attach evidence without guessing fields.

doc-ref:
  - "https://github.com/xoreos/xoreos/blob/89c99d2a93c23f3ba2b1218759e38775e4f2bdf9/src/aurora/types.h#L197-L198 xoreos — `kFileTypeBIP`"
  - "https://github.com/OpenKotOR/PyKotor/blob/e03ea2c077f1be1d6704d228d156748a9cc3d0eb/Libraries/PyKotor/src/pykotor/resource/type.py#L1131-L1137 PyKotor — `ResourceType.BIP` (3028; binary LIP comment)"
  - "https://github.com/modawan/reone/blob/61531089341caf5827abbc54346c8c959b03d449/include/reone/resource/types.h#L89-L96 reone — `ResType::Lip` (no separate BIP id in this enum)"
  - "https://github.com/modawan/reone/blob/61531089341caf5827abbc54346c8c959b03d449/src/libs/graphics/format/lipreader.cpp#L27-L41 reone — `LipReader::load` (LIP wire; not BIP-specific)"
  - "https://github.com/xoreos/xoreos-tools/blob/b2ebf4fb98b423d94adf5092fd2d10f5d128ffd3/README.md#L17-L43 xoreos-tools — shipped CLI inventory (no BIP-specific tool on `master`)"
  - "https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#lip PyKotor wiki — LIP family"
  - "https://github.com/xoreos/xoreos-docs/tree/4e1c197aa09b532ef466ff8ceccfd6221e80c3c9/specs/bioware xoreos-docs — BioWare specs tree (no BIP-specific Torlack/PDF; verify wire with PyKotor / **observed behavior** on shipped builds when possible)"

seq:
  - id: payload
    size-eos: true
    doc: Opaque binary LIP payload — replace with structured fields after verification.
