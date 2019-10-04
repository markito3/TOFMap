#!/usr/bin/env python
import sys
i = 0
for line in sys.stdin:
    i = i + 1
    liner = line.rstrip()
    print(liner)
    if i == 1:
        print("one")	
