SECTOR_ANT ?= AM-5G19-120-Hpol.ant
SECTOR_PERMUTATIONS := hamwansectors hamwans1 hamwans12 hamwans13 hamwans2 hamwans23 hamwans3

default: coverage

ant: $(SECTOR_PERMUTATIONS:=.ant)

az: $(SECTOR_PERMUTATIONS:=.az)

%.az: %.ant
	../ant2azel.py $(@:az=ant)

coverage: az
	./hamwan-all-sites.py | sh

hamwansectors.ant:
	../cellularant.py ${SECTOR_ANT} 0 120 240 > $@

hamwans1.ant:
	../cellularant.py ${SECTOR_ANT} 0 > $@

hamwans12.ant:
	../cellularant.py ${SECTOR_ANT} 0 120 > $@

hamwans13.ant:
	../cellularant.py ${SECTOR_ANT} 0 240 > $@

hamwans2.ant:
	../cellularant.py ${SECTOR_ANT} 120 > $@

hamwans23.ant:
	../cellularant.py ${SECTOR_ANT} 120 240 > $@

hamwans3.ant:
	../cellularant.py ${SECTOR_ANT} 240 > $@
