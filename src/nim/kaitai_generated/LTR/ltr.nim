import kaitai_struct_nim_runtime
import options
import bioware_common

type
  Ltr* = ref object of KaitaiStruct
    `fileType`*: string
    `fileVersion`*: string
    `letterCount`*: BiowareCommon_BiowareLtrAlphabetLength
    `singleLetterBlock`*: Ltr_LetterBlock
    `doubleLetterBlocks`*: Ltr_DoubleLetterBlocksArray
    `tripleLetterBlocks`*: Ltr_TripleLetterBlocksArray
    `parent`*: KaitaiStruct
  Ltr_DoubleLetterBlocksArray* = ref object of KaitaiStruct
    `blocks`*: seq[Ltr_LetterBlock]
    `parent`*: Ltr
  Ltr_LetterBlock* = ref object of KaitaiStruct
    `startProbabilities`*: seq[float32]
    `middleProbabilities`*: seq[float32]
    `endProbabilities`*: seq[float32]
    `parent`*: KaitaiStruct
  Ltr_TripleLetterBlocksArray* = ref object of KaitaiStruct
    `rows`*: seq[Ltr_TripleLetterRow]
    `parent`*: Ltr
  Ltr_TripleLetterRow* = ref object of KaitaiStruct
    `blocks`*: seq[Ltr_LetterBlock]
    `parent`*: Ltr_TripleLetterBlocksArray

proc read*(_: typedesc[Ltr], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Ltr
proc read*(_: typedesc[Ltr_DoubleLetterBlocksArray], io: KaitaiStream, root: KaitaiStruct, parent: Ltr): Ltr_DoubleLetterBlocksArray
proc read*(_: typedesc[Ltr_LetterBlock], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Ltr_LetterBlock
proc read*(_: typedesc[Ltr_TripleLetterBlocksArray], io: KaitaiStream, root: KaitaiStruct, parent: Ltr): Ltr_TripleLetterBlocksArray
proc read*(_: typedesc[Ltr_TripleLetterRow], io: KaitaiStream, root: KaitaiStruct, parent: Ltr_TripleLetterBlocksArray): Ltr_TripleLetterRow



##[
**LTR** (letter / Markov name tables): header + three float blobs (single / double / triple letter statistics).
`letter_count` is **26** (NWN) vs **28** (KotOR `a-z` + `'` + `-`) — decode via `bioware_ltr_alphabet_length` in
`bioware_common.ksy`. Use `.to_i` on that enum inside `valid`/`repeat-expr` (see Kaitai user guide: enums).

@see <a href="https://github.com/OpenKotOR/PyKotor/wiki/LTR-File-Format">PyKotor wiki — LTR</a>
@see <a href="https://github.com/OpenKotOR/PyKotor/blob/master/Libraries/PyKotor/src/pykotor/resource/formats/ltr/io_ltr.py#L44-L155">PyKotor — `io_ltr` reader/writer (start of `write`)</a>
@see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/types.h#L101">xoreos — `kFileTypeLTR`</a>
@see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/ltrfile.cpp#L121-L133">xoreos — `LTRFile::readLetterSet`</a>
@see <a href="https://github.com/xoreos/xoreos/blob/master/src/aurora/ltrfile.cpp#L135-L168">xoreos — `LTRFile::load`</a>
@see <a href="https://github.com/modawan/reone/blob/master/src/libs/resource/format/ltrreader.cpp#L27-L74">reone — `LtrReader::load` + `readLetterSet`</a>
@see <a href="https://github.com/KobaltBlu/KotOR.js/blob/master/src/resource/LTRObject.ts#L51-L122">KotOR.js — `LTRObject.readBuffer`</a>
@see <a href="https://github.com/xoreos/xoreos-docs/tree/master/specs/bioware">xoreos-docs — BioWare specs tree (no dedicated LTR Torlack page; use `ltrfile.cpp` + PyKotor)</a>
]##
proc read*(_: typedesc[Ltr], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Ltr =
  template this: untyped = result
  this = new(Ltr)
  let root = if root == nil: cast[Ltr](this) else: cast[Ltr](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  File type signature. Must be "LTR " (space-padded) for LTR files.
  ]##
  let fileTypeExpr = encode(this.io.readBytes(int(4)), "ASCII")
  this.fileType = fileTypeExpr

  ##[
  File format version. Must be "V1.0" for LTR files.
  ]##
  let fileVersionExpr = encode(this.io.readBytes(int(4)), "ASCII")
  this.fileVersion = fileVersionExpr

  ##[
  Alphabet size (`u1`). Canonical enum: `formats/Common/bioware_common.ksy` → `bioware_ltr_alphabet_length`
(26 = NWN `a-z`; 28 = KotOR `a-z` + `'` + `-`). For `repeat-expr` counts use `letter_count.to_i` (Kaitai: enum → int, user guide section 6.4.5).

  ]##
  let letterCountExpr = BiowareCommon_BiowareLtrAlphabetLength(this.io.readU1())
  this.letterCount = letterCountExpr

  ##[
  Single-letter probability block (no context).
Used for generating the first character of names.
Contains start/middle/end probability arrays, each with letter_count floats.
Total size: letter_count × 3 × 4 bytes = 336 bytes for KotOR (28 chars).

  ]##
  let singleLetterBlockExpr = Ltr_LetterBlock.read(this.io, this.root, this)
  this.singleLetterBlock = singleLetterBlockExpr

  ##[
  Double-letter probability blocks (1-character context).
Array of letter_count blocks, each indexed by the previous character.
Used for generating the second character based on the first character.
Each block contains start/middle/end probability arrays.
Total size: letter_count × 3 × letter_count × 4 bytes = 9,408 bytes for KotOR.

  ]##
  let doubleLetterBlocksExpr = Ltr_DoubleLetterBlocksArray.read(this.io, this.root, this)
  this.doubleLetterBlocks = doubleLetterBlocksExpr

  ##[
  Triple-letter probability blocks (2-character context).
