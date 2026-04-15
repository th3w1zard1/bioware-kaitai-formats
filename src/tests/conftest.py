"""Pytest hooks for everything under ``src/tests/``."""

from __future__ import annotations

import sys
from pathlib import Path


def pytest_configure() -> None:
    # ``src/python`` holds ``bioware_kaitai_formats`` (PyKotor import shim) and ``kaitai_generated``.
    src_python = Path(__file__).resolve().parents[1] / "python"
    p = str(src_python)
    if p not in sys.path:
        sys.path.insert(0, p)
