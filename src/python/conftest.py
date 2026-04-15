"""Pytest hooks for tests under ``src/python/`` (e.g. ``src/python/tests/``)."""

from __future__ import annotations

import sys
from pathlib import Path


def pytest_configure() -> None:
    root = Path(__file__).resolve().parent
    p = str(root)
    if p not in sys.path:
        sys.path.insert(0, p)
