# -*- coding: UTF-8 -*-
from elasticsearch import Elasticsearch
import mysql.connector
from datetime import datetime

loop = 0
while loop < 16:
    loop +=1
    cnx = mysql.connector.connect(user='root', password='jozias123',
                                  host='127.0.0.1',
                                  database='machinelearning')
    es = Elasticsearch([{'host': 'localhost'}])
    cursor = cnx.cursor()

    query = ("SELECT * FROM ML_BASE_TESTE WHERE RECLAMACAO IS NOT NULL or RECLAMACAO != '' ")

    now = datetime.now()
    arquivo = open("log_registros.log", "a+")
    cursor.execute(query)
    acerto = 0
    total = 0
    for i in cursor:
        reclamacao = i[1]
        # analyzer = 'classificacao_anatel'
        res = es.search(index="machine_learning_treino", body={
            "query": {"common": {"RECLAMACAO.classificacao": {"query": reclamacao, "analyzer": "classificacao_anatel", "cutoff_frequency": 0.001}}}, "size": loop})
        verificador = {}
        total += 1
        if res['hits']['total'] > 0:
            for hit in res['hits']['hits']:
                if(verificador.has_key(hit['_source']['SERVICO'])):
                    verificador[hit['_source']['SERVICO']] += 1
                else:
                    verificador[hit['_source']['SERVICO']] = 1


            if max(verificador, key=verificador.get) == i[5]:
                acerto +=1

    print "%d acertos em %d registros - acurácia de %.2f"%(acerto,total,((acerto*100)/float(total)))
    arquivo.write("\nQuantidade de vizinhos - %d"%(loop))
    arquivo.write("\n%d acertos em %d registros - acurácia de %.2f"%(acerto,total,((acerto*100)/float(total))))


    cnx.close()
    arquivo.close()








