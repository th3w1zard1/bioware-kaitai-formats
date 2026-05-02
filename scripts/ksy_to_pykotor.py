#!/usr/bin/env python3
"""
Custom code generator that reads .ksy files and generates PyKotor-compatible code.

This generator produces:
1. BinaryReader/BinaryWriter classes matching PyKotor patterns
2. read_<format>/write_<format>/bytes_<format> functions
3. <Format> data classes
4. Test suites matching PyKotor's test structure

This is NOT using Kaitai Struct's code generator - we're building our own
that reads .ksy specs and generates PyKotor-compatible code.
"""

from __future__ import annotations

import yaml
from pathlib import Path
from typing import Any, Dict, List
from dataclasses import dataclass


@dataclass
class KsyField:
    """Represents a field in a .ksy type definition."""

    id: str
    type: str
    doc: str = ""
    repeat: str | None = None
    size: Any = None
    encoding: str | None = None

    @classmethod
    def from_dict(cls, data: Dict[str, Any]) -> KsyField:
        return cls(
            id=data.get("id", ""),
            type=data.get("type", "u1"),
            doc=data.get("doc", ""),
            repeat=data.get("repeat"),
            size=data.get("size"),
            encoding=data.get("encoding"),
        )


@dataclass
class KsyType:
    """Represents a type definition in .ksy file."""

    name: str
    seq: List[KsyField]
    doc: str = ""
    instances: Dict[str, Any] = None

    @classmethod
    def from_dict(cls, name: str, data: Dict[str, Any]) -> KsyType:
        seq = [KsyField.from_dict(f) for f in data.get("seq", [])]
        return cls(
            name=name,
            seq=seq,
            doc=data.get("doc", ""),
            instances=data.get("instances", {}),
        )


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
        """Parse .ksy file into specification."""
        with open(ksy_path, "r", encoding="utf-8") as f:
            data = yaml.safe_load(f)

        meta = data.get("meta", {})

        # Parse types
        types = {}
        if "types" in data:
            for name, type_data in data["types"].items():
                types[name] = KsyType.from_dict(name, type_data)

        # Parse root sequence as a type
        root_type = None
        if "seq" in data:
            root_type = KsyType.from_dict("_root", {"seq": data["seq"]})

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
    """Generate PyKotor-compatible code from .ksy specs."""

    def __init__(self, spec: KsySpec):
        self.spec = spec
        self.format_name = spec.id.upper()
        self.class_name = spec.id.upper()

    def generate_data_class(self) -> str:
        """Generate <Format> data class."""
        return f'''"""
{self.spec.title} data class.
Auto-generated from {self.spec.id}.ksy
"""

from __future__ import annotations

from typing import TYPE_CHECKING

from pykotor.resource.generics.base import GenericBase
from pykotor.resource.type import ResourceType

if TYPE_CHECKING:
    from pykotor.resource.type import SOURCE_TYPES, TARGET_TYPES


class {self.class_name}(GenericBase):
    """{self.spec.doc}
    
    Auto-generated from {self.spec.id}.ksy specification.
    """
    
    BINARY_TYPE = ResourceType.{self.format_name}
    
    def __init__(self):
        super().__init__()
        # TODO: Auto-generate fields from .ksy spec
        # Fields would be extracted from {self.spec.id}.ksy types/seq sections
'''

    def generate_binary_reader(self) -> str:
        """Generate BinaryReader class."""
        return f'''"""
Binary reader for {self.spec.title}.
Auto-generated from {self.spec.id}.ksy
"""

from __future__ import annotations

from typing import TYPE_CHECKING

from pykotor.resource.formats.gff import GFFBinaryReader

if TYPE_CHECKING:
    from pykotor.resource.type import SOURCE_TYPES
    from pykotor.resource.generics.{self.spec.id} import {self.class_name}


class {self.class_name}BinaryReader(GFFBinaryReader):
    """Binary reader for {self.class_name} files."""
    
    def load(self, target: {self.class_name}) -> {self.class_name}:
        """Load {self.class_name} from binary data.
        
        This implementation would:
        1. Read GFF structure from binary
        2. Extract fields according to {self.spec.id}.ksy specification
        3. Populate target {self.class_name} object
        """
        # TODO: Implement based on .ksy spec
        return target
'''

    def generate_binary_writer(self) -> str:
        """Generate BinaryWriter class."""
        return f'''"""
Binary writer for {self.spec.title}.
Auto-generated from {self.spec.id}.ksy
"""

from __future__ import annotations

from typing import TYPE_CHECKING

from pykotor.resource.formats.gff import GFFBinaryWriter

if TYPE_CHECKING:
    from pykotor.resource.type import TARGET_TYPES
    from pykotor.resource.generics.{self.spec.id} import {self.class_name}


class {self.class_name}BinaryWriter(GFFBinaryWriter):
    """Binary writer for {self.class_name} files."""
    
    def write(self, {self.spec.id}: {self.class_name}) -> bytes:
        """Write {self.class_name} to binary format.
        
        This implementation would:
        1. Convert {self.class_name} object to GFF structure
        2. Serialize fields according to {self.spec.id}.ksy specification
        3. Write binary GFF data
        """
        # TODO: Implement based on .ksy spec
        pass
'''

    def generate_api_functions(self) -> str:
        """Generate read/write/bytes functions."""
        return f'''"""
API functions for {self.spec.title}.
Auto-generated from {self.spec.id}.ksy
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
    """
    from pykotor.resource.generics.{self.spec.id} import {self.class_name}
    # TODO: Implement
    return {self.class_name}()


def write_{self.spec.id}(
    {self.spec.id}: {self.class_name},
    target: TARGET_TYPES,
    game: Game = Game.K2,
    file_format: ResourceType = ResourceType.GFF,
) -> bytes:
    """Write {self.class_name} to target.
    
    Matches PyKotor's write_{self.spec.id} function signature exactly.
    """
    # TODO: Implement
    pass


def bytes_{self.spec.id}(
    {self.spec.id}: {self.class_name},
    file_format: ResourceType = ResourceType.GFF,
) -> bytes:
    """Convert {self.class_name} to bytes.
    
    Matches PyKotor's bytes_{self.spec.id} function signature exactly.
    """
    from io import BytesIO
    buffer = BytesIO()
    write_{self.spec.id}({self.spec.id}, buffer, file_format=file_format)
    return buffer.getvalue()
'''

    def generate_test_suite(self) -> str:
        """Generate test suite matching PyKotor patterns."""
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
        pass
    
    def test_io_reconstruct(self):
        """Test round-trip: read -> write -> read."""
        # TODO: Implement based on PyKotor's test_{self.spec.id}.py
        pass
    
    def test_file_io(self):
        """Test file-based I/O operations."""
        # TODO: Implement based on PyKotor's test_{self.spec.id}.py
        pass


