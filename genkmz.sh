#!/bin/bash
while read line
do
	echo $line
	if [[ $line == Writing* ]]
	then
		while IFS='"' read -ra writingline
		do
			filename=${writingline[1]%.*}
		done <<< $line
	fi
	if [[ $line == \|* ]]
	then
		while IFS='|' read -ra coords
		do
			cat << EOF > doc.kml
<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2" xmlns:kml="http://www.opengis.net/kml/2.2" xmlns:atom="http://www.w3.org/2005/Atom">
<Document>
<GroundOverlay>
    <name>${filename}</name>
    <Icon>
        <href>${filename}.png</href>
    </Icon>
    <LatLonBox>
        <north>${coords[1]}</north>
        <east>${coords[2]}</east>
        <south>${coords[3]}</south>
        <west>${coords[4]}</west>
    </LatLonBox>
</GroundOverlay>
<ScreenOverlay>
    <name>Legend</name>
    <Icon>
        <href>legend.png</href>
    </Icon>
    <overlayXY x="0" y="1" xunits="fraction" yunits="fraction" />
    <screenXY x="0" y="1" xunits="fraction" yunits="fraction" />
    <rotationXY x="0" y="0" xunits="fraction" yunits="fraction" />
    <size x="0" y="0" xunits="fraction" yunits="fraction" />
</ScreenOverlay>
</Document>
</kml>
EOF
		done <<< $line
	fi
done
./genlegend.sh < "${filename}.dcf" | sh
zip "${filename}" "${filename}.png" doc.kml legend.png
mv "${filename}".zip "${filename}".kmz
echo Generated "${filename}".kmz
