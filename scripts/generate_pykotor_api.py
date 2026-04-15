#!/usr/bin/env python3
"""
Generate PyKotor-compatible API from .ksy specifications.

This creates:
1. BinaryReader/BinaryWriter classes (ResourceWriter inheritance)
2. read_<format>/write_<format>/bytes_<format> functions
3. <Format> data classes
4. Test suites matching PyKotor patterns

For ALL supported languages.
"""

from __future__ import annotations

import yaml
from pathlib import Path
from typing import Any, Dict, List
from dataclasses import dataclass


@dataclass
class KsyField:
    """Field definition from .ksy."""

    id: str
    type: str
    doc: str = ""
    repeat: str | None = None
    size: Any = None
    encoding: str | None = None


@dataclass
class KsyType:
    """Type definition from .ksy."""

    name: str
    seq: List[KsyField]
    doc: str = ""
    instances: Dict[str, Any] = None


@dataclass
class KsySpec:
    """Parsed .ksy specification."""

    id: str
    title: str
    file_extension: str
    endian: str
    doc: str
    types: Dict[str, KsyType]
    root_type: KsyType | None
    imports: List[str]

    @classmethod
    def from_file(cls, ksy_path: Path) -> KsySpec:
        """Parse .ksy file."""
        with open(ksy_path, "r", encoding="utf-8") as f:
            data = yaml.safe_load(f)

        meta = data.get("meta", {})
        types = {}
        if "types" in data:
            for name, type_data in data["types"].items():
                seq = [KsyField(**f) for f in type_data.get("seq", [])]
                types[name] = KsyType(
                    name=name,
                    seq=seq,
                    doc=type_data.get("doc", ""),
                    instances=type_data.get("instances", {}),
                )

        root_type = None
        if "seq" in data:
            root_type = KsyType("_root", [KsyField(**f) for f in data["seq"]])

        return cls(
            id=meta.get("id", ""),
            title=meta.get("title", ""),
            file_extension=meta.get("file-extension", ""),
            endian=meta.get("endian", "le"),
            doc=data.get("doc", ""),
            types=types,
            root_type=root_type,
            imports=meta.get("imports", []),
        )


