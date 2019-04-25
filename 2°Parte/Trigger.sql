-- TRIGGER PARA LOG DE MODIFICACIONES EN LAS PELICULAS
CREATE TABLE IF NOT EXISTS pelicula_log (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pelicula_id INT NOT NULL,
    old_titulo VARCHAR(255) NOT NULL,
    new_titulo VARCHAR(255) NOT NULL,
    fecha_modificacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    accion VARCHAR(50) NOT NULL
);

DELIMITER $$
CREATE TRIGGER after_pelicula_update 
    AFTER UPDATE ON pelicula
    FOR EACH ROW 
BEGIN
    INSERT INTO pelicula_log
    SET accion = 'UPDATE',
	pelicula_id = NEW.id,
	old_titulo = OLD.titulo,
    new_titulo = NEW.titulo; 
END$$
DELIMITER ;
-- PRUEBA
/*
INSERT INTO pelicula
(id, anio, genero, precioBase, puntaje, titulo)
VALUES
(123,2000,'Accion',200,9.9,'PROBANDO TRIGGER');

UPDATE pelicula
SET titulo = 'PROBANDO' WHERE id = 123;
*/