#!/usr/bin/env python
id = 0
ends = ['+1', '-1', '+1', '-1']
endnames = ['UP', 'DW', 'N', 'S']
tab = '\t'
for iend in range(0,4):
    end = ends[iend]
    endname = endnames[iend]
    for iseq in range(1,45):
        id += 1
        print(str(id) + tab + '0' + tab + end + tab + 'TOF-' + endname + '-' + str(iseq))

