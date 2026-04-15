"""Pytest hooks for everything under ``tests/``."""

from __future__ import annotations

import sys
from pathlib import Path


def pytest_configure() -> None:
    repo_root = Path(__file__).resolve().parents[1]
    src_python = repo_root / "src" / "python"
    p = str(src_python)
    if p not in sys.path:
        sys.path.insert(0, p)
