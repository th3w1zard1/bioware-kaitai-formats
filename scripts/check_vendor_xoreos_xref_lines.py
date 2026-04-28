#!/usr/bin/env python3
"""Validate ``#L`` line bands in ``meta.xref`` / ``doc-ref`` against **local** vendor checkouts.

This complements ``scripts/verify_ksy_urls.py --check-xoreos-github-line-ranges``, which fetches
``raw.githubusercontent.com/xoreos/.../master`` (upstream). Submodules under ``vendor/`` may be
forks at different SHAs; this script answers: *at the tree currently on disk*, does each cited
file exist and do the line numbers fall within the file length?

Scan roots (default): ``formats/**/*.ksy`` and optionally ``docs/XOREOS_FORMAT_COVERAGE.md``.

Exit code: 0 if no issues; 1 if any band is out of range or a referenced file is missing locally.
"""

from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path

# Same host/path shape as verify_ksy_urls policy: xoreos org, blob/master, line fragment.
_VENDOR_XOREOS_LINE = re.compile(
    r"https://github\.com/xoreos/(?P<repo>xoreos|xoreos-tools|xoreos-docs)/blob/master/(?P<path>[^#\s\)>\]'\"`]+)#L(?P<lo>\d+)(?:-L(?P<hi>\d+))?"
)


def _repo_root(args: argparse.Namespace) -> Path:
    return Path(args.root).resolve()


def _collect_text_files(paths: list[Path]) -> list[Path]:
    out: list[Path] = []
    for p in paths:
        if p.is_dir():
            out.extend(sorted(p.rglob("*.ksy")))
        elif p.is_file():
            out.append(p)
    return out


def _vendor_base(root: Path, repo: str) -> Path | None:
    if repo == "xoreos":
        d = root / "vendor" / "xoreos"
    elif repo == "xoreos-tools":
        d = root / "vendor" / "xoreos-tools"
    elif repo == "xoreos-docs":
        d = root / "vendor" / "xoreos-docs"
    else:
        return None
    if d.is_dir() and any(d.iterdir()):
        return d
    return None


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument(
        "--root",
        default=".",
        help="Repository root (default: current directory).",
    )
    ap.add_argument(
        "--also",
        action="append",
        default=[],
        metavar="PATH",
        help="Additional file or directory to scan (repeatable). Default includes docs/XOREOS_FORMAT_COVERAGE.md.",
    )
    args = ap.parse_args()
    root = _repo_root(args)

    scan_paths = [root / "formats"]
    extra = list(args.also)
    if not extra:
        extra = ["docs/XOREOS_FORMAT_COVERAGE.md"]
    for e in extra:
        scan_paths.append((root / e).resolve())

    files = _collect_text_files(scan_paths)
    if not files:
        print("check_vendor_xoreos_xref_lines: no files matched", file=sys.stderr)
        return 1

    issues: list[str] = []
    skipped_no_vendor: list[str] = []
    checked = 0

    for fp in files:
        try:
            text = fp.read_text(encoding="utf-8")
        except OSError as exc:
            issues.append(f"{fp}: read error: {exc}")
            continue
        for m in _VENDOR_XOREOS_LINE.finditer(text):
            repo = m.group("repo")
            rel = m.group("path").lstrip("/")
            lo = int(m.group("lo"))
            hi_s = m.group("hi")
            hi = int(hi_s) if hi_s else lo
            if hi < lo:
                issues.append(f"{fp}: inverted range {m.group(0)!r} (L{lo}-L{hi})")
                continue

            base = _vendor_base(root, repo)
            if base is None:
                skipped_no_vendor.append(repo)
                continue

            local = (base / rel).resolve()
            try:
                local.relative_to(base.resolve())
            except ValueError:
                issues.append(f"{fp}: path escapes vendor tree: {local}")
                continue

            if not local.is_file():
                issues.append(
                    f"{fp}: missing file for xref: {local} (from {m.group(0)!r})"
                )
                continue

            nlines = sum(1 for _ in local.open("rb"))
            if lo < 1 or hi > nlines:
                issues.append(
                    f"{fp}: line range L{lo}-L{hi} out of bounds for {local} "
                    f"({nlines} lines; URL {m.group(0)!r})"
                )
            checked += 1

    for msg in issues:
        print(msg, file=sys.stderr)

    uniq_skip = sorted(set(skipped_no_vendor))
    if uniq_skip:
        print(
            "check_vendor_xoreos_xref_lines: note - no populated checkout for: "
            + ", ".join(uniq_skip)
            + " (run `git submodule update --init vendor/<name>`; skipping those URLs).",
            file=sys.stderr,
        )

    if issues:
        print(
            f"check_vendor_xoreos_xref_lines: {len(issues)} issue(s), "
            f"{checked} in-range band(s) checked under vendor/",
            file=sys.stderr,
        )
        return 1

    print(
        f"check_vendor_xoreos_xref_lines: OK - {checked} line band(s) validated "
        f"against local vendor trees in {len(files)} file(s)."
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
