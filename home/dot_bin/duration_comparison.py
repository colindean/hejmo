#!/usr/bin/env python3
# Compares two Python timedelta duration timestamps
# It'd be awfully nice if timedelta could parse its own string output…
import sys
import logging
from datetime import timedelta


def no_leading_zero(num: str) -> str:
    if len(num) > 1:
        return num.lstrip('0')
    else:
        # it's probably just 0
        return num

def safely_int(num: str) -> int:
    return int(no_leading_zero(num))

# TODO: handle days
def parse_duration(dur: str) -> timedelta:
    hours, minutes, seconds_and_microseconds = dur.split(':')
    seconds, microseconds = seconds_and_microseconds.split('.')
    time = list(map(safely_int, [hours, minutes, seconds, microseconds]))
    return timedelta(
        hours=time[0],
        minutes=time[1],
        seconds=time[2],
        microseconds=time[3])

first = parse_duration(sys.argv[1])
second = parse_duration(sys.argv[2])

if second > first:
    print(f"Second is {second - first} more than first")
    print(f"Second is {round(100*second / first, 3)}% more than first")
    print(f"First is {round(100*first / second, 3)}% of second")
if first > second:
    print(f"First is {first - second} more than second")
    print(f"First is {round(100*first / second, 3)}% more than first")
    print(f"Second is {round(100*second / first, 3)}% of first")

