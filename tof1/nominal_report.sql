SELECT pmtLocation.id as ID, pmtLocation.label AS Cable_Label, serialNo as PMT_Serial_No, layer as Layer, moduleType as Module_Type
  FROM pmtLocation, pmt, moduleLocation
  WHERE pmt.pmtLocationId = pmtLocation.id
  AND moduleLocationId = moduleLocation.id ORDER BY pmtLocation.id;
