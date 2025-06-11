--SEGURIDAD
--SEGURIDAD

--PK_ASISTENTE_DE_GERENCIA
CREATE OR REPLACE PACKAGE PK_ASISTENTE_DE_GERENCIA AS

    PROCEDURE Añadir_Pelicula(
        Nombre IN VARCHAR2, 
        Tipo IN CHAR DEFAULT 'P', 
        Rating IN CHAR, 
        Reseña IN VARCHAR2, 
        Duracion IN VARCHAR2, 
        Ano IN DATE, 
        Genero IN VARCHAR2, 
        Visualizacion IN INTEGER, 
        Nombre_Saga IN VARCHAR2, 
        Nom_Plataforma IN VARCHAR2, 
        Precio IN NUMBER
    );

    PROCEDURE Añadir_Serie(
        Nombre IN VARCHAR2, 
        Tipo IN CHAR DEFAULT 'S', 
        Rating IN CHAR, 
        Reseña IN VARCHAR2, 
        Año_Inicio IN DATE, 
        Año_Final IN DATE, 
        Genero IN VARCHAR2, 
        Estado IN CHAR, 
        Visualizacion IN INTEGER, 
        N_Capitulos IN INTEGER, 
        Nombre_Cap IN VARCHAR2, 
        N_Temporada IN INTEGER, 
        Descripcion IN VARCHAR2, 
        Nom_Plataforma IN VARCHAR2, 
        Precio IN NUMBER
    );
    
    
    PROCEDURE Añadir_Plataforma(
        Nom_Plataforma IN VARCHAR2, 
        Precio IN NUMBER
    );
    
    PROCEDURE Crear_Usuario(
        Nombre_Usuario IN VARCHAR2,
        Contacto1 IN VARCHAR2,
        Contacto2 IN VARCHAR2,
        Razon_Social IN XMLTYPE,
        Contrasena IN VARCHAR2,
        Cedula IN VARCHAR2,
        Telefono IN VARCHAR2,
        Edad IN INTEGER,
        Correo IN VARCHAR2,
        Nit IN VARCHAR2,
        Nombre_Representante IN VARCHAR2,
        Telefono_Representante IN VARCHAR2
    );


    PROCEDURE Crear_Valoracion(
        NombreUsuario IN VARCHAR2,
        NombreContenido IN VARCHAR2,
        Codigo IN VARCHAR2,
        Descripcion IN VARCHAR2,
        Valoracion IN INTEGER,
        Fecha_Valoracion IN DATE
    );
    
    
    PROCEDURE Crear_Alerta(
        NombreUsuario IN VARCHAR2,
        Descripcion IN VARCHAR2,
        Fecha_Alerta IN DATE
    );
    
    
    PROCEDURE Modificar_Plataforma(
        Nom_Plataforma IN VARCHAR2, 
        Precio IN NUMBER
    );
    
    
    PROCEDURE Modificar_Pelicula(
        Nombre IN VARCHAR2, 
        Tipo IN CHAR, 
        Rating IN CHAR, 
        Reseña IN VARCHAR2, 
        Duracion IN VARCHAR2, 
        Ano IN DATE, 
        Genero IN VARCHAR2, 
        Visualizacion IN INTEGER, 
        Nombre_Saga IN VARCHAR2, 
        Nom_Plataforma IN VARCHAR2, 
        Precio IN NUMBER
    );
    
    
    PROCEDURE Modificar_Usuario(
        Nombre_Usuario IN VARCHAR2,
        Contacto1 IN VARCHAR2,
        Contacto2 IN VARCHAR2,
        Razon_Social IN XMLTYPE,
        Contrasena IN VARCHAR2,
        Cedula IN VARCHAR2,
        Telefono IN VARCHAR2,
        Edad IN INTEGER,
        Correo IN VARCHAR2,
        Nit IN VARCHAR2,
        Nombre_Representante IN VARCHAR2,
        Telefono_Representante IN VARCHAR2
    );
    
    
    
    PROCEDURE Modificar_Valoracion(
        NombreUsuario IN VARCHAR2,
        NombreContenido IN VARCHAR2,
        Codigo IN VARCHAR2,
        Descripcion IN VARCHAR2,
        Valoracion IN INTEGER,
        Fecha_Valoracion IN DATE
    );
    
    
    PROCEDURE Modificar_Actualizacion(
        NombreUsuario IN INTEGER,
        Descripcion IN VARCHAR2,
        Estado IN VARCHAR2
    );
    

    PROCEDURE Eliminar_Plataforma(
        Nom_Plataforma IN VARCHAR2
    );
    
    
    PROCEDURE Eliminar_Valoracion(
        NombreUsuario IN VARCHAR2,
        NombreContenido IN VARCHAR2
    );
    
    
    PROCEDURE ConsultarUsuario(
        NombreUsuario IN VARCHAR2,
        Nit IN VARCHAR2,
        Resultado OUT SYS_REFCURSOR
    );
    
    
    PROCEDURE ConsultarPosiblesBaneos(
        Resultado OUT SYS_REFCURSOR
    );
    
    PROCEDURE Consultar_PeliculaSaga(
        Nombre_Saga IN VARCHAR2, 
        Resultado OUT SYS_REFCURSOR
    );
    
    
    PROCEDURE Consultar_PeliculasEnPlataforma(
        Nombre_Plataforma IN VARCHAR2,   -- Nombre de la plataforma a consultar
        Resultado OUT SYS_REFCURSOR      -- Cursor de salida con los resultados
    );
    
    
    PROCEDURE Consultar_Serie_Plataforma(
        Nombre_Plataforma IN VARCHAR2, 
        Resultado OUT SYS_REFCURSOR
    );
    
    
    PROCEDURE Consultar_PlataformaMasVista(
        Resultado OUT SYS_REFCURSOR
    );


    PROCEDURE Consultar_VistasPlataforma(
        Nom_Plataforma IN VARCHAR2, 
        Resultado OUT SYS_REFCURSOR
    );
    
    PROCEDURE Consultar_ContenidosReseñasPositivas(
        Resultado OUT SYS_REFCURSOR
    );
    
    
    PROCEDURE ConsultarValoraciones(
        NombreUsuario IN VARCHAR2,
        NombreContenido IN VARCHAR2,
        Resultado OUT SYS_REFCURSOR
    );
    
    PROCEDURE ConsultarCantActdesaprobadas(
        Resultado OUT SYS_REFCURSOR
    );
    
        PROCEDURE ConsultarCantAlertas(
        Resultado OUT SYS_REFCURSOR
    );

    PROCEDURE ConsultarCantValoraciones(
        Resultado OUT SYS_REFCURSOR
    );

    PROCEDURE ConsultarCantUsuariosActualizan(
        Resultado OUT SYS_REFCURSOR
    );

    PROCEDURE ConsultaTelefonosEmpresasGeneranAlertas(
        Resultado OUT SYS_REFCURSOR
    );

END PK_ASISTENTE_DE_GERENCIA;


CREATE OR REPLACE PACKAGE BODY PK_ASISTENTE_DE_GERENCIA AS

    PROCEDURE Añadir_Pelicula(
        Nombre IN VARCHAR2, 
        Tipo IN CHAR DEFAULT 'P', 
        Rating IN CHAR, 
        Reseña IN VARCHAR2, 
        Duracion IN VARCHAR2, 
        Ano IN DATE, 
        Genero IN VARCHAR2, 
        Visualizacion IN INTEGER, 
        Nombre_Saga IN VARCHAR2, 
        Nom_Plataforma IN VARCHAR2, 
        Precio IN NUMBER
    ) IS
        N_pelicula NUMBER;
        C_Contenido NUMBER;
        Num_Plataforma NUMBER;  -- Definir la variable para el código de contenido
        Saga_Existe BOOLEAN := FALSE;  -- Variable para verificar si la saga existe
    BEGIN

        -- Obtener el siguiente valor de la secuencia para N_pelicula
        SELECT SEQ_N_PELICULA.NEXTVAL INTO N_pelicula FROM dual;
    
        -- Obtener el siguiente valor de la secuencia para Codigo_contenido
        SELECT SEQ_CONTENIDOS.NEXTVAL INTO C_Contenido FROM dual;
        
        -- Insertar la película en la tabla Contenidos
        INSERT INTO Contenidos (Codigo, Tipo, Nombre, Rating, Reseña)
        VALUES (C_Contenido,'P', Nombre, Rating, Reseña);
        
        -- Insertar la película en la tabla Peliculas
        INSERT INTO Peliculas (Codigo_contenido, N_pelicula, Duracion, Ano, Genero, Visualizacion)
        VALUES ('P'||C_Contenido, N_pelicula, Duracion, Ano, Genero, Visualizacion);
        COMMIT;
        
        -- Si la película tiene saga, actualizar la tabla Sagas
        IF Nombre_Saga IS NOT NULL THEN
            -- Verificar si la saga ya existe
            SELECT COUNT(*) INTO N_pelicula
            FROM Sagas U
            WHERE U.Nombre_saga = Nombre_Saga;

            IF N_pelicula > 0 THEN
                -- Si existe, actualizar el número de películas de la saga
                UPDATE Sagas
                SET N_peliculas = N_peliculas + 1
                WHERE Nombre_saga = Nombre_Saga;
            ELSE
                -- Si no existe, insertar la nueva saga
                INSERT INTO Sagas (Codigo_pelicula, Nombre_saga, N_peliculas)
                VALUES ('P'||C_Contenido, Nombre_Saga, 1);  -- Inicialmente, con 1 película
            END IF;
        END IF;
    
        -- Verificar si la plataforma existe, si no, insertarla
        BEGIN
            SELECT Numero_plataforma INTO Num_Plataforma
            FROM Plataformas
            WHERE Nombre = Nom_Plataforma;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                -- Si no existe, insertar la nueva plataforma
                INSERT INTO Plataformas(Numero_plataforma, Nombre, Precio)
                VALUES (SEQ_NUMERO_PLATAFORMA.NEXTVAL, Nom_Plataforma, Precio);
                
                -- Obtener el número de plataforma recién creado
                SELECT SEQ_NUMERO_PLATAFORMA.CURRVAL INTO Num_Plataforma FROM dual;
        END;
    
        -- Insertar en la tabla ContenidosXPlataformas
        INSERT INTO ContenidosXPlataformas (Codigo_contenido, Numero_plataforma)
        VALUES ('P'||C_Contenido, Num_Plataforma);

        COMMIT;  -- Confirmar la inserción de los datos
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- Revertir cualquier cambio en caso de error
            RAISE;  -- Re-lanzar la excepción para su manejo
    END Añadir_Pelicula;

    -- Procedimiento para añadir una serie
    PROCEDURE Añadir_Serie(
        Nombre IN VARCHAR2, 
        Tipo IN CHAR DEFAULT 'S', 
        Rating IN CHAR, 
        Reseña IN VARCHAR2, 
        Año_Inicio IN DATE, 
        Año_Final IN DATE, 
        Genero IN VARCHAR2, 
        Estado IN CHAR, 
        Visualizacion IN INTEGER, 
        N_Capitulos IN INTEGER, 
        Nombre_Cap IN VARCHAR2, 
        N_Temporada IN INTEGER, 
        Descripcion IN VARCHAR2, 
        Nom_Plataforma IN VARCHAR2, 
        Precio IN NUMBER
    ) IS
        N_serie NUMBER;
        C_Contenido VARCHAR2(10);
        Num_plataforma NUMBER;
    BEGIN
    

        -- Obtener el siguiente valor de la secuencia para N_serie
        SELECT SEQ_CODIGO_SERIE.NEXTVAL INTO N_serie FROM dual;
        
        -- Obtener el siguiente valor de la secuencia para Código de contenido
        SELECT SEQ_CONTENIDOS.NEXTVAL INTO C_Contenido FROM dual;
    
        -- Insertar en la tabla Contenidos (para la serie)
        INSERT INTO Contenidos (Codigo, Tipo, Nombre, Rating, Reseña)
        VALUES (C_Contenido, 'S', Nombre, Rating, Reseña);
    
        -- Insertar en la tabla Series
        INSERT INTO Series (Codigo_contenido, N_serie, Ano_inicio, Ano_final, Genero, Estado, Visualizacion)
        VALUES ('S'||C_Contenido, N_serie, Año_Inicio, Año_Final, Genero, Estado, Visualizacion);
    
        -- Insertar los capítulos relacionados (de acuerdo al número de capítulos)
        INSERT INTO Capitulos (Codigo_serie, N_capitulo, Nombre)
        VALUES ('S'||C_Contenido, N_Capitulos, Nombre_Cap);

        -- Insertar las temporadas
        INSERT INTO Temporadas (Codigo_serie, N_temporada, Descripcion)
        VALUES ('S'||C_Contenido, N_temporada, Descripcion);

        -- Obtener el número de la plataforma
        BEGIN
            SELECT Numero_plataforma INTO Num_Plataforma
            FROM Plataformas
            WHERE Nombre = Nom_Plataforma;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                -- Si no existe, insertar la nueva plataforma
                INSERT INTO Plataformas(Numero_plataforma, Nombre, Precio)
                VALUES (SEQ_NUMERO_PLATAFORMA.NEXTVAL, Nom_Plataforma, Precio);
                
                -- Obtener el número de plataforma recién creado
                SELECT SEQ_NUMERO_PLATAFORMA.CURRVAL INTO Num_Plataforma FROM dual;
        END;

        -- Insertar en la tabla ContenidosXPlataformas
        INSERT INTO ContenidosXPlataformas (Codigo_contenido, Numero_plataforma)
        VALUES ('S'||C_Contenido, Num_plataforma);
    
        COMMIT;  -- Confirmar la inserción de los datos
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- En caso de error, revertir los cambios
            RAISE;  -- Re-lanzar la excepción para su manejo
    END Añadir_Serie;



    -- Procedimiento para añadir una plataforma
    PROCEDURE Añadir_Plataforma(
            Nom_Plataforma IN VARCHAR2,  -- Nombre de la plataforma
            Precio IN NUMBER             -- Precio de la plataforma
        ) IS
            Numero_plataforma NUMBER;    -- Número de la plataforma generado
            Plataforma_Existe NUMBER;   -- Variable para verificar si la plataforma ya existe
        BEGIN
            -- Verificar si la plataforma ya existe
            SELECT COUNT(*) INTO Plataforma_Existe
            FROM Plataformas
            WHERE Nombre = Nom_Plataforma;
    
            -- Si la plataforma no existe, proceder a insertarla
            IF Plataforma_Existe = 0 THEN
                -- Obtener el siguiente valor de la secuencia para Numero_plataforma
                SELECT SEQ_NUMERO_PLATAFORMA.NEXTVAL INTO Numero_plataforma FROM dual;
            
                -- Insertar en la tabla Plataformas
                INSERT INTO Plataformas (Numero_plataforma, Nombre, Precio)
                VALUES (Numero_plataforma, Nom_Plataforma, Precio);
            
                COMMIT;  -- Confirmar la inserción de los datos
            END IF;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;  -- En caso de error, revertir los cambios
                RAISE;  -- Re-lanzar la excepción para su manejo
        END Añadir_Plataforma;
        
    PROCEDURE Crear_Usuario(
        Nombre_Usuario IN VARCHAR2,
        Contacto1 IN VARCHAR2,
        Contacto2 IN VARCHAR2,
        Razon_Social IN XMLTYPE,
        Contrasena IN VARCHAR2,
        Cedula IN VARCHAR2,
        Telefono IN VARCHAR2,
        Edad IN INTEGER,
        Correo IN VARCHAR2,
        Nit IN VARCHAR2,
        Nombre_Representante IN VARCHAR2,
        Telefono_Representante IN VARCHAR2
    ) IS
        N_usuario NUMBER;
    BEGIN
        IF Cedula IS NOT NULL THEN
            -- Usuario estándar
            SELECT SEQ_N_USUARIO.NEXTVAL INTO N_usuario FROM dual;
            INSERT INTO Usuarios (N_usuario, NombreUsuario, Contacto1, Contacto2, Contraseña)
            VALUES (N_usuario, Nombre_Usuario, Contacto1, Contacto2, Contrasena);
            
            INSERT INTO UsuariosEstandar (N_usuarioU, Cedula, Telefono, Edad)
            VALUES (N_usuario, Cedula, Telefono, Edad);
            
            INSERT INTO Correos (Correo,N_UsuarioE,Cedula_UsuarioE)
            VALUES (Correo,N_Usuario,Cedula);
            
        ELSIF Razon_Social IS NOT NULL THEN
            -- Empresa
            SELECT SEQ_N_USUARIO.NEXTVAL INTO N_usuario FROM dual;
            INSERT INTO Usuarios (N_usuario, NombreUsuario, Contacto1, Contacto2, Contraseña)
            VALUES (N_usuario, Nombre_Usuario, Contacto1, Contacto2, Contrasena);
            
            INSERT INTO Empresas (N_usuario, NIT, RazonSocial, Nombre_representante, Telefono, Telefono_representante)
            VALUES (N_usuario, Nit, Razon_Social, Nombre_Representante, Telefono, Telefono_Representante);
        END IF;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END Crear_Usuario;

    -- Procedimiento para crear una valoración
    PROCEDURE Crear_Valoracion(
        NombreUsuario IN VARCHAR2,
        NombreContenido IN VARCHAR2,
        Codigo IN VARCHAR2,
        Descripcion IN VARCHAR2,
        Valoracion IN INTEGER,
        Fecha_Valoracion IN DATE
    ) IS
        N_Usuario NUMBER;
        CedulaU VARCHAR2(20);
    BEGIN
        SELECT N_usuarioU, Cedula INTO N_Usuario, CedulaU
        FROM UsuariosEstandar
        WHERE NombreUsuario = NombreUsuario;

        INSERT INTO Valoraciones (N_usuarioE, Cedula_usuarioE, Codigo_contenido, Codigo, Descripcion, Valoracion, Fecha_Valoracion)
        VALUES (N_Usuario, CedulaU, NombreContenido, Codigo, Descripcion, Valoracion, Fecha_Valoracion);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END Crear_Valoracion;

   PROCEDURE Crear_Alerta(
        NombreUsuario IN VARCHAR2,
        Descripcion IN VARCHAR2,
        Fecha_Alerta IN DATE
    ) IS
        N_Usuario NUMBER; -- Variable para almacenar el N_usuario
        N_Alerta NUMBER;  -- Variable para almacenar el N_alerta generado
        CANTIDAD_REGISTROS NUMBER; -- Variable para contar registros coincidentes
    BEGIN
        -- Verifica si el NombreUsuario existe y cuántos registros coinciden
        SELECT COUNT(*) INTO CANTIDAD_REGISTROS
        FROM Usuarios U
        WHERE U.NombreUsuario = NombreUsuario;
    
        -- Manejo de casos específicos
        IF CANTIDAD_REGISTROS = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'No existe un usuario con ese NombreUsuario.');
        END IF;
    
        -- Recupera el N_usuario del usuario solicitado
        SELECT U.N_usuario INTO N_Usuario
        FROM Usuarios U
        WHERE U.NombreUsuario = NombreUsuario AND ROWNUM = 1;
    
        -- Genera el número único para la alerta
        SELECT SEQ_N_ALERTA.NEXTVAL INTO N_Alerta FROM dual;
    
        -- Inserta la alerta
        INSERT INTO Alertas (N_alerta, N_usuarioU, Descripcion, fechaAlerta)
        VALUES (N_Alerta, N_Usuario, Descripcion, Fecha_Alerta);
    
        -- Confirmar la transacción
        COMMIT;
    
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Error: El usuario no existe.');
            RAISE_APPLICATION_ERROR(-20001, 'Usuario no encontrado.');
    
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error inesperado: ' || SQLERRM);
            ROLLBACK;
            RAISE;
    END Crear_Alerta;
    
    PROCEDURE Modificar_Plataforma(
        Nom_Plataforma IN VARCHAR2,  -- Nombre de la plataforma a modificar
        Precio IN NUMBER             -- Nuevo precio de la plataforma
    ) IS
        Numero_plataforma NUMBER;    -- Número de la plataforma a actualizar
    BEGIN
        -- Obtener el número de la plataforma basado en el nombre proporcionado
        SELECT Numero_plataforma INTO Numero_plataforma
        FROM Plataformas
        WHERE Nombre = Nom_Plataforma;
    
        -- Actualizar el precio en la tabla Plataformas
        UPDATE Plataformas
        SET Precio = NVL(Precio, Precio)
        WHERE Numero_plataforma = Numero_plataforma;
    
        -- Actualizar los contenidos asociados a esta plataforma
        -- (Si el precio de la plataforma cambia, se actualiza la relación en ContenidosXPlataformas)
        UPDATE ContenidosXPlataformas
        SET Numero_plataforma = Numero_plataforma
        WHERE Numero_plataforma = Numero_plataforma;
    
        COMMIT;  -- Confirmar los cambios
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- En caso de error, revertir los cambios
            RAISE;      -- Re-lanzar la excepción para su manejo
    END Modificar_Plataforma;
    
    PROCEDURE Modificar_Pelicula(
        Nombre IN VARCHAR2,                  -- Nombre de la película a modificar
        Tipo IN CHAR,                         -- Tipo de contenido (por ejemplo, 'P' para película)
        Rating IN CHAR,                       -- Calificación de la película
        Reseña IN VARCHAR2,                   -- Reseña de la película
        Duracion IN VARCHAR2,                 -- Duración de la película
        Ano IN DATE,                          -- Año de la película
        Genero IN VARCHAR2,                   -- Género de la película
        Visualizacion IN INTEGER,             -- Número de visualizaciones
        Nombre_Saga IN VARCHAR2,              -- Nombre de la saga (si aplica)
        Nom_Plataforma IN VARCHAR2,           -- Nombre de la plataforma
        Precio IN NUMBER                      -- Precio de la plataforma
    ) IS
        Codigo_contenido VARCHAR2(10);        -- Código de contenido de la película
        Numero_plataforma NUMBER;             -- Número de la plataforma
    BEGIN
        -- Obtener el código de contenido de la película
        SELECT Codigo 
        INTO Codigo_contenido 
        FROM Contenidos U
        WHERE U.Nombre = Nombre
        AND U.Tipo = Tipo -- Asegúrate de que esta condición sea única
        AND ROWNUM = 1;  -- Obtiene solo el primer registro si hay más de uno

        -- Actualizar los datos en la tabla Contenidos solo si el valor no es NULL
        IF Rating IS NOT NULL THEN
            UPDATE Contenidos U
            SET U.Rating = Rating
            WHERE Codigo = Codigo_contenido;
        END IF;
    
        IF Reseña IS NOT NULL THEN
            UPDATE Contenidos U
            SET U.Reseña = Reseña
            WHERE Codigo = Codigo_contenido;
        END IF;

        -- Actualizar los datos de la película en la tabla Peliculas solo si el valor no es NULL
        IF Duracion IS NOT NULL THEN
            UPDATE Peliculas U
            SET U.Duracion = Duracion
            WHERE U.Codigo_contenido = Codigo_contenido;
        END IF;
    
        IF Ano  IS NOT NULL THEN
            UPDATE Peliculas U
            SET U.Ano = Ano
            WHERE U.Codigo_contenido = Codigo_contenido;
        END IF;
    
        IF Visualizacion IS NOT NULL THEN
            UPDATE Peliculas U
            SET U.Visualizacion = Visualizacion
            WHERE U.Codigo_contenido = Codigo_contenido;
        END IF;
    
        -- Si hay saga, actualizar la tabla Sagas solo si el valor no es NULL
        IF Nombre_Saga IS NOT NULL THEN
            -- Actualizar o insertar saga si no existe
            UPDATE Sagas U
            SET U.Nombre_saga = Nombre_Saga
            WHERE Codigo_pelicula = Codigo_contenido;
        END IF;
    
        -- Obtener el número de la plataforma
        SELECT Numero_plataforma 
        INTO Numero_plataforma 
        FROM Plataformas 
        WHERE Nombre = Nom_Plataforma
        AND ROWNUM = 1; -- Obtiene el primer registro si hay más de uno
    
        -- Validar si existe la plataforma asociada al contenido
        DECLARE
            plataforma_existe INTEGER;
        BEGIN
            SELECT COUNT(*)
            INTO plataforma_existe
            FROM ContenidosXPlataformas
            WHERE Codigo_contenido = Codigo_contenido
              AND Numero_plataforma = Numero_plataforma;
    
            IF plataforma_existe = 0 THEN
                RAISE_APPLICATION_ERROR(-20001, 'La plataforma no existe para este contenido.');
            ELSE
                -- Actualizar el precio en la tabla Plataformas solo si el valor no es NULL
                IF Precio IS NOT NULL THEN
                    UPDATE Plataformas U
                    SET U.Precio = Precio
                    WHERE Numero_plataforma = Numero_plataforma;
                END IF;
            END IF;
        END;
    
        COMMIT;  -- Confirmar los cambios
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- Revertir cualquier cambio si ocurre un error
            RAISE;      -- Re-lanzar la excepción para su manejo
    END Modificar_Pelicula;
    
       PROCEDURE Modificar_Usuario(
        Nombre_Usuario IN VARCHAR2,
        Contacto1 IN VARCHAR2,
        Contacto2 IN VARCHAR2,
        Razon_Social IN XMLTYPE,
        Contrasena IN VARCHAR2,
        Cedula IN VARCHAR2,
        Telefono IN VARCHAR2,
        Edad IN INTEGER,
        Correo IN VARCHAR2,
        Nit IN VARCHAR2,
        Nombre_Representante IN VARCHAR2,
        Telefono_Representante IN VARCHAR2
    ) IS
    BEGIN
        -- Actualiza en la tabla Usuarios
        DBMS_OUTPUT.PUT_LINE('Intentando actualizar Usuarios...');
        UPDATE Usuarios
        SET 
            Contacto1 = NVL(Modificar_Usuario.Contacto1, Usuarios.Contacto1),
            Contacto2 = NVL(Modificar_Usuario.Contacto2, Usuarios.Contacto2),
            Contraseña = NVL(Modificar_Usuario.Contrasena, Usuarios.Contraseña)
        WHERE Usuarios.NombreUsuario = Modificar_Usuario.Nombre_Usuario;
    
        IF SQL%ROWCOUNT = 0 THEN
            DBMS_OUTPUT.PUT_LINE('No se encontró el usuario en la tabla Usuarios.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Tabla Usuarios actualizada.');
        END IF;
    
        -- Actualiza en la tabla UsuariosEstandar si Cedula no es NULL
        IF Cedula IS NOT NULL THEN
            DBMS_OUTPUT.PUT_LINE('Intentando actualizar UsuariosEstandar...');
            UPDATE UsuariosEstandar
            SET 
                Telefono = NVL(Modificar_Usuario.Telefono, UsuariosEstandar.Telefono),
                Edad = NVL(Modificar_Usuario.Edad, UsuariosEstandar.Edad)
            WHERE UsuariosEstandar.Cedula = Modificar_Usuario.Cedula;
    
            IF SQL%ROWCOUNT = 0 THEN
                DBMS_OUTPUT.PUT_LINE('No se encontró el usuario en la tabla UsuariosEstandar.');
            ELSE
                DBMS_OUTPUT.PUT_LINE('Tabla UsuariosEstandar actualizada.');
            END IF;
        END IF;
    
        -- Actualiza en la tabla Empresas si Nit no es NULL
        IF Nit IS NOT NULL THEN
            DBMS_OUTPUT.PUT_LINE('Intentando actualizar Empresas...');
            UPDATE Empresas
            SET 
                RazonSocial = NVL(Modificar_Usuario.Razon_Social, Empresas.RazonSocial),
                Telefono = NVL(Modificar_Usuario.Telefono, Empresas.Telefono),
                Telefono_representante = NVL(Modificar_Usuario.Telefono_Representante, Empresas.Telefono_representante),
                Nombre_representante = NVL(Modificar_Usuario.Nombre_Representante, Empresas.Nombre_representante)
            WHERE Empresas.NIT = Modificar_Usuario.Nit;
    
            IF SQL%ROWCOUNT = 0 THEN
                DBMS_OUTPUT.PUT_LINE('No se encontró la empresa en la tabla Empresas.');
            ELSE
                DBMS_OUTPUT.PUT_LINE('Tabla Empresas actualizada.');
            END IF;
        END IF;
    
        -- Actualiza en la tabla Correos si Correo no es NULL
        -- Actualiza en la tabla Correos si Correo no es NULL
    IF Correo IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('Intentando actualizar Correos...');
        DBMS_OUTPUT.PUT_LINE('Correo proporcionado: ' || Correo || ', Cédula proporcionada: ' || Cedula);
    
        -- Actualiza el correo en la tabla Correos
        UPDATE Correos
        SET Correo = Modificar_Usuario.Correo
        WHERE TRIM(Cedula_usuarioE) = TRIM(Cedula);
    
        -- Verifica si se actualizaron filas
        IF SQL%ROWCOUNT = 0 THEN
            DBMS_OUTPUT.PUT_LINE('No se encontró un correo asociado en la tabla Correos para la cédula proporcionada.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Tabla Correos actualizada correctamente.');
        END IF;
    END IF;
    
        -- Confirmar la transacción
    COMMIT;
    
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('Error inesperado: ' || SQLERRM);
            RAISE;
    END Modificar_Usuario;




    -- Procedimiento para modificar una valoración
    PROCEDURE Modificar_Valoracion(
        NombreUsuario IN VARCHAR2,
        NombreContenido IN VARCHAR2,
        Codigo IN VARCHAR2,
        Descripcion IN VARCHAR2,
        Valoracion IN INTEGER,
        Fecha_Valoracion IN DATE
    ) IS
        N_Usuario NUMBER;
        CedulaU VARCHAR2(20);
    BEGIN
        SELECT N_usuarioU, Cedula INTO N_Usuario, CedulaU
        FROM UsuariosEstandar
        WHERE NombreUsuario = NombreUsuario;

        UPDATE Valoraciones
        SET 
            Descripcion = NVL(Descripcion, Descripcion),
            Valoracion = NVL(Valoracion, Valoracion),
            Fecha_Valoracion = NVL(Fecha_Valoracion, Fecha_Valoracion)
        WHERE N_usuarioE = N_Usuario 
            AND Cedula_usuarioE = CedulaU
            AND Codigo_contenido = NombreContenido
            AND Codigo = Codigo;
        
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END Modificar_Valoracion;

    -- Procedimiento para modificar una actualización
    PROCEDURE Modificar_Actualizacion(
        NombreUsuario IN INTEGER,
        Descripcion IN VARCHAR2,
        Estado IN VARCHAR2
    ) IS
        N_Usuario NUMBER;
        CedulaU VARCHAR2(20);
        N_Recompensa NUMBER;
    BEGIN
        SELECT N_usuarioU, Cedula INTO N_Usuario, CedulaU
        FROM UsuariosEstandar
        WHERE N_usuarioU = NombreUsuario;

        IF Estado = 'Aprobado' THEN
            SELECT SEQ_RECOMPENSAS.NEXTVAL INTO N_Recompensa FROM dual;

            INSERT INTO SistemasRecompensa (N_recompensa, Descripcion, Tipo)
            VALUES (N_Recompensa, Descripcion, 'Recompensa Aprobada');

            UPDATE Actualizaciones
            SET N_recompensas = N_Recompensa
            WHERE N_usuarioE = N_Usuario
            AND Cedula_usuarioE = CedulaU;
        END IF;

        UPDATE Actualizaciones
        SET 
            Descripcion = NVL(Descripcion, Descripcion),
            Estado = NVL(Estado, Estado)
        WHERE N_usuarioE = N_Usuario
        AND Cedula_usuarioE = CedulaU;

        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END Modificar_Actualizacion;
    
        PROCEDURE Eliminar_Plataforma(
        Nom_Plataforma IN VARCHAR2  -- Nombre de la plataforma a eliminar
    ) IS
        Numero_plataforma NUMBER;   -- Número de la plataforma a eliminar
    BEGIN
        -- Intentar obtener el número de la plataforma
        BEGIN
            SELECT Numero_plataforma
            INTO Numero_plataforma
            FROM Plataformas
            WHERE Nombre = Nom_Plataforma;
    
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                -- Manejo del error si no se encuentra la plataforma
                RAISE_APPLICATION_ERROR(-20001, 'La plataforma no existe: ' || Nom_Plataforma);
            WHEN OTHERS THEN
                -- Manejo de cualquier otro error
                RAISE_APPLICATION_ERROR(-20002, 'Error al obtener la plataforma: ' || SQLERRM);
        END;
    
        -- Eliminar las relaciones de la plataforma con los contenidos
        DELETE FROM ContenidosXPlataformas
        WHERE Numero_plataforma = Numero_plataforma;
    
        -- Eliminar la plataforma de la tabla Plataformas
        DELETE FROM Plataformas
        WHERE Numero_plataforma = Numero_plataforma;
    
        -- Confirmar los cambios
        COMMIT;
    
    EXCEPTION
        WHEN OTHERS THEN
            -- Revertir cambios en caso de error
            ROLLBACK;
            RAISE; -- Re-lanzar la excepción para su manejo
    END Eliminar_Plataforma;
    
        PROCEDURE Eliminar_Valoracion(
        NombreUsuario IN VARCHAR2,
        NombreContenido IN VARCHAR2
    ) IS
        N_Usuario NUMBER;
        CedulaU VARCHAR2(20);
        CodigoContenido VARCHAR2(10);
    BEGIN
        SELECT N_usuarioU, Cedula INTO N_Usuario, CedulaU
        FROM UsuariosEstandar
        WHERE NombreUsuario = NombreUsuario;

        SELECT Codigo INTO CodigoContenido
        FROM Contenidos
        WHERE Nombre = NombreContenido;

        DELETE FROM Valoraciones
        WHERE N_usuarioE = N_Usuario
        AND Cedula_usuarioE = CedulaU
        AND Codigo_contenido = CodigoContenido;

        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END Eliminar_Valoracion;
    
    PROCEDURE ConsultarUsuario(
        NombreUsuario IN VARCHAR2,
        Nit IN VARCHAR2,
        Resultado OUT SYS_REFCURSOR
    ) IS
    BEGIN
        IF NombreUsuario IS NOT NULL THEN
            OPEN Resultado FOR
            SELECT U.N_usuario, C.Correo
            FROM Usuarios U
            LEFT JOIN UsuariosEstandar UE ON U.N_usuario = UE.N_usuarioU
            LEFT JOIN Correos C ON C.N_usuarioE = UE.N_usuarioU
            WHERE U.NombreUsuario = NombreUsuario;
        ELSIF Nit IS NOT NULL THEN
            OPEN Resultado FOR
            SELECT E.N_usuario
            FROM Empresas E
            WHERE E.NIT = Nit;
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END ConsultarUsuario;
    
        -- Procedimiento para consultar los usuarios que más crean actualizaciones desaprobadas
    PROCEDURE ConsultarPosiblesBaneos(
        Resultado OUT SYS_REFCURSOR
    ) IS
    BEGIN
        OPEN Resultado FOR
        SELECT N_usuarioE, COUNT(*) AS Cantidad
        FROM Actualizaciones
        WHERE Estado = 'Desaprobado'
        GROUP BY N_usuarioE
        ORDER BY Cantidad DESC;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END ConsultarPosiblesBaneos;
    
    PROCEDURE Consultar_PeliculaSaga(
        Nombre_Saga IN VARCHAR2,  -- Nombre de la saga a consultar
        Resultado OUT SYS_REFCURSOR  -- Cursor de salida con los resultados
    ) IS
    BEGIN
        -- Abrir el cursor para consultar todas las películas relacionadas con la saga
        OPEN Resultado FOR
        SELECT P.Codigo_contenido, P.N_pelicula, P.Duracion, P.Ano, P.Genero, P.Visualizacion
        FROM Peliculas P
        JOIN Sagas S ON P.Codigo_contenido = S.Codigo_pelicula
        WHERE S.Nombre_saga = Nombre_Saga;
    
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- En caso de error, revertir cualquier cambio
            RAISE;      -- Re-lanzar la excepción para su manejo
    END Consultar_PeliculaSaga;
    
    -- Procedimiento para consultar las películas en una plataforma
    PROCEDURE Consultar_PeliculasEnPlataforma(
        Nombre_Plataforma IN VARCHAR2,   -- Nombre de la plataforma a consultar
        Resultado OUT SYS_REFCURSOR      -- Cursor de salida con los resultados
    ) IS
    BEGIN
        -- Abrir el cursor para consultar las películas en la plataforma correspondiente
        OPEN Resultado FOR
        SELECT P.Codigo_contenido, P.N_pelicula, P.Duracion, P.Ano, P.Genero, P.Visualizacion
        FROM Peliculas P
        JOIN Contenidos C ON P.Codigo_contenido = C.Codigo
        JOIN ContenidosXPlataformas CP ON P.Codigo_contenido = CP.Codigo_contenido
        JOIN Plataformas PL ON CP.Numero_plataforma = PL.Numero_plataforma
        WHERE PL.Nombre = Nombre_Plataforma;  -- Filtrando por el nombre de la plataforma
    
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- En caso de error, revertir cualquier cambio
            RAISE;      -- Re-lanzar la excepción para su manejo
    END Consultar_PeliculasEnPlataforma;
    
    -- Procedimiento para consultar las series en una plataforma
    PROCEDURE Consultar_Serie_Plataforma(
        Nombre_Plataforma IN VARCHAR2,   -- Nombre de la plataforma a consultar
        Resultado OUT SYS_REFCURSOR      -- Cursor de salida con los resultados
    ) IS
    BEGIN
        -- Abrir el cursor para consultar las series en la plataforma correspondiente
        OPEN Resultado FOR
        SELECT S.Codigo_contenido, S.N_Serie, S.Ano_inicio, S.Ano_final, S.Genero, S.Estado, S.Visualizacion
        FROM Series S
        JOIN Contenidos C ON S.Codigo_contenido = C.Codigo
        JOIN ContenidosXPlataformas CP ON S.Codigo_contenido = CP.Codigo_contenido
        JOIN Plataformas PL ON CP.Numero_plataforma = PL.Numero_plataforma
        WHERE PL.Nombre = Nombre_Plataforma;  -- Filtrando por el nombre de la plataforma
    
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- En caso de error, revertir cualquier cambio
            RAISE;      -- Re-lanzar la excepción para su manejo
    END Consultar_Serie_Plataforma;
    
    -- Procedimiento para consultar la plataforma más vista
    PROCEDURE Consultar_PlataformaMasVista(
        Resultado OUT SYS_REFCURSOR   -- Cursor de salida con el resultado
    ) IS
    BEGIN
        -- Abrir el cursor para obtener la plataforma más vista según las visualizaciones
        OPEN Resultado FOR
        SELECT PL.Nombre AS Plataforma,
               SUM(S.Visualizacion) AS Total_Visualizaciones
        FROM Plataformas PL
        JOIN ContenidosXPlataformas CP ON PL.Numero_plataforma = CP.Numero_plataforma
        JOIN Contenidos C ON CP.Codigo_contenido = C.Codigo
        LEFT JOIN Series S ON C.Codigo = S.Codigo_contenido  -- Asociamos las series
        LEFT JOIN Peliculas P ON C.Codigo = P.Codigo_contenido  -- Asociamos las películas
        GROUP BY PL.Nombre
        ORDER BY Total_Visualizaciones DESC
        FETCH FIRST 1 ROWS ONLY;  -- Obtener la plataforma con más visualizaciones
    
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- En caso de error, revertir cualquier cambio
            RAISE;      -- Re-lanzar la excepción para su manejo
    END Consultar_PlataformaMasVista;
    
    -- Procedimiento para consultar las vistas de una plataforma
    PROCEDURE Consultar_VistasPlataforma(
        Nom_Plataforma IN VARCHAR2,   -- Nombre de la plataforma que se desea consultar
        Resultado OUT SYS_REFCURSOR   -- Cursor de salida con el resultado
    ) IS
        v_Numero_plataforma NUMBER;   -- Variable para almacenar el número de la plataforma
    BEGIN
        -- Obtener el número de la plataforma basada en su nombre
        SELECT Numero_plataforma 
        INTO v_Numero_plataforma
        FROM Plataformas
        WHERE Nombre = Nom_Plataforma;
    
        -- Abrir el cursor para obtener las visualizaciones totales de la plataforma
        OPEN Resultado FOR
        SELECT PL.Nombre AS Plataforma,
               SUM(NVL(S.Visualizacion, 0) + NVL(P.Visualizacion, 0)) AS Total_Visualizaciones
        FROM ContenidosXPlataformas CP
        JOIN Plataformas PL ON CP.Numero_plataforma = PL.Numero_plataforma
        JOIN Contenidos C ON CP.Codigo_contenido = C.Codigo
        LEFT JOIN Series S ON C.Codigo = S.Codigo_contenido  -- Asociamos las series
        LEFT JOIN Peliculas P ON C.Codigo = P.Codigo_contenido  -- Asociamos las películas
        WHERE PL.Numero_plataforma = v_Numero_plataforma
        GROUP BY PL.Nombre
        ORDER BY Total_Visualizaciones DESC;
    
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- En caso de error, revertir cualquier cambio
            RAISE;      -- Re-lanzar la excepción para su manejo
    END Consultar_VistasPlataforma;
    
    -- Procedimiento para consultar contenidos con reseñas positivas
    PROCEDURE Consultar_ContenidosReseñasPositivas(
        Resultado OUT SYS_REFCURSOR  -- Cursor de salida con el resultado
    ) IS
    BEGIN
        -- Abrir el cursor para obtener los contenidos con valoraciones positivas
        OPEN Resultado FOR
        SELECT C.Nombre AS Contenido,
               V.Descripcion AS Reseña,
               V.Valoracion AS Valoracion
        FROM Valoraciones V
        JOIN Contenidos C ON V.Codigo_contenido = C.Codigo
        WHERE V.Valoracion >= 4  -- Umbral de valoración positiva
        ORDER BY V.Valoracion DESC;  -- Ordenamos de mayor a menor valoración
    
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- En caso de error, revertir cualquier cambio
            RAISE;      -- Re-lanzar la excepción para su manejo
    END Consultar_ContenidosReseñasPositivas;
    
        PROCEDURE ConsultarActualizaciones(
        NombreUsuario IN VARCHAR2,
        Resultado OUT SYS_REFCURSOR
    ) IS
        N_Usuario NUMBER;
    BEGIN
        SELECT N_usuarioU INTO N_Usuario
        FROM UsuariosEstandar
        WHERE NombreUsuario = NombreUsuario;

        OPEN Resultado FOR
        SELECT A.Descripcion, A.Estado
        FROM Actualizaciones A
        WHERE A.N_usuarioE = N_Usuario;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END ConsultarActualizaciones;
    
    PROCEDURE ConsultarValoraciones(
        NombreUsuario IN VARCHAR2,
        NombreContenido IN VARCHAR2,
        Resultado OUT SYS_REFCURSOR
    ) IS
        N_Usuario NUMBER;
        CedulaU VARCHAR2(20);
        CodigoContenido VARCHAR2(10);
    BEGIN
        SELECT N_usuarioU, Cedula INTO N_Usuario, CedulaU
        FROM UsuariosEstandar
        WHERE NombreUsuario = NombreUsuario;

        SELECT Codigo INTO CodigoContenido
        FROM Contenidos
        WHERE Nombre = NombreContenido;

        OPEN Resultado FOR
        SELECT V.Descripcion, V.Valoracion, V.fecha_valoracion
        FROM Valoraciones V
        WHERE V.N_usuarioE = N_Usuario
        AND V.Cedula_usuarioE = CedulaU
        AND V.Codigo_contenido = CodigoContenido;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END ConsultarValoraciones;
    
        PROCEDURE ConsultarCantActdesaprobadas(
        Resultado OUT SYS_REFCURSOR
    ) IS
    BEGIN
        OPEN Resultado FOR
        SELECT COUNT(*) AS Cantidad
        FROM Actualizaciones
        WHERE Estado = 'Desaprobado';
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END ConsultarCantActdesaprobadas;

    -- Procedimiento para consultar la cantidad de alertas que han generado los usuarios
    PROCEDURE ConsultarCantAlertas(
        Resultado OUT SYS_REFCURSOR
    ) IS
    BEGIN
        OPEN Resultado FOR
        SELECT COUNT(*) AS Cantidad
        FROM Alertas;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END ConsultarCantAlertas;
    
        PROCEDURE ConsultarCantValoraciones(
        Resultado OUT SYS_REFCURSOR
    ) IS
    BEGIN
        OPEN Resultado FOR
        SELECT COUNT(*) AS Cantidad
        FROM Valoraciones;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END ConsultarCantValoraciones;

    -- Procedimiento para consultar la cantidad de usuarios que han actualizado información
    PROCEDURE ConsultarCantUsuariosActualizan(
        Resultado OUT SYS_REFCURSOR
    ) IS
    BEGIN
        OPEN Resultado FOR
        SELECT COUNT(DISTINCT N_usuarioE) AS Cantidad
        FROM Actualizaciones
        WHERE N_recompensas IS NOT NULL;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END ConsultarCantUsuariosActualizan;

    -- Procedimiento para consultar los teléfonos de las empresas que han generado alertas
    PROCEDURE ConsultaTelefonosEmpresasGeneranAlertas(
        Resultado OUT SYS_REFCURSOR
    ) IS
    BEGIN
        OPEN Resultado FOR
        SELECT E.Telefono
        FROM Empresas E
        JOIN Alertas A ON E.N_usuario = A.N_usuarioU;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END ConsultaTelefonosEmpresasGeneranAlertas;
    

