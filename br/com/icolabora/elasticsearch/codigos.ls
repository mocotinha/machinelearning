DELETE newsgroup

PUT /newsgroup
{
   "settings": {
      "analysis": {
         "analyzer": {
            "classificacao_email": {
               "type": "custom",
               "tokenizer": "lowercase",
               "filter": [
                  "asciifolding",
                  "stem_minimal",
                  "english_stop",
                  "token_type"
               ],
               "char_filter": [
                  "html_strip"
               ]
            }

         },
             "filter": {

            "stem_minimal": {
               "type": "stemmer",
               "language": "english"
            },
            "english_stop": {
               "type": "stop",
               "stopwords": "_english_"
            },

            "token_type": {
               "type": "word_delimiter",
               "catenate_words": true

            }
         },
         "number_of_shards": 5,
         "number_of_replicas": 2

      }
   }
}

PUT /newsgroup
{
   "settings": {
      "analysis": {
         "analyzer": {
            "classificacao_email": {
               "type": "custom",
               "tokenizer": "lowercase",
               "filter": [
                  "custom_stop_words",
                  "asciifolding",
                  "stem_minimal_pt",
                  "brazilian_stop",
                  "token_type"
               ],
               "char_filter": [
                  "html_strip"
               ]
            },
            "classificacao_anatel_commons_index": {
               "type": "custom",
               "tokenizer": "lowercase",
               "filter": [
                  "custom_stop_words",
                  "index_filter",
                  "stem_minimal_pt",
                  "brazilian_stop",
                  "token_type"
               ],
               "char_filter": [
                  "html_strip"
               ]
            },
            "classificacao_anatel_commons_search": {
               "type": "custom",
               "tokenizer": "lowercase",
               "filter": [
                  "custom_stop_words",
                  "search_filter",
                  "stem_minimal_pt",
                  "brazilian_stop",
                  "token_type"
               ],
               "char_filter": [
                  "html_strip"
               ]
            }

         },
             "filter": {
                 "index_filter": {
              "type":         "common_grams",
              "common_words": "_brazilian_"
            },
            "search_filter": {
              "type":         "common_grams",
              "common_words": "_brazilian_",
              "query_mode":   true
            },
            "stem_minimal_pt": {
               "type": "stemmer",
               "language": "brazilian"
            },
            "brazilian_stop": {
               "type": "stop",
               "stopwords": "_brazilian_"
            },
            "custom_stop_words": {
               "type": "stop",
               "stopwords": [
                  "a",
                  "à",
                  "agora",
                  "ainda",
                  "alguém",
                  "algum",
                  "alguma",
                  "algumas",
                  "alguns",
                  "ampla",
                  "amplas",
                  "amplo",
                  "amplos",
                  "ante",
                  "antes",
                  "ao",
                  "aos",
                  "após",
                  "aquela",
                  "aquelas",
                  "aquele",
                  "aqueles",
                  "aquilo",
                  "as",
                  "até",
                  "ate",
                  "através",
                  "cada",
                  "coisa",
                  "coisas",
                  "com",
                  "como",
                  "contra",
                  "contudo",
                  "da",
                  "daquele",
                  "daqueles",
                  "das",
                  "de",
                  "dela",
                  "delas",
                  "dele",
                  "deles",
                  "depois",
                  "dessa",
                  "dessas",
                  "desse",
                  "desses",
                  "desta",
                  "destas",
                  "deste",
                  "deste",
                  "destes",
                  "deve",
                  "devem",
                  "devendo",
                  "dever",
                  "deverá",
                  "deverão",
                  "deveria",
                  "deveriam",
                  "devia",
                  "deviam",
                  "disse",
                  "disso",
                  "disto",
                  "dito",
                  "diz",
                  "dizem",
                  "do",
                  "dos",
                  "e",
                  "é",
                  "e'",
                  "ela",
                  "elas",
                  "ele",
                  "eles",
                  "em",
                  "enquanto",
                  "entre",
                  "era",
                  "essa",
                  "essas",
                  "esse",
                  "esses",
                  "esta",
                  "está",
                  "estamos",
                  "estão",
                  "estas",
                  "estava",
                  "estavam",
                  "estávamos",
                  "este",
                  "estes",
                  "estou",
                  "eu",
                  "fazendo",
                  "fazer",
                  "feita",
                  "feitas",
                  "feito",
                  "feitos",
                  "foi",
                  "for",
                  "foram",
                  "fosse",
                  "fossem",
                  "grande",
                  "grandes",
                  "há",
                  "isso",
                  "isto",
                  "já",
                  "la",
                  "la",
                  "lá",
                  "lhe",
                  "lhes",
                  "lo",
                  "mas",
                  "me",
                  "mesma",
                  "mesmas",
                  "mesmo",
                  "mesmos",
                  "meu",
                  "meus",
                  "minha",
                  "minhas",
                  "muita",
                  "muitas",
                  "muito",
                  "muitos",
                  "na",
                  "não",
                  "nas",
                  "nem",
                  "nenhum",
                  "nessa",
                  "nessas",
                  "nesta",
                  "nestas",
                  "ninguém",
                  "no",
                  "nos",
                  "nós",
                  "nossa",
                  "nossas",
                  "nosso",
                  "nossos",
                  "num",
                  "numa",
                  "nunca",
                  "o",
                  "os",
                  "ou",
                  "outra",
                  "outras",
                  "outro",
                  "outros",
                  "para",
                  "pela",
                  "pelas",
                  "pelo",
                  "pelos",
                  "pequena",
                  "pequenas",
                  "pequeno",
                  "pequenos",
                  "per",
                  "perante",
                  "pode",
                  "pôde",
                  "podendo",
                  "poder",
                  "poderia",
                  "poderiam",
                  "podia",
                  "podiam",
                  "poucas",
                  "pouco",
                  "poucos",
                  "primeiro",
                  "primeiros",
                  "própria",
                  "próprias",
                  "próprio",
                  "próprios",
                  "quais",
                  "qual",
                  "quando",
                  "quanto",
                  "quantos",
                  "que",
                  "quem",
                  "são",
                  "se",
                  "seja",
                  "sejam",
                  "sem",
                  "sempre",
                  "sendo",
                  "será",
                  "serão",
                  "seu",
                  "seus",
                  "si",
                  "sido",
                  "só",
                  "sob",
                  "sobre",
                  "sua",
                  "suas",
                  "talvez",
                  "também",
                  "tampouco",
                  "te",
                  "tem",
                  "tendo",
                  "tenha",
                  "ter",
                  "teu",
                  "teus",
                  "ti",
                  "tido",
                  "tinha",
                  "tinham",
                  "toda",
                  "todas",
                  "todavia",
                  "todo",
                  "todos",
                  "tu",
                  "tua",
                  "tuas",
                  "tudo",
                  "última",
                  "últimas",
                  "último",
                  "últimos",
                  "um",
                  "uma",
                  "umas",
                  "uns",
                  "vendo",
                  "ver",
                  "vez",
                  "vindo",
                  "vir",
                  "vos",
                  "vós",
                  "protocolo",
                  "prestadora",
                  "data",
                  "dia",
                  "operadora",
                  "reclamacao",
                  "reclama",
                  "problema",
                  "pede",
                  "porem",
                  "consumidor",
                  "consumidora",
                  "indevidamente",
                  "ja",
                  "mais",
                  "solicita",
                  "nao",
                  "sim",
                  "pois",
                  "por",
                  "porém",
                  "porque",
                  "posso",
                  "pouca",
                  "poucas",
                  "pouco",
                  "poucos",
                  "primeiro",
                  "primeiros",
                  "própria",
                  "próprias",
                  "próprio",
                  "próprios",
                  "quais",
                  "qual",
                  "quando",
                  "quanto",
                  "quantos",
                  "que",
                  "quem",
                  "são",
                  "se",
                  "seja",
                  "sejam",
                  "sem",
                  "sempre",
                  "sendo",
                  "será",
                  "serão",
                  "seu",
                  "seus",
                  "si",
                  "sido",
                  "só",
                  "sob",
                  "sobre",
                  "sua",
                  "suas",
                  "talvez",
                  "também",
                  "tampouco",
                  "te",
                  "tem",
                  "tendo",
                  "tenha",
                  "ter",
                  "teu",
                  "teus",
                  "ti",
                  "tido",
                  "tinha",
                  "tinham",
                  "toda",
                  "todas",
                  "todavia",
                  "todo",
                  "todos",
                  "tu",
                  "tua",
                  "tuas",
                  "tudo",
                  "última",
                  "últimas",
                  "último",
                  "últimos",
                  "um",
                  "uma",
                  "umas",
                  "uns",
                  "vendo",
                  "ver",
                  "vez",
                  "vindo",
                  "vir",
                  "vos",
                  "vós",
                  "protocolo",
                  "prestadora",
                  "data",
                  "dia",
                  "operadora",
                  "reclamacao",
                  "reclama",
                  "problema",
                  "pede",
                  "porem",
                  "consumidor",
                  "consumidora",
                  "indevidamente",
                  "ja",
                  "mais",
                  "solicita",
                  "nao",
                  "sim"
               ]
            },
            "token_type": {
               "type": "word_delimiter",
               "catenate_words": true,
               "catenate_all": true,
               "split_on_case_change": true,
               "split_on_numerics": true
            }
         },
         "number_of_shards": 5,
         "number_of_replicas": 2
      }
   }
}

