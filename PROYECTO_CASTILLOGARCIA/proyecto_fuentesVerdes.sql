--Fuentes Verdes
---TMoneda para Plataformas
ALTER TABLE PLATAFORMAS
ADD CONSTRAINT CHK_PRECIO CHECK (Precio > 0);

---TGeneroP para Peliculas
ALTER TABLE PELICULAS
ADD CONSTRAINT CHK_GENERO_PELICULAS CHECK (Genero IN('AC', 'AV', 'AN', 'BI', 'CO', 'CR', 'DO', 'DR', 'FA', 'HI', 'HO', 'IN','MI', 'MU', 'RO', 'CF', 'SU', 'DE'));

---TGeneroS para Series
ALTER TABLE Series
ADD CONSTRAINT CHK_GENERO_SERIES CHECK (Genero IN('AC', 'AV', 'AN', 'BI', 'CO', 'CR', 'DO', 'DR', 'FA', 'HI', 'HO', 'IN','MI', 'MU', 'RO', 'CF', 'SU', 'DE'));

---TDuracion para Peliculas
ALTER TABLE Peliculas
ADD CONSTRAINT CHK_DURACION_FORMATO 
CHECK (
    REGEXP_LIKE(Duracion, '^[0-9]{2}:[0-9]{2}$') AND 
    LENGTH(Duracion) = 5
);

---TEstadoSE para Series
ALTER TABLE Series
ADD CONSTRAINT CHK_ESTADO_SERIE CHECK (Estado IN ('F', 'E', 'C'));

---TRol para Casting
ALTER TABLE Casting
ADD CONSTRAINT CHK_ROL CHECK (Rol > 0);

---TDuracion para Casting
ALTER TABLE Casting
ADD CONSTRAINT CHK_DURACIONC_FORMATO 
CHECK (
    REGEXP_LIKE(Tiempo_participacion, '^[0-9]{2}:[0-9]{2}$') AND 
    LENGTH(Tiempo_participacion) = 5
);

---TGenero para Personas
ALTER TABLE Personas
ADD CONSTRAINT CHK_PERSONAS_GENERO CHECK (Genero IN ('H', 'M'));

---TEstadoRE para Reconocimientos
ALTER TABLE Reconocimientos
ADD CONSTRAINT CHK_NOMINACION CHECK (Estado IN ('G', 'N', 'V'));

---TContraseña para Usuarios
ALTER TABLE Usuarios
ADD CONSTRAINT CHK_CONTRASEÑA
CHECK (
    REGEXP_LIKE(Contraseña, '^(?=.*[0-9]{5,})(?=.*[A-Za-z]{3,})[0-9A-Za-z]{8}$')
);

alter table Usuarios drop constraint CHK_CONTRASEÑA;
---TCorreo para Correos
ALTER TABLE Correos
ADD CONSTRAINT CHK_CORREO CHECK (Correo LIKE '%@%');

---TEstadoAC para Actualizaciones
ALTER TABLE Actualizaciones
ADD CONSTRAINT CHK_ESTADO_AC CHECK (Estado IN ('A', 'D', 'P'));

---TTipo para SistemasRecompensa
ALTER TABLE SistemasRecompensa
ADD CONSTRAINT CHK_TIPO_SR CHECK (Tipo IN ('R', 'B', 'S'));

---TValoracion para Valoraciones
ALTER TABLE Valoraciones
ADD CONSTRAINT CHK_VALORACION_RANGO 
CHECK (Valoracion BETWEEN 1 AND 10);

---TNumero para Usuarios(Contacto1)
ALTER TABLE Usuarios
ADD CONSTRAINT CHK_CONTACTO1_FORMATO 
CHECK (
   REGEXP_LIKE(Contacto1, '^[0-9]{10}$') AND 
   TO_NUMBER(Contacto1) > 0
);

---TNumero para Usuarios(Contacto2)
ALTER TABLE Usuarios
ADD CONSTRAINT CHK_CONTACTO2_FORMATO 
CHECK (
   REGEXP_LIKE(Contacto2, '^[0-9]{10}$') AND 
   TO_NUMBER(Contacto2) > 0
);

---TNumero para Empresas(Telefono)
ALTER TABLE Empresas
ADD CONSTRAINT CHK_EMPRESAS_TLFFORMATO 
CHECK (
   REGEXP_LIKE(Telefono, '^[0-9]{10}$') AND 
   TO_NUMBER(Telefono) > 0
);

---TNumero para Empresas(Telefono_representante)
ALTER TABLE Empresas
ADD CONSTRAINT CHK_EMPRESAS_TLFREFORMATO 
CHECK (
   REGEXP_LIKE(Telefono_representante, '^[0-9]{10}$') AND 
   TO_NUMBER(Telefono_representante) > 0
);

---TNumero para UsuariosEstandar
ALTER TABLE UsuariosEstandar
ADD CONSTRAINT CHK_USUARIOSE_TLFFORMATO 
CHECK (
   REGEXP_LIKE(Telefono, '^[0-9]{10}$') AND 
   TO_NUMBER(Telefono) > 0
);

---TTipo para Contenidos
ALTER TABLE Contenidos
ADD CONSTRAINT CHK_CONTENIDOS_TIPO CHECK (Tipo IN ('P', 'S'));

---Rating para Contenidos
ALTER TABLE Contenidos
ADD CONSTRAINT CHK_RATING_CONTENIDO CHECK (Rating BETWEEN 1.0 AND 10.0);



--------Acciones Referenciales---------
ALTER TABLE Sagas
DROP CONSTRAINT FK_SAGA_PELICULA;

ALTER TABLE Sagas
ADD CONSTRAINT FK_SAGA_PELICULA
FOREIGN KEY (Codigo_pelicula)
references Peliculas(Codigo_contenido)
ON DELETE CASCADE;


ALTER TABLE Capitulos
DROP CONSTRAINT FK_SERIE_CAPITULO;

ALTER TABLE Capitulos
ADD CONSTRAINT FK_SERIE_CAPITULO
FOREIGN KEY (Codigo_serie)
references Series(Codigo_contenido)
ON DELETE CASCADE;