END PK_ASISTENTE_DE_GERENCIA;


CREATE OR REPLACE PACKAGE PK_U_ESTANDAR AS

    PROCEDURE Crear_Usuario(
        Nombre_Usuario IN VARCHAR2,
        Contacto1 IN VARCHAR2,
        Contacto2 IN VARCHAR2,
        Razon_Social IN XMLTYPE,
        Contrasena IN VARCHAR2,
        Cedula IN VARCHAR2,
        Telefono IN VARCHAR2,
        Edad IN INTEGER,
        Correo IN VARCHAR2,
        Nit IN VARCHAR2,
        Nombre_Representante IN VARCHAR2,
        Telefono_Representante IN VARCHAR2
    );


    PROCEDURE Crear_Valoracion(
        NombreUsuario IN VARCHAR2,
        NombreContenido IN VARCHAR2,
        Codigo IN VARCHAR2,
        Descripcion IN VARCHAR2,
        Valoracion IN INTEGER,
        Fecha_Valoracion IN DATE
    );
    
    
    PROCEDURE Crear_Alerta(
        NombreUsuario IN VARCHAR2,
        Descripcion IN VARCHAR2,
        Fecha_Alerta IN DATE
    );
    
    
    PROCEDURE Modificar_Usuario(
        Nombre_Usuario IN VARCHAR2,
        Contacto1 IN VARCHAR2,
        Contacto2 IN VARCHAR2,
        Razon_Social IN XMLTYPE,
        Contrasena IN VARCHAR2,
        Cedula IN VARCHAR2,
        Telefono IN VARCHAR2,
        Edad IN INTEGER,
        Correo IN VARCHAR2,
        Nit IN VARCHAR2,
        Nombre_Representante IN VARCHAR2,
        Telefono_Representante IN VARCHAR2
    );
    
    
    
    PROCEDURE Modificar_Valoracion(
        NombreUsuario IN VARCHAR2,
        NombreContenido IN VARCHAR2,
        Codigo IN VARCHAR2,
        Descripcion IN VARCHAR2,
        Valoracion IN INTEGER,
        Fecha_Valoracion IN DATE
    );

    PROCEDURE Eliminar_Valoracion(
        NombreUsuario IN VARCHAR2,
        NombreContenido IN VARCHAR2
    );
    
    
    PROCEDURE ConsultarActualizaciones(
        NombreUsuario IN VARCHAR2,
        Resultado OUT SYS_REFCURSOR
    );

    PROCEDURE ConsultarRecompensas(
        NombreUsuario IN VARCHAR2,
        Resultado OUT SYS_REFCURSOR
    );


    PROCEDURE Añadir_Pelicula(
        Nombre IN VARCHAR2, 
        Tipo IN CHAR DEFAULT 'P', 
        Rating IN CHAR, 
        Reseña IN VARCHAR2, 
        Duracion IN VARCHAR2, 
        Ano IN DATE, 
        Genero IN VARCHAR2, 
        Visualizacion IN INTEGER, 
        Nombre_Saga IN VARCHAR2, 
        Nom_Plataforma IN VARCHAR2, 
        Precio IN NUMBER
    );

    PROCEDURE Añadir_Serie(
        Nombre IN VARCHAR2, 
        Tipo IN CHAR DEFAULT 'S', 
        Rating IN CHAR, 
        Reseña IN VARCHAR2, 
        Año_Inicio IN DATE, 
        Año_Final IN DATE, 
        Genero IN VARCHAR2, 
        Estado IN CHAR, 
        Visualizacion IN INTEGER, 
        N_Capitulos IN INTEGER, 
        Nombre_Cap IN VARCHAR2, 
        N_Temporada IN INTEGER, 
        Descripcion IN VARCHAR2, 
        Nom_Plataforma IN VARCHAR2, 
        Precio IN NUMBER
    );
    
    
    PROCEDURE Añadir_Plataforma(
        Nom_Plataforma IN VARCHAR2, 
        Precio IN NUMBER
    );
    

    PROCEDURE Modificar_Pelicula(
        Nombre IN VARCHAR2, 
        Tipo IN CHAR, 
        Rating IN CHAR, 
        Reseña IN VARCHAR2, 
        Duracion IN VARCHAR2, 
        Ano IN DATE, 
        Genero IN VARCHAR2, 
        Visualizacion IN INTEGER, 
        Nombre_Saga IN VARCHAR2, 
        Nom_Plataforma IN VARCHAR2, 
        Precio IN NUMBER
    );


    PROCEDURE Modificar_Serie(
        Nombre IN VARCHAR2, 
        Tipo IN CHAR, 
        Rating IN CHAR, 
        Reseña IN VARCHAR2, 
        Año_Inicio IN DATE, 
        Año_Final IN DATE, 
        Genero IN VARCHAR2, 
        Estado IN CHAR, 
        Visualizacion IN INTEGER, 
        N_Capitulos IN INTEGER, 
        Nombre_Cap IN VARCHAR2, 
        N_Temporada IN INTEGER, 
        Descripcion IN VARCHAR2, 
        Nom_Plataforma IN VARCHAR2, 
        Precio IN NUMBER
    );

    PROCEDURE Modificar_Plataforma(
        Nom_Plataforma IN VARCHAR2, 
        Precio IN NUMBER
    );
    
    PROCEDURE Eliminar_Plataforma(
        Nom_Plataforma IN VARCHAR2
    );
    
    PROCEDURE Consultar_PeliculaSaga(
        Nombre_Saga IN VARCHAR2, 
        Resultado OUT SYS_REFCURSOR
    );
    
    
    PROCEDURE Consultar_PeliculasEnPlataforma(
        Nombre_Plataforma IN VARCHAR2,   -- Nombre de la plataforma a consultar
        Resultado OUT SYS_REFCURSOR      -- Cursor de salida con los resultados
    );
    
    
    PROCEDURE Consultar_Serie_Plataforma(
        Nombre_Plataforma IN VARCHAR2, 
        Resultado OUT SYS_REFCURSOR
    );
    
    
    PROCEDURE Consultar_PlataformaMasVista(
        Resultado OUT SYS_REFCURSOR
    );


    PROCEDURE Consultar_VistasPlataforma(
        Nom_Plataforma IN VARCHAR2, 
        Resultado OUT SYS_REFCURSOR
    );
    
    PROCEDURE Consultar_ContenidosReseñasPositivas(
        Resultado OUT SYS_REFCURSOR
    );

    PROCEDURE Crear_Persona(
        Cedula IN VARCHAR2, 
        Nombre IN VARCHAR2, 
        Edad IN INTEGER, 
        Nacionalidad IN VARCHAR2, 
        F_Nacimiento IN DATE, 
        F_Fallecimiento IN DATE, 
        Genero IN VARCHAR2, 
        Genero_pref IN VARCHAR2, 
        Productora_Aliada IN VARCHAR2, 
        Altura IN FLOAT, 
        Formacion IN VARCHAR2
    );
    
    PROCEDURE Crear_Dirigidos(
        Nombre_Persona IN VARCHAR2, 
        Nombre_Contenido IN VARCHAR2, 
        Fecha_Inicio IN DATE, 
        Fecha_Final IN DATE
    );

    PROCEDURE Crear_Castings(
        Nombre_Persona IN VARCHAR2, 
        Nombre_Contenido IN VARCHAR2, 
        Nombre_Personaje IN VARCHAR2, 
        Rol IN VARCHAR2, 
        Tiempo_Participacion IN INTEGER, 
        Sueldo IN INTEGER
    );
    
    PROCEDURE Crear_Reconocimientos(
        N_Nominacion IN VARCHAR2, 
        Nombre_Persona IN VARCHAR2, 
        Nominacion IN VARCHAR2, 
        Estado IN VARCHAR2
    );
    
        PROCEDURE Modificar_Persona(
        Cedula IN VARCHAR2, 
        Nombre IN VARCHAR2, 
        Edad IN INTEGER, 
        Nacionalidad IN VARCHAR2, 
        F_Nacimiento IN DATE, 
        F_Fallecimiento IN DATE, 
        Genero IN VARCHAR2, 
        Genero_pref IN VARCHAR2, 
        Productora_Aliada IN VARCHAR2, 
        Altura IN FLOAT, 
        Formacion IN VARCHAR2
    );

    -- Consultas
    PROCEDURE Consultar_Personas(
        Nombre_Persona IN VARCHAR2, 
        Resultado OUT SYS_REFCURSOR
    );

    PROCEDURE Consultar_CastingsActor(
        Nombre_Persona IN VARCHAR2, 
        Resultado OUT SYS_REFCURSOR
    );

    PROCEDURE Consultar_DirigidosDirector(
        Nombre_Persona IN VARCHAR2, 
        Resultado OUT SYS_REFCURSOR
    );

    PROCEDURE Consultar_Reconocimientos(
        Nombre_Persona IN VARCHAR2, 
        Resultado OUT SYS_REFCURSOR
    );

    PROCEDURE Consultar_ContenidoActor(
        Nombre_Persona IN VARCHAR2, 
        Resultado OUT SYS_REFCURSOR
    );

    PROCEDURE Consultar_ActorTendencia(
        Nombre_Persona IN VARCHAR2, 
        Resultado OUT SYS_REFCURSOR
    );
    

END PK_U_ESTANDAR;


