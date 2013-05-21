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

db = MySQLdb.connect(host="10.1.1.xxxxx", port=3306, user="xxxxx", passwd="xxxxx")
cursor = db.cursor()
# kindle amazon amazon-related, 
fids = [1,6,8364,838,7,18,3397,32,17,2129,554,366,506,8163,14,8164,395,8091,24,23,16,4,15,28,30,31,38,35]
rows_to_write = {}
for fid in fids:
    print "processing %s ..." % (fid)
    # create cache table
    query = "SELECT user_id , fid , num_of_likes+num_of_comments+num_of_liked FROM fb_fe.fb_comment_like_access WHERE fid=%s LIMIT 200000" % (fid)
    try:
        cursor.execute(query)
    except:
        print "error executing " + query

    for j in xrange(cursor.rowcount):
        row = cursor.fetchone()
        try:
            val = int(row[2])
        except:
            val = 1
        try:
            rows_to_write[row[0]][row[1]] = val
        except:
            rows_to_write[row[0]] = dict()
            rows_to_write[row[0]][row[1]] = val

with open("large.dat", "a") as myfile:
    for key in rows_to_write.keys():
        access_list = rows_to_write[key]
        mask = [ access_list[fid] if fid in access_list else 0 for fid in fids ]
        # only keeyp nonsparse ones.
        if sum([1 for x in mask if x > 0]) > 1:
            mask = [ str(item) for item in mask ]
            myfile.write(' '.join(mask))
            myfile.write('\n')
print "done!"
