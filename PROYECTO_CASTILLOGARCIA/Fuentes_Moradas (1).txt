-------Fuentes moradas

---Vista que muestre al Usuario y la recompensa que se ganó gracias a su actualización
CREATE OR REPLACE VIEW VistaUsuarioRecompensa AS
SELECT 
    U.NombreUsuario,
    SR.Tipo AS TipoRecompensa
FROM 
    Usuarios U
JOIN 
    UsuariosEstandar UE ON U.N_usuario = UE.N_usuarioU
JOIN 
    Actualizaciones A ON UE.N_usuarioU = A.N_usuarioE AND UE.Cedula = A.Cedula_usuarioE
JOIN 
    SistemasRecompensa SR ON A.N_recompensas = SR.N_recompensa;
    
SELECT * FROM VISTAUSUARIORECOMPENSA;

---Vista que muestre el nombre del contenido y el nombre de la plataforma a la que pertenece
CREATE OR REPLACE VIEW Vista_Contenidos_Plataformas AS
SELECT 
    c.Nombre AS Nombre_Contenido,
    p.Nombre AS Nombre_Plataforma
FROM 
    Contenidos c
JOIN 
    ContenidosXPlataformas cxp ON c.Codigo = cxp.Codigo_contenido
JOIN 
    Plataformas p ON cxp.Numero_plataforma = p.Numero_plataforma;
    
SELECT * FROM VISTA_CONTENIDOS_PLATAFORMA;

---Vista que muestre el contenido (nombre), su rating en la plataforma y la valoración dada por usuarios estandar.
CREATE OR REPLACE VIEW Vista_Contenidos_Valoraciones AS
SELECT 
    c.Nombre AS Nombre_Contenido,
    c.Rating AS Rating_Contenido,
    v.Valoracion AS Valoracion_Usuario,
    v.Descripcion AS Comentario_Valoracion,
    v.fecha_valoracion AS Fecha_Valoracion
FROM 
    Contenidos c
LEFT JOIN 
    Valoraciones v ON c.Codigo = v.Codigo_contenido;

SELECT * FROM Vista_Contenidos_Valoraciones;


---
CREATE OR REPLACE VIEW Vista_Personas_Reconocimientos AS
SELECT 
    p.Nombre AS Nombre_Persona,
    r.Nominacion AS Nominacion,
    r.Estado AS Estado_Nominacion
FROM 
    Personas p
JOIN 
    PersonasXReconocimientos pxr ON p.Cedula = pxr.Cedula_persona
JOIN 
    Reconocimientos r ON pxr.N_nominacion = r.N_nominacion;

SELECT * FROM VISTA_PERSONAS_RECONOCIMIENTOS;

--Indice de los nombres de los Usuarios
CREATE INDEX IDX_Nombre_Usuarios 
ON Usuarios(NombreUsuario);


---Indice de los nombres de los contenidos y el tipo de contenidos
CREATE INDEX IDX_Contenidos_Peliculas 
ON Contenidos(Nombre, Tipo);

---Indice para los anexos de Usuarios
CREATE INDEX IDX_Usuarios_RazonSocial 
ON Usuarios(RazonSocial) 
INDEXTYPE IS CTXSYS.CONTEXT 
PARAMETERS ('SYNC (ON COMMIT)');

---Indice de la productora afiliada de los directores
CREATE INDEX IDX_Productora_afiliada ON Directores(Productora_afiliada);

---Indice de los nombres de los personajes por actor
CREATE INDEX IDX_Nombre_personaje ON Casting(Nombre_personaje);


---Indice del nombre de la plataforms
CREATE INDEX IDX_Nombre_Plataforma ON Plataformas(Nombre);

---Indice de los generos de las peliculas
CREATE INDEX IDX_Genero_pelicula ON Peliculas(Genero);

---Indice de los generos de las series
CREATE INDEX IDX_Genero_serie ON Series(Genero);


---Indice para ver las nominaciones y premios de reconocimientos
CREATE INDEX IDX_nominaciones ON Reconocimientos(Nominacion);
----XVistas y XIndices

DROP VIEW VISTAUSUARIORECOMPENSA;
DROP VIEW VISTA_CONTENIDOS_PLATAFORMAS;
DROP VIEW Vista_Contenidos_Valoraciones;
DROP VIEW VISTA_PERSONAS_RECONOCIMIENTOS;

DROP INDEX IDX_Contenidos_Peliculas;
DROP INDEX IDX_Usuarios_RazonSocial;
DROP INDEX IDX_Productora_afiliada;
DROP INDEX IDX_Nombre_personaje;
DROP INDEX IDX_Nombre_Plataforma;
DROP INDEX IDX_Genero_pelicula;
DROP INDEX IDX_Genero_serie;
DROP INDEX IDX_nominaciones;