/*Pergunta de negócio:
QUAL A MUSICA MAIS LUCRATIVA DE CADA ARTISTA?

O relatório final deve ter uma linha para cada música, mas você só deve mostrar as músicas que são o Rank 1 para o seu respectivo artista.

O relatório deve conter:

Nome do Artista.
Nome da Música.
Receita Total da Música..
Receita Média do Artista: A média da receita gerada por todas as músicas daquele artista (o benchmark interno).
 */
SELECT *
FROM(
	SELECT 
	--Aplicando row_number() para criar um rank de musicas mais lucrativa por artista
		t3.Artista,
		t3.Musica,
		t3.Receita_musica,
		t3.media_artista,
		ROW_NUMBER()OVER(PARTITION BY t3.Artista ORDER BY t3.Receita_musica DESC)AS rank_musica
	FROM(
		SELECT 
		--usando funções de janela para calcular a média por artista
			t2.Artista,
			t2.Musica,
			t2.Receita_musica,
			ROUND(AVG(t2.Receita_musica)OVER(PARTITION BY t2.Artista),2)AS media_artista
		FROM (
			SELECT 
			--trazendo os 3 primeiros requisitos do desafio e calculando a receita por musica
				a.Name AS Artista,
				t.name AS Musica,
				SUM (il.UnitPrice * il.Quantity )AS Receita_musica
			FROM Artist a 
			INNER JOIN Album a2 ON a.ArtistId = a2.ArtistId
			INNER JOIN Track t ON a2.AlbumId = t.AlbumId 
			INNER JOIN InvoiceLine il ON il.TrackId = t.TrackId 
			GROUP BY 1,2
		) AS t2
	) AS t3 
) AS t4 WHERE rank_musica = 1 --garantindo que o relatório só trará a música mais lucrativa do rank