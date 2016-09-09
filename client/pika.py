#!/usr/bin/python

import sys
from optparse import OptionParser
import urllib2
import json

parser = OptionParser()

parser.add_option("-e", "--expired-at", dest="expired_at", default=0, help="Set expiration, in minute")
parser.add_option("-s", "--syntax", dest="syntax", default="plain", help="Coloring syntax, see more: http://goo.gl/nLFqyB")
parser.add_option("-t", "--title", dest="title", default="", help="Title")

(options, args) = parser.parse_args()

PIKA_URL = 'https://pikab.in/'

payload = {
    'document': {
        'content': sys.stdin.read(),
        'title': options.title,
        'expired_at': options.expired_at,
        'syntax': options.syntax
    }
}

data = json.dumps(payload)
req = urllib2.Request(PIKA_URL, data, {'Content-Type': 'application/json'})

s = urllib2.urlopen(req)
print json.loads(s.read())['uri']

s.close()

