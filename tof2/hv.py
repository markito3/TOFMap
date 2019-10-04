#!/usr/bin/env python
import sys
i = 0
for line in sys.stdin:
    i = i + 1
    liner = line.rstrip()
    print(liner)
    if i == 1:
        slots = liner.split(',')
        nslots = len(slots) - 1
        for j in range(1, nslots + 1):
            print("INSERT INTO hvCardLocation SET id = " + str(j) + ", slot = " + slots[j] + ";")
    elif i == 2:
        serialNos = liner.split(',')
        for j in range(1, nslots + 1):
            print("INSERT INTO hvCard SET serialNo = \"" + serialNos[j] + "\", hvCardLocationId = " + str(j) + ";")
    else:
        cables = liner.split(',')
        channel = cables[0]
        cable_id = 0
        for j in range(1, nslots + 1):
            label = cables[j]
            if label[0:4] == 'TOF-':
                cable_id = cable_id + 1
                print("INSERT INTO hvCable SET label = \"" + label + "\", hvCardLocationId = " + str(j) + ", channel = \"" + channel + "\", pmtLocationId = (SELECT id FROM pmtLocation WHERE label = \"" + label + "\");")