ALTER TABLE Temporadas
DROP CONSTRAINT FK_SERIE_TEMPORADA;

ALTER TABLE Temporadas
ADD CONSTRAINT FK_SERIE_TEMPORADA
FOREIGN KEY (Codigo_serie)
references Series(Codigo_contenido)
ON DELETE CASCADE;

ALTER TABLE Series DROP CONSTRAINT FK_CONTENIDO_SERIE;
ALTER TABLE Peliculas DROP CONSTRAINT FK_CONTENIDO_PELICULA;

ALTER TABLE Series
ADD CONSTRAINT FK_CONTENIDO_SERIE 
FOREIGN KEY (Codigo_contenido) 
REFERENCES Contenidos(Codigo)
ON DELETE CASCADE;

ALTER TABLE Peliculas
ADD CONSTRAINT FK_CONTENIDO_PELICULA 
FOREIGN KEY (Codigo_contenido) 
REFERENCES Contenidos(Codigo)
ON DELETE CASCADE;



----------Disparadores------------------

---GC Contenidos
---Adicionar

CREATE SEQUENCE SEQ_CONTENIDOS
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 999999999
    NOCYCLE;



CREATE SEQUENCE SEQ_N_PELICULA
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 999999999
    NOCYCLE;

CREATE SEQUENCE SEQ_NUMERO_PLATAFORMA
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 999999999
    NOCYCLE;


CREATE SEQUENCE SEQ_CODIGO_SERIE
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 999999999
    NOCYCLE;
    
CREATE SEQUENCE SEQ_N_CAPITULO
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 999999999
    NOCYCLE;
    
CREATE SEQUENCE SEQ_N_NOMINACION
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 999999999
    NOCYCLE;

-- Crear secuencia para N_Usuarios
CREATE SEQUENCE SEQ_N_USUARIO
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 999999999
    NOCYCLE;

-- Crear secuencia para N_Alerta
CREATE SEQUENCE SEQ_N_ALERTA
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 999999999
    NOCYCLE;


CREATE SEQUENCE SEQ_INDX
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 999999999
    NOCYCLE;


CREATE SEQUENCE SEQ_INDX2
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 999999999
    NOCYCLE;

-- Crear secuencia para N_Actualizacion
CREATE SEQUENCE SEQ_N_ACTUALIZACION
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 999999999
    NOCYCLE;

CREATE SEQUENCE SEQ_RECOMPENSAS
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 999999999
    NOCYCLE;

DROP SEQUENCE SEQ_CODIGO_SERIE;
DROP SEQUENCE SEQ_CONTENIDOS;
DROP SEQUENCE SEQ_INDX;
DROP SEQUENCE SEQ_INDX2;
DROP SEQUENCE SEQ_NUMERO_PLATAFORMA;
DROP SEQUENCE SEQ_N_ACTUALIZACION;
DROP SEQUENCE SEQ_N_ALERTA;
DROP SEQUENCE SEQ_N_CAPITULO;
DROP SEQUENCE SEQ_N_NOMINACION;
DROP SEQUENCE SEQ_N_PELICULA;
DROP SEQUENCE SEQ_N_USUARIO;
DROP SEQUENCE SEQ_RECOMPENSAS;


CREATE OR REPLACE TRIGGER TR_CODIGO_CONTENIDO
BEFORE INSERT ON Contenidos
FOR EACH ROW
BEGIN
   IF :NEW.Tipo = 'P' THEN
       :NEW.Codigo := 'P' || :NEW.Codigo;
   ELSIF :NEW.Tipo = 'S' THEN
       :NEW.Codigo := 'S' || :NEW.Codigo;
   END IF;
END;
/

CREATE OR REPLACE TRIGGER TR_CODIGO_PELICULA
BEFORE INSERT ON PELICULAS
FOR EACH ROW
BEGIN
    -- Concatenar 'P' al valor que se va a insertar en 'Codigo_contenido'
    :NEW.Codigo_contenido := 'P' || :NEW.Codigo_contenido;
END;
/


CREATE OR REPLACE TRIGGER TR_CODIGO_SERIE
BEFORE INSERT ON SERIES
FOR EACH ROW
BEGIN
    -- Concatenar 'S' al valor que se va a insertar en 'Codigo_contenido'
    :NEW.Codigo_contenido := 'S' || :NEW.Codigo_contenido;
END;
/


CREATE OR REPLACE TRIGGER TR_CODIGO_SAGAS
BEFORE INSERT ON SAGAS
FOR EACH ROW
BEGIN
    :NEW.Codigo_pelicula := 'P' || :NEW.Codigo_pelicula;
END;
/

CREATE OR REPLACE TRIGGER TR_CODIGO_CAPITULOS
BEFORE INSERT ON CAPITULOS
FOR EACH ROW
BEGIN
    :NEW.Codigo_serie := 'S' || :NEW.Codigo_serie;
END;
/

CREATE OR REPLACE TRIGGER TR_CODIGO_TEMPORADAS
BEFORE INSERT ON TEMPORADAS
FOR EACH ROW
BEGIN
    :NEW.Codigo_serie := 'S' || :NEW.Codigo_serie;
END;
/

CREATE OR REPLACE TRIGGER TR_SERIE_ESTADO
BEFORE INSERT ON Series
FOR EACH ROW
BEGIN
    IF :NEW.Ano_final IS NULL THEN
        :NEW.Estado := 'E';
    END IF;
END;
/


CREATE OR REPLACE TRIGGER TR_CODIGO_CASTING
BEFORE INSERT ON CASTING
FOR EACH ROW
BEGIN
    IF TO_NUMBER(:NEW.Codigo_contenido) <= 2000 THEN
        :NEW.Codigo_contenido := 'P' || :NEW.Codigo_contenido;
    ELSE
        :NEW.Codigo_contenido := 'S' || :NEW.Codigo_contenido;
    END IF;
END;
/


CREATE OR REPLACE TRIGGER TR_CODIGO_DIRIGIDOS
BEFORE INSERT ON DIRIGIDOS
FOR EACH ROW
BEGIN
    IF TO_NUMBER(:NEW.Codigo_contenido) <= 2000 THEN
        :NEW.Codigo_contenido := 'P' || :NEW.Codigo_contenido;
    ELSE
        :NEW.Codigo_contenido := 'S' || :NEW.Codigo_contenido;
    END IF;