CREATE OR REPLACE PACKAGE BODY PK_U_ESTANDAR AS

    PROCEDURE Crear_Usuario(
        Nombre_Usuario IN VARCHAR2,
        Contacto1 IN VARCHAR2,
        Contacto2 IN VARCHAR2,
        Razon_Social IN XMLTYPE,
        Contrasena IN VARCHAR2,
        Cedula IN VARCHAR2,
        Telefono IN VARCHAR2,
        Edad IN INTEGER,
        Correo IN VARCHAR2,
        Nit IN VARCHAR2,
        Nombre_Representante IN VARCHAR2,
        Telefono_Representante IN VARCHAR2
    ) IS
        N_usuario NUMBER;
    BEGIN
        IF Cedula IS NOT NULL THEN
            -- Usuario estándar
            SELECT SEQ_N_USUARIO.NEXTVAL INTO N_usuario FROM dual;
            INSERT INTO Usuarios (N_usuario, NombreUsuario, Contacto1, Contacto2, Contraseña)
            VALUES (N_usuario, Nombre_Usuario, Contacto1, Contacto2, Contrasena);
            
            INSERT INTO UsuariosEstandar (N_usuarioU, Cedula, Telefono, Edad)
            VALUES (N_usuario, Cedula, Telefono, Edad);
            
            INSERT INTO Correos (Correo,N_UsuarioE,Cedula_UsuarioE)
            VALUES (Correo,N_Usuario,Cedula);
            
        ELSIF Razon_Social IS NOT NULL THEN
            -- Empresa
            SELECT SEQ_N_USUARIO.NEXTVAL INTO N_usuario FROM dual;
            INSERT INTO Usuarios (N_usuario, NombreUsuario, Contacto1, Contacto2, Contraseña)
            VALUES (N_usuario, Nombre_Usuario, Contacto1, Contacto2, Contrasena);
            
            INSERT INTO Empresas (N_usuario, NIT, RazonSocial, Nombre_representante, Telefono, Telefono_representante)
            VALUES (N_usuario, Nit, Razon_Social, Nombre_Representante, Telefono, Telefono_Representante);
        END IF;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END Crear_Usuario;

    -- Procedimiento para crear una valoración
    PROCEDURE Crear_Valoracion(
        NombreUsuario IN VARCHAR2,
        NombreContenido IN VARCHAR2,
        Codigo IN VARCHAR2,
        Descripcion IN VARCHAR2,
        Valoracion IN INTEGER,
        Fecha_Valoracion IN DATE
    ) IS
        N_Usuario NUMBER;
        CedulaU VARCHAR2(20);
    BEGIN
        SELECT N_usuarioU, Cedula INTO N_Usuario, CedulaU
        FROM UsuariosEstandar
        WHERE NombreUsuario = NombreUsuario;

        INSERT INTO Valoraciones (N_usuarioE, Cedula_usuarioE, Codigo_contenido, Codigo, Descripcion, Valoracion, Fecha_Valoracion)
        VALUES (N_Usuario, CedulaU, NombreContenido, Codigo, Descripcion, Valoracion, Fecha_Valoracion);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END Crear_Valoracion;

   PROCEDURE Crear_Alerta(
        NombreUsuario IN VARCHAR2,
        Descripcion IN VARCHAR2,
        Fecha_Alerta IN DATE
    ) IS
        N_Usuario NUMBER; -- Variable para almacenar el N_usuario
        N_Alerta NUMBER;  -- Variable para almacenar el N_alerta generado
        CANTIDAD_REGISTROS NUMBER; -- Variable para contar registros coincidentes
    BEGIN
        -- Verifica si el NombreUsuario existe y cuántos registros coinciden
        SELECT COUNT(*) INTO CANTIDAD_REGISTROS
        FROM Usuarios U
        WHERE U.NombreUsuario = NombreUsuario;
    
        -- Manejo de casos específicos
        IF CANTIDAD_REGISTROS = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'No existe un usuario con ese NombreUsuario.');
        END IF;
    
        -- Recupera el N_usuario del usuario solicitado
        SELECT U.N_usuario INTO N_Usuario
        FROM Usuarios U
        WHERE U.NombreUsuario = NombreUsuario AND ROWNUM = 1;
    
        -- Genera el número único para la alerta
        SELECT SEQ_N_ALERTA.NEXTVAL INTO N_Alerta FROM dual;
    
        -- Inserta la alerta
        INSERT INTO Alertas (N_alerta, N_usuarioU, Descripcion, fechaAlerta)
        VALUES (N_Alerta, N_Usuario, Descripcion, Fecha_Alerta);
    
        -- Confirmar la transacción
        COMMIT;
    
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Error: El usuario no existe.');
            RAISE_APPLICATION_ERROR(-20001, 'Usuario no encontrado.');
    
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error inesperado: ' || SQLERRM);
            ROLLBACK;
            RAISE;
    END Crear_Alerta;



    -- Procedimiento para modificar un usuario
   PROCEDURE Modificar_Usuario(
        Nombre_Usuario IN VARCHAR2,
        Contacto1 IN VARCHAR2,
        Contacto2 IN VARCHAR2,
        Razon_Social IN XMLTYPE,
        Contrasena IN VARCHAR2,
        Cedula IN VARCHAR2,
        Telefono IN VARCHAR2,
        Edad IN INTEGER,
        Correo IN VARCHAR2,
        Nit IN VARCHAR2,
        Nombre_Representante IN VARCHAR2,
        Telefono_Representante IN VARCHAR2
    ) IS
    BEGIN
        -- Actualiza en la tabla Usuarios
        DBMS_OUTPUT.PUT_LINE('Intentando actualizar Usuarios...');
        UPDATE Usuarios
        SET 
            Contacto1 = NVL(Modificar_Usuario.Contacto1, Usuarios.Contacto1),
            Contacto2 = NVL(Modificar_Usuario.Contacto2, Usuarios.Contacto2),
            Contraseña = NVL(Modificar_Usuario.Contrasena, Usuarios.Contraseña)
        WHERE Usuarios.NombreUsuario = Modificar_Usuario.Nombre_Usuario;
    
        IF SQL%ROWCOUNT = 0 THEN
            DBMS_OUTPUT.PUT_LINE('No se encontró el usuario en la tabla Usuarios.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Tabla Usuarios actualizada.');
        END IF;
    
        -- Actualiza en la tabla UsuariosEstandar si Cedula no es NULL
        IF Cedula IS NOT NULL THEN
            DBMS_OUTPUT.PUT_LINE('Intentando actualizar UsuariosEstandar...');
            UPDATE UsuariosEstandar
            SET 
                Telefono = NVL(Modificar_Usuario.Telefono, UsuariosEstandar.Telefono),
                Edad = NVL(Modificar_Usuario.Edad, UsuariosEstandar.Edad)
            WHERE UsuariosEstandar.Cedula = Modificar_Usuario.Cedula;
    
            IF SQL%ROWCOUNT = 0 THEN
                DBMS_OUTPUT.PUT_LINE('No se encontró el usuario en la tabla UsuariosEstandar.');
            ELSE
                DBMS_OUTPUT.PUT_LINE('Tabla UsuariosEstandar actualizada.');
            END IF;
        END IF;
    
        -- Actualiza en la tabla Empresas si Nit no es NULL
        IF Nit IS NOT NULL THEN
            DBMS_OUTPUT.PUT_LINE('Intentando actualizar Empresas...');
            UPDATE Empresas
            SET 
                RazonSocial = NVL(Modificar_Usuario.Razon_Social, Empresas.RazonSocial),
                Telefono = NVL(Modificar_Usuario.Telefono, Empresas.Telefono),
                Telefono_representante = NVL(Modificar_Usuario.Telefono_Representante, Empresas.Telefono_representante),
                Nombre_representante = NVL(Modificar_Usuario.Nombre_Representante, Empresas.Nombre_representante)
            WHERE Empresas.NIT = Modificar_Usuario.Nit;
    
            IF SQL%ROWCOUNT = 0 THEN
                DBMS_OUTPUT.PUT_LINE('No se encontró la empresa en la tabla Empresas.');
            ELSE
                DBMS_OUTPUT.PUT_LINE('Tabla Empresas actualizada.');
            END IF;
        END IF;
    
        -- Actualiza en la tabla Correos si Correo no es NULL
        -- Actualiza en la tabla Correos si Correo no es NULL
    IF Correo IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('Intentando actualizar Correos...');
        DBMS_OUTPUT.PUT_LINE('Correo proporcionado: ' || Correo || ', Cédula proporcionada: ' || Cedula);
    
        -- Actualiza el correo en la tabla Correos
        UPDATE Correos
        SET Correo = Modificar_Usuario.Correo
        WHERE TRIM(Cedula_usuarioE) = TRIM(Cedula);
    
        -- Verifica si se actualizaron filas
        IF SQL%ROWCOUNT = 0 THEN
            DBMS_OUTPUT.PUT_LINE('No se encontró un correo asociado en la tabla Correos para la cédula proporcionada.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Tabla Correos actualizada correctamente.');
        END IF;
    END IF;
    
        -- Confirmar la transacción
    COMMIT;
    
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('Error inesperado: ' || SQLERRM);
            RAISE;
    END Modificar_Usuario;




    -- Procedimiento para modificar una valoración
    PROCEDURE Modificar_Valoracion(
        NombreUsuario IN VARCHAR2,
        NombreContenido IN VARCHAR2,
        Codigo IN VARCHAR2,
        Descripcion IN VARCHAR2,
        Valoracion IN INTEGER,
        Fecha_Valoracion IN DATE
    ) IS
        N_Usuario NUMBER;
        CedulaU VARCHAR2(20);
    BEGIN
        SELECT N_usuarioU, Cedula INTO N_Usuario, CedulaU
        FROM UsuariosEstandar
        WHERE NombreUsuario = NombreUsuario;

        UPDATE Valoraciones
        SET 
            Descripcion = NVL(Descripcion, Descripcion),
            Valoracion = NVL(Valoracion, Valoracion),
            Fecha_Valoracion = NVL(Fecha_Valoracion, Fecha_Valoracion)
        WHERE N_usuarioE = N_Usuario 
            AND Cedula_usuarioE = CedulaU
            AND Codigo_contenido = NombreContenido
            AND Codigo = Codigo;
        
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END Modificar_Valoracion;

    -- Procedimiento para modificar una actualización
    PROCEDURE Modificar_Actualizacion(
        NombreUsuario IN INTEGER,
        Descripcion IN VARCHAR2,
        Estado IN VARCHAR2
    ) IS
        N_Usuario NUMBER;
        CedulaU VARCHAR2(20);
        N_Recompensa NUMBER;
    BEGIN
        SELECT N_usuarioU, Cedula INTO N_Usuario, CedulaU
        FROM UsuariosEstandar
        WHERE N_usuarioU = NombreUsuario;

        IF Estado = 'Aprobado' THEN
            SELECT SEQ_RECOMPENSAS.NEXTVAL INTO N_Recompensa FROM dual;

            INSERT INTO SistemasRecompensa (N_recompensa, Descripcion, Tipo)
            VALUES (N_Recompensa, Descripcion, 'Recompensa Aprobada');

            UPDATE Actualizaciones
            SET N_recompensas = N_Recompensa
            WHERE N_usuarioE = N_Usuario
            AND Cedula_usuarioE = CedulaU;
        END IF;

        UPDATE Actualizaciones
        SET 
            Descripcion = NVL(Descripcion, Descripcion),
            Estado = NVL(Estado, Estado)
        WHERE N_usuarioE = N_Usuario
        AND Cedula_usuarioE = CedulaU;

        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END Modificar_Actualizacion;

    -- Procedimiento para eliminar una valoración
    PROCEDURE Eliminar_Valoracion(
        NombreUsuario IN VARCHAR2,
        NombreContenido IN VARCHAR2
    ) IS
        N_Usuario NUMBER;
        CedulaU VARCHAR2(20);
        CodigoContenido VARCHAR2(10);
    BEGIN
        SELECT N_usuarioU, Cedula INTO N_Usuario, CedulaU
        FROM UsuariosEstandar
        WHERE NombreUsuario = NombreUsuario;

        SELECT Codigo INTO CodigoContenido
        FROM Contenidos
        WHERE Nombre = NombreContenido;

        DELETE FROM Valoraciones
        WHERE N_usuarioE = N_Usuario
        AND Cedula_usuarioE = CedulaU
        AND Codigo_contenido = CodigoContenido;

        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END Eliminar_Valoracion;
    
    PROCEDURE ConsultarActualizaciones(
        NombreUsuario IN VARCHAR2,
        Resultado OUT SYS_REFCURSOR
    ) IS
        N_Usuario NUMBER;
    BEGIN
        SELECT N_usuarioU INTO N_Usuario
        FROM UsuariosEstandar
        WHERE NombreUsuario = NombreUsuario;

        OPEN Resultado FOR
        SELECT A.Descripcion, A.Estado
        FROM Actualizaciones A
        WHERE A.N_usuarioE = N_Usuario;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END ConsultarActualizaciones;

    -- Procedimiento para consultar recompensas
    PROCEDURE ConsultarRecompensas(
        NombreUsuario IN VARCHAR2,
        Resultado OUT SYS_REFCURSOR
    ) IS
        N_Usuario NUMBER;
    BEGIN
        SELECT N_usuarioU INTO N_Usuario
        FROM UsuariosEstandar
        WHERE NombreUsuario = NombreUsuario;

        OPEN Resultado FOR
        SELECT R.Descripcion, R.Tipo
        FROM SistemasRecompensa R
        JOIN Actualizaciones A ON A.N_recompensas = R.N_recompensa
        WHERE A.N_usuarioE = N_Usuario;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END ConsultarRecompensas;
    
        PROCEDURE Añadir_Pelicula(
        Nombre IN VARCHAR2, 
        Tipo IN CHAR DEFAULT 'P', 
        Rating IN CHAR, 
        Reseña IN VARCHAR2, 
        Duracion IN VARCHAR2, 
        Ano IN DATE, 
        Genero IN VARCHAR2, 
        Visualizacion IN INTEGER, 
        Nombre_Saga IN VARCHAR2, 
        Nom_Plataforma IN VARCHAR2, 
        Precio IN NUMBER
    ) IS
        N_pelicula NUMBER;
        C_Contenido NUMBER;
        Num_Plataforma NUMBER;  -- Definir la variable para el código de contenido
        Saga_Existe BOOLEAN := FALSE;  -- Variable para verificar si la saga existe
    BEGIN

        -- Obtener el siguiente valor de la secuencia para N_pelicula
        SELECT SEQ_N_PELICULA.NEXTVAL INTO N_pelicula FROM dual;
    
        -- Obtener el siguiente valor de la secuencia para Codigo_contenido
        SELECT SEQ_CONTENIDOS.NEXTVAL INTO C_Contenido FROM dual;
        
        -- Insertar la película en la tabla Contenidos
        INSERT INTO Contenidos (Codigo, Tipo, Nombre, Rating, Reseña)
        VALUES (C_Contenido,'P', Nombre, Rating, Reseña);
        
        -- Insertar la película en la tabla Peliculas
        INSERT INTO Peliculas (Codigo_contenido, N_pelicula, Duracion, Ano, Genero, Visualizacion)
        VALUES ('P'||C_Contenido, N_pelicula, Duracion, Ano, Genero, Visualizacion);
        COMMIT;
        
        -- Si la película tiene saga, actualizar la tabla Sagas
        IF Nombre_Saga IS NOT NULL THEN
            -- Verificar si la saga ya existe
            SELECT COUNT(*) INTO N_pelicula
            FROM Sagas U
            WHERE U.Nombre_saga = Nombre_Saga;

            IF N_pelicula > 0 THEN
                -- Si existe, actualizar el número de películas de la saga
                UPDATE Sagas
                SET N_peliculas = N_peliculas + 1
                WHERE Nombre_saga = Nombre_Saga;
            ELSE
                -- Si no existe, insertar la nueva saga
                INSERT INTO Sagas (Codigo_pelicula, Nombre_saga, N_peliculas)
                VALUES ('P'||C_Contenido, Nombre_Saga, 1);  -- Inicialmente, con 1 película
            END IF;
        END IF;
    
        -- Verificar si la plataforma existe, si no, insertarla
        BEGIN
            SELECT Numero_plataforma INTO Num_Plataforma
            FROM Plataformas
            WHERE Nombre = Nom_Plataforma;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                -- Si no existe, insertar la nueva plataforma
                INSERT INTO Plataformas(Numero_plataforma, Nombre, Precio)
                VALUES (SEQ_NUMERO_PLATAFORMA.NEXTVAL, Nom_Plataforma, Precio);
                
                -- Obtener el número de plataforma recién creado
                SELECT SEQ_NUMERO_PLATAFORMA.CURRVAL INTO Num_Plataforma FROM dual;
        END;
    
        -- Insertar en la tabla ContenidosXPlataformas
        INSERT INTO ContenidosXPlataformas (Codigo_contenido, Numero_plataforma)
        VALUES ('P'||C_Contenido, Num_Plataforma);

        COMMIT;  -- Confirmar la inserción de los datos
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- Revertir cualquier cambio en caso de error
            RAISE;  -- Re-lanzar la excepción para su manejo
    END Añadir_Pelicula;

    -- Procedimiento para añadir una serie
    PROCEDURE Añadir_Serie(
        Nombre IN VARCHAR2, 
        Tipo IN CHAR DEFAULT 'S', 
        Rating IN CHAR, 
        Reseña IN VARCHAR2, 
        Año_Inicio IN DATE, 
        Año_Final IN DATE, 
        Genero IN VARCHAR2, 
        Estado IN CHAR, 
        Visualizacion IN INTEGER, 
        N_Capitulos IN INTEGER, 
        Nombre_Cap IN VARCHAR2, 
        N_Temporada IN INTEGER, 
        Descripcion IN VARCHAR2, 
        Nom_Plataforma IN VARCHAR2, 
        Precio IN NUMBER
    ) IS
        N_serie NUMBER;
        C_Contenido VARCHAR2(10);
        Num_plataforma NUMBER;
    BEGIN
    

        -- Obtener el siguiente valor de la secuencia para N_serie
        SELECT SEQ_CODIGO_SERIE.NEXTVAL INTO N_serie FROM dual;
        
        -- Obtener el siguiente valor de la secuencia para Código de contenido
        SELECT SEQ_CONTENIDOS.NEXTVAL INTO C_Contenido FROM dual;
    
        -- Insertar en la tabla Contenidos (para la serie)
        INSERT INTO Contenidos (Codigo, Tipo, Nombre, Rating, Reseña)
        VALUES (C_Contenido, 'S', Nombre, Rating, Reseña);
    
        -- Insertar en la tabla Series
        INSERT INTO Series (Codigo_contenido, N_serie, Ano_inicio, Ano_final, Genero, Estado, Visualizacion)
        VALUES ('S'||C_Contenido, N_serie, Año_Inicio, Año_Final, Genero, Estado, Visualizacion);
    
        -- Insertar los capítulos relacionados (de acuerdo al número de capítulos)
        INSERT INTO Capitulos (Codigo_serie, N_capitulo, Nombre)
        VALUES ('S'||C_Contenido, N_Capitulos, Nombre_Cap);

        -- Insertar las temporadas
        INSERT INTO Temporadas (Codigo_serie, N_temporada, Descripcion)
        VALUES ('S'||C_Contenido, N_temporada, Descripcion);

        -- Obtener el número de la plataforma
        BEGIN
            SELECT Numero_plataforma INTO Num_Plataforma
            FROM Plataformas
            WHERE Nombre = Nom_Plataforma;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                -- Si no existe, insertar la nueva plataforma
                INSERT INTO Plataformas(Numero_plataforma, Nombre, Precio)
                VALUES (SEQ_NUMERO_PLATAFORMA.NEXTVAL, Nom_Plataforma, Precio);
                
                -- Obtener el número de plataforma recién creado
                SELECT SEQ_NUMERO_PLATAFORMA.CURRVAL INTO Num_Plataforma FROM dual;
        END;

        -- Insertar en la tabla ContenidosXPlataformas
        INSERT INTO ContenidosXPlataformas (Codigo_contenido, Numero_plataforma)
        VALUES ('S'||C_Contenido, Num_plataforma);
    
        COMMIT;  -- Confirmar la inserción de los datos
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- En caso de error, revertir los cambios
            RAISE;  -- Re-lanzar la excepción para su manejo
    END Añadir_Serie;



    -- Procedimiento para añadir una plataforma
    PROCEDURE Añadir_Plataforma(
            Nom_Plataforma IN VARCHAR2,  -- Nombre de la plataforma
            Precio IN NUMBER             -- Precio de la plataforma
        ) IS
            Numero_plataforma NUMBER;    -- Número de la plataforma generado
            Plataforma_Existe NUMBER;   -- Variable para verificar si la plataforma ya existe
        BEGIN
            -- Verificar si la plataforma ya existe
            SELECT COUNT(*) INTO Plataforma_Existe
            FROM Plataformas
            WHERE Nombre = Nom_Plataforma;
    
            -- Si la plataforma no existe, proceder a insertarla
            IF Plataforma_Existe = 0 THEN
                -- Obtener el siguiente valor de la secuencia para Numero_plataforma
                SELECT SEQ_NUMERO_PLATAFORMA.NEXTVAL INTO Numero_plataforma FROM dual;
            
                -- Insertar en la tabla Plataformas
                INSERT INTO Plataformas (Numero_plataforma, Nombre, Precio)
                VALUES (Numero_plataforma, Nom_Plataforma, Precio);
            
                COMMIT;  -- Confirmar la inserción de los datos
            END IF;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;  -- En caso de error, revertir los cambios
                RAISE;  -- Re-lanzar la excepción para su manejo
        END Añadir_Plataforma;


    -- Procedimiento para modificar una película
    PROCEDURE Modificar_Pelicula(
        Nombre IN VARCHAR2,                  -- Nombre de la película a modificar
        Tipo IN CHAR,                         -- Tipo de contenido (por ejemplo, 'P' para película)
        Rating IN CHAR,                       -- Calificación de la película
        Reseña IN VARCHAR2,                   -- Reseña de la película
        Duracion IN VARCHAR2,                 -- Duración de la película
        Ano IN DATE,                          -- Año de la película
        Genero IN VARCHAR2,                   -- Género de la película
        Visualizacion IN INTEGER,             -- Número de visualizaciones
        Nombre_Saga IN VARCHAR2,              -- Nombre de la saga (si aplica)
        Nom_Plataforma IN VARCHAR2,           -- Nombre de la plataforma
        Precio IN NUMBER                      -- Precio de la plataforma
    ) IS
        Codigo_contenido VARCHAR2(10);        -- Código de contenido de la película
        Numero_plataforma NUMBER;             -- Número de la plataforma
    BEGIN
        -- Obtener el código de contenido de la película
        SELECT Codigo 
        INTO Codigo_contenido 
        FROM Contenidos U
        WHERE U.Nombre = Nombre
        AND U.Tipo = Tipo -- Asegúrate de que esta condición sea única
        AND ROWNUM = 1;  -- Obtiene solo el primer registro si hay más de uno

        -- Actualizar los datos en la tabla Contenidos solo si el valor no es NULL
        IF Rating IS NOT NULL THEN
            UPDATE Contenidos U
            SET U.Rating = Rating
            WHERE Codigo = Codigo_contenido;
        END IF;
    
        IF Reseña IS NOT NULL THEN
            UPDATE Contenidos U
            SET U.Reseña = Reseña
            WHERE Codigo = Codigo_contenido;
        END IF;

        -- Actualizar los datos de la película en la tabla Peliculas solo si el valor no es NULL
        IF Duracion IS NOT NULL THEN
            UPDATE Peliculas U
            SET U.Duracion = Duracion
            WHERE U.Codigo_contenido = Codigo_contenido;
        END IF;
    
        IF Ano  IS NOT NULL THEN
            UPDATE Peliculas U
            SET U.Ano = Ano
            WHERE U.Codigo_contenido = Codigo_contenido;
        END IF;
    
        IF Visualizacion IS NOT NULL THEN
            UPDATE Peliculas U
            SET U.Visualizacion = Visualizacion
            WHERE U.Codigo_contenido = Codigo_contenido;
        END IF;
    
        -- Si hay saga, actualizar la tabla Sagas solo si el valor no es NULL
        IF Nombre_Saga IS NOT NULL THEN
            -- Actualizar o insertar saga si no existe
            UPDATE Sagas U
            SET U.Nombre_saga = Nombre_Saga
            WHERE Codigo_pelicula = Codigo_contenido;
        END IF;
    
        -- Obtener el número de la plataforma
        SELECT Numero_plataforma 
        INTO Numero_plataforma 
        FROM Plataformas 
        WHERE Nombre = Nom_Plataforma
        AND ROWNUM = 1; -- Obtiene el primer registro si hay más de uno
    
        -- Validar si existe la plataforma asociada al contenido
        DECLARE
            plataforma_existe INTEGER;
        BEGIN
            SELECT COUNT(*)
            INTO plataforma_existe
            FROM ContenidosXPlataformas
            WHERE Codigo_contenido = Codigo_contenido
              AND Numero_plataforma = Numero_plataforma;
    
            IF plataforma_existe = 0 THEN
                RAISE_APPLICATION_ERROR(-20001, 'La plataforma no existe para este contenido.');
            ELSE
                -- Actualizar el precio en la tabla Plataformas solo si el valor no es NULL
                IF Precio IS NOT NULL THEN
                    UPDATE Plataformas U
                    SET U.Precio = Precio
                    WHERE Numero_plataforma = Numero_plataforma;
                END IF;
            END IF;
        END;
    
        COMMIT;  -- Confirmar los cambios
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- Revertir cualquier cambio si ocurre un error
            RAISE;      -- Re-lanzar la excepción para su manejo
    END Modificar_Pelicula;


    -- Procedimiento para modificar una serie
    PROCEDURE Modificar_Serie(
        Nombre IN VARCHAR2,                    -- Nombre de la serie a modificar
        Tipo IN CHAR,                           -- Tipo de contenido (por ejemplo, 'S' para serie)
        Rating IN CHAR,                         -- Calificación de la serie
        Reseña IN VARCHAR2,                     -- Reseña de la serie
        Año_Inicio IN DATE,                     -- Año de inicio de la serie
        Año_Final IN DATE,                      -- Año final de la serie (puede ser nulo)
        Genero IN VARCHAR2,                     -- Género de la serie
        Estado IN CHAR,                         -- Estado de la serie (activo, inactivo, etc.)
        Visualizacion IN INTEGER,               -- Número de visualizaciones
        N_Capitulos IN INTEGER,                 -- Número de capítulos
        Nombre_Cap IN VARCHAR2,                 -- Nombre de los capítulos
        N_Temporada IN INTEGER,                 -- Número de temporada
        Descripcion IN VARCHAR2,                -- Descripción de la temporada
        Nom_Plataforma IN VARCHAR2,             -- Nombre de la plataforma
        Precio IN NUMBER                        -- Precio de la plataforma
    ) IS
        Codigo_contenido VARCHAR2(10);          -- Código del contenido de la serie
        Numero_plataforma NUMBER;               -- Número de la plataforma
    BEGIN
        -- Obtener el código de contenido de la serie
        SELECT Codigo INTO Codigo_contenido 
        FROM Contenidos U
        WHERE U.Nombre = Nombre
        AND U.Tipo = 'S';  -- Tipo 'S' para serie
    
        -- Actualizar los datos en la tabla Contenidos
        IF Rating IS NOT NULL THEN
            UPDATE Contenidos
            SET Rating = Rating
            WHERE Codigo = Codigo_contenido;
        END IF;

        IF Reseña IS NOT NULL THEN
            UPDATE Contenidos
            SET Reseña = Reseña
            WHERE Codigo = Codigo_contenido;
        END IF;

        -- Actualizar los datos de la serie en la tabla Series
        IF Año_Inicio IS NOT NULL THEN
            UPDATE Series
            SET Ano_inicio = Año_Inicio
            WHERE Codigo_contenido = Codigo_contenido;
        END IF;

        IF Año_Final IS NOT NULL THEN
            UPDATE Series
            SET Ano_final = Año_Final
            WHERE Codigo_contenido = Codigo_contenido;
        END IF;

        IF Estado IS NOT NULL THEN
            UPDATE Series
            SET Estado = Estado
            WHERE Codigo_contenido = Codigo_contenido;
        END IF;

        IF Visualizacion IS NOT NULL THEN
            UPDATE Series
            SET Visualizacion = Visualizacion
            WHERE Codigo_contenido = Codigo_contenido;
        END IF;

        -- Actualizar capítulos si el número de capítulos es proporcionado
        IF N_Capitulos > 0 THEN
            FOR i IN 1..N_Capitulos LOOP
                UPDATE Capitulos
                SET Nombre = Nombre_Cap || ' ' || i
                WHERE Codigo_serie = Codigo_contenido AND N_capitulo = i;
            END LOOP;
        END IF;

        -- Actualizar las temporadas si la temporada es proporcionada
        IF N_Temporada > 0 THEN
            FOR j IN 1..N_Temporada LOOP
                UPDATE Temporadas
                SET Descripcion = Descripcion
                WHERE Codigo_serie = Codigo_contenido AND N_temporada = j;
            END LOOP;
        END IF;

        -- Obtener el número de la plataforma
        SELECT Numero_plataforma INTO Numero_plataforma
        FROM Plataformas
        WHERE Nombre = Nom_Plataforma;
    
        -- Validar si existe la plataforma asociada al contenido
        DECLARE
            plataforma_existe INTEGER;
        BEGIN
            SELECT COUNT(*)
            INTO plataforma_existe
            FROM ContenidosXPlataformas
            WHERE Codigo_contenido = Codigo_contenido
              AND Numero_plataforma = Numero_plataforma;
    
            IF plataforma_existe = 0 THEN
                RAISE_APPLICATION_ERROR(-20001, 'La plataforma no existe para este contenido.');
            ELSE
                -- Actualizar el precio en la tabla Plataformas solo si el valor no es NULL
                IF Precio IS NOT NULL THEN
                    UPDATE Plataformas
                    SET Precio = Precio
                    WHERE Numero_plataforma = Numero_plataforma;
                END IF;
            END IF;
        END;
    
        COMMIT;  -- Confirmar los cambios
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- Revertir cualquier cambio si ocurre un error
            RAISE;      -- Re-lanzar la excepción para su manejo
    END Modificar_Serie;


    -- Procedimiento para modificar una plataforma
    PROCEDURE Modificar_Plataforma(
        Nom_Plataforma IN VARCHAR2,  -- Nombre de la plataforma a modificar
        Precio IN NUMBER             -- Nuevo precio de la plataforma
    ) IS
        Numero_plataforma NUMBER;    -- Número de la plataforma a actualizar
    BEGIN
        -- Obtener el número de la plataforma basado en el nombre proporcionado
        SELECT Numero_plataforma INTO Numero_plataforma
        FROM Plataformas
        WHERE Nombre = Nom_Plataforma;
    
        -- Actualizar el precio en la tabla Plataformas
        UPDATE Plataformas
        SET Precio = NVL(Precio, Precio)
        WHERE Numero_plataforma = Numero_plataforma;
    
        -- Actualizar los contenidos asociados a esta plataforma
        -- (Si el precio de la plataforma cambia, se actualiza la relación en ContenidosXPlataformas)
        UPDATE ContenidosXPlataformas
        SET Numero_plataforma = Numero_plataforma
        WHERE Numero_plataforma = Numero_plataforma;
    
        COMMIT;  -- Confirmar los cambios
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- En caso de error, revertir los cambios
            RAISE;      -- Re-lanzar la excepción para su manejo
    END Modificar_Plataforma;
    
    -- Procedimiento para eliminar una plataforma
    PROCEDURE Eliminar_Plataforma(
        Nom_Plataforma IN VARCHAR2  -- Nombre de la plataforma a eliminar
    ) IS
        Numero_plataforma NUMBER;   -- Número de la plataforma a eliminar
    BEGIN
        -- Intentar obtener el número de la plataforma
        BEGIN
            SELECT Numero_plataforma
            INTO Numero_plataforma
            FROM Plataformas
            WHERE Nombre = Nom_Plataforma;
    
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                -- Manejo del error si no se encuentra la plataforma
                RAISE_APPLICATION_ERROR(-20001, 'La plataforma no existe: ' || Nom_Plataforma);
            WHEN OTHERS THEN
                -- Manejo de cualquier otro error
                RAISE_APPLICATION_ERROR(-20002, 'Error al obtener la plataforma: ' || SQLERRM);
        END;
    
        -- Eliminar las relaciones de la plataforma con los contenidos
        DELETE FROM ContenidosXPlataformas
        WHERE Numero_plataforma = Numero_plataforma;
    
        -- Eliminar la plataforma de la tabla Plataformas
        DELETE FROM Plataformas
        WHERE Numero_plataforma = Numero_plataforma;
    
        -- Confirmar los cambios
        COMMIT;
    
    EXCEPTION
        WHEN OTHERS THEN
            -- Revertir cambios en caso de error
            ROLLBACK;
            RAISE; -- Re-lanzar la excepción para su manejo
    END Eliminar_Plataforma;


    
    -- Procedimiento para consultar las películas por saga
    PROCEDURE Consultar_PeliculaSaga(
        Nombre_Saga IN VARCHAR2,  -- Nombre de la saga a consultar
        Resultado OUT SYS_REFCURSOR  -- Cursor de salida con los resultados
    ) IS
    BEGIN
        -- Abrir el cursor para consultar todas las películas relacionadas con la saga
        OPEN Resultado FOR
        SELECT P.Codigo_contenido, P.N_pelicula, P.Duracion, P.Ano, P.Genero, P.Visualizacion
        FROM Peliculas P
        JOIN Sagas S ON P.Codigo_contenido = S.Codigo_pelicula
        WHERE S.Nombre_saga = Nombre_Saga;
    
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- En caso de error, revertir cualquier cambio
            RAISE;      -- Re-lanzar la excepción para su manejo
    END Consultar_PeliculaSaga;
    
    -- Procedimiento para consultar las películas en una plataforma
    PROCEDURE Consultar_PeliculasEnPlataforma(
        Nombre_Plataforma IN VARCHAR2,   -- Nombre de la plataforma a consultar
        Resultado OUT SYS_REFCURSOR      -- Cursor de salida con los resultados
    ) IS
    BEGIN
        -- Abrir el cursor para consultar las películas en la plataforma correspondiente
        OPEN Resultado FOR
        SELECT P.Codigo_contenido, P.N_pelicula, P.Duracion, P.Ano, P.Genero, P.Visualizacion
        FROM Peliculas P
        JOIN Contenidos C ON P.Codigo_contenido = C.Codigo
        JOIN ContenidosXPlataformas CP ON P.Codigo_contenido = CP.Codigo_contenido
        JOIN Plataformas PL ON CP.Numero_plataforma = PL.Numero_plataforma
        WHERE PL.Nombre = Nombre_Plataforma;  -- Filtrando por el nombre de la plataforma
    
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- En caso de error, revertir cualquier cambio
            RAISE;      -- Re-lanzar la excepción para su manejo
    END Consultar_PeliculasEnPlataforma;
    
    -- Procedimiento para consultar las series en una plataforma
    PROCEDURE Consultar_Serie_Plataforma(
        Nombre_Plataforma IN VARCHAR2,   -- Nombre de la plataforma a consultar
        Resultado OUT SYS_REFCURSOR      -- Cursor de salida con los resultados
    ) IS
    BEGIN
        -- Abrir el cursor para consultar las series en la plataforma correspondiente
        OPEN Resultado FOR
        SELECT S.Codigo_contenido, S.N_Serie, S.Ano_inicio, S.Ano_final, S.Genero, S.Estado, S.Visualizacion
        FROM Series S
        JOIN Contenidos C ON S.Codigo_contenido = C.Codigo
        JOIN ContenidosXPlataformas CP ON S.Codigo_contenido = CP.Codigo_contenido
        JOIN Plataformas PL ON CP.Numero_plataforma = PL.Numero_plataforma
        WHERE PL.Nombre = Nombre_Plataforma;  -- Filtrando por el nombre de la plataforma
    
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- En caso de error, revertir cualquier cambio
            RAISE;      -- Re-lanzar la excepción para su manejo
    END Consultar_Serie_Plataforma;
    
    -- Procedimiento para consultar la plataforma más vista
    PROCEDURE Consultar_PlataformaMasVista(
        Resultado OUT SYS_REFCURSOR   -- Cursor de salida con el resultado
    ) IS
    BEGIN
        -- Abrir el cursor para obtener la plataforma más vista según las visualizaciones
        OPEN Resultado FOR
        SELECT PL.Nombre AS Plataforma,
               SUM(S.Visualizacion) AS Total_Visualizaciones
        FROM Plataformas PL
        JOIN ContenidosXPlataformas CP ON PL.Numero_plataforma = CP.Numero_plataforma
        JOIN Contenidos C ON CP.Codigo_contenido = C.Codigo
        LEFT JOIN Series S ON C.Codigo = S.Codigo_contenido  -- Asociamos las series
        LEFT JOIN Peliculas P ON C.Codigo = P.Codigo_contenido  -- Asociamos las películas
        GROUP BY PL.Nombre
        ORDER BY Total_Visualizaciones DESC
        FETCH FIRST 1 ROWS ONLY;  -- Obtener la plataforma con más visualizaciones
    
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- En caso de error, revertir cualquier cambio
            RAISE;      -- Re-lanzar la excepción para su manejo
    END Consultar_PlataformaMasVista;
    
    -- Procedimiento para consultar las vistas de una plataforma
    PROCEDURE Consultar_VistasPlataforma(
        Nom_Plataforma IN VARCHAR2,   -- Nombre de la plataforma que se desea consultar
        Resultado OUT SYS_REFCURSOR   -- Cursor de salida con el resultado
    ) IS
        v_Numero_plataforma NUMBER;   -- Variable para almacenar el número de la plataforma
    BEGIN
        -- Obtener el número de la plataforma basada en su nombre
        SELECT Numero_plataforma 
        INTO v_Numero_plataforma
        FROM Plataformas
        WHERE Nombre = Nom_Plataforma;
    
        -- Abrir el cursor para obtener las visualizaciones totales de la plataforma
        OPEN Resultado FOR
        SELECT PL.Nombre AS Plataforma,
               SUM(NVL(S.Visualizacion, 0) + NVL(P.Visualizacion, 0)) AS Total_Visualizaciones
        FROM ContenidosXPlataformas CP
        JOIN Plataformas PL ON CP.Numero_plataforma = PL.Numero_plataforma
        JOIN Contenidos C ON CP.Codigo_contenido = C.Codigo
        LEFT JOIN Series S ON C.Codigo = S.Codigo_contenido  -- Asociamos las series
        LEFT JOIN Peliculas P ON C.Codigo = P.Codigo_contenido  -- Asociamos las películas
        WHERE PL.Numero_plataforma = v_Numero_plataforma
        GROUP BY PL.Nombre
        ORDER BY Total_Visualizaciones DESC;
    
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- En caso de error, revertir cualquier cambio
            RAISE;      -- Re-lanzar la excepción para su manejo
    END Consultar_VistasPlataforma;
    
    -- Procedimiento para consultar contenidos con reseñas positivas
    PROCEDURE Consultar_ContenidosReseñasPositivas(
        Resultado OUT SYS_REFCURSOR  -- Cursor de salida con el resultado
    ) IS
    BEGIN
        -- Abrir el cursor para obtener los contenidos con valoraciones positivas
        OPEN Resultado FOR
        SELECT C.Nombre AS Contenido,
               V.Descripcion AS Reseña,
               V.Valoracion AS Valoracion
        FROM Valoraciones V
        JOIN Contenidos C ON V.Codigo_contenido = C.Codigo
        WHERE V.Valoracion >= 4  -- Umbral de valoración positiva
        ORDER BY V.Valoracion DESC;  -- Ordenamos de mayor a menor valoración
    
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- En caso de error, revertir cualquier cambio
            RAISE;      -- Re-lanzar la excepción para su manejo
    END Consultar_ContenidosReseñasPositivas;
    
    
        PROCEDURE Crear_Persona(
        Cedula IN VARCHAR2, 
        Nombre IN VARCHAR2, 
        Edad IN INTEGER, 
        Nacionalidad IN VARCHAR2, 
        F_Nacimiento IN DATE, 
        F_Fallecimiento IN DATE, 
        Genero IN VARCHAR2, 
        Genero_pref IN VARCHAR2, 
        Productora_Aliada IN VARCHAR2, 
        Altura IN FLOAT, 
        Formacion IN VARCHAR2
    ) IS
        N_persona NUMBER;
    BEGIN
        -- Insertar en la tabla Personas
        INSERT INTO Personas (Cedula, Nombre, Edad, Nacionalidad, f_nacimiento, f_fallecimiento, Genero)
        VALUES (Cedula, Nombre, Edad, Nacionalidad, F_Nacimiento, F_Fallecimiento, Genero);

        -- Verificar si es director o actor y hacer inserciones correspondientes
        IF Genero_pref IS NOT NULL AND Productora_Aliada IS NOT NULL THEN
            -- Insertar como director
            INSERT INTO Directores (Cedula_persona, Genero_pref, Productora_afiliada)
            VALUES (Cedula, Genero_pref, Productora_Aliada);
        ELSIF Altura IS NOT NULL AND Formacion IS NOT NULL THEN
            -- Insertar como actor
            INSERT INTO Actores (Cedula_persona, Altura, Formacion)
            VALUES (Cedula, Altura, Formacion);
        END IF;
        
        COMMIT;  -- Confirmar la inserción de los datos
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- En caso de error, revertir los cambios
            RAISE;  -- Re-lanzar la excepción para su manejo
    END Crear_Persona;


    -- Procedimiento para crear dirigidos
    PROCEDURE Crear_Dirigidos(
        Nombre_Persona IN VARCHAR2, 
        Nombre_Contenido IN VARCHAR2, 
        Fecha_Inicio IN DATE, 
        Fecha_Final IN DATE
    ) IS
        Cedula_persona VARCHAR2(10);
        Codigo_contenido VARCHAR2(10);
    BEGIN
        -- Obtener Cedula de la persona desde la tabla Personas
        SELECT Cedula INTO Cedula_persona 
        FROM Personas 
        WHERE Nombre = Nombre_Persona;

        -- Obtener Codigo del contenido desde la tabla Contenidos
        SELECT Codigo INTO Codigo_contenido 
        FROM Contenidos 
        WHERE Nombre = Nombre_Contenido;

        -- Insertar en la tabla Dirigidos
        INSERT INTO Dirigidos (Cedula_directores, Codigo_contenido, fecha_inicio, fecha_final)
        VALUES (Cedula_persona, Codigo_contenido, Fecha_Inicio, Fecha_Final);

        COMMIT;  -- Confirmar la inserción de los datos
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- Revertir los cambios en caso de error
            RAISE;  -- Re-lanzar la excepción para su manejo
    END Crear_Dirigidos;


    -- Procedimiento para crear castings
    PROCEDURE Crear_Castings(
        Nombre_Persona IN VARCHAR2, 
        Nombre_Contenido IN VARCHAR2, 
        Nombre_Personaje IN VARCHAR2, 
        Rol IN VARCHAR2, 
        Tiempo_Participacion IN INTEGER, 
        Sueldo IN INTEGER
    ) IS
        Cedula_persona VARCHAR2(10);
        Codigo_contenido VARCHAR2(10);
    BEGIN
        -- Obtener Cedula de la persona desde la tabla Personas
        SELECT Cedula INTO Cedula_persona 
        FROM Personas 
        WHERE Nombre = Nombre_Persona;

        -- Obtener Codigo del contenido desde la tabla Contenidos
        SELECT Codigo INTO Codigo_contenido 
        FROM Contenidos 
        WHERE Nombre = Nombre_Contenido;

        -- Insertar en la tabla Casting
        INSERT INTO Casting (Cedula_actor, Codigo_contenido, Nombre_personaje, Rol, Tiempo_participacion, Sueldo)
        VALUES (Cedula_persona, Codigo_contenido, Nombre_Personaje, Rol, Tiempo_Participacion, Sueldo);

        COMMIT;  -- Confirmar la inserción de los datos
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- Revertir los cambios en caso de error
            RAISE;  -- Re-lanzar la excepción para su manejo
    END Crear_Castings;


    -- Procedimiento para crear reconocimientos
    PROCEDURE Crear_Reconocimientos(
        N_Nominacion IN VARCHAR2, 
        Nombre_Persona IN VARCHAR2, 
        Nominacion IN VARCHAR2, 
        Estado IN VARCHAR2
    ) IS
        Cedula_persona VARCHAR2(10);
        N_Nom NUMBER;
    BEGIN
        -- Obtener Cedula de la persona desde la tabla Personas
        SELECT Cedula INTO Cedula_persona 
        FROM Personas 
        WHERE Nombre = Nombre_Persona;

        -- Obtener el siguiente valor de la secuencia para Nominacion
        SELECT SEQ_N_NOMINACION.NEXTVAL INTO N_Nom FROM dual;

        -- Insertar en la tabla Reconocimientos
        INSERT INTO Reconocimientos (N_nominacion, Nominacion, Estado)
        VALUES (N_Nom, Nominacion, Estado);

        -- Relacionar la nominación con la persona en PersonasXReconocimientos
        INSERT INTO PersonasXReconocimientos (N_nominacion, Cedula_persona)
        VALUES (N_Nom, Cedula_persona);

        COMMIT;  -- Confirmar la inserción de los datos
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- Revertir los cambios en caso de error
            RAISE;  -- Re-lanzar la excepción para su manejo
    END Crear_Reconocimientos;


    -- Procedimiento para modificar persona
    PROCEDURE Modificar_Persona(
        Cedula IN VARCHAR2, 
        Nombre IN VARCHAR2, 
        Edad IN INTEGER, 
        Nacionalidad IN VARCHAR2, 
        F_Nacimiento IN DATE, 
        F_Fallecimiento IN DATE, 
        Genero IN VARCHAR2, 
        Genero_pref IN VARCHAR2, 
        Productora_Aliada IN VARCHAR2, 
        Altura IN FLOAT, 
        Formacion IN VARCHAR2
    ) IS
    BEGIN
        -- Actualizar los datos básicos en la tabla Personas
        UPDATE Personas
        SET 
            Nombre = NVL(Nombre, Nombre),
            Edad = NVL(Edad, Edad),
            Nacionalidad = NVL(Nacionalidad, Nacionalidad),
            f_nacimiento = NVL(F_Nacimiento, f_nacimiento),
            f_fallecimiento = NVL(F_Fallecimiento, f_fallecimiento),
            Genero = NVL(Genero, Genero)
        WHERE Cedula = Cedula;

        -- Verificar si es director o actor y actualizar los datos correspondientes
        IF Genero_pref IS NOT NULL AND Productora_Aliada IS NOT NULL THEN
            -- Actualizar director
            UPDATE Directores
            SET 
                Genero_pref = NVL(Genero_pref, Genero_pref),
                Productora_afiliada = NVL(Productora_Aliada, Productora_Aliada)
            WHERE Cedula_persona = Cedula;
        ELSIF Altura IS NOT NULL AND Formacion IS NOT NULL THEN
            -- Actualizar actor
            UPDATE Actores
            SET 
                Altura = NVL(Altura, Altura),
                Formacion = NVL(Formacion, Formacion)
            WHERE Cedula_persona = Cedula;
        END IF;

        COMMIT;  -- Confirmar los cambios realizados
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- Revertir cualquier cambio si ocurre un error
            RAISE;  -- Re-lanzar la excepción para su manejo
    END Modificar_Persona;


    -- Procedimiento para consultar personas
    PROCEDURE Consultar_Personas(
        Nombre_Persona IN VARCHAR2, 
        Resultado OUT SYS_REFCURSOR
    ) IS
    BEGIN
        -- Abrir el cursor para obtener la información de la persona
        OPEN Resultado FOR
        SELECT Cedula, Nombre, Edad, Nacionalidad, f_nacimiento, f_fallecimiento, Genero
        FROM Personas
        WHERE Nombre = Nombre_Persona;

    COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- En caso de error, revertir cualquier cambio
            RAISE;  -- Re-lanzar la excepción para su manejo
    END Consultar_Personas;


    -- Procedimiento para consultar castings
    PROCEDURE Consultar_CastingsActor(
        Nombre_Persona IN VARCHAR2, 
        Resultado OUT SYS_REFCURSOR
    ) IS
        Cedula_actor VARCHAR2(10);
    BEGIN
        -- Obtener la cédula del actor a partir del nombre de la persona
        SELECT Cedula INTO Cedula_actor 
        FROM Personas 
        WHERE Nombre = Nombre_Persona;

        -- Abrir el cursor para obtener los castings del actor
        OPEN Resultado FOR
        SELECT Ca.Codigo_contenido, Ca.Nombre_personaje, Ca.Rol, Ca.Tiempo_participacion, Ca.Sueldo
        FROM Casting Ca
        WHERE Ca.Cedula_actor = Cedula_actor;

    COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- En caso de error, revertir cualquier cambio
            RAISE;  -- Re-lanzar la excepción para su manejo
    END Consultar_CastingsActor;


    -- Procedimiento para consultar dirigidos por director
    PROCEDURE Consultar_DirigidosDirector(
        Nombre_Persona IN VARCHAR2, 
        Resultado OUT SYS_REFCURSOR
    ) IS
        Cedula_director VARCHAR2(10);
    BEGIN
        -- Obtener la cédula del director a partir del nombre de la persona
        SELECT Cedula INTO Cedula_director 
        FROM Personas 
        WHERE Nombre = Nombre_Persona;

        -- Abrir el cursor para obtener los contenidos dirigidos por este director
        OPEN Resultado FOR
        SELECT D.Codigo_contenido, D.fecha_inicio, D.fecha_final
        FROM Dirigidos D
        WHERE D.Cedula_directores = Cedula_director;

    COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- En caso de error, revertir cualquier cambio
            RAISE;  -- Re-lanzar la excepción para su manejo
    END Consultar_DirigidosDirector;


    -- Procedimiento para consultar reconocimientos
    PROCEDURE Consultar_Reconocimientos(
        Nombre_Persona IN VARCHAR2, 
        Resultado OUT SYS_REFCURSOR
    ) IS
        Cedula_persona VARCHAR2(10);
    BEGIN
        -- Obtener la cédula de la persona a partir del nombre
        SELECT Cedula INTO Cedula_persona 
        FROM Personas 
        WHERE Nombre = Nombre_Persona;

        -- Abrir el cursor para obtener los reconocimientos de la persona
        OPEN Resultado FOR
        SELECT R.N_nominacion, R.Nominacion, R.Estado
        FROM Reconocimientos R
        JOIN PersonasXReconocimientos PR ON R.N_nominacion = PR.N_nominacion
        WHERE PR.Cedula_persona = Cedula_persona;

    COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- En caso de error, revertir cualquier cambio
            RAISE;  -- Re-lanzar la excepción para su manejo
    END Consultar_Reconocimientos;


    -- Procedimiento para consultar contenido de actor
    PROCEDURE Consultar_ContenidoActor(
        Nombre_Persona IN VARCHAR2, 
        Resultado OUT SYS_REFCURSOR
    ) IS
        Cedula_actor VARCHAR2(10);
    BEGIN
        -- Obtener la cédula del actor a partir del nombre de la persona
        SELECT Cedula INTO Cedula_actor 
        FROM Personas 
        WHERE Nombre = Nombre_Persona;

        -- Abrir el cursor para obtener los contenidos en los que ha participado el actor
        OPEN Resultado FOR
        SELECT C.Nombre AS Nombre_Contenido
        FROM Contenidos C
        JOIN Casting Ca ON C.Codigo = Ca.Codigo_contenido
        WHERE Ca.Cedula_actor = Cedula_actor;

    COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- En caso de error, revertir cualquier cambio
            RAISE;  -- Re-lanzar la excepción para su manejo
    END Consultar_ContenidoActor;


    -- Procedimiento para consultar actor tendencia
    PROCEDURE Consultar_ActorTendencia(
        Nombre_Persona IN VARCHAR2, 
        Resultado OUT SYS_REFCURSOR
    ) IS
        Cedula_actor VARCHAR2(10);
    BEGIN
        -- Obtener la cédula del actor a partir del nombre de la persona
        SELECT Cedula INTO Cedula_actor 
        FROM Personas 
        WHERE Nombre = Nombre_Persona;

        -- Abrir el cursor para obtener el actor con mayor cantidad de contenidos en los que ha participado
        OPEN Resultado FOR
        SELECT Ca.Cedula_actor, COUNT(*) AS Cantidad
        FROM Casting Ca
        JOIN Contenidos C ON Ca.Codigo_contenido = C.Codigo
        WHERE Ca.Cedula_actor = Cedula_actor
        GROUP BY Ca.Cedula_actor
        ORDER BY Cantidad DESC
        FETCH FIRST 1 ROWS ONLY;  -- Obtener el actor con mayor cantidad de contenidos

    COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- En caso de error, revertir cualquier cambio
            RAISE;  -- Re-lanzar la excepción para su manejo
    END Consultar_ActorTendencia;

