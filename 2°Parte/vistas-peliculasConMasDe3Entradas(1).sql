CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `peliculasconmasde3entradas` AS
    SELECT 
        `p`.`id` AS `id`,
        `p`.`anio` AS `anio`,
        `p`.`genero` AS `genero`,
        `p`.`precioBase` AS `precioBase`,
        `p`.`puntaje` AS `puntaje`,
        `p`.`titulo` AS `titulo`,
        COUNT(`e`.`pelicula_id`) AS `cantidadEntradas`
    FROM
        (`pelicula` `p`
        JOIN `entrada` `e` ON ((`p`.`id` = `e`.`pelicula_id`)))
    GROUP BY `p`.`id`
    HAVING (COUNT(`e`.`pelicula_id`) >= 3)