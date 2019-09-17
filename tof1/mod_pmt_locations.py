#!/usr/bin/env python
# looping over PMT labels, calculate module label
for i in range(1, 22):
    print("TOF-UP-" + str(45 - i) + " X-" + str(i))
    print("TOF-DW-" + str(45 - i) + " X-" + str(i))
    print("TOF-N-" + str(i) + " Y-" + str(i))
    print("TOF-S-" + str(i) + " Y-" + str(i))
for i in range(22, 24):
    print("TOF-UP-" + str(45 - i) + " X-" + str(i + 2))
    print("TOF-DW-" + str(45 - i) + " X-" + str(i))
    print("TOF-N-" + str(i) + " Y-" + str(i))
    print("TOF-S-" + str(i) + " Y-" + str(i + 2))
for i in range(24, 45):
    print("TOF-UP-" + str(45 - i) + " X-" + str(i + 2))
    print("TOF-DW-" + str(45 - i) + " X-" + str(i + 2))
    print("TOF-N-" + str(i) + " Y-" + str(i + 2))
    print("TOF-S-" + str(i) + " Y-" + str(i + 2))
