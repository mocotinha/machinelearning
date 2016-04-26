# -*- coding: UTF-8 -*-
from elasticsearch import Elasticsearch
from sklearn.datasets import fetch_20newsgroups
import time
import random
import uuid
#from pprint import pprint

es = Elasticsearch()


categories = [
        'alt.atheism',
        'talk.religion.misc',
        'comp.graphics',
        #'sci.space',
    ]
for j in categories:
    newsgroups_train = fetch_20newsgroups(subset='train', categories=[j],
                                shuffle=True, random_state=42,
                                remove=('headers', 'footers', 'quotes'))

    for i in range(len(newsgroups_train.data)):

        doc = {'email': newsgroups_train.data[i],
               'classe':j,
               }
        try:

            res = es.index(index="newsgroup", doc_type='email', id=uuid.uuid4(), body=doc)
        except:
            continue
        print(res['created'])