END PK_U_ESTANDAR;


CREATE OR REPLACE PACKAGE PK_EMPRESAS AS

    PROCEDURE Crear_Usuario(
        Nombre_Usuario IN VARCHAR2,
        Contacto1 IN VARCHAR2,
        Contacto2 IN VARCHAR2,
        Razon_Social IN XMLTYPE,
        Contrasena IN VARCHAR2,
        Cedula IN VARCHAR2,
        Telefono IN VARCHAR2,
        Edad IN INTEGER,
        Correo IN VARCHAR2,
        Nit IN VARCHAR2,
        Nombre_Representante IN VARCHAR2,
        Telefono_Representante IN VARCHAR2
    );
    
    PROCEDURE Crear_Alerta(
        NombreUsuario IN VARCHAR2,
        Descripcion IN VARCHAR2,
        Fecha_Alerta IN DATE
    );
    
    PROCEDURE Modificar_Usuario(
        Nombre_Usuario IN VARCHAR2,
        Contacto1 IN VARCHAR2,
        Contacto2 IN VARCHAR2,
        Razon_Social IN XMLTYPE,
        Contrasena IN VARCHAR2,
        Cedula IN VARCHAR2,
        Telefono IN VARCHAR2,
        Edad IN INTEGER,
        Correo IN VARCHAR2,
        Nit IN VARCHAR2,
        Nombre_Representante IN VARCHAR2,
        Telefono_Representante IN VARCHAR2
    );
    
        PROCEDURE Añadir_Pelicula(
        Nombre IN VARCHAR2, 
        Tipo IN CHAR DEFAULT 'P', 
        Rating IN CHAR, 
        Reseña IN VARCHAR2, 
        Duracion IN VARCHAR2, 
        Ano IN DATE, 
        Genero IN VARCHAR2, 
        Visualizacion IN INTEGER, 
        Nombre_Saga IN VARCHAR2, 
        Nom_Plataforma IN VARCHAR2, 
        Precio IN NUMBER
    );

    -- Procedimiento para añadir una serie
    PROCEDURE Añadir_Serie(
        Nombre IN VARCHAR2, 
        Tipo IN CHAR DEFAULT 'S', 
        Rating IN CHAR, 
        Reseña IN VARCHAR2, 
        Año_Inicio IN DATE, 
        Año_Final IN DATE, 
        Genero IN VARCHAR2, 
        Estado IN CHAR, 
        Visualizacion IN INTEGER, 
        N_Capitulos IN INTEGER, 
        Nombre_Cap IN VARCHAR2, 
        N_Temporada IN INTEGER, 
        Descripcion IN VARCHAR2, 
        Nom_Plataforma IN VARCHAR2, 
        Precio IN NUMBER
    );

    -- Procedimiento para añadir una plataforma
    PROCEDURE Añadir_Plataforma(
        Nom_Plataforma IN VARCHAR2, 
        Precio IN NUMBER
    );

    -- Procedimiento para modificar una película
    PROCEDURE Modificar_Pelicula(
        Nombre IN VARCHAR2, 
        Tipo IN CHAR, 
        Rating IN CHAR, 
        Reseña IN VARCHAR2, 
        Duracion IN VARCHAR2, 
        Ano IN DATE, 
        Genero IN VARCHAR2, 
        Visualizacion IN INTEGER, 
        Nombre_Saga IN VARCHAR2, 
        Nom_Plataforma IN VARCHAR2, 
        Precio IN NUMBER
    );

    -- Procedimiento para modificar una serie
    PROCEDURE Modificar_Serie(
        Nombre IN VARCHAR2, 
        Tipo IN CHAR, 
        Rating IN CHAR, 
        Reseña IN VARCHAR2, 
        Año_Inicio IN DATE, 
        Año_Final IN DATE, 
        Genero IN VARCHAR2, 
        Estado IN CHAR, 
        Visualizacion IN INTEGER, 
        N_Capitulos IN INTEGER, 
        Nombre_Cap IN VARCHAR2, 
        N_Temporada IN INTEGER, 
        Descripcion IN VARCHAR2, 
        Nom_Plataforma IN VARCHAR2, 
        Precio IN NUMBER
    );

    -- Procedimiento para modificar una plataforma
    PROCEDURE Modificar_Plataforma(
        Nom_Plataforma IN VARCHAR2, 
        Precio IN NUMBER
    );

    -- Procedimiento para eliminar una plataforma
    PROCEDURE Eliminar_Plataforma(
        Nom_Plataforma IN VARCHAR2
    );

    -- Procedimiento para consultar las películas de una saga
    PROCEDURE Consultar_PeliculaSaga(
        Nombre_Saga IN VARCHAR2, 
        Resultado OUT SYS_REFCURSOR
    );

    -- Procedimiento para consultar las películas en una plataforma
    PROCEDURE Consultar_PeliculasEnPlataforma(
        Nombre_Plataforma IN VARCHAR2,   -- Nombre de la plataforma a consultar
        Resultado OUT SYS_REFCURSOR      -- Cursor de salida con los resultados
    );

    -- Procedimiento para consultar las series en una plataforma
    PROCEDURE Consultar_Serie_Plataforma(
        Nombre_Plataforma IN VARCHAR2, 
        Resultado OUT SYS_REFCURSOR
    );

    -- Procedimiento para consultar la plataforma más vista
    PROCEDURE Consultar_PlataformaMasVista(
        Resultado OUT SYS_REFCURSOR
    );

    -- Procedimiento para consultar las vistas de una plataforma
    PROCEDURE Consultar_VistasPlataforma(
        Nom_Plataforma IN VARCHAR2, 
        Resultado OUT SYS_REFCURSOR
    );

    -- Procedimiento para consultar contenidos con reseñas positivas
    PROCEDURE Consultar_ContenidosReseñasPositivas(
        Resultado OUT SYS_REFCURSOR
    );
    
        PROCEDURE Consultar_Personas(
        Nombre_Persona IN VARCHAR2, 
        Resultado OUT SYS_REFCURSOR
    );

    PROCEDURE Consultar_CastingsActor(
        Nombre_Persona IN VARCHAR2, 
        Resultado OUT SYS_REFCURSOR
    );

    PROCEDURE Consultar_DirigidosDirector(
        Nombre_Persona IN VARCHAR2, 
        Resultado OUT SYS_REFCURSOR
    );

    PROCEDURE Consultar_Reconocimientos(
        Nombre_Persona IN VARCHAR2, 
        Resultado OUT SYS_REFCURSOR
    );

    PROCEDURE Consultar_ContenidoActor(
        Nombre_Persona IN VARCHAR2, 
        Resultado OUT SYS_REFCURSOR
    );

    PROCEDURE Consultar_ActorTendencia(
        Nombre_Persona IN VARCHAR2, 
        Resultado OUT SYS_REFCURSOR
    );
    

