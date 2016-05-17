SELECT
    UUID() AS ID,
    RECLAMACAO.TEXT_ AS RECLAMACAO,
    DATA_REGISTRO.TEXT_ AS DATA_REGISTRO,
    UF.TEXT_ AS UF,
    CIDADE.TEXT_ AS CIDADE,
    SERVICO.TEXT_ AS SERVICO,
    MOTIVO.TEXT_ AS MOTIVO,
    SUBMOTIVO.TEXT_ AS SUBMOTIVO,
    VAR2.TEXT_ AS RECLAMACAO
FROM
    ACT_RE_PROCDEF DEF
        INNER JOIN
    ACT_HI_PROCINST PROC ON PROC.PROC_DEF_ID_ = DEF.ID_
        AND DEF.KEY_ = 'atendimento'
        INNER JOIN
    ACT_HI_VARINST VAR ON VAR.PROC_INST_ID_ = PROC.ID_
        AND VAR.NAME_ = 'canalEntrada'
        AND VAR.TEXT_ = 'Fale Conosco'
        INNER JOIN
    ACT_HI_VARINST RECLAMACAO ON RECLAMACAO.PROC_INST_ID_ = PROC.ID_
        AND RECLAMACAO.NAME_ = 'descricao_reclamacao'
        INNER JOIN
    ACT_HI_VARINST VAR2 ON VAR.PROC_INST_ID_ = PROC.ID_
        AND VAR2.NAME_ = 'tipo_atendimento'
        AND VAR2.TEXT_ = 'Reclamação'
        INNER JOIN
    ACT_HI_VARINST DATA_REGISTRO ON DATA_REGISTRO.PROC_INST_ID_ = PROC.ID_
        AND DATA_REGISTRO.NAME_ = 'data_registro'
        INNER JOIN
    ACT_HI_VARINST UF ON UF.PROC_INST_ID_ = PROC.ID_
        AND UF.NAME_ = 'uf_cliente'
        INNER JOIN
    ACT_HI_VARINST CIDADE ON CIDADE.PROC_INST_ID_ = PROC.ID_
        AND CIDADE.NAME_ = 'cidade_cliente'
        INNER JOIN
    ACT_HI_VARINST SERVICO ON SERVICO.PROC_INST_ID_ = PROC.ID_
        AND SERVICO.NAME_ = 'servico'
        INNER JOIN
    ACT_HI_VARINST MOTIVO ON MOTIVO.PROC_INST_ID_ = PROC.ID_
        AND MOTIVO.NAME_ = 'cb_script_motivo'
        INNER JOIN
    ACT_HI_VARINST SUBMOTIVO ON SUBMOTIVO.PROC_INST_ID_ = PROC.ID_
        AND SUBMOTIVO.NAME_ = 'cb_script_submotivo'
