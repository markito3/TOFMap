#!/usr/bin/env python
# looping over PMT labels, calculate module label
def pad(i):
    out = '%02d' % i
    return out
for i in range(1, 22):
    print("TOF-UP-" + str(45 - i) + " X-" + pad(i))
    print("TOF-DW-" + str(45 - i) + " X-" + pad(i))
    print("TOF-N-" + str(i) + " Y-" + pad(i))
    print("TOF-S-" + str(i) + " Y-" + pad(i))
for i in range(22, 24):
    print("TOF-UP-" + str(45 - i) + " X-" + pad(i + 2))
    print("TOF-DW-" + str(45 - i) + " X-" + pad(i))
    print("TOF-N-" + str(i) + " Y-" + pad(i))
    print("TOF-S-" + str(i) + " Y-" + pad(i + 2))
for i in range(24, 45):
    print("TOF-UP-" + str(45 - i) + " X-" + pad(i + 2))
    print("TOF-DW-" + str(45 - i) + " X-" + pad(i + 2))
    print("TOF-N-" + str(i) + " Y-" + pad(i + 2))
    print("TOF-S-" + str(i) + " Y-" + pad(i + 2))