END PK_EMPRESAS;


CREATE OR REPLACE PACKAGE BODY PK_EMPRESAS AS

    PROCEDURE Crear_Usuario(
        Nombre_Usuario IN VARCHAR2,
        Contacto1 IN VARCHAR2,
        Contacto2 IN VARCHAR2,
        Razon_Social IN XMLTYPE,
        Contrasena IN VARCHAR2,
        Cedula IN VARCHAR2,
        Telefono IN VARCHAR2,
        Edad IN INTEGER,
        Correo IN VARCHAR2,
        Nit IN VARCHAR2,
        Nombre_Representante IN VARCHAR2,
        Telefono_Representante IN VARCHAR2
    ) IS
        N_usuario NUMBER;
    BEGIN
        IF Cedula IS NOT NULL THEN
            -- Usuario estándar
            SELECT SEQ_N_USUARIO.NEXTVAL INTO N_usuario FROM dual;
            INSERT INTO Usuarios (N_usuario, NombreUsuario, Contacto1, Contacto2, Contraseña)
            VALUES (N_usuario, Nombre_Usuario, Contacto1, Contacto2, Contrasena);
            
            INSERT INTO UsuariosEstandar (N_usuarioU, Cedula, Telefono, Edad)
            VALUES (N_usuario, Cedula, Telefono, Edad);
            
            INSERT INTO Correos (Correo,N_UsuarioE,Cedula_UsuarioE)
            VALUES (Correo,N_Usuario,Cedula);
            
        ELSIF Razon_Social IS NOT NULL THEN
            -- Empresa
            SELECT SEQ_N_USUARIO.NEXTVAL INTO N_usuario FROM dual;
            INSERT INTO Usuarios (N_usuario, NombreUsuario, Contacto1, Contacto2, Contraseña)
            VALUES (N_usuario, Nombre_Usuario, Contacto1, Contacto2, Contrasena);
            
            INSERT INTO Empresas (N_usuario, NIT, RazonSocial, Nombre_representante, Telefono, Telefono_representante)
            VALUES (N_usuario, Nit, Razon_Social, Nombre_Representante, Telefono, Telefono_Representante);
        END IF;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END Crear_Usuario;
    
    
       PROCEDURE Crear_Alerta(
        NombreUsuario IN VARCHAR2,
        Descripcion IN VARCHAR2,
        Fecha_Alerta IN DATE
    ) IS
        N_Usuario NUMBER; -- Variable para almacenar el N_usuario
        N_Alerta NUMBER;  -- Variable para almacenar el N_alerta generado
        CANTIDAD_REGISTROS NUMBER; -- Variable para contar registros coincidentes
    BEGIN
        -- Verifica si el NombreUsuario existe y cuántos registros coinciden
        SELECT COUNT(*) INTO CANTIDAD_REGISTROS
        FROM Usuarios U
        WHERE U.NombreUsuario = NombreUsuario;
    
        -- Manejo de casos específicos
        IF CANTIDAD_REGISTROS = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'No existe un usuario con ese NombreUsuario.');
        END IF;
    
        -- Recupera el N_usuario del usuario solicitado
        SELECT U.N_usuario INTO N_Usuario
        FROM Usuarios U
        WHERE U.NombreUsuario = NombreUsuario AND ROWNUM = 1;
    
        -- Genera el número único para la alerta
        SELECT SEQ_N_ALERTA.NEXTVAL INTO N_Alerta FROM dual;
    
        -- Inserta la alerta
        INSERT INTO Alertas (N_alerta, N_usuarioU, Descripcion, fechaAlerta)
        VALUES (N_Alerta, N_Usuario, Descripcion, Fecha_Alerta);
    
        -- Confirmar la transacción
        COMMIT;
    
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Error: El usuario no existe.');
            RAISE_APPLICATION_ERROR(-20001, 'Usuario no encontrado.');
    
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error inesperado: ' || SQLERRM);
            ROLLBACK;
            RAISE;
    END Crear_Alerta;
    
    
       PROCEDURE Modificar_Usuario(
        Nombre_Usuario IN VARCHAR2,
        Contacto1 IN VARCHAR2,
        Contacto2 IN VARCHAR2,
        Razon_Social IN XMLTYPE,
        Contrasena IN VARCHAR2,
        Cedula IN VARCHAR2,
        Telefono IN VARCHAR2,
        Edad IN INTEGER,
        Correo IN VARCHAR2,
        Nit IN VARCHAR2,
        Nombre_Representante IN VARCHAR2,
        Telefono_Representante IN VARCHAR2
    ) IS
    BEGIN
        -- Actualiza en la tabla Usuarios
        DBMS_OUTPUT.PUT_LINE('Intentando actualizar Usuarios...');
        UPDATE Usuarios
        SET 
            Contacto1 = NVL(Modificar_Usuario.Contacto1, Usuarios.Contacto1),
            Contacto2 = NVL(Modificar_Usuario.Contacto2, Usuarios.Contacto2),
            Contraseña = NVL(Modificar_Usuario.Contrasena, Usuarios.Contraseña)
        WHERE Usuarios.NombreUsuario = Modificar_Usuario.Nombre_Usuario;
    
        IF SQL%ROWCOUNT = 0 THEN
            DBMS_OUTPUT.PUT_LINE('No se encontró el usuario en la tabla Usuarios.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Tabla Usuarios actualizada.');
        END IF;
    
        -- Actualiza en la tabla UsuariosEstandar si Cedula no es NULL
        IF Cedula IS NOT NULL THEN
            DBMS_OUTPUT.PUT_LINE('Intentando actualizar UsuariosEstandar...');
            UPDATE UsuariosEstandar
            SET 
                Telefono = NVL(Modificar_Usuario.Telefono, UsuariosEstandar.Telefono),
                Edad = NVL(Modificar_Usuario.Edad, UsuariosEstandar.Edad)
            WHERE UsuariosEstandar.Cedula = Modificar_Usuario.Cedula;
    
            IF SQL%ROWCOUNT = 0 THEN
                DBMS_OUTPUT.PUT_LINE('No se encontró el usuario en la tabla UsuariosEstandar.');
            ELSE
                DBMS_OUTPUT.PUT_LINE('Tabla UsuariosEstandar actualizada.');
            END IF;
        END IF;
    
        -- Actualiza en la tabla Empresas si Nit no es NULL
        IF Nit IS NOT NULL THEN
            DBMS_OUTPUT.PUT_LINE('Intentando actualizar Empresas...');
            UPDATE Empresas
            SET 
                RazonSocial = NVL(Modificar_Usuario.Razon_Social, Empresas.RazonSocial),
                Telefono = NVL(Modificar_Usuario.Telefono, Empresas.Telefono),
                Telefono_representante = NVL(Modificar_Usuario.Telefono_Representante, Empresas.Telefono_representante),
                Nombre_representante = NVL(Modificar_Usuario.Nombre_Representante, Empresas.Nombre_representante)
            WHERE Empresas.NIT = Modificar_Usuario.Nit;
    
            IF SQL%ROWCOUNT = 0 THEN
                DBMS_OUTPUT.PUT_LINE('No se encontró la empresa en la tabla Empresas.');
            ELSE
                DBMS_OUTPUT.PUT_LINE('Tabla Empresas actualizada.');
            END IF;
        END IF;
    
        -- Actualiza en la tabla Correos si Correo no es NULL
        -- Actualiza en la tabla Correos si Correo no es NULL
    IF Correo IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('Intentando actualizar Correos...');
        DBMS_OUTPUT.PUT_LINE('Correo proporcionado: ' || Correo || ', Cédula proporcionada: ' || Cedula);
    
        -- Actualiza el correo en la tabla Correos
        UPDATE Correos
        SET Correo = Modificar_Usuario.Correo
        WHERE TRIM(Cedula_usuarioE) = TRIM(Cedula);
    
        -- Verifica si se actualizaron filas
        IF SQL%ROWCOUNT = 0 THEN
            DBMS_OUTPUT.PUT_LINE('No se encontró un correo asociado en la tabla Correos para la cédula proporcionada.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Tabla Correos actualizada correctamente.');
        END IF;
    END IF;
    
        -- Confirmar la transacción
    COMMIT;
    
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('Error inesperado: ' || SQLERRM);
            RAISE;
    END Modificar_Usuario;
    
    PROCEDURE Añadir_Pelicula(
        Nombre IN VARCHAR2, 
        Tipo IN CHAR DEFAULT 'P', 
        Rating IN CHAR, 
        Reseña IN VARCHAR2, 
        Duracion IN VARCHAR2, 
        Ano IN DATE, 
        Genero IN VARCHAR2, 
        Visualizacion IN INTEGER, 
        Nombre_Saga IN VARCHAR2, 
        Nom_Plataforma IN VARCHAR2, 
        Precio IN NUMBER
    ) IS
        N_pelicula NUMBER;
        C_Contenido NUMBER;
        Num_Plataforma NUMBER;  -- Definir la variable para el código de contenido
        Saga_Existe BOOLEAN := FALSE;  -- Variable para verificar si la saga existe
    BEGIN

        -- Obtener el siguiente valor de la secuencia para N_pelicula
        SELECT SEQ_N_PELICULA.NEXTVAL INTO N_pelicula FROM dual;
    
        -- Obtener el siguiente valor de la secuencia para Codigo_contenido
        SELECT SEQ_CONTENIDOS.NEXTVAL INTO C_Contenido FROM dual;
        
        -- Insertar la película en la tabla Contenidos
        INSERT INTO Contenidos (Codigo, Tipo, Nombre, Rating, Reseña)
        VALUES (C_Contenido,'P', Nombre, Rating, Reseña);
        
        -- Insertar la película en la tabla Peliculas
        INSERT INTO Peliculas (Codigo_contenido, N_pelicula, Duracion, Ano, Genero, Visualizacion)
        VALUES ('P'||C_Contenido, N_pelicula, Duracion, Ano, Genero, Visualizacion);
        COMMIT;
        
        -- Si la película tiene saga, actualizar la tabla Sagas
        IF Nombre_Saga IS NOT NULL THEN
            -- Verificar si la saga ya existe
            SELECT COUNT(*) INTO N_pelicula
            FROM Sagas U
            WHERE U.Nombre_saga = Nombre_Saga;

            IF N_pelicula > 0 THEN
                -- Si existe, actualizar el número de películas de la saga
                UPDATE Sagas
                SET N_peliculas = N_peliculas + 1
                WHERE Nombre_saga = Nombre_Saga;
            ELSE
                -- Si no existe, insertar la nueva saga
                INSERT INTO Sagas (Codigo_pelicula, Nombre_saga, N_peliculas)
                VALUES ('P'||C_Contenido, Nombre_Saga, 1);  -- Inicialmente, con 1 película
            END IF;
        END IF;
    
        -- Verificar si la plataforma existe, si no, insertarla
        BEGIN
            SELECT Numero_plataforma INTO Num_Plataforma
            FROM Plataformas
            WHERE Nombre = Nom_Plataforma;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                -- Si no existe, insertar la nueva plataforma
                INSERT INTO Plataformas(Numero_plataforma, Nombre, Precio)
                VALUES (SEQ_NUMERO_PLATAFORMA.NEXTVAL, Nom_Plataforma, Precio);
                
                -- Obtener el número de plataforma recién creado
                SELECT SEQ_NUMERO_PLATAFORMA.CURRVAL INTO Num_Plataforma FROM dual;
        END;
    
        -- Insertar en la tabla ContenidosXPlataformas
        INSERT INTO ContenidosXPlataformas (Codigo_contenido, Numero_plataforma)
        VALUES ('P'||C_Contenido, Num_Plataforma);

        COMMIT;  -- Confirmar la inserción de los datos
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- Revertir cualquier cambio en caso de error
            RAISE;  -- Re-lanzar la excepción para su manejo
    END Añadir_Pelicula;

    -- Procedimiento para añadir una serie
    PROCEDURE Añadir_Serie(
        Nombre IN VARCHAR2, 
        Tipo IN CHAR DEFAULT 'S', 
        Rating IN CHAR, 
        Reseña IN VARCHAR2, 
        Año_Inicio IN DATE, 
        Año_Final IN DATE, 
        Genero IN VARCHAR2, 
        Estado IN CHAR, 
        Visualizacion IN INTEGER, 
        N_Capitulos IN INTEGER, 
        Nombre_Cap IN VARCHAR2, 
        N_Temporada IN INTEGER, 
        Descripcion IN VARCHAR2, 
        Nom_Plataforma IN VARCHAR2, 
        Precio IN NUMBER
    ) IS
        N_serie NUMBER;
        C_Contenido VARCHAR2(10);
        Num_plataforma NUMBER;
    BEGIN
    

        -- Obtener el siguiente valor de la secuencia para N_serie
        SELECT SEQ_CODIGO_SERIE.NEXTVAL INTO N_serie FROM dual;
        
        -- Obtener el siguiente valor de la secuencia para Código de contenido
        SELECT SEQ_CONTENIDOS.NEXTVAL INTO C_Contenido FROM dual;
    
        -- Insertar en la tabla Contenidos (para la serie)
        INSERT INTO Contenidos (Codigo, Tipo, Nombre, Rating, Reseña)
        VALUES (C_Contenido, 'S', Nombre, Rating, Reseña);
    
        -- Insertar en la tabla Series
        INSERT INTO Series (Codigo_contenido, N_serie, Ano_inicio, Ano_final, Genero, Estado, Visualizacion)
        VALUES ('S'||C_Contenido, N_serie, Año_Inicio, Año_Final, Genero, Estado, Visualizacion);
    
        -- Insertar los capítulos relacionados (de acuerdo al número de capítulos)
        INSERT INTO Capitulos (Codigo_serie, N_capitulo, Nombre)
        VALUES ('S'||C_Contenido, N_Capitulos, Nombre_Cap);

        -- Insertar las temporadas
        INSERT INTO Temporadas (Codigo_serie, N_temporada, Descripcion)
        VALUES ('S'||C_Contenido, N_temporada, Descripcion);

        -- Obtener el número de la plataforma
        BEGIN
            SELECT Numero_plataforma INTO Num_Plataforma
            FROM Plataformas
            WHERE Nombre = Nom_Plataforma;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                -- Si no existe, insertar la nueva plataforma
                INSERT INTO Plataformas(Numero_plataforma, Nombre, Precio)
                VALUES (SEQ_NUMERO_PLATAFORMA.NEXTVAL, Nom_Plataforma, Precio);
                
                -- Obtener el número de plataforma recién creado
                SELECT SEQ_NUMERO_PLATAFORMA.CURRVAL INTO Num_Plataforma FROM dual;
        END;

        -- Insertar en la tabla ContenidosXPlataformas
        INSERT INTO ContenidosXPlataformas (Codigo_contenido, Numero_plataforma)
        VALUES ('S'||C_Contenido, Num_plataforma);
    
        COMMIT;  -- Confirmar la inserción de los datos
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- En caso de error, revertir los cambios
            RAISE;  -- Re-lanzar la excepción para su manejo
    END Añadir_Serie;



    -- Procedimiento para añadir una plataforma
    PROCEDURE Añadir_Plataforma(
            Nom_Plataforma IN VARCHAR2,  -- Nombre de la plataforma
            Precio IN NUMBER             -- Precio de la plataforma
        ) IS
            Numero_plataforma NUMBER;    -- Número de la plataforma generado
            Plataforma_Existe NUMBER;   -- Variable para verificar si la plataforma ya existe
        BEGIN
            -- Verificar si la plataforma ya existe
            SELECT COUNT(*) INTO Plataforma_Existe
            FROM Plataformas
            WHERE Nombre = Nom_Plataforma;
    
            -- Si la plataforma no existe, proceder a insertarla
            IF Plataforma_Existe = 0 THEN
                -- Obtener el siguiente valor de la secuencia para Numero_plataforma
                SELECT SEQ_NUMERO_PLATAFORMA.NEXTVAL INTO Numero_plataforma FROM dual;
            
                -- Insertar en la tabla Plataformas
                INSERT INTO Plataformas (Numero_plataforma, Nombre, Precio)
                VALUES (Numero_plataforma, Nom_Plataforma, Precio);
            
                COMMIT;  -- Confirmar la inserción de los datos
            END IF;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;  -- En caso de error, revertir los cambios
                RAISE;  -- Re-lanzar la excepción para su manejo
        END Añadir_Plataforma;


    -- Procedimiento para modificar una película
    PROCEDURE Modificar_Pelicula(
        Nombre IN VARCHAR2,                  -- Nombre de la película a modificar
        Tipo IN CHAR,                         -- Tipo de contenido (por ejemplo, 'P' para película)
        Rating IN CHAR,                       -- Calificación de la película
        Reseña IN VARCHAR2,                   -- Reseña de la película
        Duracion IN VARCHAR2,                 -- Duración de la película
        Ano IN DATE,                          -- Año de la película
        Genero IN VARCHAR2,                   -- Género de la película
        Visualizacion IN INTEGER,             -- Número de visualizaciones
        Nombre_Saga IN VARCHAR2,              -- Nombre de la saga (si aplica)
        Nom_Plataforma IN VARCHAR2,           -- Nombre de la plataforma
        Precio IN NUMBER                      -- Precio de la plataforma
    ) IS
        Codigo_contenido VARCHAR2(10);        -- Código de contenido de la película
        Numero_plataforma NUMBER;             -- Número de la plataforma
    BEGIN
        -- Obtener el código de contenido de la película
        SELECT Codigo 
        INTO Codigo_contenido 
        FROM Contenidos U
        WHERE U.Nombre = Nombre
        AND U.Tipo = Tipo -- Asegúrate de que esta condición sea única
        AND ROWNUM = 1;  -- Obtiene solo el primer registro si hay más de uno

        -- Actualizar los datos en la tabla Contenidos solo si el valor no es NULL
        IF Rating IS NOT NULL THEN
            UPDATE Contenidos U
            SET U.Rating = Rating
            WHERE Codigo = Codigo_contenido;
        END IF;
    
        IF Reseña IS NOT NULL THEN
            UPDATE Contenidos U
            SET U.Reseña = Reseña
            WHERE Codigo = Codigo_contenido;
        END IF;

        -- Actualizar los datos de la película en la tabla Peliculas solo si el valor no es NULL
        IF Duracion IS NOT NULL THEN
            UPDATE Peliculas U
            SET U.Duracion = Duracion
            WHERE U.Codigo_contenido = Codigo_contenido;
        END IF;
    
        IF Ano  IS NOT NULL THEN
            UPDATE Peliculas U
            SET U.Ano = Ano
            WHERE U.Codigo_contenido = Codigo_contenido;
        END IF;
    
        IF Visualizacion IS NOT NULL THEN
            UPDATE Peliculas U
            SET U.Visualizacion = Visualizacion
            WHERE U.Codigo_contenido = Codigo_contenido;
        END IF;
    
        -- Si hay saga, actualizar la tabla Sagas solo si el valor no es NULL
        IF Nombre_Saga IS NOT NULL THEN
            -- Actualizar o insertar saga si no existe
            UPDATE Sagas U
            SET U.Nombre_saga = Nombre_Saga
            WHERE Codigo_pelicula = Codigo_contenido;
        END IF;
    
        -- Obtener el número de la plataforma
        SELECT Numero_plataforma 
        INTO Numero_plataforma 
        FROM Plataformas 
        WHERE Nombre = Nom_Plataforma
        AND ROWNUM = 1; -- Obtiene el primer registro si hay más de uno
    
        -- Validar si existe la plataforma asociada al contenido
        DECLARE
            plataforma_existe INTEGER;
        BEGIN
            SELECT COUNT(*)
            INTO plataforma_existe
            FROM ContenidosXPlataformas
            WHERE Codigo_contenido = Codigo_contenido
              AND Numero_plataforma = Numero_plataforma;
    
            IF plataforma_existe = 0 THEN
                RAISE_APPLICATION_ERROR(-20001, 'La plataforma no existe para este contenido.');
            ELSE
                -- Actualizar el precio en la tabla Plataformas solo si el valor no es NULL
                IF Precio IS NOT NULL THEN
                    UPDATE Plataformas U
                    SET U.Precio = Precio
                    WHERE Numero_plataforma = Numero_plataforma;
                END IF;
            END IF;
        END;
    
        COMMIT;  -- Confirmar los cambios
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- Revertir cualquier cambio si ocurre un error
            RAISE;      -- Re-lanzar la excepción para su manejo
    END Modificar_Pelicula;


    -- Procedimiento para modificar una serie
    PROCEDURE Modificar_Serie(
        Nombre IN VARCHAR2,                    -- Nombre de la serie a modificar
        Tipo IN CHAR,                           -- Tipo de contenido (por ejemplo, 'S' para serie)
        Rating IN CHAR,                         -- Calificación de la serie
        Reseña IN VARCHAR2,                     -- Reseña de la serie
        Año_Inicio IN DATE,                     -- Año de inicio de la serie
        Año_Final IN DATE,                      -- Año final de la serie (puede ser nulo)
        Genero IN VARCHAR2,                     -- Género de la serie
        Estado IN CHAR,                         -- Estado de la serie (activo, inactivo, etc.)
        Visualizacion IN INTEGER,               -- Número de visualizaciones
        N_Capitulos IN INTEGER,                 -- Número de capítulos
        Nombre_Cap IN VARCHAR2,                 -- Nombre de los capítulos
        N_Temporada IN INTEGER,                 -- Número de temporada
        Descripcion IN VARCHAR2,                -- Descripción de la temporada
        Nom_Plataforma IN VARCHAR2,             -- Nombre de la plataforma
        Precio IN NUMBER                        -- Precio de la plataforma
    ) IS
        Codigo_contenido VARCHAR2(10);          -- Código del contenido de la serie
        Numero_plataforma NUMBER;               -- Número de la plataforma
    BEGIN
        -- Obtener el código de contenido de la serie
        SELECT Codigo INTO Codigo_contenido 
        FROM Contenidos U
        WHERE U.Nombre = Nombre
        AND U.Tipo = 'S';  -- Tipo 'S' para serie
    
        -- Actualizar los datos en la tabla Contenidos
        IF Rating IS NOT NULL THEN
            UPDATE Contenidos
            SET Rating = Rating
            WHERE Codigo = Codigo_contenido;
        END IF;

        IF Reseña IS NOT NULL THEN
            UPDATE Contenidos
            SET Reseña = Reseña
            WHERE Codigo = Codigo_contenido;
        END IF;

        -- Actualizar los datos de la serie en la tabla Series
        IF Año_Inicio IS NOT NULL THEN
            UPDATE Series
            SET Ano_inicio = Año_Inicio
            WHERE Codigo_contenido = Codigo_contenido;
        END IF;

        IF Año_Final IS NOT NULL THEN
            UPDATE Series
            SET Ano_final = Año_Final
            WHERE Codigo_contenido = Codigo_contenido;
        END IF;

        IF Estado IS NOT NULL THEN
            UPDATE Series
            SET Estado = Estado
            WHERE Codigo_contenido = Codigo_contenido;
        END IF;

        IF Visualizacion IS NOT NULL THEN
            UPDATE Series
            SET Visualizacion = Visualizacion
            WHERE Codigo_contenido = Codigo_contenido;
        END IF;

        -- Actualizar capítulos si el número de capítulos es proporcionado
        IF N_Capitulos > 0 THEN
            FOR i IN 1..N_Capitulos LOOP
                UPDATE Capitulos
                SET Nombre = Nombre_Cap || ' ' || i
                WHERE Codigo_serie = Codigo_contenido AND N_capitulo = i;
            END LOOP;
        END IF;

        -- Actualizar las temporadas si la temporada es proporcionada
        IF N_Temporada > 0 THEN
            FOR j IN 1..N_Temporada LOOP
                UPDATE Temporadas
                SET Descripcion = Descripcion
                WHERE Codigo_serie = Codigo_contenido AND N_temporada = j;
            END LOOP;
        END IF;

        -- Obtener el número de la plataforma
        SELECT Numero_plataforma INTO Numero_plataforma
        FROM Plataformas
        WHERE Nombre = Nom_Plataforma;
    
        -- Validar si existe la plataforma asociada al contenido
        DECLARE
            plataforma_existe INTEGER;
        BEGIN
            SELECT COUNT(*)
            INTO plataforma_existe
            FROM ContenidosXPlataformas
            WHERE Codigo_contenido = Codigo_contenido
              AND Numero_plataforma = Numero_plataforma;
    
            IF plataforma_existe = 0 THEN
                RAISE_APPLICATION_ERROR(-20001, 'La plataforma no existe para este contenido.');
            ELSE
                -- Actualizar el precio en la tabla Plataformas solo si el valor no es NULL
                IF Precio IS NOT NULL THEN
                    UPDATE Plataformas
                    SET Precio = Precio
                    WHERE Numero_plataforma = Numero_plataforma;
                END IF;
            END IF;
        END;
    
        COMMIT;  -- Confirmar los cambios
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- Revertir cualquier cambio si ocurre un error
            RAISE;      -- Re-lanzar la excepción para su manejo
    END Modificar_Serie;


    -- Procedimiento para modificar una plataforma
    PROCEDURE Modificar_Plataforma(
        Nom_Plataforma IN VARCHAR2,  -- Nombre de la plataforma a modificar
        Precio IN NUMBER             -- Nuevo precio de la plataforma
    ) IS
        Numero_plataforma NUMBER;    -- Número de la plataforma a actualizar
    BEGIN
        -- Obtener el número de la plataforma basado en el nombre proporcionado
        SELECT Numero_plataforma INTO Numero_plataforma
        FROM Plataformas
        WHERE Nombre = Nom_Plataforma;
    
        -- Actualizar el precio en la tabla Plataformas
        UPDATE Plataformas
        SET Precio = NVL(Precio, Precio)
        WHERE Numero_plataforma = Numero_plataforma;
    
        -- Actualizar los contenidos asociados a esta plataforma
        -- (Si el precio de la plataforma cambia, se actualiza la relación en ContenidosXPlataformas)
        UPDATE ContenidosXPlataformas
        SET Numero_plataforma = Numero_plataforma
        WHERE Numero_plataforma = Numero_plataforma;
    
        COMMIT;  -- Confirmar los cambios
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- En caso de error, revertir los cambios
            RAISE;      -- Re-lanzar la excepción para su manejo
    END Modificar_Plataforma;
    
    -- Procedimiento para eliminar una plataforma
    PROCEDURE Eliminar_Plataforma(
        Nom_Plataforma IN VARCHAR2  -- Nombre de la plataforma a eliminar
    ) IS
        Numero_plataforma NUMBER;   -- Número de la plataforma a eliminar
    BEGIN
        -- Intentar obtener el número de la plataforma
        BEGIN
            SELECT Numero_plataforma
            INTO Numero_plataforma
            FROM Plataformas
            WHERE Nombre = Nom_Plataforma;
    
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                -- Manejo del error si no se encuentra la plataforma
                RAISE_APPLICATION_ERROR(-20001, 'La plataforma no existe: ' || Nom_Plataforma);
            WHEN OTHERS THEN
                -- Manejo de cualquier otro error
                RAISE_APPLICATION_ERROR(-20002, 'Error al obtener la plataforma: ' || SQLERRM);
        END;
    
        -- Eliminar las relaciones de la plataforma con los contenidos
        DELETE FROM ContenidosXPlataformas
        WHERE Numero_plataforma = Numero_plataforma;
    
        -- Eliminar la plataforma de la tabla Plataformas
        DELETE FROM Plataformas
        WHERE Numero_plataforma = Numero_plataforma;
    
        -- Confirmar los cambios
        COMMIT;
    
    EXCEPTION
        WHEN OTHERS THEN
            -- Revertir cambios en caso de error
            ROLLBACK;
            RAISE; -- Re-lanzar la excepción para su manejo
    END Eliminar_Plataforma;


    
    -- Procedimiento para consultar las películas por saga
    PROCEDURE Consultar_PeliculaSaga(
        Nombre_Saga IN VARCHAR2,  -- Nombre de la saga a consultar
        Resultado OUT SYS_REFCURSOR  -- Cursor de salida con los resultados
    ) IS
    BEGIN
        -- Abrir el cursor para consultar todas las películas relacionadas con la saga
        OPEN Resultado FOR
        SELECT P.Codigo_contenido, P.N_pelicula, P.Duracion, P.Ano, P.Genero, P.Visualizacion
        FROM Peliculas P
        JOIN Sagas S ON P.Codigo_contenido = S.Codigo_pelicula
        WHERE S.Nombre_saga = Nombre_Saga;
    
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- En caso de error, revertir cualquier cambio
            RAISE;      -- Re-lanzar la excepción para su manejo
    END Consultar_PeliculaSaga;
    
    -- Procedimiento para consultar las películas en una plataforma
    PROCEDURE Consultar_PeliculasEnPlataforma(
        Nombre_Plataforma IN VARCHAR2,   -- Nombre de la plataforma a consultar
        Resultado OUT SYS_REFCURSOR      -- Cursor de salida con los resultados
    ) IS
    BEGIN
        -- Abrir el cursor para consultar las películas en la plataforma correspondiente
        OPEN Resultado FOR
        SELECT P.Codigo_contenido, P.N_pelicula, P.Duracion, P.Ano, P.Genero, P.Visualizacion
        FROM Peliculas P
        JOIN Contenidos C ON P.Codigo_contenido = C.Codigo
        JOIN ContenidosXPlataformas CP ON P.Codigo_contenido = CP.Codigo_contenido
        JOIN Plataformas PL ON CP.Numero_plataforma = PL.Numero_plataforma
        WHERE PL.Nombre = Nombre_Plataforma;  -- Filtrando por el nombre de la plataforma
    
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- En caso de error, revertir cualquier cambio
            RAISE;      -- Re-lanzar la excepción para su manejo
    END Consultar_PeliculasEnPlataforma;
    
    -- Procedimiento para consultar las series en una plataforma
    PROCEDURE Consultar_Serie_Plataforma(
        Nombre_Plataforma IN VARCHAR2,   -- Nombre de la plataforma a consultar
        Resultado OUT SYS_REFCURSOR      -- Cursor de salida con los resultados
    ) IS
    BEGIN
        -- Abrir el cursor para consultar las series en la plataforma correspondiente
        OPEN Resultado FOR
        SELECT S.Codigo_contenido, S.N_Serie, S.Ano_inicio, S.Ano_final, S.Genero, S.Estado, S.Visualizacion
        FROM Series S
        JOIN Contenidos C ON S.Codigo_contenido = C.Codigo
        JOIN ContenidosXPlataformas CP ON S.Codigo_contenido = CP.Codigo_contenido
        JOIN Plataformas PL ON CP.Numero_plataforma = PL.Numero_plataforma
        WHERE PL.Nombre = Nombre_Plataforma;  -- Filtrando por el nombre de la plataforma
    
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- En caso de error, revertir cualquier cambio
            RAISE;      -- Re-lanzar la excepción para su manejo
    END Consultar_Serie_Plataforma;
    
    -- Procedimiento para consultar la plataforma más vista
    PROCEDURE Consultar_PlataformaMasVista(
        Resultado OUT SYS_REFCURSOR   -- Cursor de salida con el resultado
    ) IS
    BEGIN
        -- Abrir el cursor para obtener la plataforma más vista según las visualizaciones
        OPEN Resultado FOR
        SELECT PL.Nombre AS Plataforma,
               SUM(S.Visualizacion) AS Total_Visualizaciones
        FROM Plataformas PL
        JOIN ContenidosXPlataformas CP ON PL.Numero_plataforma = CP.Numero_plataforma
        JOIN Contenidos C ON CP.Codigo_contenido = C.Codigo
        LEFT JOIN Series S ON C.Codigo = S.Codigo_contenido  -- Asociamos las series
        LEFT JOIN Peliculas P ON C.Codigo = P.Codigo_contenido  -- Asociamos las películas
        GROUP BY PL.Nombre
        ORDER BY Total_Visualizaciones DESC
        FETCH FIRST 1 ROWS ONLY;  -- Obtener la plataforma con más visualizaciones
    
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- En caso de error, revertir cualquier cambio
            RAISE;      -- Re-lanzar la excepción para su manejo
    END Consultar_PlataformaMasVista;
    
    -- Procedimiento para consultar las vistas de una plataforma
    PROCEDURE Consultar_VistasPlataforma(
        Nom_Plataforma IN VARCHAR2,   -- Nombre de la plataforma que se desea consultar
        Resultado OUT SYS_REFCURSOR   -- Cursor de salida con el resultado
    ) IS
        v_Numero_plataforma NUMBER;   -- Variable para almacenar el número de la plataforma
    BEGIN
        -- Obtener el número de la plataforma basada en su nombre
        SELECT Numero_plataforma 
        INTO v_Numero_plataforma
        FROM Plataformas
        WHERE Nombre = Nom_Plataforma;
    
        -- Abrir el cursor para obtener las visualizaciones totales de la plataforma
        OPEN Resultado FOR
        SELECT PL.Nombre AS Plataforma,
               SUM(NVL(S.Visualizacion, 0) + NVL(P.Visualizacion, 0)) AS Total_Visualizaciones
        FROM ContenidosXPlataformas CP
        JOIN Plataformas PL ON CP.Numero_plataforma = PL.Numero_plataforma
        JOIN Contenidos C ON CP.Codigo_contenido = C.Codigo
        LEFT JOIN Series S ON C.Codigo = S.Codigo_contenido  -- Asociamos las series
        LEFT JOIN Peliculas P ON C.Codigo = P.Codigo_contenido  -- Asociamos las películas
        WHERE PL.Numero_plataforma = v_Numero_plataforma
        GROUP BY PL.Nombre
        ORDER BY Total_Visualizaciones DESC;
    
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- En caso de error, revertir cualquier cambio
            RAISE;      -- Re-lanzar la excepción para su manejo
    END Consultar_VistasPlataforma;
    
    -- Procedimiento para consultar contenidos con reseñas positivas
    PROCEDURE Consultar_ContenidosReseñasPositivas(
        Resultado OUT SYS_REFCURSOR  -- Cursor de salida con el resultado
    ) IS
    BEGIN
        -- Abrir el cursor para obtener los contenidos con valoraciones positivas
        OPEN Resultado FOR
        SELECT C.Nombre AS Contenido,
               V.Descripcion AS Reseña,
               V.Valoracion AS Valoracion
        FROM Valoraciones V
        JOIN Contenidos C ON V.Codigo_contenido = C.Codigo
        WHERE V.Valoracion >= 4  -- Umbral de valoración positiva
        ORDER BY V.Valoracion DESC;  -- Ordenamos de mayor a menor valoración
    
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- En caso de error, revertir cualquier cambio
            RAISE;      -- Re-lanzar la excepción para su manejo
    END Consultar_ContenidosReseñasPositivas;
    
        PROCEDURE Consultar_Personas(
        Nombre_Persona IN VARCHAR2, 
        Resultado OUT SYS_REFCURSOR
    ) IS
    BEGIN
        -- Abrir el cursor para obtener la información de la persona
        OPEN Resultado FOR
        SELECT Cedula, Nombre, Edad, Nacionalidad, f_nacimiento, f_fallecimiento, Genero
        FROM Personas
        WHERE Nombre = Nombre_Persona;

    COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- En caso de error, revertir cualquier cambio
            RAISE;  -- Re-lanzar la excepción para su manejo
    END Consultar_Personas;


    -- Procedimiento para consultar castings
    PROCEDURE Consultar_CastingsActor(
        Nombre_Persona IN VARCHAR2, 
        Resultado OUT SYS_REFCURSOR
    ) IS
        Cedula_actor VARCHAR2(10);
    BEGIN
        -- Obtener la cédula del actor a partir del nombre de la persona
        SELECT Cedula INTO Cedula_actor 
        FROM Personas 
        WHERE Nombre = Nombre_Persona;

        -- Abrir el cursor para obtener los castings del actor
        OPEN Resultado FOR
        SELECT Ca.Codigo_contenido, Ca.Nombre_personaje, Ca.Rol, Ca.Tiempo_participacion, Ca.Sueldo
        FROM Casting Ca
        WHERE Ca.Cedula_actor = Cedula_actor;

    COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- En caso de error, revertir cualquier cambio
            RAISE;  -- Re-lanzar la excepción para su manejo
    END Consultar_CastingsActor;


    -- Procedimiento para consultar dirigidos por director
    PROCEDURE Consultar_DirigidosDirector(
        Nombre_Persona IN VARCHAR2, 
        Resultado OUT SYS_REFCURSOR
    ) IS
        Cedula_director VARCHAR2(10);
    BEGIN
        -- Obtener la cédula del director a partir del nombre de la persona
        SELECT Cedula INTO Cedula_director 
        FROM Personas 
        WHERE Nombre = Nombre_Persona;

        -- Abrir el cursor para obtener los contenidos dirigidos por este director
        OPEN Resultado FOR
        SELECT D.Codigo_contenido, D.fecha_inicio, D.fecha_final
        FROM Dirigidos D
        WHERE D.Cedula_directores = Cedula_director;

    COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- En caso de error, revertir cualquier cambio
            RAISE;  -- Re-lanzar la excepción para su manejo
    END Consultar_DirigidosDirector;


    -- Procedimiento para consultar reconocimientos
    PROCEDURE Consultar_Reconocimientos(
        Nombre_Persona IN VARCHAR2, 
        Resultado OUT SYS_REFCURSOR
    ) IS
        Cedula_persona VARCHAR2(10);
    BEGIN
        -- Obtener la cédula de la persona a partir del nombre
        SELECT Cedula INTO Cedula_persona 
        FROM Personas 
        WHERE Nombre = Nombre_Persona;

        -- Abrir el cursor para obtener los reconocimientos de la persona
        OPEN Resultado FOR
        SELECT R.N_nominacion, R.Nominacion, R.Estado
        FROM Reconocimientos R
        JOIN PersonasXReconocimientos PR ON R.N_nominacion = PR.N_nominacion
        WHERE PR.Cedula_persona = Cedula_persona;

    COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- En caso de error, revertir cualquier cambio
            RAISE;  -- Re-lanzar la excepción para su manejo
    END Consultar_Reconocimientos;


    -- Procedimiento para consultar contenido de actor
    PROCEDURE Consultar_ContenidoActor(
        Nombre_Persona IN VARCHAR2, 
        Resultado OUT SYS_REFCURSOR
    ) IS
        Cedula_actor VARCHAR2(10);
    BEGIN
        -- Obtener la cédula del actor a partir del nombre de la persona
        SELECT Cedula INTO Cedula_actor 
        FROM Personas 
        WHERE Nombre = Nombre_Persona;

        -- Abrir el cursor para obtener los contenidos en los que ha participado el actor
        OPEN Resultado FOR
        SELECT C.Nombre AS Nombre_Contenido
        FROM Contenidos C
        JOIN Casting Ca ON C.Codigo = Ca.Codigo_contenido
        WHERE Ca.Cedula_actor = Cedula_actor;

    COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- En caso de error, revertir cualquier cambio
            RAISE;  -- Re-lanzar la excepción para su manejo
    END Consultar_ContenidoActor;


    -- Procedimiento para consultar actor tendencia
    PROCEDURE Consultar_ActorTendencia(
        Nombre_Persona IN VARCHAR2, 
        Resultado OUT SYS_REFCURSOR
    ) IS
        Cedula_actor VARCHAR2(10);
    BEGIN
        -- Obtener la cédula del actor a partir del nombre de la persona
        SELECT Cedula INTO Cedula_actor 
        FROM Personas 
        WHERE Nombre = Nombre_Persona;

        -- Abrir el cursor para obtener el actor con mayor cantidad de contenidos en los que ha participado
        OPEN Resultado FOR
        SELECT Ca.Cedula_actor, COUNT(*) AS Cantidad
        FROM Casting Ca
        JOIN Contenidos C ON Ca.Codigo_contenido = C.Codigo
        WHERE Ca.Cedula_actor = Cedula_actor
        GROUP BY Ca.Cedula_actor
        ORDER BY Cantidad DESC
        FETCH FIRST 1 ROWS ONLY;  -- Obtener el actor con mayor cantidad de contenidos

    COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- En caso de error, revertir cualquier cambio
            RAISE;  -- Re-lanzar la excepción para su manejo
    END Consultar_ActorTendencia;

