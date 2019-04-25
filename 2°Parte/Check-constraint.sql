-- CHECK CONSTRAINT (USAMOS UN SP Y UN TRIGGER PORQUE MYSQL NO TIENE CHECK CONSTRAINT NATIVO).

DELIMITER $
CREATE PROCEDURE validar_saldo_usuario (IN saldo DECIMAL(19,2))
BEGIN
    IF saldo < 0 THEN
        SIGNAL SQLSTATE '45000'
           SET MESSAGE_TEXT = 'CHECK CONSTRAINT: Saldo no puede ser negativo.';
    END IF;
END$
DELIMITER ;

-- Antes de la inserción del usuario, revisa que el saldo sea positivo.
DELIMITER $
CREATE TRIGGER saldo_before_insert BEFORE INSERT ON usuario
FOR EACH ROW
BEGIN
    CALL validar_saldo_usuario(new.saldo);
END$   
DELIMITER ; 
-- Antes de la actualización del usuario, revisa que el saldo sea positivo.
DELIMITER $
CREATE TRIGGER saldo_before_update BEFORE UPDATE ON usuario
FOR EACH ROW
BEGIN
    CALL validar_saldo_usuario(new.saldo);
END$   
DELIMITER ;