#!/bin/bash
i=0
output=
while read line
do
	output+=" fill rgb(${line#*:}) circle 10,$((i+10)) 5,$((i+5))"
	output+=" text 25,$((i+15)) '> ${line%:*} dBm'"
	((i+=20))
done
echo convert -size 100x$i xc:white -draw \""$output"\" legend.png
