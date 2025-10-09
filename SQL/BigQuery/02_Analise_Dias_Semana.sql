/* 
O Objetivo 
Crie uma query que classifique os dias da semana com base no total de viagens e retorne o seguinte resultado para cada dia: 

O dia da semana (ex: Segunda, Terça). 

O total de viagens realizadas nesse dia. 

A duração média das viagens (em minutos inteiros). 

O ranking desse dia (1º, 2º, 3º, etc.) com base no volume de viagens. 

O tipo de assinatura mais popular do dia (Anual ou Avulso). 
*/ 
WITH metricas_gerais AS( 
    SELECT 
        dia_semana, 
        tipo_assinatura, 
        COUNT(id_viagem) AS total_viagens, 
        CAST(AVG(duracao_segundos/60)AS INT64) AS duracao_media_minutos 
    FROM `gcp_project.dm_mobility.viagens_bike` 
    GROUP BY 1, 2 
    ORDER BY total_viagens DESC 
) 

,cont_tipo_assinatura AS( 
    SELECT 
        dia_semana, 
        tipo_assinatura, 
        COUNT(id_viagem)AS qtd_viagem 
    FROM 
        `gcp_project.dm_mobility.viagens_bike` 
    GROUP BY 1,2 
    ) 
,rank_assinatura AS( 
    SELECT 
        dia_semana, 
        tipo_assinatura, 
        qtd_viagem, 
        ROW_NUMBER()OVER (PARTITION BY dia_semana ORDER BY qtd_viagem DESC)AS rank_assinatura 
    FROM 
        cont_tipo_assinatura 
    ) 
,cont_dia_semana AS( 
    SELECT 
        dia_semana,
        SUM(qtd_viagem) AS total_viagens
    FROM 
        cont_tipo_assinatura
    GROUP BY 1
    ) 


 
,rank_dia_semana AS( 
    SELECT 
        dia_semana, 
        total_viagens, 
        ROW_NUMBER()OVER (ORDER BY total_viagens DESC)AS rank_dia 
    FROM 
        cont_dia_semana 
    ) 


SELECT 
        rs.dia_semana,
        rs.rank_dia, 
        rs.total_viagens,
        mg.duracao_media_minutos AS duracao_media,
        ra.rank_assinatura,
        ra.tipo_assinatura AS cliente_mais_popular
FROM rank_dia_semana AS rs

INNER JOIN rank_assinatura AS ra ON rs.dia_semana = ra.dia_semana

INNER JOIN metricas_gerais AS mg ON mg.dia_semana = ra.dia_semana AND mg.tipo_assinatura = ra.tipo_assinatura

WHERE ra.rank_assinatura = 1

ORDER BY rs.rank_dia
