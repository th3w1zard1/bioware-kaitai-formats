import re
import pathlib

root = pathlib.Path("formats")
url_re = re.compile(r"https://github\.com/[^\s]+/blob/master/[^\s#]+")
xref_re = re.compile(r"^    [A-Za-z0-9_]+:\s+https://github\.com/")
docref_re = re.compile(r'^  - "https://github\.com/')
out: list[tuple[str, int, str]] = []
for p in sorted(root.rglob("*.ksy")):
    try:
        lines = p.read_text(encoding="utf-8").splitlines()
    except OSError:
        continue
    for i, line in enumerate(lines, 1):
        if "blob/master/" not in line or "#L" in line:
            continue
        if not url_re.search(line):
            continue
        if xref_re.search(line):
            continue
        if docref_re.search(line):
            continue
        out.append((p.as_posix(), i, line.rstrip()[:220]))
for rel, ln, s in out[:30]:
    print(f"{rel}:{ln}: {s}")
print("--- total", len(out))
