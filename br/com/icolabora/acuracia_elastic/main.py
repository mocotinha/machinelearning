# -*- coding: UTF-8 -*-
from elasticsearch import Elasticsearch
import mysql.connector
from datetime import datetime

loop = 0
while loop < 16:
    loop +=1
    cnx = mysql.connector.connect(user='turbina', password='ico!@#',
                                  host='oimysql.icolabora.com.br',
                                  database='turbina_atento')
    es = Elasticsearch([{'host': 'localhost'}])
    cursor = cnx.cursor()

    #query = ("SELECT * FROM ML_BASE_TESTE WHERE RECLAMACAO IS NOT NULL or RECLAMACAO != '' ")
    query = ("SELECT replace(replace(replace(replace(replace(replace(replace(replace(CAST(RECLAMACAO.TEXT_ AS CHAR CHARACTER SET utf8), %s, %s), %s,%s), %s,%s), %s,%s),%s,%s), %s,%s), %s,%s), %s,%s) AS RECLAMACAO, replace(replace(replace(replace(replace(replace(replace(replace(CAST(SERVICO.TEXT_ AS CHAR CHARACTER SET utf8), %s, %s), %s,%s), %s,%s), %s,%s),%s,%s), %s,%s), %s,%s), %s,%s) AS SERVICO FROM ACT_HI_PROCINST PROC INNER JOIN ACT_RE_PROCDEF DEF ON DEF.KEY_= %s AND PROC.PROC_DEF_ID_ = DEF.ID_ INNER JOIN ACT_HI_VARINST VAR ON VAR.PROC_INST_ID_ = PROC.ID_ AND VAR.NAME_ = %s AND VAR.TEXT_ = %s INNER JOIN ACT_HI_VARINST RECLAMACAO ON RECLAMACAO.PROC_INST_ID_ = PROC.ID_ AND RECLAMACAO.NAME_ = %s INNER JOIN ACT_HI_VARINST VAR2 ON VAR2.PROC_INST_ID_ = PROC.ID_ AND VAR2.NAME_ = %s AND VAR2.TEXT_ = %s INNER JOIN ACT_HI_VARINST DATA_REGISTRO ON DATA_REGISTRO.PROC_INST_ID_ = PROC.ID_ AND DATA_REGISTRO.NAME_ = %s INNER JOIN ACT_HI_VARINST UF ON UF.PROC_INST_ID_ = PROC.ID_ AND UF.NAME_ = %s INNER JOIN ACT_HI_VARINST CIDADE ON CIDADE.PROC_INST_ID_ = PROC.ID_ AND CIDADE.NAME_ = %s INNER JOIN ACT_HI_VARINST SERVICO ON SERVICO.PROC_INST_ID_ = PROC.ID_ AND SERVICO.NAME_ = %s INNER JOIN ACT_HI_VARINST MOTIVO ON MOTIVO.PROC_INST_ID_ = PROC.ID_ AND MOTIVO.NAME_ = %s INNER JOIN ACT_HI_VARINST SUBMOTIVO ON SUBMOTIVO.PROC_INST_ID_ = PROC.ID_ AND SUBMOTIVO.NAME_ = %s WHERE RECLAMACAO.TEXT_ IS NOT NULL AND RECLAMACAO.TEXT_ != %s")

    now = datetime.now()
    arquivo = open("log_registros.log", "a+")
    aux = (":"," ","\n"," ","|"," ","\r"," ",";"," ",",", "","/"," ","\\"," ",":"," ","\n"," ","|"," ","\r"," ",";"," ",",", "","/"," ","\\"," ","atendimento","canalEntrada","Fale Conosco","descricao_reclamacao","tipo_atendimento","Reclamação","data_registro","uf_cliente","cidade_cliente","servico","cb_script_motivo","cb_script_submotivo","")
    cursor.execute(query,aux)
    acerto = 0
    total = 0

    for i in cursor:
        reclamacao = i[0]
        # analyzer = 'classificacao_anatel'
        res = es.search(index="machine_learning_oi", body={
            "query": {"common": {"reclamacao.classificacao": {"query": reclamacao, "analyzer": "classificacao_email", "cutoff_frequency": 0.001}}}, "size": loop})
        verificador = {}
        total += 1
        if res['hits']['total'] > 0:
            for hit in res['hits']['hits']:
                if(verificador.has_key(hit['_source']['servico'])):
                    verificador[hit['_source']['servico']] += 1
                else:
                    verificador[hit['_source']['servico']] = 1

            t1 = max(verificador, key=verificador.get).encode('ascii','ignore')
            t2 = i[1].encode('ascii','ignore')
            if t1 == t2:
                acerto +=1


    print "%d acertos em %d registros - acurácia de %.2f"%(acerto,total,((acerto*100)/float(total)))
    arquivo.write("\nQuantidade de vizinhos - %d"%(loop))
    arquivo.write("\n%d acertos em %d registros - acurácia de %.2f"%(acerto,total,((acerto*100)/float(total))))


    cnx.close()
    arquivo.close()








