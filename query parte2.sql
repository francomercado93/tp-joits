select p.titulo, p.anio, p.puntaje, p.genero, f.fecha, f.hora, f.nombreSala from pelicula p
inner join pelicula_funcion e on e.Pelicula_id = p.id
inner join funcion f on f.id = e.funcionesDisponibles_id
where f.nombreSala = 'Rivadavia' and p.genero = "Accion";