END;
/


CREATE OR REPLACE TRIGGER TR_CODIGO_CXU
BEFORE INSERT ON CONTENIDOSXUSUARIOS
FOR EACH ROW
BEGIN
    IF TO_NUMBER(:NEW.Codigo_contenido) <= 2000 THEN
        :NEW.Codigo_contenido := 'P' || :NEW.Codigo_contenido;
    ELSE
        :NEW.Codigo_contenido := 'S' || :NEW.Codigo_contenido;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER TR_CODIGO_VALORACIONES
BEFORE INSERT ON VALORACIONES
FOR EACH ROW
BEGIN
    IF TO_NUMBER(:NEW.Codigo_contenido) <= 2000 THEN
        :NEW.Codigo_contenido := 'P' || :NEW.Codigo_contenido;
    ELSE
        :NEW.Codigo_contenido := 'S' || :NEW.Codigo_contenido;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER TR_FECHA_SERIE
BEFORE INSERT OR UPDATE ON Series
FOR EACH ROW
BEGIN
    ---Evaluar que la fecha de inicio de la serie no es mayor al día actual
    IF :NEW.Ano_inicio > SYSDATE THEN
        RAISE_APPLICATION_ERROR(-20002, 'La fecha de inicio de la serie no puede ser mayor a la fecha actual.');
    END IF;
    
    ---Evaluar que la fecha final no sea mayor que la fecha final
    IF :NEW.Ano_final < :NEW.Ano_inicio THEN
        RAISE_APPLICATION_ERROR(-20003, 'La fecha final de la serie no puede ser mayor a la fecha de inicio.');
    END IF;
END;
/


CREATE OR REPLACE TRIGGER TR_FECHA_PELICULA
BEFORE INSERT OR UPDATE ON Peliculas
FOR EACH ROW
BEGIN
    IF :NEW.Ano > SYSDATE THEN
        RAISE_APPLICATION_ERROR(-20001, 'La fecha de la película no puede ser mayor a la fecha actual.');
    END IF;
END;
/



CREATE OR REPLACE TRIGGER trg_update_cascade_peliculas
AFTER UPDATE OF Codigo ON Contenidos
FOR EACH ROW
WHEN (OLD.Codigo != NEW.Codigo) 
BEGIN
    UPDATE Peliculas
    SET Codigo_contenido = :NEW.Codigo
    WHERE Codigo_contenido = :OLD.Codigo;
END;
/


CREATE OR REPLACE TRIGGER trg_update_cascade_series
AFTER UPDATE OF Codigo ON Contenidos
FOR EACH ROW
WHEN (OLD.Codigo != NEW.Codigo) 
BEGIN
    UPDATE Series
    SET Codigo_contenido = :NEW.Codigo
    WHERE Codigo_contenido = :OLD.Codigo;
END;
/


CREATE OR REPLACE TRIGGER trg_update_cascade_sagas
AFTER UPDATE OF Codigo_contenido ON Peliculas
FOR EACH ROW
BEGIN
    UPDATE Sagas
    SET Codigo_pelicula = :NEW.Codigo_contenido
    WHERE Codigo_pelicula = :OLD.Codigo_contenido;
END;
/


CREATE OR REPLACE TRIGGER trg_update_cascade_capitulos
AFTER UPDATE OF Codigo_contenido ON Series
FOR EACH ROW
BEGIN
    UPDATE Capitulos
    SET Codigo_serie = :NEW.Codigo_contenido
    WHERE Codigo_serie = :OLD.Codigo_contenido;
END;
/


CREATE OR REPLACE TRIGGER trg_update_cascade_temporada
AFTER UPDATE OF Codigo_contenido ON Series
FOR EACH ROW
BEGIN
    UPDATE Temporadas
    SET Codigo_serie = :NEW.Codigo_contenido
    WHERE Codigo_serie = :OLD.Codigo_contenido;
END;
/


CREATE OR REPLACE TRIGGER trg_prevent_update_if_state_C
BEFORE UPDATE ON Series
FOR EACH ROW
BEGIN
    --Si el estado de la serie es 'Cancelada' no se puede modificar
    IF :OLD.Estado = 'C' THEN
        RAISE_APPLICATION_ERROR(-20001, 'Cannot update record because the series state is C.');
    END IF;
    
    --Si la fecha_final es nula, se puede modificar, de resto no se puede modificar la fecha_inicio y fecha_final
    IF :OLD.Ano_final IS NOT NULL THEN 
        IF :NEW.Ano_inicio != :OLD.Ano_inicio OR :NEW.Ano_final != :OLD.Ano_final THEN 
            RAISE_APPLICATION_ERROR(-20003, 'Cannot update fecha_inicio or fecha_final when fecha_final is not NULL.'); 
        END IF; 
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_prevent_update_genero_peliculas
BEFORE UPDATE OF Genero ON Peliculas
FOR EACH ROW
BEGIN
    RAISE_APPLICATION_ERROR(-20004, 'Cannot modify the genre of a movie.');
END;
/


CREATE OR REPLACE TRIGGER trg_prevent_update_genero_series
BEFORE UPDATE OF Genero ON Series
FOR EACH ROW
BEGIN
    RAISE_APPLICATION_ERROR(-20004, 'Cannot modify the genre of a serie.');
END;
/


CREATE OR REPLACE TRIGGER trg_allow_delete_only_if_C
BEFORE DELETE ON Series
FOR EACH ROW
BEGIN
    IF :OLD.Estado != 'C' THEN
        RAISE_APPLICATION_ERROR(-20005, 'You can only delete series with estado C.');
    END IF;
    
    IF :OLD.Ano_final IS NULL THEN
        RAISE_APPLICATION_ERROR(-20006, 'Solo se pueden borrar series que han sido canceladas o finalizadas');
    END IF;
END;
/