GET _cat/indices?v

DELETE /machine_learning

GET /_cluster/health

GET machine_learning

GET reclamacao/_search

GET machine_learning/reclamacao/_search
{
    "query": {
        "match_all": {}
    },"aggs" : {
        "servicos" : { "terms" : { "field" : "SERVICO" }},
        "motivo" : {"terms" : { "field" : "MOTIVO"}},
        "submotivo" : {"terms" : { "field" : "SUBMOTIVO"}},
        "tipo_atendimento" : {"terms" : { "field" : "TIPO_ATENDIMENTO"}}

    }
}

GET machine_learning/reclamacao/_search?analyzer=classificacao_anatel
{
    "query": {
        "common" :{
            "RECLAMACAO.classificacao":{
                "query": "TV por assinatura",
                "cutoff_frequency": 0.001
            }

        }
    },
    "size": 10,
    "aggs" : {
        "servicos" : { "terms" : { "field" : "SERVICO" }},
        "motivo" : {"terms" : { "field" : "MOTIVO"}},
        "submotivo" : {"terms" : { "field" : "SUBMOTIVO"}},
        "tipo_atendimento" : {"terms" : { "field" : "TIPO_ATENDIMENTO"}}

    }
}

GET newsgroup/email/_search
{
    "query": {
        "match_all": {}
    }
}

