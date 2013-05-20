#!/usr/bin/python
# processes customer requests on the fly. tag features to comments
# python CreateTimeCacheTable.py 1 1
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

db = MySQLdb.connect(host="xxxxx", port=3306, user="xxxxx", passwd="xxxx")
cursor = db.cursor()

fids = [1,6,8364,838,8448,18,3397,32,17,2129,554,366,506,8163,55716,8164,395,8091,24,23,16]
rows_to_write = {}
for fid in fids:
    print "processing %s ..." % (fid)
    # create cache table
    query = "SELECT user_id , fid FROM fb_fe.fb_comment_like_access WHERE fid=%s LIMIT 80000" % (fid)
    try:
        cursor.execute(query)
    except:
        print "error executing " + query

    for j in xrange(cursor.rowcount):
        row = cursor.fetchone()
        try:
            rows_to_write[row[0]].append(row[1])
        except:
            rows_to_write[row[0]] = [row[1]]

with open("sensitivityRecSyS.dat", "a") as myfile:
    for key in rows_to_write.keys():
        access_list = rows_to_write[key]
        mask = [ 1 if fid in access_list else 0 for fid in fids ]
        # only keeyp nonsparse ones.
        if sum(mask) > 1:
            mask = [ str(item) for item in mask ]
            myfile.write(' '.join(mask))
            myfile.write('\n')
print "done!"
