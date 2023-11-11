#!/usr/bin/env python
import os
import ssl
import sys
from pprint import pprint as pp


def main(*argv):
    cert_file_base_name = "q016899247.crt"
    cert_file_name = os.path.join(os.path.dirname(__file__), cert_file_base_name)
    try:
        cert_dict = ssl._ssl._test_decode_cert(cert_file_name)
    except Exception as e:
        print("Error decoding certificate: {:}".format(e))
    else:
        print("Certificate ({:s}) data:\n".format(cert_file_base_name))
        pp(cert_dict)


if __name__ == "__main__":
    print("Python {:s} {:03d}bit on {:s}\n".format(" ".join(elem.strip() for elem in sys.version.split("\n")),
                                                   64 if sys.maxsize > 0x100000000 else 32, sys.platform))
    rc = main(*sys.argv[1:])
    print("\nDone.")
    sys.exit(rc)