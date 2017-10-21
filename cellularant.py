#!/usr/bin/env python
"""Combines sector antenna patterns for modeling an entire cell site at once.
Usage: ./cellularant.py input.ant AZIMUTH [AZIMUTH..]
Example: ./cellularant.py AM-5G19-120-Hpol.ant 0 120 240 > sectors_combined.ant
"""
import sys


class AntFile(object):
    def __init__(self, filename):
        with open(filename, 'r') as ant:
            self.az = [float(next(ant)) for i in xrange(360)]
            self.el = [float(next(ant)) for i in xrange(360)]

    def offset_az(self, direction):
        return [self.az[(i + direction) % 360] for i in xrange(360)]


def main():
    ant = AntFile(sys.argv[1])
    azimuths = [int(az) for az in sys.argv[2:]]
    adjusted_patterns = [ant.offset_az(az) for az in azimuths]

    for i in xrange(360):
        print max([pattern[i] for pattern in adjusted_patterns])
    for el in ant.el:
        print el

if __name__ == "__main__":
    main()
