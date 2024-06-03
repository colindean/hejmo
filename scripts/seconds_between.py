#!/usr/bin/env python3

import sys
from datetime import datetime

if len(sys.argv) < 3:
    sys.stderr.write(
        f"Usage: {sys.argv[0]} start end [format='%H:%M:%S.%f']\n")
    sys.exit(1)

start = sys.argv[1]
end = sys.argv[2]
strpfmt = sys.argv[3] if len(sys.argv) == 4 else "%H:%M:%S.%f"

s = datetime.strptime(start, strpfmt)
e = datetime.strptime(end, strpfmt)
d = e - s
print(d.total_seconds())
