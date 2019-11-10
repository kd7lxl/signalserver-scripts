#!/bin/bash
# example usage: ./hamwansectors.sh -lat 48.7080722 -lon -122.3930283 -txh 60 -o GalbraithAllSectors
for name; do true; done
cp "${0%.sh}.az" $name.az
cp "${0%.sh}.el" $name.el
cat <<- EOF > $name.dcf
-70: 255, 0, 0
EOF
../genpng.sh -f 5900 -erp 39811 -rxh 30 -rt -70 -R 62 $@ | ../genkmz.sh
