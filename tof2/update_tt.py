#!/usr/bin/env python
import mysql.connector
import sqlite3 as lite
import sys

mydb = mysql.connector.connect(
  host="localhost",
  user="tofuser",
  passwd="",
  database="TOFMap2"
)

mycursor = mydb.cursor()

# Connect to SQLite DB file
db_filename = sys.argv[1]
print ""
print "opening SQLite DB file: %s" % db_filename
print "---------------------------------------------"
con = lite.connect(db_filename)
con.row_factory = lite.Row
cur = con.cursor()

# insert new ADC module
cur.execute("SELECT max(moduleid) FROM Module;")
row = cur.fetchone()
new_moduleid = str(row[0] + 1)
# use hardwired crate id and slot number
adcModuleInsertQuery = "INSERT INTO Module VALUES (" + new_moduleid + ", 61, 16, \"fADC250\", \"ACDI-???\");"
print(adcModuleInsertQuery)
cur.execute(adcModuleInsertQuery)
con.commit()

cur.execute("DROP TABLE IF EXISTS TOF2;")
createQuery = "CREATE TABLE TOF2(plane INT, bar INT, end TEXT, adc_chanid INTEGER, tdc_chanid INTEGER, disc_chanid INTEGER);"
cur.execute(createQuery)

theQuery = """select
splitterLocation.id, splitterLocation.label,
signalCable.label,
pmtLocation.end, pmtLocation.label, pmtLocation.labelPhysics,
moduleLocation.layer, moduleLocation.bar,
adcCable.label, adcCable.channel,
adcLocation.crateLocationId, adcLocation.slot,
discCable.label, discCable.channel,
discLocation.crateLocationId, discLocation.slot,
tdcCable.label, tdcCable.discChannel, tdcCable.tdcHalf, tdcCable.tdcChannel,
tdcLocation.crateLocationId, tdcLocation.slot
from
splitterLocation, signalCable, pmtLocation, moduleLocation, adcCable,
adcLocation, discCable, discLocation, tdcCable, tdcLocation
where
signalCable.splitterLocationId = splitterLocation.id
and pmtLocationId = pmtLocation.id
and moduleLocationId = moduleLocation.id
and adcCable.splitterLocationId = splitterLocation.id
and adcLocationId = adcLocation.id
and discCable.splitterLocationId = splitterLocation.id
and discCable.discLocationId = discLocation.id
and tdcCable.discLocationId = discLocation.id
and tdcLocationId = tdcLocation.id
and tdcCable.label = discCable.label
order by splitterLocation.id;"""

mycursor.execute(theQuery)

myresult = mycursor.fetchall()

for x in myresult:
  print(x)
  myend = x[3]
  layer = x[6]
  if layer == -1:
    plane = '1'
    if myend == -1:
      end = 'S'
    elif myend == 1:
      end = 'N'
    else:
      exit(1)
  elif layer == 1:
    plane = '0'
    if myend == -1:
      end = 'DW'
    elif myend == 1:
      end = 'UP'
    else:
      exit(1)
  else:
    exit(1)
  bar = str(x[7])
  print('bar =', bar)
  adcLabel = str(x[8])
  tdcLabel = str(x[16])
  discLabel = str(x[2])
  if bar == '23' or bar == '24':
    print('here comes trouble')
    cur.execute("SELECT MAX(chanid) FROM Channel")
    row = cur.fetchone()
    chanid = row[0]+1
    adcslot = str(x[11])
    adcModQuery = "SELECT moduleid FROM Module, Crate WHERE Crate.name = \"D2-1-TOP\" and slot = " + adcslot + " and Module.crateid = Crate.crateid;"
    print(adcModQuery)
    cur.execute(adcModQuery)
    row = cur.fetchone()
    adc_moduleid = str(row[0])
    channel = str(x[9])
    insertQuery = "INSERT INTO Channel (chanid, moduleid, name, channel, system,col_name, enable) VALUES (" + str(chanid) + ", " + adc_moduleid + ", \"" + adcLabel + "\", " + channel + ", \"TOF\", \"adc_chanid\", 1)"
    print(insertQuery)
    cur.execute(insertQuery)
    con.commit()
  adcQuery = "SELECT chanid FROM Channel WHERE name = \"" + adcLabel + "\";"
  print(adcQuery)
  cur.execute(adcQuery)
  row = cur.fetchone()
  adc_chanid = str(row[0])
  tdcQuery = "SELECT chanid FROM Channel WHERE name = \"" + tdcLabel + "\";"
  print(tdcQuery)
  cur.execute(tdcQuery)
  row = cur.fetchone()
  tdc_chanid = str(row[0])
  discQuery = "SELECT chanid FROM Channel WHERE name = \"" + discLabel + "\";"
  print(discQuery)
  cur.execute(discQuery)
  row = cur.fetchone()
  disc_chanid = str(row[0])
  liteQuery = "INSERT INTO TOF2 (plane, bar, end, adc_chanid, tdc_chanid, disc_chanid) VALUES (" + plane + ", " + bar + ", \"" + end + "\", " + adc_chanid + ", " + tdc_chanid + ", " + disc_chanid + ");"
  print(liteQuery)
  cur.execute(liteQuery)
  con.commit()