CREATE OR REPLACE TRIGGER trg_allow_delete_before_1965
BEFORE DELETE ON Peliculas
FOR EACH ROW
BEGIN
    IF TO_CHAR(:OLD.Ano, 'YYYY') > 1965 THEN
        RAISE_APPLICATION_ERROR(-20006, 'You can only delete movies before the year 1965.');
    END IF;
END;
/


CREATE OR REPLACE TRIGGER TR_MAL_RATING
BEFORE DELETE ON Contenidos
FOR EACH ROW
BEGIN
    IF :OLD.Rating >= 4.0 THEN
        RAISE_APPLICATION_ERROR(-20007, 'Solo se puede eliminar un contenido con un rating menor o igual a 4.0');
    END IF;
END;
/


---GC Personas 

CREATE OR REPLACE TRIGGER TR_RECONOCIMIENTOS
BEFORE INSERT ON Reconocimientos
FOR EACH ROW
BEGIN
    IF :NEW.Nominacion IS NULL THEN
        :NEW.Estado := 'V';
    END IF;
END;
/


CREATE OR REPLACE TRIGGER TR_FECHA_NACIMIENTO
BEFORE INSERT OR UPDATE ON Personas
FOR EACH ROW
BEGIN

    ---Evaluar que la fecha nacimiento no sea mayor que la fecha fallecimiento
    IF :NEW.F_Nacimiento > :NEW.F_Fallecimiento THEN
        RAISE_APPLICATION_ERROR(-20003, 'La fecha de nacimiento no puede ser mayor a su fallecimiento.');
    END IF;
END;
/


CREATE OR REPLACE TRIGGER TR_FECHA_DIRIGIDOS
BEFORE INSERT OR UPDATE ON DIRIGIDOS
FOR EACH ROW
BEGIN
    ---Evaluar que la fecha de inicio de la serie no es mayor al día actual
    IF :NEW.Fecha_inicio > SYSDATE THEN
        RAISE_APPLICATION_ERROR(-20002, 'La fecha de inicio no puede ser mayor a la fecha actual.');
    END IF;
    
    ---Evaluar que la fecha final no sea mayor que la fecha final
    IF :NEW.Fecha_final < :NEW.Fecha_inicio THEN
        RAISE_APPLICATION_ERROR(-20003, 'La fecha final no puede ser mayor a la fecha de inicio.');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER TR_FECHA_FALLECIMIENTO
BEFORE UPDATE ON Personas
FOR EACH ROW
BEGIN
    IF :OLD.F_fallecimiento IS NOT NULL THEN 
        IF :NEW.F_nacimiento != :OLD.F_nacimiento OR :NEW.F_fallecimiento != :OLD.F_fallecimiento THEN 
            RAISE_APPLICATION_ERROR(-20003, 'Cannot update fecha_inicio or fecha_final when fecha_final is not NULL.'); 
        END IF; 
    END IF;
END;
/


CREATE OR REPLACE TRIGGER trg_restrict_altura_update
BEFORE UPDATE OF Altura ON Actores
FOR EACH ROW
DECLARE
    v_edad NUMBER;
BEGIN
    -- Obtener la edad de la persona asociada al actor
    SELECT Edad INTO v_edad
    FROM Personas
    WHERE Cedula = :OLD.Cedula_persona;

    -- Verificar si la edad es mayor o igual a 21
    IF v_edad >= 21 THEN
        RAISE_APPLICATION_ERROR(-20001, 'No se puede modificar la Altura porque la Edad es mayor o igual a 21.');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER TR_FECHAS_DIRIGIDOS_NULIDAD
BEFORE UPDATE ON Dirigidos
FOR EACH ROW 
BEGIN
    --Si la fecha_final es nula, se puede modificar, de resto no se puede modificar la fecha_inicio y fecha_final
    IF :OLD.Fecha_Final IS NOT NULL THEN 
        IF :NEW.Fecha_Inicio != :OLD.Fecha_Inicio OR :NEW.Fecha_Final != :OLD.Fecha_Final THEN 
            RAISE_APPLICATION_ERROR(-20003, 'Cannot update fecha_inicio or fecha_finalizado when fecha_final is not NULL.'); 
        END IF; 
    END IF;
END;
/


CREATE OR REPLACE TRIGGER trg_update_cascade_pXnominaciones
AFTER UPDATE OF N_nominacion ON Reconocimientos
FOR EACH ROW
BEGIN
    UPDATE PersonasXReconocimientos
    SET N_nominacion = :NEW.N_nominacion
    WHERE N_nominacion = :OLD.N_nominacion;
END;
/


CREATE OR REPLACE TRIGGER trg_update_cascade_personasXr
AFTER UPDATE OF Cedula ON Personas
FOR EACH ROW
BEGIN
    UPDATE PersonasXReconocimientos
    SET Cedula_persona = :NEW.Cedula
    WHERE Cedula_persona = :OLD.Cedula;
END;
/


CREATE OR REPLACE TRIGGER trg_update_cascade_directores
AFTER UPDATE OF Cedula ON Personas
FOR EACH ROW
BEGIN
    UPDATE Directores
    SET Cedula_persona = :NEW.Cedula
    WHERE Cedula_persona = :OLD.Cedula;
END;
/

CREATE OR REPLACE TRIGGER trg_update_cascade_actores
AFTER UPDATE OF Cedula ON Personas
FOR EACH ROW
BEGIN
    UPDATE Actores
    SET Cedula_persona = :NEW.Cedula
    WHERE Cedula_persona = :OLD.Cedula;
END;
/

CREATE OR REPLACE TRIGGER trg_update_cascade_dirigidos
AFTER UPDATE OF Cedula_persona ON Directores
FOR EACH ROW
BEGIN
    UPDATE Dirigidos
    SET Cedula_directores = :NEW.Cedula_persona
    WHERE Cedula_directores = :OLD.Cedula_persona;
END;
/

CREATE OR REPLACE TRIGGER trg_update_cascade_dirigidosC
AFTER UPDATE OF Codigo ON Contenidos
FOR EACH ROW
BEGIN
    UPDATE Dirigidos
    SET Codigo_contenido = :NEW.Codigo
    WHERE Codigo_contenido = :OLD.Codigo;
