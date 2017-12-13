## written by Ed Mountjoy

#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# Take stdout from "qctool -g <bgen> -og -"

import sys

def main():

    # Start column for dosages (index 0)
    dosage_start = 6

    for line in sys.stdin:

        parts = line.rstrip().split(" ")
        # Get dosages
        dosages = parts[dosage_start:]
        # Assert that its a multiple of 3
        assert(len(dosages) % 3 == 0)
        # Convert to additive expected value
        expected = [str(dos2expected(chunk)) for chunk in chunks(dosages, 3)]
        # Put back together
        sys.stdout.write(" ".join(parts[:dosage_start] + expected)+ "\n")

    return 0

def dos2expected(triplet):
    return float(triplet[1]) + 2 * float(triplet[2])

def chunks(l, n):
    """Yield successive n-sized chunks from l."""
    for i in xrange(0, len(l), n):
        yield l[i:i+n]

if __name__ == '__main__':

    main()

