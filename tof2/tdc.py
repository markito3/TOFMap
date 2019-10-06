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
        nslots = len(slots) - 2
        for j in range(1, nslots + 1):
            print("INSERT INTO tdcLocation SET id = " + str(j) + ", crateLocationId = 4, slot = " + slots[j + 1] + ";")
    elif i == 2:
        serialNos = liner.split(',')
        for j in range(1, nslots + 1):
            print("INSERT INTO tdc SET serialNo = \"" + serialNos[j + 1] + "\", tdcLocationId = " + str(j) + ";")
    else:
        cables = liner.split(',')
        channel = cables[0]
        half = cables[1]
        for j in range(1, nslots + 1):
            label = cables[j]
            slot = slots[j]
            if label[0:4] == 'TOF-':
                cable_id = cable_id + 1
                print("INSERT INTO tdcCable SET id = " + str(cable_id) + ", label = \"" + label + "\", tdcLocationId = (SELECT id from tdcLocation WHERE crateLocationId = 4 AND slot = \"" + slot + "\"), tdcHalf = \"" + half + "\", tdcChannel = " + channel + ", discLocationId = (SELECT discLocation.id FROM discLocation, discCable WHERE discCable.discLocationId = discLocation.id AND discCable.label = \"" + label + "\");")