END;
/

CREATE OR REPLACE TRIGGER trg_update_cascade_castingA
AFTER UPDATE OF Cedula_persona ON Actores
FOR EACH ROW
BEGIN
    UPDATE Casting
    SET Cedula_actor = :NEW.Cedula_persona
    WHERE Cedula_actor = :OLD.Cedula_persona;
END;
/

CREATE OR REPLACE TRIGGER trg_update_cascade_castingC
AFTER UPDATE OF Codigo ON Contenidos
FOR EACH ROW
BEGIN
    UPDATE Casting
    SET Codigo_contenido = :NEW.Codigo
    WHERE Codigo_contenido = :OLD.Codigo;
END;
/   
    

CREATE OR REPLACE TRIGGER TR_PERSONA_FALLECIDO
BEFORE DELETE ON Personas
FOR EACH ROW
BEGIN
    IF :OLD.f_fallecimiento IS NULL THEN
        RAISE_APPLICATION_ERROR(-20001, 'No se puede eliminar la persona porque f_fallecimiento es NULL.');
    END IF;
END;
/

---GC Usuarios

CREATE OR REPLACE TRIGGER trg_check_nombre_usuario
BEFORE INSERT OR UPDATE ON Usuarios
FOR EACH ROW
BEGIN
    -- Verificar si NombreUsuario contiene espacios, comas o puntos
    IF INSTR(:NEW.NombreUsuario, ' ') > 0 OR
       INSTR(:NEW.NombreUsuario, ',') > 0 OR
       INSTR(:NEW.NombreUsuario, '.') > 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'El NombreUsuario no puede contener espacios, comas ni puntos.');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_check_contraseña
BEFORE INSERT OR UPDATE ON Usuarios
FOR EACH ROW
DECLARE
    v_num_count NUMBER := 0;
    v_letter_count NUMBER := 0;
BEGIN
    -- Contar números y letras en la contraseña
    FOR i IN 1..LENGTH(:NEW.Contraseña) LOOP
        IF SUBSTR(:NEW.Contraseña, i, 1) BETWEEN '0' AND '9' THEN
            v_num_count := v_num_count + 1;  -- Contar números
        ELSIF SUBSTR(:NEW.Contraseña, i, 1) BETWEEN 'A' AND 'Z' OR
               SUBSTR(:NEW.Contraseña, i, 1) BETWEEN 'a' AND 'z' THEN
            v_letter_count := v_letter_count + 1;  -- Contar letras
        END IF;
    END LOOP;

    -- Verificar si se cumplen los requisitos
    IF v_num_count < 5 OR v_letter_count < 3 THEN
        RAISE_APPLICATION_ERROR(-20001, 'La contraseña debe contener al menos 5 números y 3 letras.');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_check_contactos
BEFORE INSERT OR UPDATE ON Usuarios
FOR EACH ROW
BEGIN
    -- Verificar si contacto1 es igual a contacto2
    IF :NEW.contacto1 = :NEW.contacto2 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Los campos contacto1 y contacto2 no pueden ser iguales.');
    END IF;
END;
/


CREATE OR REPLACE TRIGGER TR_ALERTAS_FECHA
BEFORE INSERT ON Alertas
FOR EACH ROW
BEGIN
    :NEW.fechaAlerta := SYSDATE;
END;
/

CREATE OR REPLACE TRIGGER TR_EDAD_USUARIOE
BEFORE INSERT OR UPDATE ON UsuariosEstandar
FOR EACH ROW
BEGIN
    IF :NEW.Edad < 18 THEN
        RAISE_APPLICATION_ERROR(-20010, 'Se debe ser mayor de 18 años para ingresar a esta plataforma');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_check_telefono
BEFORE INSERT OR UPDATE ON UsuariosEstandar
FOR EACH ROW
BEGIN
    -- Verificar si el Telefono no comienza con '3'
    IF :NEW.Telefono IS NOT NULL AND SUBSTR(:NEW.Telefono, 1, 1) != '3' THEN
        -- Cambiar el Telefono para que comience con '3'
        :NEW.Telefono := '3' || SUBSTR(:NEW.Telefono, 2);
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_check_contacto1
BEFORE INSERT OR UPDATE ON Usuarios
FOR EACH ROW
BEGIN
    -- Verificar si el Telefono no comienza con '3'
    IF :NEW.Contacto1 IS NOT NULL AND SUBSTR(:NEW.Contacto1, 1, 1) != '3' THEN
        -- Cambiar el Telefono para que comience con '3'
        :NEW.Contacto1 := '3' || SUBSTR(:NEW.Contacto1, 2);
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_check_contacto2
BEFORE INSERT OR UPDATE ON Usuarios
FOR EACH ROW
BEGIN
    -- Verificar si el Telefono no comienza con '3'
    IF :NEW.Contacto2 IS NOT NULL AND SUBSTR(:NEW.Contacto2, 1, 1) != '3' THEN
        -- Cambiar el Telefono para que comience con '3'
        :NEW.Contacto2 := '3' || SUBSTR(:NEW.Contacto2, 2);
    END IF;
END;
/


CREATE OR REPLACE TRIGGER trg_check_tlfemp
BEFORE INSERT OR UPDATE ON Empresas
FOR EACH ROW
BEGIN
    -- Verificar si el Telefono no comienza con '3'
    IF :NEW.Telefono IS NOT NULL AND SUBSTR(:NEW.Telefono, 1, 1) != '3' THEN
        -- Cambiar el Telefono para que comience con '3'
        :NEW.Telefono := '3' || SUBSTR(:NEW.Telefono, 2);
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_check_tlfrep
BEFORE INSERT OR UPDATE ON Empresas
FOR EACH ROW
BEGIN
    -- Verificar si el Telefono no comienza con '3'
    IF :NEW.Telefono_representante IS NOT NULL AND SUBSTR(:NEW.Telefono_representante, 1, 1) != '3' THEN
        -- Cambiar el Telefono para que comience con '3'
        :NEW.Telefono_representante := '3' || SUBSTR(:NEW.Telefono_representante, 2);
    END IF;
END;
/


