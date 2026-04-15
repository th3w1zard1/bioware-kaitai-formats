meta:
  id: bif
  title: BioWare BIF (Binary Index Format) File
  license: MIT
  endian: le
  file-extension: bif
  imports:
    - ../Common/bioware_type_ids
  xref:
    repo_coverage_matrix: |
      Maintainer index: docs/XOREOS_FORMAT_COVERAGE.md (xoreos / xoreos-tools / xoreos-docs ↔ this spec; submodule section 0).
      KotOR PC binary evidence: Cursor MCP user-agdec-http (Odyssey) — see AGENTS.md.
    ghidra_odyssey_k1: |
      Odyssey Ghidra /K1/k1_win_gog_swkotor.exe loads BIF archives alongside KEY; BIFF V1 on-disk layout matches Aurora tooling (PyKotor/reone/xoreos).
    pykotor: https://github.com/OpenKotOR/PyKotor/tree/master/Libraries/PyKotor/src/pykotor/resource/formats/bif/
    github_openkotor_pykotor_io_bif: |
      https://github.com/OpenKotOR/PyKotor — `Libraries/PyKotor/src/pykotor/resource/formats/bif/io_bif.py`:
      **`_load_bif_from_kaitai`** **57–91**; legacy **`BIFF`** / **`BZF `** branch **94–166**; **`BIFBinaryReader.load`** **200–215** ( **`BZF `** fast path **209–213**).
    github_openkotor_pykotor_bif_data: |
      https://github.com/OpenKotOR/PyKotor — `Libraries/PyKotor/src/pykotor/resource/formats/bif/bif_data.py`:
      **`BIFType`** **`BIFF`** / **`BZF `** **59–71**; LZMA / mobile **BZF** notes in module doc **34–37**.
    github_modawan_reone_bifreader: |
      https://github.com/modawan/reone — `src/libs/resource/format/bifreader.cpp`: **`BifReader::load`** **`BIFFV1  `** check **26–29**; **`loadHeader`** **32–38**; **`readResourceEntry`** **50–63**.
    xoreos_biffile_cpp: https://github.com/xoreos/xoreos/blob/master/src/aurora/biffile.cpp#L54-L97
    xoreos_types_kfiletype_bif: https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L208
    xoreos_bif_load: https://github.com/xoreos/xoreos/blob/master/src/aurora/biffile.cpp#L54-L82
    xoreos_bif_read_var_res_table: https://github.com/xoreos/xoreos/blob/master/src/aurora/biffile.cpp#L84-L97
    pykotor_wiki_bif: https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#bif
    xoreos_docs_torlack_bif: https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/bif.html
    github_xoreos_tools_unkeybif_bif_branch: https://github.com/xoreos/xoreos-tools/blob/master/src/unkeybif.cpp#L206-L209
    github_xoreos_docs_keybif_pdf: https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/KeyBIF_Format.pdf
    github_kobaltblu_kotor_js_bif: https://github.com/KobaltBlu/KotOR.js/blob/master/src/resource/BIFObject.ts#L87-L123
doc: |
  **BIF** (binary index file): Aurora archive of `(resource_id, type, offset, size)` rows; **ResRef** strings live in
  the paired **KEY** (`KEY.ksy`), not in the BIF.

doc-ref:
  - "https://github.com/OpenKotOR/PyKotor/wiki/Container-Formats#bif PyKotor wiki — BIF"
  - "https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/bif/io_bif.py#L57-L215 PyKotor — `io_bif` (Kaitai + legacy + reader)"
  - "https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/bif/bif_data.py#L59-L71 PyKotor — `BIFType`"
  - "https://github.com/xoreos/xoreos/blob/master/src/aurora/biffile.cpp#L54-L97 xoreos — `BIFFile::load` + `readVarResTable`"
  - "https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L208 xoreos — `kFileTypeBIF`"
  - "https://github.com/xoreos/xoreos-tools/blob/master/src/unkeybif.cpp#L206-L209 xoreos-tools — `unkeybif` (non-`.bzf` → `BIFFile`)"
  - "https://github.com/modawan/reone/blob/master/src/libs/resource/format/bifreader.cpp#L26-L63 reone — `BifReader`"
  - "https://github.com/KobaltBlu/KotOR.js/blob/master/src/resource/BIFObject.ts#L87-L123 KotOR.js — `BIFObject.readFromDisk` (header + variable resource table)"
  - "https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/bif.html xoreos-docs — Torlack bif.html"
  - "https://github.com/xoreos/xoreos-docs/blob/master/specs/bioware/KeyBIF_Format.pdf xoreos-docs — KeyBIF_Format.pdf"

seq:
  - id: file_type
    type: str
    encoding: ASCII
    size: 4
    doc: File type signature. Must be "BIFF" for BIF files.
    valid: "'BIFF'"
  
  - id: version
    type: str
    encoding: ASCII
    size: 4
    doc: File format version. Typically "V1  " or "V1.1".
    valid:
      any-of:
        - "'V1  '"
        - "'V1.1'"
  
  - id: var_res_count
    type: u4
    doc: Number of variable-size resources in this file.
  
  - id: fixed_res_count
    type: u4
    doc: Number of fixed-size resources (always 0 in KotOR, legacy from NWN).
    valid: 0
  
  - id: var_table_offset
    type: u4
    doc: Byte offset to the variable resource table from the beginning of the file.

instances:
  var_resource_table:
    pos: var_table_offset
    type: var_resource_table
    if: var_res_count > 0
    doc: Variable resource table containing entries for each resource.

types:
  var_resource_table:
    seq:
      - id: entries
        type: var_resource_entry
        repeat: expr
        repeat-expr: _root.var_res_count
        doc: Array of variable resource entries.
  
  var_resource_entry:
    seq:
      - id: resource_id
        type: u4
        doc: |
          Resource ID (matches KEY file entry).
          Encodes BIF index (bits 31-20) and resource index (bits 19-0).
          Formula: resource_id = (bif_index << 20) | resource_index
      
      - id: offset
        type: u4
        doc: Byte offset to resource data in file (absolute file offset).
      
      - id: file_size
        type: u4
        doc: Uncompressed size of resource data in bytes.
      
      - id: resource_type
        type: u4
        enum: bioware_type_ids::xoreos_file_type_id
        doc: |
          Aurora resource type id (`u4` on disk). Payloads are not embedded here; KotOR tools may
          read beyond `file_size` for some types (e.g. WOK/BWM). Canonical enum:
          `formats/Common/bioware_type_ids.ksy` → `xoreos_file_type_id`.