class PyKotorCodeGenerator:
    """Generate PyKotor-compatible code for a specific language."""

    def __init__(self, spec: KsySpec, target_lang: str):
        self.spec = spec
        self.target_lang = target_lang
        self.format_name = spec.id.upper()
        self.class_name = spec.id.upper()

        # Language-specific settings
        self.lang_config = self._get_lang_config()

    def _get_lang_config(self) -> Dict[str, Any]:
        """Get language-specific configuration."""
        configs = {
            "python": {
                "file_ext": ".py",
                "class_suffix": "",
                "reader_base": "GFFBinaryReader",
                "writer_base": "GFFBinaryWriter",
                "resource_type": f"ResourceType.{self.format_name}",
                "imports": [
                    "from pykotor.resource.generics.base import GenericBase",
                    "from pykotor.resource.type import ResourceType",
                    "from pykotor.resource.formats.gff import GFFBinaryReader, GFFBinaryWriter",
                ],
            },
            "csharp": {
                "file_ext": ".cs",
                "class_suffix": "",
                "reader_base": "GFFBinaryReader",
                "writer_base": "GFFBinaryWriter",
                "resource_type": f"ResourceType.{self.format_name}",
                "imports": [
                    "using PyKotor.Resource.Generics.Base;",
                    "using PyKotor.Resource.Type;",
                    "using PyKotor.Resource.Formats.GFF;",
                ],
            },
            "javascript": {
                "file_ext": ".js",
                "class_suffix": "",
                "reader_base": "GFFBinaryReader",
                "writer_base": "GFFBinaryWriter",
                "resource_type": f"ResourceType.{self.format_name}",
                "imports": [],
            },
        }
        return configs.get(self.target_lang, configs["python"])

    def generate_data_class(self) -> str:
        """Generate <Format> data class."""
        config = self.lang_config

        if self.target_lang == "python":
            return f'''"""
{self.spec.title} data class.
Auto-generated from {self.spec.id}.ksy for PyKotor compatibility
"""

{chr(10).join(config["imports"])}

class {self.class_name}(GenericBase):
    """{self.spec.doc}

    Auto-generated from {self.spec.id}.ksy specification.
    """

    BINARY_TYPE = {config["resource_type"]}

    def __init__(self):
        super().__init__()
        # TODO: Auto-generate fields from .ksy spec
        # Fields extracted from {self.spec.id}.ksy types/seq sections
        pass
'''

        elif self.target_lang == "csharp":
            return f"""/*
{self.spec.title} data class.
Auto-generated from {self.spec.id}.ksy for PyKotor compatibility
*/

{chr(10).join(config["imports"])}

namespace PyKotor.Resource.Generics
{{
    public class {self.class_name} : GenericBase
    {{
        public const ResourceType BINARY_TYPE = {config["resource_type"]};

        public {self.class_name}()
        {{
            // TODO: Auto-generate fields from .ksy spec
            // Fields extracted from {self.spec.id}.ksy types/seq sections
        }}
    }}
}}
"""

        # Default fallback
        return f"// TODO: Implement {self.class_name} for {self.target_lang}"

    def generate_binary_reader(self) -> str:
        """Generate BinaryReader class."""
        config = self.lang_config

        if self.target_lang == "python":
            return f'''"""
Binary reader for {self.spec.title}.
Auto-generated from {self.spec.id}.ksy for PyKotor compatibility
"""

{chr(10).join(config["imports"])}

class {self.class_name}BinaryReader({config["reader_base"]}):
    """Binary reader for {self.class_name} files."""

    def load(self, target: {self.class_name}) -> {self.class_name}:
        """Load {self.class_name} from binary data.

        Uses Kaitai-generated parser internally, converts to PyKotor objects.
        """
        # Parse using Kaitai Struct
        from kaitai_generated.{self.spec.id} import {self.class_name} as Kaitai{self.class_name}
        kaitai_obj = Kaitai{self.class_name}.from_bytes(self._data)

        # Convert to PyKotor object
        return self._kaitai_to_pykotor(kaitai_obj, target)

    def _kaitai_to_pykotor(self, kaitai_obj, target: {self.class_name}) -> {self.class_name}:
        """Convert Kaitai structure to PyKotor {self.class_name} object."""
        # TODO: Implement field mapping from .ksy spec
        return target
'''

        elif self.target_lang == "csharp":
            return f"""/*
Binary reader for {self.spec.title}.
Auto-generated from {self.spec.id}.ksy for PyKotor compatibility
*/

{chr(10).join(config["imports"])}

namespace PyKotor.Resource.Formats.{self.spec.id}
{{
    public class {self.class_name}BinaryReader : {config["reader_base"]}
    {{
        public {self.class_name} Load({self.class_name} target)
        {{
            // Parse using Kaitai Struct
            var kaitaiObj = new KaitaiGenerated.{self.class_name}(Data);

            // Convert to PyKotor object
            return KaitaiToPykotor(kaitaiObj, target);
        }}

        private {self.class_name} KaitaiToPykotor(object kaitaiObj, {self.class_name} target)
        {{
            // TODO: Implement field mapping from .ksy spec
            return target;
        }}
    }}
}}
"""

        return (
            f"// TODO: Implement {self.class_name}BinaryReader for {self.target_lang}"
        )

    def generate_binary_writer(self) -> str:
        """Generate BinaryWriter class."""
        config = self.lang_config

        if self.target_lang == "python":
            return f'''"""
Binary writer for {self.spec.title}.
Auto-generated from {self.spec.id}.ksy for PyKotor compatibility
"""

{chr(10).join(config["imports"])}

class {self.class_name}BinaryWriter({config["writer_base"]}):
    """Binary writer for {self.class_name} files."""

    def write(self, {self.spec.id}: {self.class_name}) -> bytes:
        """Write {self.class_name} to binary format.

        Converts PyKotor object to GFF structure and serializes.
        """
        # Convert to GFF structure
        gff = self._pykotor_to_gff({self.spec.id})

        # Write binary GFF
        return self._write_gff(gff)

    def _pykotor_to_gff(self, {self.spec.id}: {self.class_name}):
        """Convert PyKotor object to GFF structure."""
        from pykotor.resource.formats.gff import GFF, GFFStruct

        gff = GFF()
        gff.file_type = "{self.format_name} "
        gff.file_version = "V3.2"

        # TODO: Implement field serialization from .ksy spec
        return gff
'''

        elif self.target_lang == "csharp":
            return f"""/*
Binary writer for {self.spec.title}.
Auto-generated from {self.spec.id}.ksy for PyKotor compatibility
*/

{chr(10).join(config["imports"])}

namespace PyKotor.Resource.Formats.{self.spec.id}
{{
    public class {self.class_name}BinaryWriter : {config["writer_base"]}
    {{
        public byte[] Write({self.class_name} {self.spec.id})
        {{
            // Convert to GFF structure
            var gff = PykotorToGff({self.spec.id});

            // Write binary GFF
            return WriteGff(gff);
        }}

        private object PykotorToGff({self.class_name} {self.spec.id})
        {{
            // TODO: Implement field serialization from .ksy spec
            return null;
        }}
    }}
}}
"""

        return (
            f"// TODO: Implement {self.class_name}BinaryWriter for {self.target_lang}"
        )

    def generate_api_functions(self) -> str:
        """Generate read/write/bytes functions."""
        _config = self.lang_config

        if self.target_lang == "python":
            return f'''"""
API functions for {self.spec.title}.
Auto-generated from {self.spec.id}.ksy for PyKotor compatibility
"""

from __future__ import annotations

from typing import TYPE_CHECKING

from pykotor.common.misc import Game
from pykotor.resource.type import ResourceType

if TYPE_CHECKING:
    from pykotor.resource.type import SOURCE_TYPES, TARGET_TYPES
    from pykotor.resource.generics.{self.spec.id} import {self.class_name}


def read_{self.spec.id}(
    source: SOURCE_TYPES,
    offset: int = 0,
    size: int | None = None,
) -> {self.class_name}:
    """Read {self.class_name} from source.

    Matches PyKotor's read_{self.spec.id} function signature exactly.
    Supports binary, XML, and JSON formats.
    """
    from pykotor.resource.generics.{self.spec.id} import {self.class_name}
    from pykotor.resource.formats.gff import read_gff

    # Detect format and read
    if isinstance(source, (str, Path)) and source.endswith(('.xml', '.json')):
        file_format = ResourceType.GFF_XML if source.endswith('.xml') else ResourceType.GFF_JSON
        gff = read_gff(source, file_format=file_format)
        return _construct_{self.spec.id}_from_gff(gff)

    # Binary format
    from pykotor.resource.generics.{self.spec.id}.io_{self.spec.id} import {self.class_name}BinaryReader
    reader = {self.class_name}BinaryReader(source, offset, size)
    return reader.load({self.class_name}())


def write_{self.spec.id}(
    {self.spec.id}: {self.class_name},
    target: TARGET_TYPES,
    game: Game = Game.K2,
    file_format: ResourceType = ResourceType.GFF,
) -> bytes:
    """Write {self.class_name} to target.

    Matches PyKotor's write_{self.spec.id} function signature exactly.
    """
    if file_format == ResourceType.GFF:
        # Binary format
        from pykotor.resource.generics.{self.spec.id}.io_{self.spec.id} import {self.class_name}BinaryWriter
        writer = {self.class_name}BinaryWriter(target, game=game)
        return writer.write({self.spec.id})

    # XML/JSON format
    from pykotor.resource.formats.gff import write_gff
    gff = _dismantle_{self.spec.id}_to_gff({self.spec.id})
    return write_gff(gff, target, file_format=file_format)


def bytes_{self.spec.id}(
    {self.spec.id}: {self.class_name},
    game: Game = Game.K2,
    file_format: ResourceType = ResourceType.GFF,
) -> bytes:
    """Convert {self.class_name} to bytes.

    Matches PyKotor's bytes_{self.spec.id} function signature exactly.
    """
    from io import BytesIO
    buffer = BytesIO()
    write_{self.spec.id}({self.spec.id}, buffer, game, file_format)
    return buffer.getvalue()


def _construct_{self.spec.id}_from_gff(gff) -> {self.class_name}:
    """Construct {self.class_name} from GFF (for XML/JSON loading)."""
    from pykotor.resource.generics.{self.spec.id} import {self.class_name}
    # TODO: Implement GFF to object conversion
    return {self.class_name}()


def _dismantle_{self.spec.id}_to_gff({self.spec.id}: {self.class_name}):
    """Dismantle {self.class_name} to GFF (for XML/JSON saving)."""
    from pykotor.resource.formats.gff import GFF
    # TODO: Implement object to GFF conversion
    return GFF()
'''

        return f"// TODO: Implement API functions for {self.target_lang}"

    def generate_test_suite(self) -> str:
        """Generate test suite matching PyKotor patterns."""
        _config = self.lang_config

        if self.target_lang == "python":
            return f'''"""
Test suite for {self.spec.title}.
Auto-generated from {self.spec.id}.ksy to match PyKotor test patterns.
"""

import unittest
from pathlib import Path

from pykotor.resource.generics.{self.spec.id} import read_{self.spec.id}, write_{self.spec.id}, {self.class_name}
from pykotor.resource.type import ResourceType


class Test{self.class_name}(unittest.TestCase):
    """Test {self.class_name} read/write operations.

    These tests match PyKotor's test structure and should produce identical results.
    """

    def setUp(self):
        self.test_data_dir = Path(__file__).parent / "test_files"

    def test_io_construct(self):
        """Test constructing {self.class_name} from binary data."""
        # TODO: Implement based on PyKotor's test_{self.spec.id}.py
        # Should match PyKotor's test structure exactly
        pass

    def test_io_reconstruct(self):
        """Test round-trip: read -> write -> read."""
        # TODO: Implement based on PyKotor's test_{self.spec.id}.py
        pass

    def test_file_io(self):
        """Test file-based I/O operations."""
        # TODO: Implement based on PyKotor's test_{self.spec.id}.py
        pass

    def test_xml_io(self):
        """Test XML format I/O."""
        # Test XML reading/writing matches PyKotor
        pass

    def test_json_io(self):
        """Test JSON format I/O."""
        # Test JSON reading/writing matches PyKotor
        pass


if __name__ == "__main__":
    unittest.main()
'''

        return f"// TODO: Implement test suite for {self.target_lang}"

    def generate_all(self, output_dir: Path):
        """Generate all code files for this format and language."""
        output_dir.mkdir(parents=True, exist_ok=True)

        # Generate data class
        data_file = output_dir / f"{self.spec.id}{self.lang_config['file_ext']}"
        data_file.write_text(self.generate_data_class())

        # Generate reader/writer
        io_file = output_dir / f"io_{self.spec.id}{self.lang_config['file_ext']}"
        io_content = (
            self.generate_binary_reader() + "\n\n" + self.generate_binary_writer()
        )
        io_file.write_text(io_content)

        # Generate API functions
        api_file = output_dir / f"{self.spec.id}_auto{self.lang_config['file_ext']}"
        api_file.write_text(self.generate_api_functions())

        # Generate tests
        test_dir = (
            output_dir.parent.parent
            / "tests"
            / self.target_lang
            / "resource"
            / "generics"
        )
        test_dir.mkdir(parents=True, exist_ok=True)
        test_file = test_dir / f"test_{self.spec.id}{self.lang_config['file_ext']}"
        test_file.write_text(self.generate_test_suite())

        print(f"OK Generated {self.class_name} code for {self.target_lang}")


