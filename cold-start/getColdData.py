#!/usr/bin/python
# processes customer requests on the fly. tag features to comments
# python getColdData.py mymatrix.dat
# Copyright (c) 2013 All Right Reserved, Voxsup Inc.
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

filename = str(sys.argv[1])
db = MySQLdb.connect(host="10.1.1.xxxxx", port=3306, user="xxxxx", passwd="xxxxx")
cursor = db.cursor()
# choose Walmart as the wall to predict. i.e. the one with sparse data
# we will pull its most-related walls from DB to treat them as what we discover from LASSO SParse regression
# then We will set up a few matrices to complete, each of which contained more content-information. The baseline 
# matrix would be just user-brand co-filtering matrix. then we add attribute contents rows such as country, language,
# category, likes etc. Then we can add rows that signify the intersection with selected walls.
# 
# The plan is to use matrix completion technologies to fill the user preference on walmart.
# a proposed way to evaluate this cold-start-handling strategy is to use precise interests.
# 1. fill w,the sparse column by TFOCS.
# relative err: Relative error fill all 0s:  12.95697829% ( 65.35627357% against full matrix)
#               Relative error only walmart 0s:  0.19969832% ( 64.60999208%)
# 2. cluster the users. cosClustSp999WalFil,cosClustSp999AllFil
# 3. for each cluster of users, learn f(a,b,c,a*b,b*c,a*c,ALLwalls/w) (how??)
# using kmeans k=20 is noticeably better than k=10 in final correlation and convergence 
# WalFill and AllFill seem to give close results in the end.
# 4. update the sparse column using learned f function (avg w/ existng val).
# 5. now w is not sparse, use NNMF on the matrix.
# 6. use NNMF to augment (a,b,c) to (a,b,c,d,e,f)
# 7. Go to 3
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

with open(filename, "a") as myfile:
    for key in rows_to_write.keys():
        access_list = rows_to_write[key]
        mask = [ access_list[fid] if fid in access_list else 0 for fid in fids ]
        # only keeyp nonsparse ones.
        if sum([1 for x in mask if x > 0]) > 1:
            mask = [ str(item) for item in mask ]
            myfile.write(' '.join(mask))
            myfile.write('\n')
print "done!"
