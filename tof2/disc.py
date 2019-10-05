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
            print("INSERT INTO discLocation SET id = " + str(j) + ", slot = " + slots[j] + ", crateLocationId = 3;")
    elif i == 2:
        serialNos = liner.split(',')
        for j in range(1, nslots + 1):
            print("INSERT INTO disc SET serialNo = \"" + serialNos[j] + "\", discLocationId = " + str(j) + ";")
    else:
        cables = liner.split(',')
        channel = cables[0]
        for j in range(1, nslots + 1):
            label = cables[j]
            if label[0:4] == 'TOF-':
                cable_id = cable_id + 1
                label_fields = label.split('-')
                label_signal_cable = label_fields[0] + '-' + label_fields[1] + '-' + label_fields[3] 
                print("INSERT INTO discCable SET id = " + str(cable_id) + ", label = \"" + label + "\", discLocationId = " + str(j) + ", channel = \"" + channel + "\", splitterLocationId = (SELECT splitterLocation.id FROM signalCable, splitterLocation WHERE signalCable.splitterLocationId = splitterLocation.id AND signalCable.label = \"" + label_signal_cable + "\");")