END PK_EMPRESAS;


CREATE OR REPLACE PACKAGE PK_GERENTE AS

     PROCEDURE Crear_Usuario(
        Nombre_Usuario IN VARCHAR2,
        Contacto1 IN VARCHAR2,
        Contacto2 IN VARCHAR2,
        Razon_Social IN XMLTYPE,
        Contrasena IN VARCHAR2,
        Cedula IN VARCHAR2,
        Telefono IN VARCHAR2,
        Edad IN INTEGER,
        Correo IN VARCHAR2,
        Nit IN VARCHAR2,
        Nombre_Representante IN VARCHAR2,
        Telefono_Representante IN VARCHAR2
    );

    PROCEDURE Crear_Valoracion(
        NombreUsuario IN VARCHAR2,
        NombreContenido IN VARCHAR2,
        Codigo IN VARCHAR2,
        Descripcion IN VARCHAR2,
        Valoracion IN INTEGER,
        Fecha_Valoracion IN DATE
    );

    PROCEDURE Crear_Alerta(
        NombreUsuario IN VARCHAR2,
        Descripcion IN VARCHAR2,
        Fecha_Alerta IN DATE
    );

    PROCEDURE Modificar_Usuario(
        Nombre_Usuario IN VARCHAR2,
        Contacto1 IN VARCHAR2,
        Contacto2 IN VARCHAR2,
        Razon_Social IN XMLTYPE,
        Contrasena IN VARCHAR2,
        Cedula IN VARCHAR2,
        Telefono IN VARCHAR2,
        Edad IN INTEGER,
        Correo IN VARCHAR2,
        Nit IN VARCHAR2,
        Nombre_Representante IN VARCHAR2,
        Telefono_Representante IN VARCHAR2
    );

    PROCEDURE Modificar_Valoracion(
        NombreUsuario IN VARCHAR2,
        NombreContenido IN VARCHAR2,
        Codigo IN VARCHAR2,
        Descripcion IN VARCHAR2,
        Valoracion IN INTEGER,
        Fecha_Valoracion IN DATE
    );

    PROCEDURE Modificar_Actualizacion(
        NombreUsuario IN INTEGER,
        Descripcion IN VARCHAR2,
        Estado IN VARCHAR2
    );

    PROCEDURE Eliminar_Valoracion(
        NombreUsuario IN VARCHAR2,
        NombreContenido IN VARCHAR2
    );

    PROCEDURE ConsultarUsuario(
        NombreUsuario IN VARCHAR2,
        Nit IN VARCHAR2,
        Resultado OUT SYS_REFCURSOR
    );

    PROCEDURE ConsultarActualizaciones(
        NombreUsuario IN VARCHAR2,
        Resultado OUT SYS_REFCURSOR
    );

    PROCEDURE ConsultarRecompensas(
        NombreUsuario IN VARCHAR2,
        Resultado OUT SYS_REFCURSOR
    );

    PROCEDURE ConsultarValoraciones(
        NombreUsuario IN VARCHAR2,
        NombreContenido IN VARCHAR2,
        Resultado OUT SYS_REFCURSOR
    );
    
    PROCEDURE ConsultarCantActdesaprobadas(
        Resultado OUT SYS_REFCURSOR
    );

    PROCEDURE ConsultarCantAlertas(
        Resultado OUT SYS_REFCURSOR
    );

    PROCEDURE ConsultarCantValoraciones(
        Resultado OUT SYS_REFCURSOR
    );

    PROCEDURE ConsultarCantUsuariosActualizan(
        Resultado OUT SYS_REFCURSOR
    );

    PROCEDURE ConsultaTelefonosEmpresasGeneranAlertas(
        Resultado OUT SYS_REFCURSOR
    );

    PROCEDURE ConsultarPosiblesBaneos(
        Resultado OUT SYS_REFCURSOR
    );
    
        PROCEDURE Crear_Persona(
        Cedula IN VARCHAR2, 
        Nombre IN VARCHAR2, 
        Edad IN INTEGER, 
        Nacionalidad IN VARCHAR2, 
        F_Nacimiento IN DATE, 
        F_Fallecimiento IN DATE, 
        Genero IN VARCHAR2, 
        Genero_pref IN VARCHAR2, 
        Productora_Aliada IN VARCHAR2, 
        Altura IN FLOAT, 
        Formacion IN VARCHAR2
    );
    
    PROCEDURE Crear_Dirigidos(
        Nombre_Persona IN VARCHAR2, 
        Nombre_Contenido IN VARCHAR2, 
        Fecha_Inicio IN DATE, 
        Fecha_Final IN DATE
    );

    PROCEDURE Crear_Castings(
        Nombre_Persona IN VARCHAR2, 
        Nombre_Contenido IN VARCHAR2, 
        Nombre_Personaje IN VARCHAR2, 
        Rol IN VARCHAR2, 
        Tiempo_Participacion IN INTEGER, 
        Sueldo IN INTEGER
    );
    
    PROCEDURE Crear_Reconocimientos(
        N_Nominacion IN VARCHAR2, 
        Nombre_Persona IN VARCHAR2, 
        Nominacion IN VARCHAR2, 
        Estado IN VARCHAR2
    );
    
    -- Procedimiento para modificar datos
    PROCEDURE Modificar_Persona(
        Cedula IN VARCHAR2, 
        Nombre IN VARCHAR2, 
        Edad IN INTEGER, 
        Nacionalidad IN VARCHAR2, 
        F_Nacimiento IN DATE, 
        F_Fallecimiento IN DATE, 
        Genero IN VARCHAR2, 
        Genero_pref IN VARCHAR2, 
        Productora_Aliada IN VARCHAR2, 
        Altura IN FLOAT, 
        Formacion IN VARCHAR2
    );

    -- Consultas
    PROCEDURE Consultar_Personas(
        Nombre_Persona IN VARCHAR2, 
        Resultado OUT SYS_REFCURSOR
    );

    PROCEDURE Consultar_CastingsActor(
        Nombre_Persona IN VARCHAR2, 
        Resultado OUT SYS_REFCURSOR
    );

    PROCEDURE Consultar_DirigidosDirector(
        Nombre_Persona IN VARCHAR2, 
        Resultado OUT SYS_REFCURSOR
    );

    PROCEDURE Consultar_Reconocimientos(
        Nombre_Persona IN VARCHAR2, 
        Resultado OUT SYS_REFCURSOR
    );

    PROCEDURE Consultar_ContenidoActor(
        Nombre_Persona IN VARCHAR2, 
        Resultado OUT SYS_REFCURSOR
    );

    PROCEDURE Consultar_ActorTendencia(
        Nombre_Persona IN VARCHAR2, 
        Resultado OUT SYS_REFCURSOR
    );


    PROCEDURE Añadir_Pelicula(
        Nombre IN VARCHAR2, 
        Tipo IN CHAR DEFAULT 'P', 
        Rating IN CHAR, 
        Reseña IN VARCHAR2, 
        Duracion IN VARCHAR2, 
        Ano IN DATE, 
        Genero IN VARCHAR2, 
        Visualizacion IN INTEGER, 
        Nombre_Saga IN VARCHAR2, 
        Nom_Plataforma IN VARCHAR2, 
        Precio IN NUMBER
    );

    -- Procedimiento para añadir una serie
    PROCEDURE Añadir_Serie(
        Nombre IN VARCHAR2, 
        Tipo IN CHAR DEFAULT 'S', 
        Rating IN CHAR, 
        Reseña IN VARCHAR2, 
        Año_Inicio IN DATE, 
        Año_Final IN DATE, 
        Genero IN VARCHAR2, 
        Estado IN CHAR, 
        Visualizacion IN INTEGER, 
        N_Capitulos IN INTEGER, 
        Nombre_Cap IN VARCHAR2, 
        N_Temporada IN INTEGER, 
        Descripcion IN VARCHAR2, 
        Nom_Plataforma IN VARCHAR2, 
        Precio IN NUMBER
    );

    -- Procedimiento para añadir una plataforma
    PROCEDURE Añadir_Plataforma(
        Nom_Plataforma IN VARCHAR2, 
        Precio IN NUMBER
    );

    -- Procedimiento para modificar una película
    PROCEDURE Modificar_Pelicula(
        Nombre IN VARCHAR2, 
        Tipo IN CHAR, 
        Rating IN CHAR, 
        Reseña IN VARCHAR2, 
        Duracion IN VARCHAR2, 
        Ano IN DATE, 
        Genero IN VARCHAR2, 
        Visualizacion IN INTEGER, 
        Nombre_Saga IN VARCHAR2, 
        Nom_Plataforma IN VARCHAR2, 
        Precio IN NUMBER
    );

    -- Procedimiento para modificar una serie
    PROCEDURE Modificar_Serie(
        Nombre IN VARCHAR2, 
        Tipo IN CHAR, 
        Rating IN CHAR, 
        Reseña IN VARCHAR2, 
        Año_Inicio IN DATE, 
        Año_Final IN DATE, 
        Genero IN VARCHAR2, 
        Estado IN CHAR, 
        Visualizacion IN INTEGER, 
        N_Capitulos IN INTEGER, 
        Nombre_Cap IN VARCHAR2, 
        N_Temporada IN INTEGER, 
        Descripcion IN VARCHAR2, 
        Nom_Plataforma IN VARCHAR2, 
        Precio IN NUMBER
    );

    -- Procedimiento para modificar una plataforma
    PROCEDURE Modificar_Plataforma(
        Nom_Plataforma IN VARCHAR2, 
        Precio IN NUMBER
    );

    -- Procedimiento para eliminar una plataforma
    PROCEDURE Eliminar_Plataforma(
        Nom_Plataforma IN VARCHAR2
    );

    -- Procedimiento para consultar las películas de una saga
    PROCEDURE Consultar_PeliculaSaga(
        Nombre_Saga IN VARCHAR2, 
        Resultado OUT SYS_REFCURSOR
    );

    -- Procedimiento para consultar las películas en una plataforma
    PROCEDURE Consultar_PeliculasEnPlataforma(
        Nombre_Plataforma IN VARCHAR2,   -- Nombre de la plataforma a consultar
        Resultado OUT SYS_REFCURSOR      -- Cursor de salida con los resultados
    );

    -- Procedimiento para consultar las series en una plataforma
    PROCEDURE Consultar_Serie_Plataforma(
        Nombre_Plataforma IN VARCHAR2, 
        Resultado OUT SYS_REFCURSOR
    );

    -- Procedimiento para consultar la plataforma más vista
    PROCEDURE Consultar_PlataformaMasVista(
        Resultado OUT SYS_REFCURSOR
    );

    -- Procedimiento para consultar las vistas de una plataforma
    PROCEDURE Consultar_VistasPlataforma(
        Nom_Plataforma IN VARCHAR2, 
        Resultado OUT SYS_REFCURSOR
    );

    -- Procedimiento para consultar contenidos con reseñas positivas
    PROCEDURE Consultar_ContenidosReseñasPositivas(
        Resultado OUT SYS_REFCURSOR
    );

END PK_GERENTE;