if __name__ == "__main__":
    unittest.main()
'''

    def generate_all(self, output_dir: Path):
        """Generate all code files for this format."""
        output_dir.mkdir(parents=True, exist_ok=True)

        # Generate data class
        (output_dir / f"{self.spec.id}.py").write_text(self.generate_data_class())

        # Generate reader
        (output_dir / f"io_{self.spec.id}.py").write_text(
            self.generate_binary_reader() + "\n\n" + self.generate_binary_writer()
        )

        # Generate API functions
        (output_dir / f"{self.spec.id}_auto.py").write_text(
            self.generate_api_functions()
        )

        # Generate tests
        test_dir = output_dir.parent.parent / "tests" / "resource" / "generics"
        test_dir.mkdir(parents=True, exist_ok=True)
        (test_dir / f"test_{self.spec.id}.py").write_text(self.generate_test_suite())

        print(f"OK Generated {self.class_name} code and tests")


def main():
    """Generate PyKotor-compatible code for all GFF generic formats."""
    formats_dir = Path("formats/GFF/Generics")
    output_dir = Path("src/python/generated")

    # Find all GFF generic .ksy files (not XML variants)
    ksy_files = [
        f
        for f in formats_dir.rglob("*.ksy")
        if not f.stem.endswith("_XML") and not f.stem.endswith("_JSON")
    ]

    print(f"Found {len(ksy_files)} GFF generic formats")
    print("=" * 80)

    for ksy_file in sorted(ksy_files):
        try:
            print(f"Processing {ksy_file.stem}...")
            spec = KsySpec.from_file(ksy_file)
            generator = PyKotorCodeGenerator(spec)
            generator.generate_all(output_dir)
        except Exception as e:
            print(f"  ✗ Error: {e}")

    print("=" * 80)
    print("Code generation complete!")
    print(f"Generated files in: {output_dir}")


if __name__ == "__main__":
    main()