CREATE OR REPLACE TRIGGER trg_update_cascade_contenidosxU
AFTER UPDATE OF Codigo ON Contenidos
FOR EACH ROW
BEGIN
    UPDATE ContenidosXUsuarios
    SET Codigo_contenido = :NEW.Codigo
    WHERE Codigo_contenido = :OLD.Codigo;
END;
/   

CREATE OR REPLACE TRIGGER trg_update_cascade_cXUsuarios
AFTER UPDATE OF N_usuario ON Usuarios
FOR EACH ROW
BEGIN
    UPDATE ContenidosXUsuarios
    SET N_usuario = :NEW.N_usuario
    WHERE N_usuario = :OLD.N_usuario;
END;
/ 

CREATE OR REPLACE TRIGGER trg_update_cascade_UsuariosE
AFTER UPDATE OF N_usuario ON Usuarios
FOR EACH ROW
BEGIN
    UPDATE UsuariosEstandar
    SET N_usuarioU = :NEW.N_usuario
    WHERE N_usuarioU = :OLD.N_usuario;
END;
/ 

CREATE OR REPLACE TRIGGER trg_update_cascade_empresas
AFTER UPDATE OF N_usuario ON Usuarios
FOR EACH ROW
BEGIN
    UPDATE Empresas
    SET N_usuario = :NEW.N_usuario
    WHERE N_usuario = :OLD.N_usuario;
END;
/ 

CREATE OR REPLACE TRIGGER trg_update_cascade_alertas
AFTER UPDATE OF N_usuario ON Usuarios
FOR EACH ROW
BEGIN
    UPDATE Alertas
    SET N_usuarioU = :NEW.N_usuario
    WHERE N_usuarioU = :OLD.N_usuario;
END;
/ 


CREATE OR REPLACE TRIGGER TR_UPDATE_ACTUALIZACION
BEFORE UPDATE ON Actualizaciones
FOR EACH ROW 
BEGIN
    IF :OLD.Estado = 'A' THEN
        RAISE_APPLICATION_ERROR(-20013, 'Si la actualización está aprobada, no se puede modificar');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER TR_UPDATE_VALORACION
BEFORE INSERT ON Valoraciones
FOR EACH ROW
BEGIN
    :NEW.fecha_valoracion := SYSDATE;
END;
/


CREATE OR REPLACE TRIGGER TR_DELETE_ACTUALIZACION
BEFORE DELETE ON Actualizaciones
FOR EACH ROW
BEGIN
    IF :OLD.Estado = 'A' OR :OLD.Estado = 'P' THEN
        RAISE_APPLICATION_ERROR(-20014, 'Solo se puede eliminar una actualización si fue Denegada');
    END IF;
END;
/

--Cuando se agregue una pelicula se suma uno a la cantidad de peliculas en sagas
CREATE OR REPLACE TRIGGER actualizar_n_peliculas
AFTER INSERT ON Peliculas
FOR EACH ROW
BEGIN
    -- Verificar si la película insertada tiene una saga asociada
    IF :NEW.Codigo_contenido IS NOT NULL THEN
        -- Actualizar el campo N_peliculas de la saga correspondiente
        UPDATE Sagas
        SET N_peliculas = N_peliculas + 1
        WHERE Codigo_pelicula = :NEW.Codigo_contenido;
    END IF;
END;
/


-------DisparadoresOK y NOOK-------------------------
DELETE FROM CONTENIDOS;
DELETE FROM SERIES;
---TR_CODIGO_CONTENIDO
---OK
INSERT INTO CONTENIDOS(Codigo, Nombre, Tipo, Rating, Reseña)
VALUES ('asdfgg', 'Avengers', 'P', 7.5, 'Superheroes');

INSERT INTO CONTENIDOS(Codigo, Nombre, Tipo, Rating, Reseña)
VALUES ('asdfgg', 'Teen Titans', 'S', 6.5, 'Superheroes en serie');

INSERT INTO CONTENIDOS(Codigo, Nombre, Tipo, Rating, Reseña)
VALUES ('asdfgg', 'Liga de la Justicia', 'P', 5.5, 'Superheroes DC');

INSERT INTO CONTENIDOS(Codigo, Nombre, Tipo, Rating, Reseña)
VALUES ('asdfgg', 'The Flash', 'S', 8.0, 'Rapidin');

INSERT INTO CONTENIDOS(Codigo, Nombre, Tipo, Rating, Reseña)
VALUES ('asdfgg', 'La sociedad de los poetas muertos', 'P', 9.5, 'Literatura');

INSERT INTO CONTENIDOS(Codigo, Nombre, Tipo, Rating, Reseña)
VALUES ('asdfgg', 'Stranger Things', 'S', 7.5, 'Ambiente de los 80');

INSERT INTO CONTENIDOS(Codigo, Nombre, Tipo, Rating, Reseña)
VALUES ('asdfgg', 'Goodfellas', 'P', 10.0, 'Mafiosos');

INSERT INTO CONTENIDOS(Codigo, Nombre, Tipo, Rating, Reseña)
VALUES ('asdfgg', 'Green Arrow', 'S', 6.9, 'El que tira flechas');

INSERT INTO CONTENIDOS(Codigo, Nombre, Tipo, Rating, Reseña)
VALUES ('asdfgg', 'Inception', 'P', 8.5, 'Mundo de los sueños');

INSERT INTO CONTENIDOS(Codigo, Nombre, Tipo, Rating, Reseña)
VALUES ('asdfgg', 'Fallout', 'S', 7.7, 'Mundo post-apocaliptico');

INSERT INTO CONTENIDOS(Codigo, Nombre, Tipo, Rating, Reseña)
VALUES ('asdfgg', 'El Padrino', 'P', 10.0, 'Otra mas de mafiosos');

INSERT INTO CONTENIDOS(Codigo, Nombre, Tipo, Rating, Reseña)
VALUES ('asdfgg', 'Betty la Fea', 'S', 8.0, 'Trabajo');

SELECT * FROM CONTENIDOS;

---NOOK
INSERT INTO CONTENIDOS(Codigo, Nombre, Tipo, Rating, Reseña)
VALUES ('asdfgg', 'Avengers', 'G', 7.5, 'Superheroes');

