#!/usr/bin/env python
"""Gets the list of HamWAN sites from the map API and generates coverage for
each"""

import json
import os
from os import path
import re

import requests

ignore_sites = {
    "Westin": True,
}

tower_height_feet = {
    "Paine": 150,
    "Baldi": 80,
    "Triangle": 80, # unverified
    "Gold": 80,
    "Crystal": 12,
    "McDonald": 80, # unverified
    "East Tiger": 30,
    "BawFaw": 80,
    "Larch": 120,
    "Beacon": 140,
    "Haystack": 12,
    "CapitolPark": 140,
    "Capitol Peak": 80,
    "Lookout": 100,
    "Buck": 25,
}


def get_sites():
    url = "http://hamwan.org/map/status.json"
    req = requests.get(url=url)
    return req.json()['SITES'].values()

def generate_coverage(site):
    name = site['NAME'].lower().replace(' ', '-') + "-coverage"

    if path.exists(name + ".kmz"):
        print "#", name, "already exists"
        return

    sectors = re.search(r"^/map/sector(\w+)\.png$", site['ICON']).group(1)
    sh_map = {
        's': 'ectors',
    }

    os.system("""echo ./hamwans{sectors}.sh \
        -lat {LATITUDE} \
        -lon {LONGITUDE} \
        -txh {txh} \
        -o {name}""".format(
            sectors=sh_map.get(sectors, sectors),
            name=name,
            **site))

def main():
    for site in get_sites():
        if site['NAME'] in ignore_sites:
            continue
        # print json.dumps(site)
        site['txh'] = tower_height_feet[site['NAME']]
        generate_coverage(site)


if __name__ == "__main__":
    main()

# Lookout
# ./hamwansectors.sh -lat 48.6875 -lon -122.3623 -txh 80 -o lookout-coverage

# Triangle

# SnoDEM

# Haystack

# Capitol Park

# Beacon

# Gold

# ETiger

# Baldi

# Crystal

# Capitol Peak

# BawFaw

# Larch
