CREATE VIEW peliculasConMasDe3Entradas AS
SELECT P.* FROM PELICULA P 
INNER JOIN ENTRADA E ON P.id = E.pelicula_id 
GROUP BY P.id 
HAVING COUNT(E.pelicula_id) > 1;