---TR_SERIE_ESTADO
---OK
INSERT INTO SERIES(Codigo_contenido, N_pelicula, Ano_inicio, Ano_final, Genero, Estado, Visualizacion)
VALUES ('S000000066', 1, TO_DATE('2010-11-23', 'YYYY-MM-DD'), NULL, 'AC', 'F', 10000000);

INSERT INTO SERIES(Codigo_contenido, N_pelicula, Ano_inicio, Ano_final, Genero, Estado, Visualizacion)
VALUES ('S000000068', 1, TO_DATE('2010-11-23', 'YYYY-MM-DD'), NULL, 'AC', 'C', 10000000);

---NOOK
INSERT INTO SERIES(Codigo_contenido, N_pelicula, Ano_inicio, Ano_final, Genero, Estado, Visualizacion)
VALUES ('S000000068', 1, NULL, NULL, 'AC', 'C', 10000000);


SELECT * FROM SERIES;
---TRG_ALLOW_DELETE_ONLY_IF_C
---OK

DELETE SERIES WHERE CODIGO_CONTENIDO = 'S000000066';



---TR_FECHA_SERIE
---OK
UPDATE SERIES
SET ANO_INICIO = TO_DATE('2025-11-23', 'YYYY-MM-DD')
WHERE ANO_INICIO = TO_DATE('2010-11-23', 'YYYY-MM-DD');

UPDATE SERIES
SET ANO_FINAL = TO_DATE('2009-11-23', 'YYYY-MM-DD')
WHERE ANO_INICIO = TO_DATE('2010-11-23', 'YYYY-MM-DD');


---TR_FECHA_PELICULA
---OK
INSERT INTO Peliculas (Codigo_contenido, N_pelicula, Duracion, Ano, Genero, Visualizacion)
VALUES 
('P000000065', 1, '02:32', TO_DATE('2024-12-20', 'YYYY-MM-DD'), 'FA', 1000000);


---trg_prevent_update_genero_peliculas
---OK
UPDATE PELICULAS
SET GENERO = 'AC'
WHERE CODIGO_CONTENIDO = 'P000000065';

---trg_prevent_update_genero_series
---OK
UPDATE SERIES
SET GENERO = 'FA'
WHERE CODIGO_CONTENIDO = 'S000000066';


---trg_prevent_update_if_state_C
---OK

UPDATE SERIES
SET ESTADO = 'F'
WHERE CODIGO_CONTENIDO = 'S000000068';

UPDATE SERIES
SET ANO_FINAL = TO_DATE('2015-11-23', 'YYYY-MM-DD')
WHERE ANO_INICIO = TO_DATE('2010-11-23', 'YYYY-MM-DD');


---trg_allow_delete_before_1965
---OK
INSERT INTO Peliculas (Codigo_contenido, N_pelicula, Duracion, Ano, Genero, Visualizacion)
VALUES 
('P000000067', 1, '02:32', TO_DATE('1999-12-20', 'YYYY-MM-DD'), 'FA', 1000000);

DELETE PELICULAS WHERE CODIGO_CONTENIDO = 'P000000067';

SELECT * FROM PELICULAS;
---TR_MAL_RATING
---OK
DELETE CONTENIDOS WHERE CODIGO = 'S000000076';


---ON UPDATE CASCADE
UPDATE CONTENIDOS
SET CODIGO = 'P000000080'
WHERE CODIGO = 'P000000077';


UPDATE CONTENIDOS
SET CODIGO = 'S000000090'
WHERE CODIGO = 'S000000078';



---------------------------GC PERSONAS------------------------------------------

---TR_RECONOCIMIENTOS
---OK
INSERT INTO RECONOCIMIENTOS(N_nominacion, Nominacion, Estado)
VALUES (1, NULL, 'N');

SELECT * FROM RECONOCIMIENTOS;

---TR_FECHA_NACIMIENTO
---OK

INSERT INTO PERSONAS(Cedula, Nombre, Edad, Nacionalidad, F_nacimiento, F_fallecimiento, Genero)
VALUES('1234567890', 'Charlie Cooper', 12, 'Venezolano', TO_DATE('1969-12-20', 'YYYY-MM-DD'), TO_DATE('1959-12-20', 'YYYY-MM-DD'), 'M');

---TR_FECHA_DIRIGIDOS
---OK
INSERT INTO PERSONAS(Cedula, Nombre, Edad, Nacionalidad, F_nacimiento, F_fallecimiento, Genero)
VALUES('0987654321', 'Charlina Cupra', 12, 'Venezolano', TO_DATE('1969-12-20', 'YYYY-MM-DD'), NULL, 'M');

INSERT INTO DIRECTORES(Cedula_persona, Genero_pref, Productora_afiliada)
VALUES('0987654321', 'FA', 'Warner Bros');

INSERT INTO DIRIGIDOS (Cedula_directores, Codigo_contenido, fecha_inicio, fecha_final)
VALUES('0987654321', 'P000000080', TO_DATE('2030-12-20', 'YYYY-MM-DD'), NULL);

---TR_FECHA_FALLECIMIENTO
--OK

UPDATE PERSONAS
SET F_FALLECIMIENTO = TO_DATE('2020-12-20', 'YYYY-MM-DD')
WHERE CEDULA = '0987654321';

SELECT * FROM PERSONAS;
SELECT * FROM DIRECTORES;
SELECT * FROM ACTORES;
SELECT * FROM CASTING;
---trg_restrict_altura_update
---OK

INSERT INTO PERSONAS(Cedula, Nombre, Edad, Nacionalidad, F_nacimiento, F_fallecimiento, Genero)
VALUES('1234567890', 'Charlino Tuto', 15, 'Venezolano', TO_DATE('2010-12-20', 'YYYY-MM-DD'), NULL, 'H');

INSERT INTO ACTORES(Cedula_persona, Altura, FormaciOn)
VALUES('1234567890', 1.65, 'Estudios en estudiar');

UPDATE ACTORES
SET ALTURA = 1.75
WHERE CEDULA_PERSONA = '1234567890';


