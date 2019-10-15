#!/usr/bin/env python
import sys
i = 0
for line in sys.stdin:
    i = i + 1
    liner = line.rstrip()
    fields = liner.split()
    nfields = len(fields)
#    print(i, fields)
    id = int(fields[0])
    label = fields[4]
    end = int(fields[6])
    lfields = label.split('-')
    edge = lfields[1]
    if edge == 'N':
        orientation = 'H'
        index = 47 - i
    elif edge == 'S':
        orientation = 'H'
        index = i
    elif edge == 'UP':
        orientation = 'V'
        index = i
    elif edge == 'DW':
        orientation = 'V'
        index = 47 - i
    else:
        print('error')
        exit
    if end == 1:
        endchar = '+'
    elif end == -1:
        endchar = '-'
    else:
        print('error')
        exit
    print('UPDATE pmtLocation set labelPhysics = \"'  + orientation + '%02d' % index + endchar + '\" WHERE id = ' + fields[0] + ';')
    if i == 46:
        i = 0
