#!/usr/bin/python
# jaccard matrix error estimation in building arowana index
# Copyright (C) 2013 by Voxsup Inc.
# 
import sys
import os
import MySQLdb
import string
import time
import datetime
import urllib2
import urllib
import json
from random import randrange
import random

def getAffinity(id1,id2):
    if id1==id2:
        return 1
    query = "SELECT affinity_count FROM new_precise_interest.new_precise_interest WHERE id1='%s' AND id2='%s'" % (id1,id2)
    try:
        cursor.execute(query)
        row = cursor.fetchone()
        rt = int(row[0])
    except:
        rt = 0
    return rt

fb_ids = [ 5027904559,
			# YOUR OWN LIST HERE
				5862681191]

random.shuffle(fb_ids)
db = MySQLdb.connect(host="xxxxx", port=3306, user="xxxx", passwd="xxxx")
cursor = db.cursor()

start = time.time()
for id1 in fb_ids:
	row = []
	print "id1 writing..."
	for id2 in fb_ids:
		row.append(str(getAffinity(id1,id2)))
	with open("jaccard2.dat", "a") as myfile:
		myfile.write(' '.join(row))
		myfile.write('\n')

elapsed = (time.time() - start)
print "build time: "
print elapsed