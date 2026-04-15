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
    xoreos_types_kfiletype_bip: https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L197
    pykotor_lip_tree: https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/resource/formats/lip
    reone_lipreader: https://github.com/modawan/reone/blob/master/src/libs/graphics/format/lipreader.cpp#L27-L41
    xoreos_lip_note: |
      xoreos documents BIP as binary LIP (`types.h`); compare with text `LIP ` / `V1.0` wire in `formats/LIP/LIP.ksy`.
    xoreos_docs_bioware_specs_tree: https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware
doc: |
  **BIP** (`kFileTypeBIP` **3028**): **binary** lipsync payload per xoreos `types.h`. The ASCII **`LIP `** / **`V1.0`**
  framed wire lives in `LIP.ksy`.

  **TODO: VERIFY** full BIP layout against Odyssey Ghidra (`user-agdec-http`) and PyKotor; until then this spec
  exposes a single opaque blob so the type id is tracked and tooling can attach evidence without guessing fields.

doc-ref:
  - "https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L197-L198 xoreos — `kFileTypeBIP`"
  - "https://github.com/OpenKotOR/PyKotor/wiki/Audio-and-Localization-Formats#lip PyKotor wiki — LIP family"
  - "https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware xoreos-docs — BioWare specs tree (no BIP-specific Torlack/PDF; placeholder wire — verify in Ghidra)"

seq:
  - id: payload
    size-eos: true
    doc: Opaque binary LIP payload — replace with structured fields after verification.