Two-dimensional array of letter_count × letter_count blocks.
Each block is indexed by the previous two characters.
Used for generating third and subsequent characters.
Each block contains start/middle/end probability arrays.
Total size: letter_count × letter_count × 3 × letter_count × 4 bytes = 73,472 bytes for KotOR.

  ]##
  let tripleLetterBlocksExpr = Ltr_TripleLetterBlocksArray.read(this.io, this.root, this)
  this.tripleLetterBlocks = tripleLetterBlocksExpr

proc fromFile*(_: typedesc[Ltr], filename: string): Ltr =
  Ltr.read(newKaitaiFileStream(filename), nil, nil)


##[
Array of double-letter blocks. One block per character in the alphabet.
Each block is indexed by the previous character (context length 1).

]##
proc read*(_: typedesc[Ltr_DoubleLetterBlocksArray], io: KaitaiStream, root: KaitaiStruct, parent: Ltr): Ltr_DoubleLetterBlocksArray =
  template this: untyped = result
  this = new(Ltr_DoubleLetterBlocksArray)
  let root = if root == nil: cast[Ltr](this) else: cast[Ltr](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Array of letter_count blocks, each containing start/middle/end probability arrays.
Block index corresponds to the previous character in the alphabet.

  ]##
  for i in 0 ..< int(ord(Ltr(this.root).letterCount)):
    let it = Ltr_LetterBlock.read(this.io, this.root, this)
    this.blocks.add(it)

proc fromFile*(_: typedesc[Ltr_DoubleLetterBlocksArray], filename: string): Ltr_DoubleLetterBlocksArray =
  Ltr_DoubleLetterBlocksArray.read(newKaitaiFileStream(filename), nil, nil)


##[
A probability block containing three arrays of probabilities (start, middle, end).
Each array has letter_count floats representing cumulative probabilities for each character
in the alphabet appearing at that position (start, middle, or end of name).

Blocks store cumulative probabilities (monotonically increasing floats) that are compared
against random roll values during name generation.

]##
proc read*(_: typedesc[Ltr_LetterBlock], io: KaitaiStream, root: KaitaiStruct, parent: KaitaiStruct): Ltr_LetterBlock =
  template this: untyped = result
  this = new(Ltr_LetterBlock)
  let root = if root == nil: cast[Ltr](this) else: cast[Ltr](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Array of start probabilities. One float per character in alphabet.
Probability of each letter starting a name (no context for singles,
after previous character for doubles, after previous two for triples).

  ]##
  for i in 0 ..< int(ord(Ltr(this.root).letterCount)):
    let it = this.io.readF4le()
    this.startProbabilities.add(it)

  ##[
  Array of middle probabilities. One float per character in alphabet.
Probability of each letter appearing in the middle of a name.

  ]##
  for i in 0 ..< int(ord(Ltr(this.root).letterCount)):
    let it = this.io.readF4le()
    this.middleProbabilities.add(it)

  ##[
  Array of end probabilities. One float per character in alphabet.
Probability of each letter ending a name.

  ]##
  for i in 0 ..< int(ord(Ltr(this.root).letterCount)):
    let it = this.io.readF4le()
    this.endProbabilities.add(it)

proc fromFile*(_: typedesc[Ltr_LetterBlock], filename: string): Ltr_LetterBlock =
  Ltr_LetterBlock.read(newKaitaiFileStream(filename), nil, nil)


##[
Two-dimensional array of triple-letter blocks. letter_count × letter_count blocks total.
Each block is indexed by the previous two characters (context length 2).

]##
proc read*(_: typedesc[Ltr_TripleLetterBlocksArray], io: KaitaiStream, root: KaitaiStruct, parent: Ltr): Ltr_TripleLetterBlocksArray =
  template this: untyped = result
  this = new(Ltr_TripleLetterBlocksArray)
  let root = if root == nil: cast[Ltr](this) else: cast[Ltr](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Array of letter_count rows, each containing letter_count blocks.
First index corresponds to the second-to-last character.
Second index corresponds to the last character.

  ]##
  for i in 0 ..< int(ord(Ltr(this.root).letterCount)):
    let it = Ltr_TripleLetterRow.read(this.io, this.root, this)
    this.rows.add(it)

proc fromFile*(_: typedesc[Ltr_TripleLetterBlocksArray], filename: string): Ltr_TripleLetterBlocksArray =
  Ltr_TripleLetterBlocksArray.read(newKaitaiFileStream(filename), nil, nil)


##[
A row in the triple-letter blocks array. Contains letter_count blocks,
each indexed by the last character in the two-character context.

]##
proc read*(_: typedesc[Ltr_TripleLetterRow], io: KaitaiStream, root: KaitaiStruct, parent: Ltr_TripleLetterBlocksArray): Ltr_TripleLetterRow =
  template this: untyped = result
  this = new(Ltr_TripleLetterRow)
  let root = if root == nil: cast[Ltr](this) else: cast[Ltr](root)
  this.io = io
  this.root = root
  this.parent = parent


  ##[
  Array of letter_count blocks, each containing start/middle/end probability arrays.
Block index corresponds to the last character in the two-character context.

  ]##
  for i in 0 ..< int(ord(Ltr(this.root).letterCount)):
    let it = Ltr_LetterBlock.read(this.io, this.root, this)
    this.blocks.add(it)

proc fromFile*(_: typedesc[Ltr_TripleLetterRow], filename: string): Ltr_TripleLetterRow =
  Ltr_TripleLetterRow.read(newKaitaiFileStream(filename), nil, nil)

