"""Local development shim for PyKotor's ``bioware_kaitai_formats.*`` imports.

PyKotor imports Kaitai-generated parsers from the published package name
``bioware_kaitai_formats``. This repository keeps emitters under
``src/python/kaitai_generated/`` (flat and per-format subfolders). A
:class:`importlib.abc.MetaPathFinder` maps ``bioware_kaitai_formats.<id>`` to the
matching ``<id>.py`` file so ``pip install bioware-kaitai-formats`` is not
required for in-tree tests.
"""

from __future__ import annotations

import importlib.abc
import importlib.util
import sys
from pathlib import Path

_PREFIX = "bioware_kaitai_formats."
_KG = Path(__file__).resolve().parent.parent / "kaitai_generated"
if str(_KG) not in sys.path:
    sys.path.insert(0, str(_KG))


def _find_emitter_module(mod: str) -> Path | None:
    """Resolve ``kaitai_generated/**/<mod>.py`` (flat emitters and nested XML/JSON, etc.)."""
    flat = _KG / f"{mod}.py"
    if flat.is_file():
        return flat
    try:
        matches = [p for p in _KG.rglob(f"{mod}.py") if "__pycache__" not in p.parts]
    except OSError:
        return None
    if not matches:
        return None
    if len(matches) == 1:
        return matches[0]
    return min(matches, key=lambda p: len(p.parts))


class _BiowareKaitaiFormatsShimFinder(importlib.abc.MetaPathFinder):
    __slots__ = ()

    def find_spec(self, fullname: str, path, target=None):  # noqa: ARG002
        if not fullname.startswith(_PREFIX):
            return None
        mod = fullname[len(_PREFIX) :]
        if "." in mod:
            return None
        loc = _find_emitter_module(mod)
        if loc is None:
            return None
        return importlib.util.spec_from_file_location(
            fullname,
            str(loc),
            submodule_search_locations=[],
        )


if not any(isinstance(f, _BiowareKaitaiFormatsShimFinder) for f in sys.meta_path):
    sys.meta_path.insert(0, _BiowareKaitaiFormatsShimFinder())