def generate_for_all_languages():
    """Generate PyKotor-compatible code for all formats and languages."""
    formats_dir = Path("formats/GFF/Generics")
    output_base = Path("src")

    # Find all working GFF generic formats
    ksy_files = [
        f
        for f in formats_dir.rglob("*.ksy")
        if not f.stem.endswith("_XML")
        and not f.stem.endswith("_JSON")
        and f.name
        not in [
            "DA2S.ksy",
            "DAS.ksy",
            "LYT.ksy",
            "MDL.ksy",
            "MDL_ASCII.ksy",
            "PCC.ksy",
            "TGA.ksy",
            "TPC.ksy",
        ]
    ]

    languages = ["python", "csharp", "javascript"]  # Start with 3 languages

    print(
        f"Generating PyKotor APIs for {len(ksy_files)} formats in {len(languages)} languages..."
    )
    print("=" * 80)

    for lang in languages:
        print(f"Generating for {lang}...")
        lang_dir = output_base / lang / "pykotor_generated"
        lang_dir.mkdir(parents=True, exist_ok=True)

        for ksy_file in ksy_files:
            try:
                spec = KsySpec.from_file(ksy_file)
                generator = PyKotorCodeGenerator(spec, lang)
                generator.generate_all(lang_dir)
            except Exception as e:
                print(f"  ✗ Error generating {ksy_file.stem} for {lang}: {e}")

    print("=" * 80)
    print("PyKotor API generation complete!")
    print("Generated code in: src/<language>/pykotor_generated/")


if __name__ == "__main__":
    generate_for_all_languages()
