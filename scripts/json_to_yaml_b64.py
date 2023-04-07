#!/usr/bin/env python3
"""
Transfers a single-level JSON object in a file to YAML, but
encodes the values as Base64.
"""
import json
import base64
from pathlib import Path
import sys


def eprint(s):
    print(s, file=sys.stderr)


def b64enc(s):
    if not type(s) == str:
        eprint("Don't know how to handle non-string object values.")
        eprint("The behavior after here is undefined. YMMV!")

    return str(base64.standard_b64encode(bytes(s, "utf-8")), "utf-8")


secrets_json = Path(sys.argv[1])
with open(secrets_json, 'r') as file_data:
    data = json.load(file_data)

eprint(f"data has {len(data.keys())} keys: {data.keys()}")

encoded = {k: b64enc(data[k]) for k in data}

for k in encoded:
    print(f"{k}: {encoded[k]}")