DELETE  newsgroup

GET machine_learning_treino/_mapping/reclamacao

PUT newsgroup/_mapping/email
{
   "email": {
      "properties": {
         "email": {
            "type": "string",
            "fields": {
               "raw": {
                  "type": "string",
                  "index": "not_analyzed"
               },
               "classificacao": {
                  "type": "string",
                  "index_options": "freqs",
                  "analyzer": "classificacao_email"
               }
            }
         },
         "classe": {
            "type": "string",
            "index": "not_analyzed"
         }
      }
   }
}


PUT machine_learning/_mapping/reclamacao
{
   "reclamacao": {
      "properties": {
         "ID": {
            "type": "string",
            "index": "not_analyzed"
         },
         "RECLAMACAO": {
            "type": "string",
            "fields": {
               "raw": {
                  "type": "string",
                  "index": "not_analyzed"
               },
               "classificacao": {
                  "type": "string",
                  "analyzer": "classificacao_anatel",
                  "similarity": "BM25"
               }
            }
         },
         "DATA_REGISTRO": {
            "type": "date"
         },
         "UF": {
            "type": "string"
         },
         "CIDADE": {
            "type": "string",
            "index": "not_analyzed"
         },
         "SERVICO": {
            "type": "string",
            "index": "not_analyzed"
         },
         "MOTIVO": {
            "type": "string",
            "index": "not_analyzed"
         },
         "SUBMOTIVO": {
            "type": "string",
            "index": "not_analyzed"
         },
         "TIPO_ATENDIMENTO": {
            "type": "string",
            "index": "not_analyzed"
         }
      }
   }
}
