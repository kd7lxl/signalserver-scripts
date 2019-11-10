#!/bin/bash
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
PATH=$DIR/../Signal-Server:$PATH
SRTMDIR=/raid/share/Software/Mapping\&GPS/SRTM/splat

if [[ $# -eq 0 ]] ; then
	echo Usage:
	echo $0 -lat 46.4879 -lon -123.2144 -txh 60 -f 145 -erp 30 -rxh 5 -rt -100 -R 80 -o outfile | ./genkmz.sh
	echo The last argument must be the output name.
	exit 1
fi

for name; do true; done

#time ./signalserverHD -sdf $SRTMDIR/SRTM1 -dbm -pm 1 -dbg $@ 2>&1
time nice signalserver -sdf $SRTMDIR/SRTM3 -dbm -pm 1 -dbg $@ 2>&1
# to resize, add: -resize 7000x7000\>
convert $name.ppm -transparent white $name.png
