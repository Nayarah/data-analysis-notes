ALTER TABLE `gcp_project.dm_mobility.viagens_bike`
ADD COLUMN id_estacao_destino STRING;



UPDATE `gcp_project.dm_mobility.viagens_bike` AS t

SET id_estacao_destino = 
    CASE
        -- Cria um ID de destino SIMULADO concatenando um sufixo.
        WHEN t.id_estacao_partida IS NOT NULL THEN t.id_estacao_partida || '-DEST'
        ELSE NULL
    END

WHERE TRUE; -- O WHERE TRUE garante que a cláusula WHERE existe e que todas as linhas são atualizadas.