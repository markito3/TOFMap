#!/usr/bin/env python
import sys
i = 0
cable_id = 0
for line in sys.stdin:
    i = i + 1
    liner = line.rstrip()
#    print(liner)
    if i == 1:
        slots = liner.split(',')
        nslots = len(slots) - 1
        for j in range(1, nslots + 1):
            print("INSERT INTO adcLocation SET id = " + str(j) + ", crateLocationId = 1, slot = " + slots[j] + ";")
    elif i == 2:
        serialNos = liner.split(',')
        for j in range(1, nslots + 1):
            print("INSERT INTO adc SET serialNo = \"" + serialNos[j] + "\", adcLocationId = " + str(j) + ";")
    else:
        cables = liner.split(',')
        channel = cables[0]
        for j in range(1, nslots + 1):
            label = cables[j]
            if label[0:4] == 'TOF-':
                cable_id = cable_id + 1
                print("UPDATE adcCable set adcLocationId = (SELECT id FROM adcLocation where crateLocationId = 1 and slot = " + slots[j] + "), channel = " + channel + " WHERE label = \"" + label + "\";")

