/*
O Objetivo
Crie uma query que retorne o seguinte resultado:

A Estação de Partida (nome_estacao).

A Estação de Destino (nome_estacao).

O número total de viagens realizadas nessa rota (Partida → Destino).

O Tempo Médio de Viagem para essa rota (em minutos, com duas casas decimais).

O Tipo de Rota: Se a viagem de ida e volta (Rota A → B e Rota B → A) for feita pelo menos 3 vezes, classifique como Rota Diária Comum. Caso contrário, classifique como "Rota Avulsa".
*/

WITH base_com_simetria AS (
    SELECT
        -- Cria o identificador simétrico (a chave para a contagem total)
        LEAST(id_estacao_partida, REPLACE(id_estacao_destino, '-DEST', '')) || '-' || 
        GREATEST(id_estacao_partida, REPLACE(id_estacao_destino, '-DEST', '')) AS rota_simetrica,
        
        id_estacao_partida, -- Mantém para a junção
        id_estacao_destino, -- Mantém para a junção
        
        COUNT(id_viagem) AS total_viagens_AB, -- Volume apenas da rota A->B
        CAST(AVG(duracao_segundos/60)AS INT64) AS tempo_medio_AB -- Média da rota A->B

    FROM `gcp_project.dm_mobility.viagens_bike` 
    GROUP BY 1, 2, 3 -- Agrupa pelo identificador simétrico e pelas estações originais
)

,contagem_simetrica AS (
    SELECT
        rota_simetrica,
        SUM(total_viagens_AB) AS volume_ida_e_volta
    FROM base_com_simetria
    GROUP BY 1
)

,base_viages AS(
  SELECT
    b.rota_simetrica,
    b.id_estacao_partida,
    e.nome_estacao AS estacao_partida,
    b.id_estacao_destino,
    ed.nome_estacao AS estacao_destino,
    b.total_viagens_AB,
    b.tempo_medio_AB,
    s.volume_ida_e_volta

  FROM base_com_simetria AS b
  INNER JOIN contagem_simetrica AS s ON b.rota_simetrica = s.rota_simetrica
  INNER JOIN `gcp_project.dm_mobility.estacoes_bike` AS e ON b.id_estacao_partida = e.id_estacao
  INNER JOIN `gcp_project.dm_mobility.estacoes_bike` AS ed ON ed.id_estacao = REPLACE(b.id_estacao_destino, '-DEST', '') 
)

SELECT
    b.estacao_partida,
    b.estacao_destino,
    b.total_viagens_AB,
    b.tempo_medio_AB,
    
    -- O CASE WHEN FINAL:
    CASE
        WHEN volume_ida_e_volta >= 3 THEN 'Rota Diária Comum'
        ELSE 'Rota Avulsa'
    END AS tipo_rota

FROM base_viages AS b
ORDER BY total_viagens_AB DESC;