---TR_PERSONA_FALLECIDO
---OK

DELETE PERSONAS WHERE CEDULA = '1234567890';



---ON UPDATE CASCADE

UPDATE PERSONAS
SET CEDULA = '1234567888'
WHERE CEDULA = '1234567890';



---trg_check_nombre_usuario
---trg_check_contraseña
---trg_check_contactos
---trg_check_contacto1
---trg_check_contacto2
---OK
SELECT * FROM USUARIOS;
INSERT INTO USUARIOS(N_usuario, NombreUsuario, Contacto1, Contacto2, RazonSocial, Contraseña)
VALUES(1, 'Messialali', '5138678669', NULL, NULL, '12345abc');

INSERT INTO USUARIOS(N_usuario, NombreUsuario, Contacto1, Contacto2, RazonSocial, Contraseña)
VALUES(2, 'Messia lali', '5138678669', NULL, NULL, '12345abc');

INSERT INTO USUARIOS(N_usuario, NombreUsuario, Contacto1, Contacto2, RazonSocial, Contraseña)
VALUES(3, 'MessialaliII', '5138658669', '1234567890', NULL, '12345abc');

INSERT INTO USUARIOS(N_usuario, NombreUsuario, Contacto1, Contacto2, RazonSocial, Contraseña)
VALUES(4, 'Messialali', '5138678669', NULL, NULL, '123VVabc');

INSERT INTO USUARIOS(N_usuario, NombreUsuario, Contacto1, Contacto2, RazonSocial, Contraseña)
VALUES(4, 'Messialali', '5138678669', '5138678669', NULL, '12345abc');

---TR_EDAD_USUARIOE
---trg_check_telefono
--OK
INSERT INTO USUARIOSESTANDAR(N_usuarioU, Cedula, Telefono, Edad)
VALUES(1, '1234567890', '9087654321', 19);

INSERT INTO USUARIOSESTANDAR(N_usuarioU, Cedula, Telefono, Edad)
VALUES(3, '1234567890', '9087654321', 15);

---trg_check_tlfemp
---trg_check_tlfrep
---OK
SELECT * FROM EMPRESAS;
INSERT INTO EMPRESAS(N_usuario, NIT, RazonSocial, Nombre_representante, Telefono, Telefono_representante)
VALUES(3, '1111111111', '<?xml version="1.0"?><Empresa><Nombre>Juan</Nombre></Empresa>', 'Juan Perez', '1234567890', '0987654321');


---TR_UPDATE_USUARIOS
---OK
SELECT * FROM USUARIOSESTANDAR;
UPDATE USUARIOS
SET CONTACTO2 = '3196187280'
WHERE N_USUARIO = 1;

---TR_UPDATE_ACTUALIZACION
---TR_DELETE_ACTUALIZACION

---OK
INSERT INTO SISTEMASRECOMPENSA(N_recompensa, descripcion, tipo)
VALUES(1, 'ayuda', 'R');


INSERT INTO ACTUALIZACIONES(N_actualizacion, descripcion, estado, N_usuarioE, Cedula_usuarioE, N_recompensas)
VALUES(1, 'me duele la cabeza', 'A', 1, '1234567890', 1);

UPDATE ACTUALIZACIONES
SET ESTADO = 'D'
WHERE N_ACTUALIZACION = 1;

DELETE ACTUALIZACIONES WHERE N_ACTUALIZACION = 1;



DROP TRIGGER TR_FECHA_PELICULA;
DROP TRIGGER trg_update_cascade_peliculas;
DROP TRIGGER trg_update_cascade_series;
DROP TRIGGER trg_update_cascade_sagas;
DROP TRIGGER trg_update_cascade_capitulos;
DROP TRIGGER trg_update_cascade_temporada;
DROP TRIGGER trg_prevent_update_if_state_C;
DROP TRIGGER trg_prevent_update_genero_peliculas;
DROP TRIGGER trg_prevent_update_genero_series;
DROP TRIGGER trg_allow_delete_only_if_C;
DROP TRIGGER trg_allow_delete_before_1965;
DROP TRIGGER TR_MAL_RATING;
DROP TRIGGER TR_RECONOCIMIENTOS;
DROP TRIGGER TR_FECHA_NACIMIENTO;
DROP TRIGGER TR_FECHA_DIRIGIDOS;
DROP TRIGGER TR_FECHA_FALLECIMIENTO;
DROP TRIGGER trg_restrict_altura_update;
DROP TRIGGER TR_FECHAS_DIRIGIDOS_NULIDAD;
DROP TRIGGER trg_update_cascade_pXnominaciones;
DROP TRIGGER trg_update_cascade_personasXr;
DROP TRIGGER trg_update_cascade_directores;
DROP TRIGGER trg_update_cascade_actores;
DROP TRIGGER trg_update_cascade_dirigidos;
DROP TRIGGER trg_update_cascade_dirigidosC;
DROP TRIGGER trg_update_cascade_castingA;
DROP TRIGGER trg_update_cascade_castingC;
DROP TRIGGER TR_PERSONA_FALLECIDO;
DROP TRIGGER trg_check_nombre_usuario;
DROP TRIGGER trg_check_contraseña;
DROP TRIGGER trg_check_contactos;
DROP TRIGGER TR_ALERTAS_FECHA;
DROP TRIGGER TR_EDAD_USUARIOE;
DROP TRIGGER trg_check_telefono;
DROP TRIGGER trg_check_contacto1;
DROP TRIGGER trg_check_contacto2;
DROP TRIGGER trg_check_tlfemp;
DROP TRIGGER trg_check_tlfrep;
DROP TRIGGER trg_update_cascade_contenidosxU;
DROP TRIGGER trg_update_cascade_cXUsuarios;
DROP TRIGGER trg_update_cascade_UsuariosE;
DROP TRIGGER trg_update_cascade_empresas;
DROP TRIGGER trg_update_cascade_alertas;
DROP TRIGGER TR_UPDATE_ACTUALIZACION;
DROP TRIGGER TR_UPDATE_VALORACION;
DROP TRIGGER TR_DELETE_ACTUALIZACION;
DROP TRIGGER actualizar_n_peliculas;