CREATE OR REPLACE PACKAGE BODY PK_GERENTE AS

    -- Procedimiento para crear un usuario
    PROCEDURE Crear_Usuario(
        Nombre_Usuario IN VARCHAR2,
        Contacto1 IN VARCHAR2,
        Contacto2 IN VARCHAR2,
        Razon_Social IN XMLTYPE,
        Contrasena IN VARCHAR2,
        Cedula IN VARCHAR2,
        Telefono IN VARCHAR2,
        Edad IN INTEGER,
        Correo IN VARCHAR2,
        Nit IN VARCHAR2,
        Nombre_Representante IN VARCHAR2,
        Telefono_Representante IN VARCHAR2
    ) IS
        N_usuario NUMBER;
    BEGIN
        IF Cedula IS NOT NULL THEN
            -- Usuario estándar
            SELECT SEQ_N_USUARIO.NEXTVAL INTO N_usuario FROM dual;
            INSERT INTO Usuarios (N_usuario, NombreUsuario, Contacto1, Contacto2, Contraseña)
            VALUES (N_usuario, Nombre_Usuario, Contacto1, Contacto2, Contrasena);
            
            INSERT INTO UsuariosEstandar (N_usuarioU, Cedula, Telefono, Edad)
            VALUES (N_usuario, Cedula, Telefono, Edad);
            
            INSERT INTO Correos (Correo,N_UsuarioE,Cedula_UsuarioE)
            VALUES (Correo,N_Usuario,Cedula);
            
        ELSIF Razon_Social IS NOT NULL THEN
            -- Empresa
            SELECT SEQ_N_USUARIO.NEXTVAL INTO N_usuario FROM dual;
            INSERT INTO Usuarios (N_usuario, NombreUsuario, Contacto1, Contacto2, Contraseña)
            VALUES (N_usuario, Nombre_Usuario, Contacto1, Contacto2, Contrasena);
            
            INSERT INTO Empresas (N_usuario, NIT, RazonSocial, Nombre_representante, Telefono, Telefono_representante)
            VALUES (N_usuario, Nit, Razon_Social, Nombre_Representante, Telefono, Telefono_Representante);
        END IF;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END Crear_Usuario;

    -- Procedimiento para crear una valoración
    PROCEDURE Crear_Valoracion(
        NombreUsuario IN VARCHAR2,
        NombreContenido IN VARCHAR2,
        Codigo IN VARCHAR2,
        Descripcion IN VARCHAR2,
        Valoracion IN INTEGER,
        Fecha_Valoracion IN DATE
    ) IS
        N_Usuario NUMBER;
        CedulaU VARCHAR2(20);
    BEGIN
        SELECT N_usuarioU, Cedula INTO N_Usuario, CedulaU
        FROM UsuariosEstandar
        WHERE NombreUsuario = NombreUsuario;

        INSERT INTO Valoraciones (N_usuarioE, Cedula_usuarioE, Codigo_contenido, Codigo, Descripcion, Valoracion, Fecha_Valoracion)
        VALUES (N_Usuario, CedulaU, NombreContenido, Codigo, Descripcion, Valoracion, Fecha_Valoracion);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END Crear_Valoracion;

   PROCEDURE Crear_Alerta(
        NombreUsuario IN VARCHAR2,
        Descripcion IN VARCHAR2,
        Fecha_Alerta IN DATE
    ) IS
        N_Usuario NUMBER; -- Variable para almacenar el N_usuario
        N_Alerta NUMBER;  -- Variable para almacenar el N_alerta generado
        CANTIDAD_REGISTROS NUMBER; -- Variable para contar registros coincidentes
    BEGIN
        -- Verifica si el NombreUsuario existe y cuántos registros coinciden
        SELECT COUNT(*) INTO CANTIDAD_REGISTROS
        FROM Usuarios U
        WHERE U.NombreUsuario = NombreUsuario;
    
        -- Manejo de casos específicos
        IF CANTIDAD_REGISTROS = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'No existe un usuario con ese NombreUsuario.');
        END IF;
    
        -- Recupera el N_usuario del usuario solicitado
        SELECT U.N_usuario INTO N_Usuario
        FROM Usuarios U
        WHERE U.NombreUsuario = NombreUsuario AND ROWNUM = 1;
    
        -- Genera el número único para la alerta
        SELECT SEQ_N_ALERTA.NEXTVAL INTO N_Alerta FROM dual;
    
        -- Inserta la alerta
        INSERT INTO Alertas (N_alerta, N_usuarioU, Descripcion, fechaAlerta)
        VALUES (N_Alerta, N_Usuario, Descripcion, Fecha_Alerta);
    
        -- Confirmar la transacción
        COMMIT;
    
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Error: El usuario no existe.');
            RAISE_APPLICATION_ERROR(-20001, 'Usuario no encontrado.');
    
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error inesperado: ' || SQLERRM);
            ROLLBACK;
            RAISE;
    END Crear_Alerta;



    -- Procedimiento para modificar un usuario
   PROCEDURE Modificar_Usuario(
        Nombre_Usuario IN VARCHAR2,
        Contacto1 IN VARCHAR2,
        Contacto2 IN VARCHAR2,
        Razon_Social IN XMLTYPE,
        Contrasena IN VARCHAR2,
        Cedula IN VARCHAR2,
        Telefono IN VARCHAR2,
        Edad IN INTEGER,
        Correo IN VARCHAR2,
        Nit IN VARCHAR2,
        Nombre_Representante IN VARCHAR2,
        Telefono_Representante IN VARCHAR2
    ) IS
    BEGIN
        -- Actualiza en la tabla Usuarios
        DBMS_OUTPUT.PUT_LINE('Intentando actualizar Usuarios...');
        UPDATE Usuarios
        SET 
            Contacto1 = NVL(Modificar_Usuario.Contacto1, Usuarios.Contacto1),
            Contacto2 = NVL(Modificar_Usuario.Contacto2, Usuarios.Contacto2),
            Contraseña = NVL(Modificar_Usuario.Contrasena, Usuarios.Contraseña)
        WHERE Usuarios.NombreUsuario = Modificar_Usuario.Nombre_Usuario;
    
        IF SQL%ROWCOUNT = 0 THEN
            DBMS_OUTPUT.PUT_LINE('No se encontró el usuario en la tabla Usuarios.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Tabla Usuarios actualizada.');
        END IF;
    
        -- Actualiza en la tabla UsuariosEstandar si Cedula no es NULL
        IF Cedula IS NOT NULL THEN
            DBMS_OUTPUT.PUT_LINE('Intentando actualizar UsuariosEstandar...');
            UPDATE UsuariosEstandar
            SET 
                Telefono = NVL(Modificar_Usuario.Telefono, UsuariosEstandar.Telefono),
                Edad = NVL(Modificar_Usuario.Edad, UsuariosEstandar.Edad)
            WHERE UsuariosEstandar.Cedula = Modificar_Usuario.Cedula;
    
            IF SQL%ROWCOUNT = 0 THEN
                DBMS_OUTPUT.PUT_LINE('No se encontró el usuario en la tabla UsuariosEstandar.');
            ELSE
                DBMS_OUTPUT.PUT_LINE('Tabla UsuariosEstandar actualizada.');
            END IF;
        END IF;
    
        -- Actualiza en la tabla Empresas si Nit no es NULL
        IF Nit IS NOT NULL THEN
            DBMS_OUTPUT.PUT_LINE('Intentando actualizar Empresas...');
            UPDATE Empresas
            SET 
                RazonSocial = NVL(Modificar_Usuario.Razon_Social, Empresas.RazonSocial),
                Telefono = NVL(Modificar_Usuario.Telefono, Empresas.Telefono),
                Telefono_representante = NVL(Modificar_Usuario.Telefono_Representante, Empresas.Telefono_representante),
                Nombre_representante = NVL(Modificar_Usuario.Nombre_Representante, Empresas.Nombre_representante)
            WHERE Empresas.NIT = Modificar_Usuario.Nit;
    
            IF SQL%ROWCOUNT = 0 THEN
                DBMS_OUTPUT.PUT_LINE('No se encontró la empresa en la tabla Empresas.');
            ELSE
                DBMS_OUTPUT.PUT_LINE('Tabla Empresas actualizada.');
            END IF;
        END IF;
    
        -- Actualiza en la tabla Correos si Correo no es NULL
        -- Actualiza en la tabla Correos si Correo no es NULL
    IF Correo IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('Intentando actualizar Correos...');
        DBMS_OUTPUT.PUT_LINE('Correo proporcionado: ' || Correo || ', Cédula proporcionada: ' || Cedula);
    
        -- Actualiza el correo en la tabla Correos
        UPDATE Correos
        SET Correo = Modificar_Usuario.Correo
        WHERE TRIM(Cedula_usuarioE) = TRIM(Cedula);
    
        -- Verifica si se actualizaron filas
        IF SQL%ROWCOUNT = 0 THEN
            DBMS_OUTPUT.PUT_LINE('No se encontró un correo asociado en la tabla Correos para la cédula proporcionada.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Tabla Correos actualizada correctamente.');
        END IF;
    END IF;
    
        -- Confirmar la transacción
    COMMIT;
    
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('Error inesperado: ' || SQLERRM);
            RAISE;
    END Modificar_Usuario;




    -- Procedimiento para modificar una valoración
    PROCEDURE Modificar_Valoracion(
        NombreUsuario IN VARCHAR2,
        NombreContenido IN VARCHAR2,
        Codigo IN VARCHAR2,
        Descripcion IN VARCHAR2,
        Valoracion IN INTEGER,
        Fecha_Valoracion IN DATE
    ) IS
        N_Usuario NUMBER;
        CedulaU VARCHAR2(20);
    BEGIN
        SELECT N_usuarioU, Cedula INTO N_Usuario, CedulaU
        FROM UsuariosEstandar
        WHERE NombreUsuario = NombreUsuario;

        UPDATE Valoraciones
        SET 
            Descripcion = NVL(Descripcion, Descripcion),
            Valoracion = NVL(Valoracion, Valoracion),
            Fecha_Valoracion = NVL(Fecha_Valoracion, Fecha_Valoracion)
        WHERE N_usuarioE = N_Usuario 
            AND Cedula_usuarioE = CedulaU
            AND Codigo_contenido = NombreContenido
            AND Codigo = Codigo;
        
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END Modificar_Valoracion;

    -- Procedimiento para modificar una actualización
    PROCEDURE Modificar_Actualizacion(
        NombreUsuario IN INTEGER,
        Descripcion IN VARCHAR2,
        Estado IN VARCHAR2
    ) IS
        N_Usuario NUMBER;
        CedulaU VARCHAR2(20);
        N_Recompensa NUMBER;
    BEGIN
        SELECT N_usuarioU, Cedula INTO N_Usuario, CedulaU
        FROM UsuariosEstandar
        WHERE N_usuarioU = NombreUsuario;

        IF Estado = 'Aprobado' THEN
            SELECT SEQ_RECOMPENSAS.NEXTVAL INTO N_Recompensa FROM dual;

            INSERT INTO SistemasRecompensa (N_recompensa, Descripcion, Tipo)
            VALUES (N_Recompensa, Descripcion, 'Recompensa Aprobada');

            UPDATE Actualizaciones
            SET N_recompensas = N_Recompensa
            WHERE N_usuarioE = N_Usuario
            AND Cedula_usuarioE = CedulaU;
        END IF;

        UPDATE Actualizaciones
        SET 
            Descripcion = NVL(Descripcion, Descripcion),
            Estado = NVL(Estado, Estado)
        WHERE N_usuarioE = N_Usuario
        AND Cedula_usuarioE = CedulaU;

        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END Modificar_Actualizacion;

    -- Procedimiento para eliminar una valoración
    PROCEDURE Eliminar_Valoracion(
        NombreUsuario IN VARCHAR2,
        NombreContenido IN VARCHAR2
    ) IS
        N_Usuario NUMBER;
        CedulaU VARCHAR2(20);
        CodigoContenido VARCHAR2(10);
    BEGIN
        SELECT N_usuarioU, Cedula INTO N_Usuario, CedulaU
        FROM UsuariosEstandar
        WHERE NombreUsuario = NombreUsuario;

        SELECT Codigo INTO CodigoContenido
        FROM Contenidos
        WHERE Nombre = NombreContenido;

        DELETE FROM Valoraciones
        WHERE N_usuarioE = N_Usuario
        AND Cedula_usuarioE = CedulaU
        AND Codigo_contenido = CodigoContenido;

        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END Eliminar_Valoracion;

    -- Procedimiento para consultar un usuario
    PROCEDURE ConsultarUsuario(
        NombreUsuario IN VARCHAR2,
        Nit IN VARCHAR2,
        Resultado OUT SYS_REFCURSOR
    ) IS
    BEGIN
        IF NombreUsuario IS NOT NULL THEN
            OPEN Resultado FOR
            SELECT U.N_usuario, C.Correo
            FROM Usuarios U
            LEFT JOIN UsuariosEstandar UE ON U.N_usuario = UE.N_usuarioU
            LEFT JOIN Correos C ON C.N_usuarioE = UE.N_usuarioU
            WHERE U.NombreUsuario = NombreUsuario;
        ELSIF Nit IS NOT NULL THEN
            OPEN Resultado FOR
            SELECT E.N_usuario
            FROM Empresas E
            WHERE E.NIT = Nit;
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END ConsultarUsuario;

    -- Procedimiento para consultar actualizaciones
    PROCEDURE ConsultarActualizaciones(
        NombreUsuario IN VARCHAR2,
        Resultado OUT SYS_REFCURSOR
    ) IS
        N_Usuario NUMBER;
    BEGIN
        SELECT N_usuarioU INTO N_Usuario
        FROM UsuariosEstandar
        WHERE NombreUsuario = NombreUsuario;

        OPEN Resultado FOR
        SELECT A.Descripcion, A.Estado
        FROM Actualizaciones A
        WHERE A.N_usuarioE = N_Usuario;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END ConsultarActualizaciones;

    -- Procedimiento para consultar recompensas
    PROCEDURE ConsultarRecompensas(
        NombreUsuario IN VARCHAR2,
        Resultado OUT SYS_REFCURSOR
    ) IS
        N_Usuario NUMBER;
    BEGIN
        SELECT N_usuarioU INTO N_Usuario
        FROM UsuariosEstandar
        WHERE NombreUsuario = NombreUsuario;

        OPEN Resultado FOR
        SELECT R.Descripcion, R.Tipo
        FROM SistemasRecompensa R
        JOIN Actualizaciones A ON A.N_recompensas = R.N_recompensa
        WHERE A.N_usuarioE = N_Usuario;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END ConsultarRecompensas;

    -- Procedimiento para consultar valoraciones
    PROCEDURE ConsultarValoraciones(
        NombreUsuario IN VARCHAR2,
        NombreContenido IN VARCHAR2,
        Resultado OUT SYS_REFCURSOR
    ) IS
        N_Usuario NUMBER;
        CedulaU VARCHAR2(20);
        CodigoContenido VARCHAR2(10);
    BEGIN
        SELECT N_usuarioU, Cedula INTO N_Usuario, CedulaU
        FROM UsuariosEstandar
        WHERE NombreUsuario = NombreUsuario;

        SELECT Codigo INTO CodigoContenido
        FROM Contenidos
        WHERE Nombre = NombreContenido;

        OPEN Resultado FOR
        SELECT V.Descripcion, V.Valoracion, V.fecha_valoracion
        FROM Valoraciones V
        WHERE V.N_usuarioE = N_Usuario
        AND V.Cedula_usuarioE = CedulaU
        AND V.Codigo_contenido = CodigoContenido;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END ConsultarValoraciones;
    
        PROCEDURE ConsultarCantActdesaprobadas(
        Resultado OUT SYS_REFCURSOR
    ) IS
    BEGIN
        OPEN Resultado FOR
        SELECT COUNT(*) AS Cantidad
        FROM Actualizaciones
        WHERE Estado = 'Desaprobado';
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END ConsultarCantActdesaprobadas;

    -- Procedimiento para consultar la cantidad de alertas que han generado los usuarios
    PROCEDURE ConsultarCantAlertas(
        Resultado OUT SYS_REFCURSOR
    ) IS
    BEGIN
        OPEN Resultado FOR
        SELECT COUNT(*) AS Cantidad
        FROM Alertas;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END ConsultarCantAlertas;

    -- Procedimiento para consultar la cantidad de valoraciones que han hecho los usuarios
    PROCEDURE ConsultarCantValoraciones(
        Resultado OUT SYS_REFCURSOR
    ) IS
    BEGIN
        OPEN Resultado FOR
        SELECT COUNT(*) AS Cantidad
        FROM Valoraciones;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END ConsultarCantValoraciones;

    -- Procedimiento para consultar la cantidad de usuarios que han actualizado información
    PROCEDURE ConsultarCantUsuariosActualizan(
        Resultado OUT SYS_REFCURSOR
    ) IS
    BEGIN
        OPEN Resultado FOR
        SELECT COUNT(DISTINCT N_usuarioE) AS Cantidad
        FROM Actualizaciones
        WHERE N_recompensas IS NOT NULL;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END ConsultarCantUsuariosActualizan;

    -- Procedimiento para consultar los teléfonos de las empresas que han generado alertas
    PROCEDURE ConsultaTelefonosEmpresasGeneranAlertas(
        Resultado OUT SYS_REFCURSOR
    ) IS
    BEGIN
        OPEN Resultado FOR
        SELECT E.Telefono
        FROM Empresas E
        JOIN Alertas A ON E.N_usuario = A.N_usuarioU;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END ConsultaTelefonosEmpresasGeneranAlertas;

    -- Procedimiento para consultar los usuarios que más crean actualizaciones desaprobadas
    PROCEDURE ConsultarPosiblesBaneos(
        Resultado OUT SYS_REFCURSOR
    ) IS
    BEGIN
        OPEN Resultado FOR
        SELECT N_usuarioE, COUNT(*) AS Cantidad
        FROM Actualizaciones
        WHERE Estado = 'Desaprobado'
        GROUP BY N_usuarioE
        ORDER BY Cantidad DESC;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END ConsultarPosiblesBaneos;
    
    PROCEDURE Crear_Persona(
        Cedula IN VARCHAR2, 
        Nombre IN VARCHAR2, 
        Edad IN INTEGER, 
        Nacionalidad IN VARCHAR2, 
        F_Nacimiento IN DATE, 
        F_Fallecimiento IN DATE, 
        Genero IN VARCHAR2, 
        Genero_pref IN VARCHAR2, 
        Productora_Aliada IN VARCHAR2, 
        Altura IN FLOAT, 
        Formacion IN VARCHAR2
    ) IS
        N_persona NUMBER;
    BEGIN
        -- Insertar en la tabla Personas
        INSERT INTO Personas (Cedula, Nombre, Edad, Nacionalidad, f_nacimiento, f_fallecimiento, Genero)
        VALUES (Cedula, Nombre, Edad, Nacionalidad, F_Nacimiento, F_Fallecimiento, Genero);

        -- Verificar si es director o actor y hacer inserciones correspondientes
        IF Genero_pref IS NOT NULL AND Productora_Aliada IS NOT NULL THEN
            -- Insertar como director
            INSERT INTO Directores (Cedula_persona, Genero_pref, Productora_afiliada)
            VALUES (Cedula, Genero_pref, Productora_Aliada);
        ELSIF Altura IS NOT NULL AND Formacion IS NOT NULL THEN
            -- Insertar como actor
            INSERT INTO Actores (Cedula_persona, Altura, Formacion)
            VALUES (Cedula, Altura, Formacion);
        END IF;
        
        COMMIT;  -- Confirmar la inserción de los datos
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- En caso de error, revertir los cambios
            RAISE;  -- Re-lanzar la excepción para su manejo
    END Crear_Persona;


    -- Procedimiento para crear dirigidos
    PROCEDURE Crear_Dirigidos(
        Nombre_Persona IN VARCHAR2, 
        Nombre_Contenido IN VARCHAR2, 
        Fecha_Inicio IN DATE, 
        Fecha_Final IN DATE
    ) IS
        Cedula_persona VARCHAR2(10);
        Codigo_contenido VARCHAR2(10);
    BEGIN
        -- Obtener Cedula de la persona desde la tabla Personas
        SELECT Cedula INTO Cedula_persona 
        FROM Personas 
        WHERE Nombre = Nombre_Persona;

        -- Obtener Codigo del contenido desde la tabla Contenidos
        SELECT Codigo INTO Codigo_contenido 
        FROM Contenidos 
        WHERE Nombre = Nombre_Contenido;

        -- Insertar en la tabla Dirigidos
        INSERT INTO Dirigidos (Cedula_directores, Codigo_contenido, fecha_inicio, fecha_final)
        VALUES (Cedula_persona, Codigo_contenido, Fecha_Inicio, Fecha_Final);

        COMMIT;  -- Confirmar la inserción de los datos
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- Revertir los cambios en caso de error
            RAISE;  -- Re-lanzar la excepción para su manejo
    END Crear_Dirigidos;


    -- Procedimiento para crear castings
    PROCEDURE Crear_Castings(
        Nombre_Persona IN VARCHAR2, 
        Nombre_Contenido IN VARCHAR2, 
        Nombre_Personaje IN VARCHAR2, 
        Rol IN VARCHAR2, 
        Tiempo_Participacion IN INTEGER, 
        Sueldo IN INTEGER
    ) IS
        Cedula_persona VARCHAR2(10);
        Codigo_contenido VARCHAR2(10);
    BEGIN
        -- Obtener Cedula de la persona desde la tabla Personas
        SELECT Cedula INTO Cedula_persona 
        FROM Personas 
        WHERE Nombre = Nombre_Persona;

        -- Obtener Codigo del contenido desde la tabla Contenidos
        SELECT Codigo INTO Codigo_contenido 
        FROM Contenidos 
        WHERE Nombre = Nombre_Contenido;

        -- Insertar en la tabla Casting
        INSERT INTO Casting (Cedula_actor, Codigo_contenido, Nombre_personaje, Rol, Tiempo_participacion, Sueldo)
        VALUES (Cedula_persona, Codigo_contenido, Nombre_Personaje, Rol, Tiempo_Participacion, Sueldo);

        COMMIT;  -- Confirmar la inserción de los datos
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- Revertir los cambios en caso de error
            RAISE;  -- Re-lanzar la excepción para su manejo
    END Crear_Castings;


    -- Procedimiento para crear reconocimientos
    PROCEDURE Crear_Reconocimientos(
        N_Nominacion IN VARCHAR2, 
        Nombre_Persona IN VARCHAR2, 
        Nominacion IN VARCHAR2, 
        Estado IN VARCHAR2
    ) IS
        Cedula_persona VARCHAR2(10);
        N_Nom NUMBER;
    BEGIN
        -- Obtener Cedula de la persona desde la tabla Personas
        SELECT Cedula INTO Cedula_persona 
        FROM Personas 
        WHERE Nombre = Nombre_Persona;

        -- Obtener el siguiente valor de la secuencia para Nominacion
        SELECT SEQ_N_NOMINACION.NEXTVAL INTO N_Nom FROM dual;

        -- Insertar en la tabla Reconocimientos
        INSERT INTO Reconocimientos (N_nominacion, Nominacion, Estado)
        VALUES (N_Nom, Nominacion, Estado);

        -- Relacionar la nominación con la persona en PersonasXReconocimientos
        INSERT INTO PersonasXReconocimientos (N_nominacion, Cedula_persona)
        VALUES (N_Nom, Cedula_persona);

        COMMIT;  -- Confirmar la inserción de los datos
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- Revertir los cambios en caso de error
            RAISE;  -- Re-lanzar la excepción para su manejo
    END Crear_Reconocimientos;


    -- Procedimiento para modificar persona
    PROCEDURE Modificar_Persona(
        Cedula IN VARCHAR2, 
        Nombre IN VARCHAR2, 
        Edad IN INTEGER, 
        Nacionalidad IN VARCHAR2, 
        F_Nacimiento IN DATE, 
        F_Fallecimiento IN DATE, 
        Genero IN VARCHAR2, 
        Genero_pref IN VARCHAR2, 
        Productora_Aliada IN VARCHAR2, 
        Altura IN FLOAT, 
        Formacion IN VARCHAR2
    ) IS
    BEGIN
        -- Actualizar los datos básicos en la tabla Personas
        UPDATE Personas
        SET 
            Nombre = NVL(Nombre, Nombre),
            Edad = NVL(Edad, Edad),
            Nacionalidad = NVL(Nacionalidad, Nacionalidad),
            f_nacimiento = NVL(F_Nacimiento, f_nacimiento),
            f_fallecimiento = NVL(F_Fallecimiento, f_fallecimiento),
            Genero = NVL(Genero, Genero)
        WHERE Cedula = Cedula;

        -- Verificar si es director o actor y actualizar los datos correspondientes
        IF Genero_pref IS NOT NULL AND Productora_Aliada IS NOT NULL THEN
            -- Actualizar director
            UPDATE Directores
            SET 
                Genero_pref = NVL(Genero_pref, Genero_pref),
                Productora_afiliada = NVL(Productora_Aliada, Productora_Aliada)
            WHERE Cedula_persona = Cedula;
        ELSIF Altura IS NOT NULL AND Formacion IS NOT NULL THEN
            -- Actualizar actor
            UPDATE Actores
            SET 
                Altura = NVL(Altura, Altura),
                Formacion = NVL(Formacion, Formacion)
            WHERE Cedula_persona = Cedula;
        END IF;

        COMMIT;  -- Confirmar los cambios realizados
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- Revertir cualquier cambio si ocurre un error
            RAISE;  -- Re-lanzar la excepción para su manejo
    END Modificar_Persona;


    -- Procedimiento para consultar personas
    PROCEDURE Consultar_Personas(
        Nombre_Persona IN VARCHAR2, 
        Resultado OUT SYS_REFCURSOR
    ) IS
    BEGIN
        -- Abrir el cursor para obtener la información de la persona
        OPEN Resultado FOR
        SELECT Cedula, Nombre, Edad, Nacionalidad, f_nacimiento, f_fallecimiento, Genero
        FROM Personas
        WHERE Nombre = Nombre_Persona;

    COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- En caso de error, revertir cualquier cambio
            RAISE;  -- Re-lanzar la excepción para su manejo
    END Consultar_Personas;


    -- Procedimiento para consultar castings
    PROCEDURE Consultar_CastingsActor(
        Nombre_Persona IN VARCHAR2, 
        Resultado OUT SYS_REFCURSOR
    ) IS
        Cedula_actor VARCHAR2(10);
    BEGIN
        -- Obtener la cédula del actor a partir del nombre de la persona
        SELECT Cedula INTO Cedula_actor 
        FROM Personas 
        WHERE Nombre = Nombre_Persona;

        -- Abrir el cursor para obtener los castings del actor
        OPEN Resultado FOR
        SELECT Ca.Codigo_contenido, Ca.Nombre_personaje, Ca.Rol, Ca.Tiempo_participacion, Ca.Sueldo
        FROM Casting Ca
        WHERE Ca.Cedula_actor = Cedula_actor;

    COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- En caso de error, revertir cualquier cambio
            RAISE;  -- Re-lanzar la excepción para su manejo
    END Consultar_CastingsActor;


    -- Procedimiento para consultar dirigidos por director
    PROCEDURE Consultar_DirigidosDirector(
        Nombre_Persona IN VARCHAR2, 
        Resultado OUT SYS_REFCURSOR
    ) IS
        Cedula_director VARCHAR2(10);
    BEGIN
        -- Obtener la cédula del director a partir del nombre de la persona
        SELECT Cedula INTO Cedula_director 
        FROM Personas 
        WHERE Nombre = Nombre_Persona;

        -- Abrir el cursor para obtener los contenidos dirigidos por este director
        OPEN Resultado FOR
        SELECT D.Codigo_contenido, D.fecha_inicio, D.fecha_final
        FROM Dirigidos D
        WHERE D.Cedula_directores = Cedula_director;

    COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- En caso de error, revertir cualquier cambio
            RAISE;  -- Re-lanzar la excepción para su manejo
    END Consultar_DirigidosDirector;


    -- Procedimiento para consultar reconocimientos
    PROCEDURE Consultar_Reconocimientos(
        Nombre_Persona IN VARCHAR2, 
        Resultado OUT SYS_REFCURSOR
    ) IS
        Cedula_persona VARCHAR2(10);
    BEGIN
        -- Obtener la cédula de la persona a partir del nombre
        SELECT Cedula INTO Cedula_persona 
        FROM Personas 
        WHERE Nombre = Nombre_Persona;

        -- Abrir el cursor para obtener los reconocimientos de la persona
        OPEN Resultado FOR
        SELECT R.N_nominacion, R.Nominacion, R.Estado
        FROM Reconocimientos R
        JOIN PersonasXReconocimientos PR ON R.N_nominacion = PR.N_nominacion
        WHERE PR.Cedula_persona = Cedula_persona;

    COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- En caso de error, revertir cualquier cambio
            RAISE;  -- Re-lanzar la excepción para su manejo
    END Consultar_Reconocimientos;


    -- Procedimiento para consultar contenido de actor
    PROCEDURE Consultar_ContenidoActor(
        Nombre_Persona IN VARCHAR2, 
        Resultado OUT SYS_REFCURSOR
    ) IS
        Cedula_actor VARCHAR2(10);
    BEGIN
        -- Obtener la cédula del actor a partir del nombre de la persona
        SELECT Cedula INTO Cedula_actor 
        FROM Personas 
        WHERE Nombre = Nombre_Persona;

        -- Abrir el cursor para obtener los contenidos en los que ha participado el actor
        OPEN Resultado FOR
        SELECT C.Nombre AS Nombre_Contenido
        FROM Contenidos C
        JOIN Casting Ca ON C.Codigo = Ca.Codigo_contenido
        WHERE Ca.Cedula_actor = Cedula_actor;

    COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- En caso de error, revertir cualquier cambio
            RAISE;  -- Re-lanzar la excepción para su manejo
    END Consultar_ContenidoActor;


    -- Procedimiento para consultar actor tendencia
    PROCEDURE Consultar_ActorTendencia(
        Nombre_Persona IN VARCHAR2, 
        Resultado OUT SYS_REFCURSOR
    ) IS
        Cedula_actor VARCHAR2(10);
    BEGIN
        -- Obtener la cédula del actor a partir del nombre de la persona
        SELECT Cedula INTO Cedula_actor 
        FROM Personas 
        WHERE Nombre = Nombre_Persona;

        -- Abrir el cursor para obtener el actor con mayor cantidad de contenidos en los que ha participado
        OPEN Resultado FOR
        SELECT Ca.Cedula_actor, COUNT(*) AS Cantidad
        FROM Casting Ca
        JOIN Contenidos C ON Ca.Codigo_contenido = C.Codigo
        WHERE Ca.Cedula_actor = Cedula_actor
        GROUP BY Ca.Cedula_actor
        ORDER BY Cantidad DESC
        FETCH FIRST 1 ROWS ONLY;  -- Obtener el actor con mayor cantidad de contenidos

    COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- En caso de error, revertir cualquier cambio
            RAISE;  -- Re-lanzar la excepción para su manejo
    END Consultar_ActorTendencia;
    
    
    PROCEDURE Añadir_Pelicula(
        Nombre IN VARCHAR2, 
        Tipo IN CHAR DEFAULT 'P', 
        Rating IN CHAR, 
        Reseña IN VARCHAR2, 
        Duracion IN VARCHAR2, 
        Ano IN DATE, 
        Genero IN VARCHAR2, 
        Visualizacion IN INTEGER, 
        Nombre_Saga IN VARCHAR2, 
        Nom_Plataforma IN VARCHAR2, 
        Precio IN NUMBER
    ) IS
        N_pelicula NUMBER;
        C_Contenido NUMBER;
        Num_Plataforma NUMBER;  -- Definir la variable para el código de contenido
        Saga_Existe BOOLEAN := FALSE;  -- Variable para verificar si la saga existe
    BEGIN

        -- Obtener el siguiente valor de la secuencia para N_pelicula
        SELECT SEQ_N_PELICULA.NEXTVAL INTO N_pelicula FROM dual;
    
        -- Obtener el siguiente valor de la secuencia para Codigo_contenido
        SELECT SEQ_CONTENIDOS.NEXTVAL INTO C_Contenido FROM dual;
        
        -- Insertar la película en la tabla Contenidos
        INSERT INTO Contenidos (Codigo, Tipo, Nombre, Rating, Reseña)
        VALUES (C_Contenido,'P', Nombre, Rating, Reseña);
        
        -- Insertar la película en la tabla Peliculas
        INSERT INTO Peliculas (Codigo_contenido, N_pelicula, Duracion, Ano, Genero, Visualizacion)
        VALUES ('P'||C_Contenido, N_pelicula, Duracion, Ano, Genero, Visualizacion);
        COMMIT;
        
        -- Si la película tiene saga, actualizar la tabla Sagas
        IF Nombre_Saga IS NOT NULL THEN
            -- Verificar si la saga ya existe
            SELECT COUNT(*) INTO N_pelicula
            FROM Sagas U
            WHERE U.Nombre_saga = Nombre_Saga;

            IF N_pelicula > 0 THEN
                -- Si existe, actualizar el número de películas de la saga
                UPDATE Sagas
                SET N_peliculas = N_peliculas + 1
                WHERE Nombre_saga = Nombre_Saga;
            ELSE
                -- Si no existe, insertar la nueva saga
                INSERT INTO Sagas (Codigo_pelicula, Nombre_saga, N_peliculas)
                VALUES ('P'||C_Contenido, Nombre_Saga, 1);  -- Inicialmente, con 1 película
            END IF;
        END IF;
    
        -- Verificar si la plataforma existe, si no, insertarla
        BEGIN
            SELECT Numero_plataforma INTO Num_Plataforma
            FROM Plataformas
            WHERE Nombre = Nom_Plataforma;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                -- Si no existe, insertar la nueva plataforma
                INSERT INTO Plataformas(Numero_plataforma, Nombre, Precio)
                VALUES (SEQ_NUMERO_PLATAFORMA.NEXTVAL, Nom_Plataforma, Precio);
                
                -- Obtener el número de plataforma recién creado
                SELECT SEQ_NUMERO_PLATAFORMA.CURRVAL INTO Num_Plataforma FROM dual;
        END;
    
        -- Insertar en la tabla ContenidosXPlataformas
        INSERT INTO ContenidosXPlataformas (Codigo_contenido, Numero_plataforma)
        VALUES ('P'||C_Contenido, Num_Plataforma);

        COMMIT;  -- Confirmar la inserción de los datos
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- Revertir cualquier cambio en caso de error
            RAISE;  -- Re-lanzar la excepción para su manejo
    END Añadir_Pelicula;

    -- Procedimiento para añadir una serie
    PROCEDURE Añadir_Serie(
        Nombre IN VARCHAR2, 
        Tipo IN CHAR DEFAULT 'S', 
        Rating IN CHAR, 
        Reseña IN VARCHAR2, 
        Año_Inicio IN DATE, 
        Año_Final IN DATE, 
        Genero IN VARCHAR2, 
        Estado IN CHAR, 
        Visualizacion IN INTEGER, 
        N_Capitulos IN INTEGER, 
        Nombre_Cap IN VARCHAR2, 
        N_Temporada IN INTEGER, 
        Descripcion IN VARCHAR2, 
        Nom_Plataforma IN VARCHAR2, 
        Precio IN NUMBER
    ) IS
        N_serie NUMBER;
        C_Contenido VARCHAR2(10);
        Num_plataforma NUMBER;
    BEGIN
    

        -- Obtener el siguiente valor de la secuencia para N_serie
        SELECT SEQ_CODIGO_SERIE.NEXTVAL INTO N_serie FROM dual;
        
        -- Obtener el siguiente valor de la secuencia para Código de contenido
        SELECT SEQ_CONTENIDOS.NEXTVAL INTO C_Contenido FROM dual;
    
        -- Insertar en la tabla Contenidos (para la serie)
        INSERT INTO Contenidos (Codigo, Tipo, Nombre, Rating, Reseña)
        VALUES (C_Contenido, 'S', Nombre, Rating, Reseña);
    
        -- Insertar en la tabla Series
        INSERT INTO Series (Codigo_contenido, N_serie, Ano_inicio, Ano_final, Genero, Estado, Visualizacion)
        VALUES ('S'||C_Contenido, N_serie, Año_Inicio, Año_Final, Genero, Estado, Visualizacion);
    
        -- Insertar los capítulos relacionados (de acuerdo al número de capítulos)
        INSERT INTO Capitulos (Codigo_serie, N_capitulo, Nombre)
        VALUES ('S'||C_Contenido, N_Capitulos, Nombre_Cap);

        -- Insertar las temporadas
        INSERT INTO Temporadas (Codigo_serie, N_temporada, Descripcion)
        VALUES ('S'||C_Contenido, N_temporada, Descripcion);

        -- Obtener el número de la plataforma
        BEGIN
            SELECT Numero_plataforma INTO Num_Plataforma
            FROM Plataformas
            WHERE Nombre = Nom_Plataforma;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                -- Si no existe, insertar la nueva plataforma
                INSERT INTO Plataformas(Numero_plataforma, Nombre, Precio)
                VALUES (SEQ_NUMERO_PLATAFORMA.NEXTVAL, Nom_Plataforma, Precio);
                
                -- Obtener el número de plataforma recién creado
                SELECT SEQ_NUMERO_PLATAFORMA.CURRVAL INTO Num_Plataforma FROM dual;
        END;

        -- Insertar en la tabla ContenidosXPlataformas
        INSERT INTO ContenidosXPlataformas (Codigo_contenido, Numero_plataforma)
        VALUES ('S'||C_Contenido, Num_plataforma);
    
        COMMIT;  -- Confirmar la inserción de los datos
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- En caso de error, revertir los cambios
            RAISE;  -- Re-lanzar la excepción para su manejo
    END Añadir_Serie;



    -- Procedimiento para añadir una plataforma
    PROCEDURE Añadir_Plataforma(
            Nom_Plataforma IN VARCHAR2,  -- Nombre de la plataforma
            Precio IN NUMBER             -- Precio de la plataforma
        ) IS
            Numero_plataforma NUMBER;    -- Número de la plataforma generado
            Plataforma_Existe NUMBER;   -- Variable para verificar si la plataforma ya existe
        BEGIN
            -- Verificar si la plataforma ya existe
            SELECT COUNT(*) INTO Plataforma_Existe
            FROM Plataformas
            WHERE Nombre = Nom_Plataforma;
    
            -- Si la plataforma no existe, proceder a insertarla
            IF Plataforma_Existe = 0 THEN
                -- Obtener el siguiente valor de la secuencia para Numero_plataforma
                SELECT SEQ_NUMERO_PLATAFORMA.NEXTVAL INTO Numero_plataforma FROM dual;
            
                -- Insertar en la tabla Plataformas
                INSERT INTO Plataformas (Numero_plataforma, Nombre, Precio)
                VALUES (Numero_plataforma, Nom_Plataforma, Precio);
            
                COMMIT;  -- Confirmar la inserción de los datos
            END IF;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;  -- En caso de error, revertir los cambios
                RAISE;  -- Re-lanzar la excepción para su manejo
        END Añadir_Plataforma;


    -- Procedimiento para modificar una película
    PROCEDURE Modificar_Pelicula(
        Nombre IN VARCHAR2,                  -- Nombre de la película a modificar
        Tipo IN CHAR,                         -- Tipo de contenido (por ejemplo, 'P' para película)
        Rating IN CHAR,                       -- Calificación de la película
        Reseña IN VARCHAR2,                   -- Reseña de la película
        Duracion IN VARCHAR2,                 -- Duración de la película
        Ano IN DATE,                          -- Año de la película
        Genero IN VARCHAR2,                   -- Género de la película
        Visualizacion IN INTEGER,             -- Número de visualizaciones
        Nombre_Saga IN VARCHAR2,              -- Nombre de la saga (si aplica)
        Nom_Plataforma IN VARCHAR2,           -- Nombre de la plataforma
        Precio IN NUMBER                      -- Precio de la plataforma
    ) IS
        Codigo_contenido VARCHAR2(10);        -- Código de contenido de la película
        Numero_plataforma NUMBER;             -- Número de la plataforma
    BEGIN
        -- Obtener el código de contenido de la película
        SELECT Codigo 
        INTO Codigo_contenido 
        FROM Contenidos U
        WHERE U.Nombre = Nombre
        AND U.Tipo = Tipo -- Asegúrate de que esta condición sea única
        AND ROWNUM = 1;  -- Obtiene solo el primer registro si hay más de uno

        -- Actualizar los datos en la tabla Contenidos solo si el valor no es NULL
        IF Rating IS NOT NULL THEN
            UPDATE Contenidos U
            SET U.Rating = Rating
            WHERE Codigo = Codigo_contenido;
        END IF;
    
        IF Reseña IS NOT NULL THEN
            UPDATE Contenidos U
            SET U.Reseña = Reseña
            WHERE Codigo = Codigo_contenido;
        END IF;

        -- Actualizar los datos de la película en la tabla Peliculas solo si el valor no es NULL
        IF Duracion IS NOT NULL THEN
            UPDATE Peliculas U
            SET U.Duracion = Duracion
            WHERE U.Codigo_contenido = Codigo_contenido;
        END IF;
    
        IF Ano  IS NOT NULL THEN
            UPDATE Peliculas U
            SET U.Ano = Ano
            WHERE U.Codigo_contenido = Codigo_contenido;
        END IF;
    
        IF Visualizacion IS NOT NULL THEN
            UPDATE Peliculas U
            SET U.Visualizacion = Visualizacion
            WHERE U.Codigo_contenido = Codigo_contenido;
        END IF;
    
        -- Si hay saga, actualizar la tabla Sagas solo si el valor no es NULL
        IF Nombre_Saga IS NOT NULL THEN
            -- Actualizar o insertar saga si no existe
            UPDATE Sagas U
            SET U.Nombre_saga = Nombre_Saga
            WHERE Codigo_pelicula = Codigo_contenido;
        END IF;
    
        -- Obtener el número de la plataforma
        SELECT Numero_plataforma 
        INTO Numero_plataforma 
        FROM Plataformas 
        WHERE Nombre = Nom_Plataforma
        AND ROWNUM = 1; -- Obtiene el primer registro si hay más de uno
    
        -- Validar si existe la plataforma asociada al contenido
        DECLARE
            plataforma_existe INTEGER;
        BEGIN
            SELECT COUNT(*)
            INTO plataforma_existe
            FROM ContenidosXPlataformas
            WHERE Codigo_contenido = Codigo_contenido
              AND Numero_plataforma = Numero_plataforma;
    
            IF plataforma_existe = 0 THEN
                RAISE_APPLICATION_ERROR(-20001, 'La plataforma no existe para este contenido.');
            ELSE
                -- Actualizar el precio en la tabla Plataformas solo si el valor no es NULL
                IF Precio IS NOT NULL THEN
                    UPDATE Plataformas U
                    SET U.Precio = Precio
                    WHERE Numero_plataforma = Numero_plataforma;
                END IF;
            END IF;
        END;
    
        COMMIT;  -- Confirmar los cambios
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- Revertir cualquier cambio si ocurre un error
            RAISE;      -- Re-lanzar la excepción para su manejo
    END Modificar_Pelicula;


    -- Procedimiento para modificar una serie
    PROCEDURE Modificar_Serie(
        Nombre IN VARCHAR2,                    -- Nombre de la serie a modificar
        Tipo IN CHAR,                           -- Tipo de contenido (por ejemplo, 'S' para serie)
        Rating IN CHAR,                         -- Calificación de la serie
        Reseña IN VARCHAR2,                     -- Reseña de la serie
        Año_Inicio IN DATE,                     -- Año de inicio de la serie
        Año_Final IN DATE,                      -- Año final de la serie (puede ser nulo)
        Genero IN VARCHAR2,                     -- Género de la serie
        Estado IN CHAR,                         -- Estado de la serie (activo, inactivo, etc.)
        Visualizacion IN INTEGER,               -- Número de visualizaciones
        N_Capitulos IN INTEGER,                 -- Número de capítulos
        Nombre_Cap IN VARCHAR2,                 -- Nombre de los capítulos
        N_Temporada IN INTEGER,                 -- Número de temporada
        Descripcion IN VARCHAR2,                -- Descripción de la temporada
        Nom_Plataforma IN VARCHAR2,             -- Nombre de la plataforma
        Precio IN NUMBER                        -- Precio de la plataforma
    ) IS
        Codigo_contenido VARCHAR2(10);          -- Código del contenido de la serie
        Numero_plataforma NUMBER;               -- Número de la plataforma
    BEGIN
        -- Obtener el código de contenido de la serie
        SELECT Codigo INTO Codigo_contenido 
        FROM Contenidos U
        WHERE U.Nombre = Nombre
        AND U.Tipo = 'S';  -- Tipo 'S' para serie
    
        -- Actualizar los datos en la tabla Contenidos
        IF Rating IS NOT NULL THEN
            UPDATE Contenidos
            SET Rating = Rating
            WHERE Codigo = Codigo_contenido;
        END IF;

        IF Reseña IS NOT NULL THEN
            UPDATE Contenidos
            SET Reseña = Reseña
            WHERE Codigo = Codigo_contenido;
        END IF;

        -- Actualizar los datos de la serie en la tabla Series
        IF Año_Inicio IS NOT NULL THEN
            UPDATE Series
            SET Ano_inicio = Año_Inicio
            WHERE Codigo_contenido = Codigo_contenido;
        END IF;

        IF Año_Final IS NOT NULL THEN
            UPDATE Series
            SET Ano_final = Año_Final
            WHERE Codigo_contenido = Codigo_contenido;
        END IF;

        IF Estado IS NOT NULL THEN
            UPDATE Series
            SET Estado = Estado
            WHERE Codigo_contenido = Codigo_contenido;
        END IF;

        IF Visualizacion IS NOT NULL THEN
            UPDATE Series
            SET Visualizacion = Visualizacion
            WHERE Codigo_contenido = Codigo_contenido;
        END IF;

        -- Actualizar capítulos si el número de capítulos es proporcionado
        IF N_Capitulos > 0 THEN
            FOR i IN 1..N_Capitulos LOOP
                UPDATE Capitulos
                SET Nombre = Nombre_Cap || ' ' || i
                WHERE Codigo_serie = Codigo_contenido AND N_capitulo = i;
            END LOOP;
        END IF;

        -- Actualizar las temporadas si la temporada es proporcionada
        IF N_Temporada > 0 THEN
            FOR j IN 1..N_Temporada LOOP
                UPDATE Temporadas
                SET Descripcion = Descripcion
                WHERE Codigo_serie = Codigo_contenido AND N_temporada = j;
            END LOOP;
        END IF;

        -- Obtener el número de la plataforma
        SELECT Numero_plataforma INTO Numero_plataforma
        FROM Plataformas
        WHERE Nombre = Nom_Plataforma;
    
        -- Validar si existe la plataforma asociada al contenido
        DECLARE
            plataforma_existe INTEGER;
        BEGIN
            SELECT COUNT(*)
            INTO plataforma_existe
            FROM ContenidosXPlataformas
            WHERE Codigo_contenido = Codigo_contenido
              AND Numero_plataforma = Numero_plataforma;
    
            IF plataforma_existe = 0 THEN
                RAISE_APPLICATION_ERROR(-20001, 'La plataforma no existe para este contenido.');
            ELSE
                -- Actualizar el precio en la tabla Plataformas solo si el valor no es NULL
                IF Precio IS NOT NULL THEN
                    UPDATE Plataformas
                    SET Precio = Precio
                    WHERE Numero_plataforma = Numero_plataforma;
                END IF;
            END IF;
        END;
    
        COMMIT;  -- Confirmar los cambios
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- Revertir cualquier cambio si ocurre un error
            RAISE;      -- Re-lanzar la excepción para su manejo
    END Modificar_Serie;


    -- Procedimiento para modificar una plataforma
    PROCEDURE Modificar_Plataforma(
        Nom_Plataforma IN VARCHAR2,  -- Nombre de la plataforma a modificar
        Precio IN NUMBER             -- Nuevo precio de la plataforma
    ) IS
        Numero_plataforma NUMBER;    -- Número de la plataforma a actualizar
    BEGIN
        -- Obtener el número de la plataforma basado en el nombre proporcionado
        SELECT Numero_plataforma INTO Numero_plataforma
        FROM Plataformas
        WHERE Nombre = Nom_Plataforma;
    
        -- Actualizar el precio en la tabla Plataformas
        UPDATE Plataformas
        SET Precio = NVL(Precio, Precio)
        WHERE Numero_plataforma = Numero_plataforma;
    
        -- Actualizar los contenidos asociados a esta plataforma
        -- (Si el precio de la plataforma cambia, se actualiza la relación en ContenidosXPlataformas)
        UPDATE ContenidosXPlataformas
        SET Numero_plataforma = Numero_plataforma
        WHERE Numero_plataforma = Numero_plataforma;
    
        COMMIT;  -- Confirmar los cambios
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- En caso de error, revertir los cambios
            RAISE;      -- Re-lanzar la excepción para su manejo
    END Modificar_Plataforma;
    
    -- Procedimiento para eliminar una plataforma
    PROCEDURE Eliminar_Plataforma(
        Nom_Plataforma IN VARCHAR2  -- Nombre de la plataforma a eliminar
    ) IS
        Numero_plataforma NUMBER;   -- Número de la plataforma a eliminar
    BEGIN
        -- Intentar obtener el número de la plataforma
        BEGIN
            SELECT Numero_plataforma
            INTO Numero_plataforma
            FROM Plataformas
            WHERE Nombre = Nom_Plataforma;
    
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                -- Manejo del error si no se encuentra la plataforma
                RAISE_APPLICATION_ERROR(-20001, 'La plataforma no existe: ' || Nom_Plataforma);
            WHEN OTHERS THEN
                -- Manejo de cualquier otro error
                RAISE_APPLICATION_ERROR(-20002, 'Error al obtener la plataforma: ' || SQLERRM);
        END;
    
        -- Eliminar las relaciones de la plataforma con los contenidos
        DELETE FROM ContenidosXPlataformas
        WHERE Numero_plataforma = Numero_plataforma;
    
        -- Eliminar la plataforma de la tabla Plataformas
        DELETE FROM Plataformas
        WHERE Numero_plataforma = Numero_plataforma;
    
        -- Confirmar los cambios
        COMMIT;
    
    EXCEPTION
        WHEN OTHERS THEN
            -- Revertir cambios en caso de error
            ROLLBACK;
            RAISE; -- Re-lanzar la excepción para su manejo
    END Eliminar_Plataforma;


    
    -- Procedimiento para consultar las películas por saga
    PROCEDURE Consultar_PeliculaSaga(
        Nombre_Saga IN VARCHAR2,  -- Nombre de la saga a consultar
        Resultado OUT SYS_REFCURSOR  -- Cursor de salida con los resultados
    ) IS
    BEGIN
        -- Abrir el cursor para consultar todas las películas relacionadas con la saga
        OPEN Resultado FOR
        SELECT P.Codigo_contenido, P.N_pelicula, P.Duracion, P.Ano, P.Genero, P.Visualizacion
        FROM Peliculas P
        JOIN Sagas S ON P.Codigo_contenido = S.Codigo_pelicula
        WHERE S.Nombre_saga = Nombre_Saga;
    
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- En caso de error, revertir cualquier cambio
            RAISE;      -- Re-lanzar la excepción para su manejo
    END Consultar_PeliculaSaga;
    
    -- Procedimiento para consultar las películas en una plataforma
    PROCEDURE Consultar_PeliculasEnPlataforma(
        Nombre_Plataforma IN VARCHAR2,   -- Nombre de la plataforma a consultar
        Resultado OUT SYS_REFCURSOR      -- Cursor de salida con los resultados
    ) IS
    BEGIN
        -- Abrir el cursor para consultar las películas en la plataforma correspondiente
        OPEN Resultado FOR
        SELECT P.Codigo_contenido, P.N_pelicula, P.Duracion, P.Ano, P.Genero, P.Visualizacion
        FROM Peliculas P
        JOIN Contenidos C ON P.Codigo_contenido = C.Codigo
        JOIN ContenidosXPlataformas CP ON P.Codigo_contenido = CP.Codigo_contenido
        JOIN Plataformas PL ON CP.Numero_plataforma = PL.Numero_plataforma
        WHERE PL.Nombre = Nombre_Plataforma;  -- Filtrando por el nombre de la plataforma
    
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- En caso de error, revertir cualquier cambio
            RAISE;      -- Re-lanzar la excepción para su manejo
    END Consultar_PeliculasEnPlataforma;
    
    -- Procedimiento para consultar las series en una plataforma
    PROCEDURE Consultar_Serie_Plataforma(
        Nombre_Plataforma IN VARCHAR2,   -- Nombre de la plataforma a consultar
        Resultado OUT SYS_REFCURSOR      -- Cursor de salida con los resultados
    ) IS
    BEGIN
        -- Abrir el cursor para consultar las series en la plataforma correspondiente
        OPEN Resultado FOR
        SELECT S.Codigo_contenido, S.N_Serie, S.Ano_inicio, S.Ano_final, S.Genero, S.Estado, S.Visualizacion
        FROM Series S
        JOIN Contenidos C ON S.Codigo_contenido = C.Codigo
        JOIN ContenidosXPlataformas CP ON S.Codigo_contenido = CP.Codigo_contenido
        JOIN Plataformas PL ON CP.Numero_plataforma = PL.Numero_plataforma
        WHERE PL.Nombre = Nombre_Plataforma;  -- Filtrando por el nombre de la plataforma
    
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- En caso de error, revertir cualquier cambio
            RAISE;      -- Re-lanzar la excepción para su manejo
    END Consultar_Serie_Plataforma;
    
    -- Procedimiento para consultar la plataforma más vista
    PROCEDURE Consultar_PlataformaMasVista(
        Resultado OUT SYS_REFCURSOR   -- Cursor de salida con el resultado
    ) IS
    BEGIN
        -- Abrir el cursor para obtener la plataforma más vista según las visualizaciones
        OPEN Resultado FOR
        SELECT PL.Nombre AS Plataforma,
               SUM(S.Visualizacion) AS Total_Visualizaciones
        FROM Plataformas PL
        JOIN ContenidosXPlataformas CP ON PL.Numero_plataforma = CP.Numero_plataforma
        JOIN Contenidos C ON CP.Codigo_contenido = C.Codigo
        LEFT JOIN Series S ON C.Codigo = S.Codigo_contenido  -- Asociamos las series
        LEFT JOIN Peliculas P ON C.Codigo = P.Codigo_contenido  -- Asociamos las películas
        GROUP BY PL.Nombre
        ORDER BY Total_Visualizaciones DESC
        FETCH FIRST 1 ROWS ONLY;  -- Obtener la plataforma con más visualizaciones
    
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- En caso de error, revertir cualquier cambio
            RAISE;      -- Re-lanzar la excepción para su manejo
    END Consultar_PlataformaMasVista;
    
    -- Procedimiento para consultar las vistas de una plataforma
    PROCEDURE Consultar_VistasPlataforma(
        Nom_Plataforma IN VARCHAR2,   -- Nombre de la plataforma que se desea consultar
        Resultado OUT SYS_REFCURSOR   -- Cursor de salida con el resultado
    ) IS
        v_Numero_plataforma NUMBER;   -- Variable para almacenar el número de la plataforma
    BEGIN
        -- Obtener el número de la plataforma basada en su nombre
        SELECT Numero_plataforma 
        INTO v_Numero_plataforma
        FROM Plataformas
        WHERE Nombre = Nom_Plataforma;
    
        -- Abrir el cursor para obtener las visualizaciones totales de la plataforma
        OPEN Resultado FOR
        SELECT PL.Nombre AS Plataforma,
               SUM(NVL(S.Visualizacion, 0) + NVL(P.Visualizacion, 0)) AS Total_Visualizaciones
        FROM ContenidosXPlataformas CP
        JOIN Plataformas PL ON CP.Numero_plataforma = PL.Numero_plataforma
        JOIN Contenidos C ON CP.Codigo_contenido = C.Codigo
        LEFT JOIN Series S ON C.Codigo = S.Codigo_contenido  -- Asociamos las series
        LEFT JOIN Peliculas P ON C.Codigo = P.Codigo_contenido  -- Asociamos las películas
        WHERE PL.Numero_plataforma = v_Numero_plataforma
        GROUP BY PL.Nombre
        ORDER BY Total_Visualizaciones DESC;
    
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- En caso de error, revertir cualquier cambio
            RAISE;      -- Re-lanzar la excepción para su manejo
    END Consultar_VistasPlataforma;
    
    -- Procedimiento para consultar contenidos con reseñas positivas
    PROCEDURE Consultar_ContenidosReseñasPositivas(
        Resultado OUT SYS_REFCURSOR  -- Cursor de salida con el resultado
    ) IS
    BEGIN
        -- Abrir el cursor para obtener los contenidos con valoraciones positivas
        OPEN Resultado FOR
        SELECT C.Nombre AS Contenido,
               V.Descripcion AS Reseña,
               V.Valoracion AS Valoracion
        FROM Valoraciones V
        JOIN Contenidos C ON V.Codigo_contenido = C.Codigo
        WHERE V.Valoracion >= 4  -- Umbral de valoración positiva
        ORDER BY V.Valoracion DESC;  -- Ordenamos de mayor a menor valoración
    
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;  -- En caso de error, revertir cualquier cambio
            RAISE;      -- Re-lanzar la excepción para su manejo
    END Consultar_ContenidosReseñasPositivas;


