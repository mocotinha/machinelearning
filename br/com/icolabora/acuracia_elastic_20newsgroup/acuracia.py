# -*- coding: UTF-8 -*-
from elasticsearch import Elasticsearch
import mysql.connector
from datetime import datetime
from sklearn.datasets import fetch_20newsgroups

loop = 0
arquivo = open("log_registros.log", "a+")
while loop < 16:
    loop +=1

    es = Elasticsearch()




    acerto = 0
    total = 0
    categories = [
        'alt.atheism',
        'talk.religion.misc',
        'comp.graphics',
        #'sci.space',
    ]
    for j in categories:
        newsgroups_train = fetch_20newsgroups(subset='test', categories=[j],
                                              shuffle=True, random_state=42,
                                              remove=('headers', 'footers', 'quotes'))
        for i in range(len(newsgroups_train.data)):
            email = newsgroups_train.data[i]
            # analyzer = 'classificacao_anatel'
            res = es.search(index="newsgroup", body={
                "query": {"common": {"email.classificacao": {"query": email, "analyzer": "classificacao_email", "cutoff_frequency": 0.001}}}, "size": loop})
            verificador = {}
            total += 1
            if res['hits']['total'] > 0:
                for hit in res['hits']['hits']:
                    if(verificador.has_key(hit['_source']['classe'])):
                        verificador[hit['_source']['classe']] += 1
                    else:
                        verificador[hit['_source']['classe']] = 1


                if max(verificador, key=verificador.get) == j:
                    acerto +=1

    print "%d acertos em %d registros - acurácia de %.2f"%(acerto,total,((acerto*100)/float(total)))
    arquivo.write("\nQuantidade de vizinhos - %d"%(loop))
    arquivo.write("\n%d acertos em %d registros - acurácia de %.2f"%(acerto,total,((acerto*100)/float(total))))


arquivo.close()








