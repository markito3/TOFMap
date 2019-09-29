SELECT pmtLocation.id as ID, pmtLocation.label AS Cable_Label, serialNo as PMT_Serial_No, layer as Layer, moduleLocation.label as Module_Label, moduleType as Module_Type, pmtLocation.end as Module_End
  FROM pmtLocation, pmt, moduleLocation
  WHERE pmt.pmtLocationId = pmtLocation.id
  AND moduleLocationId = moduleLocation.id ORDER BY pmtLocation.id;
