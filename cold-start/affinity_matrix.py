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
    query = "SELECT affinity_count,lift_on_id1 FROM new_precise_interest.new_precise_interest WHERE id1='%s' AND id2='%s'" % (id1,id2)
    try:
        cursor.execute(query)
        row = cursor.fetchone()
        rt = (int(row[0]) , float(row[1]) )
    except:
        rt = (0, 0)
    return rt
def getFBID(fid):
    query = "SELECT fb_id FROM fb_fe.category WHERE fid=%s" % (fid)
    try:
        cursor.execute(query)
        row = cursor.fetchone()
        rt = row[0]
    except:
        rt = 0
    return rt


filename = str(sys.argv[1])
#random.shuffle(fb_ids)
db = MySQLdb.connect(host="xxxxx", port=3306, user="xxxx", passwd="xxxx")
cursor = db.cursor()

fids = [554, # wal mart
        23, # master card
        506, # target
        395, # kohls
        12, # citiBank USA
        4, # McDonalds
        24, # VISA signature
        3605, # Samsung USA
        3210, # macys
        4570, # kellogg pop tarts
        6020, # FRS healthy performance
        455, # old navy
        871, # CVS
        13, # pepsi
        6278, # charles schwab
        6, # Amazon.com
        489, # sears
        2787] # nexxus

fb_ids = [getFBID(fid) for fid in fids]

start = time.time()
for id1 in fb_ids:
	row = []
    row2 = []
	print "id1 writing..."
	for id2 in fb_ids:
        aff,lft = getAffinity(id1,id2)
		row.append(str(aff))
        row2.append(str(lft))
	with open("aff_"+filename, "a") as myfile:
		myfile.write(' '.join(row))
		myfile.write('\n')
    with open("lft_"+filename, "a") as myfile:
        myfile.write(' '.join(row))
        myfile.write('\n')

elapsed = (time.time() - start)
print "build time: "
print elapsed