CREATE PROCEDURE entradasPeliculasAccionSala(IN salaSeleccionada varchar(45))
BEGIN
	SELECT P.titulo, P.anio, P.puntaje 
    FROM PELICULA P 
    INNER JOIN FUNCION F ON P.id = F.pelicula_id 
    WHERE F.nombreSala = salaSeleccionada AND P.genero = "Accion";
END