END PK_GERENTE;



CREATE ROLE ASISTENTE_DE_GERENCIA;
GRANT EXECUTE ON PK_ASISTENTE_DE_GERENCIA TO ASISTENTE_DE_GERENCIA;

--U_ESTANDAR
CREATE ROLE U_ESTANDAR;
-- Permisos del paquete PC_USUARIOS
GRANT EXECUTE ON PK_U_ESTANDAR TO U_ESTANDAR;


--EMPRESA
CREATE ROLE EMPRESA;
-- Permisos del paquete PC_USUARIOS
GRANT EXECUTE ON PK_EMPRESA TO EMPRESA;


--GERENTE
CREATE ROLE GERENTE;
-- Permisos del paquete PC_USUARIOS
GRANT EXECUTE ON PK_GERENTE TO GERENTE;



--REVOCAR PERMISOS
-- ASISTENTE_DE_GERENCIA
REVOKE EXECUTE ON PK_ASISTENTE_DE_GERENCIA FROM ASISTENTE_DE_GERENCIA;

-- U_ESTANDAR
REVOKE EXECUTE ON PK_U_ESTANDAR FROM U_ESTANDAR;

-- EMPRESA
REVOKE EXECUTE ON PK_EMPRESA FROM EMPRESA;


-- GERENTE
REVOKE EXECUTE ON PK_GERENTE FROM GERENTE;


