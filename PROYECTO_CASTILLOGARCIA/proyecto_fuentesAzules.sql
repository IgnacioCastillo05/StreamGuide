-----Proyecto StreamGuide

----Ignacio Andrés Castillo Rendón
----Anderson Fabián García Nieto

----Fuentes Azules: Tablas y XTablas


Create table Contenidos(
    Codigo VARCHAR2(10) NOT NULL,
    Tipo VARCHAR2(1) NOT NULL,
    Nombre VARCHAR2(50) NOT NULL,
    Rating NUMBER NOT NULL,
    Reseña VARCHAR2(100) NOT NULL
);
/

Create table Peliculas(
    Codigo_contenido VARCHAR2(10) NULL,
    N_pelicula NUMBER NOT NULL,
    Duracion VARCHAR2(5) NOT NULL,
    Ano DATE NOT NULL,
    Genero VARCHAR2(5) NOT NULL,
    Visualizacion NUMBER
);
/

Create table Sagas(
    Codigo_pelicula VARCHAR2(10) NOT NULL,
    Nombre_saga VARCHAR2(50) NOT NULL,
    N_peliculas NUMBER NOT NULL
);
/

Create table Series(
    Codigo_contenido VARCHAR2(10) NOT NULL,
    N_serie NUMBER NOT NULL,
    Ano_inicio DATE NOT NULL,
    Ano_final DATE NULL,
    Genero VARCHAR2(2) NOT NULL,
    Estado VARCHAR2 (1) NOT NULL,
    Visualizacion NUMBER
);
/

Create table Capitulos(
    Codigo_serie VARCHAR2(10) NOT NULL,
    N_capitulo NUMBER NOT NULL,
    Nombre VARCHAR(50) NOT NULL
);
/

Create table Temporadas(
    Codigo_serie VARCHAR2(10) NOT NULL,
    N_temporada NUMBER NOT NULL,
    Descripcion VARCHAR2(100) NOT NULL
);
/

Create table Plataformas(
    Numero_plataforma NUMBER NOT NULL,
    Nombre VARCHAR2(50) NOT NULL,
    Precio NUMBER NOT NULL
);
/

Create table ContenidosXPlataformas(
    Codigo_contenido VARCHAR2(10) NOT NULL,
    Numero_plataforma NUMBER NOT NULL
);
/


Create table Usuarios(
    N_usuario NUMBER NOT NULL,
    NombreUsuario VARCHAR2(50) NOT NULL,
    Contacto1 VARCHAR2(10) NOT NULL,
    Contacto2 VARCHAR2(10) NULL,
    RazonSocial XMLTYPE NULL,
    Contraseña VARCHAR2(8) NOT NULL
);
/

Create table ContenidosXUsuarios(
    Codigo_contenido VARCHAR2(10) NOT NULL,
    N_usuario NUMBER NOT NULL
);
/

Create table Alertas(
    N_alerta NUMBER NOT NULL,
    N_usuarioU NUMBER NOT NULL,
    Descripcion VARCHAR2(100) NOT NULL,
    fechaAlerta DATE NOT NULL
);
/

Create table Empresas(
    N_usuario NUMBER NOT NULL,
    NIT VARCHAR2(10) NOT NULL,
    RazonSocial XMLTYPE NOT NULL,
    Nombre_representante VARCHAR2(50) NOT NULL,
    Telefono VARCHAR2(10) NOT NULL,
    Telefono_representante VARCHAR2(10) NOT NULL
);
/


CREATE TABLE UsuariosEstandar(
    N_usuarioU NUMBER NOT NULL,
    Cedula VARCHAR2(10) NOT NULL,
    Telefono VARCHAR2(10) NULL,
    Edad NUMBER NOT NULL
);
/


CREATE TABLE Correos(
    Correo VARCHAR2(50) NOT NULL,
    N_usuarioE NUMBER NOT NULL,
    Cedula_usuarioE VARCHAR2(10) NOT NULL
);
/

CREATE TABLE Valoraciones(
    N_usuarioE NUMBER NOT NULL,
    Cedula_usuarioE VARCHAR2(10) NOT NULL,
    Codigo_contenido VARCHAR2(10) NOT NULL,
    Codigo VARCHAR2(50) NOT NULL,
    Descripcion VARCHAR2(100) NOT NULL,
    Valoracion NUMBER NOT NULL,
    fecha_valoracion DATE NOT NULL
);
/


CREATE TABLE Actualizaciones(
    N_actualizacion NUMBER NOT NULL,
    Descripcion VARCHAR2(100) NOT NULL,
    Estado VARCHAR2(1) NOT NULL,
    N_usuarioE NUMBER NOT NULL,
    Cedula_usuarioE VARCHAR2(10) NOT NULL,
    N_recompensas NUMBER NOT NULL
);
/


CREATE TABLE SistemasRecompensa(
    N_recompensa NUMBER NOT NULL,
    Descripcion VARCHAR2(100) NOT NULL,
    Tipo VARCHAR(1) NOT NULL
);
/

CREATE TABLE Personas(
    Cedula VARCHAR2(10) NOT NULL,
    Nombre VARCHAR2(50) NOT NULL,
    Edad NUMBER NOT NULL,
    Nacionalidad VARCHAR2(20) NOT NULL,
    f_nacimiento DATE NOT NULL,
    f_fallecimiento DATE NULL,
    Genero VARCHAR2(1) NOT NULL
);
/


CREATE TABLE Reconocimientos(
    N_nominacion NUMBER NOT NULL,
    Nominacion VARCHAR2(50) NULL,
    Estado VARCHAR2(1) NOT NULL
);
/


CREATE TABLE PersonasXReconocimientos(
    N_nominacion NUMBER NOT NULL,
    Cedula_persona VARCHAR2(10) NOT NULL
);
/



CREATE TABLE Actores(
    Cedula_persona VARCHAR2(10) NOT NULL,
    Altura FLOAT NOT NULL,
    Formacion VARCHAR2(100) NOT NULL
);
/


CREATE TABLE Casting(
    Cedula_actor VARCHAR2(10) NOT NULL,
    Codigo_contenido VARCHAR2(10) NOT NULL,
    Nombre_personaje VARCHAR2(50) NOT NULL,
    Rol NUMBER NOT NULL,
    Tiempo_participacion VARCHAR2(5) NOT NULL,
    Sueldo FLOAT NOT NULL
);
/


CREATE TABLE Directores(
    Cedula_persona VARCHAR2(10) NOT NULL,
    Genero_pref VARCHAR2(2) NOT NULL,
    Productora_afiliada VARCHAR(20) NOT NULL
);
/


CREATE TABLE Dirigidos(
    Cedula_directores VARCHAR2(10) NOT NULL,
    Codigo_contenido VARCHAR2(10) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_final DATE NOT NULL
);
/


-----PK-------

ALTER TABLE Contenidos
ADD CONSTRAINT PK_CONTENIDOS PRIMARY KEY(Codigo);

ALTER TABLE Peliculas
ADD CONSTRAINT PK_PELICULAS PRIMARY KEY (Codigo_contenido);

ALTER TABLE Sagas 
ADD CONSTRAINT PK_SAGAS PRIMARY KEY (Codigo_pelicula);

ALTER TABLE Series
ADD CONSTRAINT PK_SERIES PRIMARY KEY (Codigo_contenido);

ALTER TABLE Capitulos 
ADD CONSTRAINT PK_CAPITULOS PRIMARY KEY (Codigo_serie);

ALTER TABLE Temporadas
ADD CONSTRAINT PK_TEMPORADAS PRIMARY KEY (Codigo_serie);

ALTER TABLE Plataformas
ADD CONSTRAINT PK_PLATAFORMAS PRIMARY KEY (Numero_plataforma);

ALTER TABLE ContenidosXPlataformas
ADD CONSTRAINT PK_CONXPLA PRIMARY KEY (Codigo_contenido, Numero_plataforma);

ALTER TABLE Usuarios
ADD CONSTRAINT PK_USUARIOS PRIMARY KEY (N_usuario);

ALTER TABLE ContenidosXUsuarios
ADD CONSTRAINT PK_CONXUS PRIMARY KEY (Codigo_contenido, N_usuario);

ALTER TABLE Alertas
ADD CONSTRAINT PK_ALERTAS PRIMARY KEY (N_alerta);

ALTER TABLE Empresas
ADD CONSTRAINT PK_EMPRESAS PRIMARY KEY (N_usuario, NIT);

ALTER TABLE UsuariosEstandar
ADD CONSTRAINT PK_USUARIOSE PRIMARY KEY (N_usuarioU, Cedula);

ALTER TABLE Correos
ADD CONSTRAINT PK_CORREOS PRIMARY KEY (Correo);

ALTER TABLE Actualizaciones
ADD CONSTRAINT PK_ACTUALIZACIONES PRIMARY KEY (N_actualizacion);

ALTER TABLE SistemasRecompensa
ADD CONSTRAINT PK_RECOMPENSAS PRIMARY KEY (N_recompensa);

ALTER TABLE Valoraciones
ADD CONSTRAINT PK_VALORACIONES PRIMARY KEY (N_usuarioE, Cedula_usuarioE, Codigo_contenido);

ALTER TABLE Personas
ADD CONSTRAINT PK_PERSONAS PRIMARY KEY (Cedula);

ALTER TABLE Reconocimientos
ADD CONSTRAINT PK_RECONOCIMIENTOS PRIMARY KEY (N_nominacion);

ALTER TABLE PersonasXReconocimientos
ADD CONSTRAINT PK_PERXREC PRIMARY KEY (Cedula_persona, N_nominacion);

ALTER TABLE Actores
ADD CONSTRAINT PK_ACTORES PRIMARY KEY (Cedula_persona);

ALTER TABLE Casting
ADD CONSTRAINT PK_CASTING PRIMARY KEY (Cedula_actor, Codigo_contenido);

ALTER TABLE Directores
ADD CONSTRAINT PK_DIRECTORES PRIMARY KEY (Cedula_persona);

ALTER TABLE Dirigidos
ADD CONSTRAINT PK_DIRIGIDOS PRIMARY KEY (Cedula_directores, Codigo_contenido);



-----UK---------

ALTER TABLE Personas
ADD CONSTRAINT UK_PERSONANOMBRE UNIQUE (Nombre);

ALTER TABLE Usuarios
ADD CONSTRAINT UK_USUARIONOMBRE UNIQUE (NombreUsuario);

ALTER TABLE Empresas
ADD CONSTRAINT UK_EMPRESATELF UNIQUE (Telefono);

ALTER TABLE Empresas
ADD CONSTRAINT UK_EMPRESATELFREP UNIQUE (Telefono_representante);

ALTER TABLE UsuariosEstandar
ADD CONSTRAINT UK_USUARIOETELF UNIQUE (Telefono);


--------FK---------------

---GC Contenidos

ALTER TABLE Peliculas
ADD CONSTRAINT FK_CONTENIDO_PELICULA FOREIGN KEY (Codigo_contenido) references Contenidos(Codigo);

ALTER TABLE Sagas
ADD CONSTRAINT FK_SAGA_PELICULA FOREIGN KEY (Codigo_pelicula) references Peliculas(Codigo_contenido);

ALTER TABLE Series
ADD CONSTRAINT FK_CONTENIDO_SERIE FOREIGN KEY (Codigo_contenido) references Contenidos(Codigo);

ALTER TABLE Capitulos
ADD CONSTRAINT FK_SERIE_CAPITULO FOREIGN KEY (Codigo_serie) references Series(Codigo_contenido);

ALTER TABLE Temporadas
ADD CONSTRAINT FK_SERIE_TEMPORADA FOREIGN KEY (Codigo_serie) references Series(Codigo_contenido);

ALTER TABLE ContenidosXPlataformas
ADD CONSTRAINT FK_CONTENIDOSXPLATAFORMAS1 FOREIGN KEY (Codigo_contenido) references Contenidos(Codigo);

ALTER TABLE ContenidosXPlataformas
ADD CONSTRAINT FK_CONTENIDOSXPLATAFORMAS2 FOREIGN KEY (Numero_plataforma) references Plataformas(Numero_plataforma);

---GC Usuarios

ALTER TABLE ContenidosXUsuarios
ADD CONSTRAINT FK_CONTENIDOSXUSUARIOS1 FOREIGN KEY (Codigo_contenido) references Contenidos(Codigo)
ADD CONSTRAINT FK_CONTENIDOSXUSUARIOS2 FOREIGN KEY (N_usuario) references Usuarios(N_usuario);

ALTER TABLE Alertas
ADD CONSTRAINT FK_ALERTAS_USUARIOS FOREIGN KEY (N_usuarioU) references Usuarios(N_usuario);

ALTER TABLE Empresas
ADD CONSTRAINT FK_EMPRESAS_USUARIOS FOREIGN KEY (N_usuario) references Usuarios(N_usuario);

ALTER TABLE UsuariosEstandar
ADD CONSTRAINT FK_USUARIOSE FOREIGN KEY (N_usuarioU) references Usuarios(N_usuario);

ALTER TABLE Correos
ADD CONSTRAINT FK_CORREO_USUARIOE FOREIGN KEY (N_usuarioE, Cedula_usuarioE) references UsuariosEstandar(N_usuarioU, Cedula);

ALTER TABLE Valoraciones
ADD CONSTRAINT FK_VALORACIONES1 FOREIGN KEY (N_usuarioE, Cedula_usuarioE) references UsuariosEstandar(N_usuarioU, Cedula)
ADD CONSTRAINT FK_VALORACIONES2 FOREIGN KEY (Codigo_contenido) references Contenidos(Codigo);

ALTER TABLE Actualizaciones
ADD CONSTRAINT FK_ACTUALIZACIONES1 FOREIGN KEY (N_usuarioE, Cedula_usuarioE) references UsuariosEstandar(N_usuarioU, Cedula)
ADD CONSTRAINT FK_ACTUALIZACIONES2 FOREIGN KEY (N_recompensas) references SistemasRecompensa(N_recompensa);

---GC Personas

ALTER TABLE PersonasXReconocimientos
ADD CONSTRAINT FK_PERSONASXRECONOCIMIENTOS1 FOREIGN KEY (N_nominacion) references Reconocimientos(N_nominacion)
ADD CONSTRAINT FK_PERSONASXRECONOCIMIENTOS2 FOREIGN KEY (Cedula_persona) references Personas(Cedula);

ALTER TABLE Actores
ADD CONSTRAINT FK_ACTOR_PERSONA FOREIGN KEY (Cedula_persona) references Personas(Cedula);

ALTER TABLE Directores
ADD CONSTRAINT FK_DIRECTOR_PERSONA FOREIGN KEY (Cedula_persona) references Personas(Cedula);

ALTER TABLE Casting
ADD CONSTRAINT FK_CASTING1 FOREIGN KEY (Cedula_actor) references Actores(Cedula_persona)
ADD CONSTRAINT FK_CASTING2 FOREIGN KEY (Codigo_contenido) references Contenidos(Codigo);

ALTER TABLE Dirigidos
ADD CONSTRAINT FK_DIRIGIDOS1 FOREIGN KEY (Cedula_directores) references Directores(Cedula_persona)
ADD CONSTRAINT FK_DIRIGIDOS2 FOREIGN KEY (Codigo_contenido) references Contenidos(Codigo);

-- Eliminación de tablas

DROP TABLE Peliculas CASCADE CONSTRAINTS;
DROP TABLE Sagas CASCADE CONSTRAINTS;
DROP TABLE Series CASCADE CONSTRAINTS;
DROP TABLE Capitulos CASCADE CONSTRAINTS;
DROP TABLE Temporadas CASCADE CONSTRAINTS;
DROP TABLE Plataformas CASCADE CONSTRAINTS;
DROP TABLE ContenidosXPlataformas CASCADE CONSTRAINTS;
DROP TABLE ContenidosXUsuarios CASCADE CONSTRAINTS;
DROP TABLE Usuarios CASCADE CONSTRAINTS;
DROP TABLE Alertas CASCADE CONSTRAINTS;
DROP TABLE Empresas CASCADE CONSTRAINTS;
DROP TABLE UsuariosEstandar CASCADE CONSTRAINTS;
DROP TABLE Correos CASCADE CONSTRAINTS;
DROP TABLE Valoraciones CASCADE CONSTRAINTS;
DROP TABLE Actualizaciones CASCADE CONSTRAINTS;
DROP TABLE SistemasRecompensa CASCADE CONSTRAINTS;
DROP TABLE Personas CASCADE CONSTRAINTS;
DROP TABLE Reconocimientos CASCADE CONSTRAINTS;
DROP TABLE PersonasXReconocimientos CASCADE CONSTRAINTS;
DROP TABLE Actores CASCADE CONSTRAINTS;
DROP TABLE Casting CASCADE CONSTRAINTS;
DROP TABLE Directores CASCADE CONSTRAINTS;
DROP TABLE Dirigidos CASCADE CONSTRAINTS;
DROP TABLE Contenidos CASCADE CONSTRAINTS;






SELECT * FROM Contenidos;
SELECT * FROM PELICULAS;
SELECT * FROM SAGAS;
SELECT * FROM SERIES;
SELECT * FROM CAPITULOS;
SELECT * FROM TEMPORADAS;
SELECT * FROM PLATAFORMAS;
SELECT * FROM CONTENIDOSXPLATAFORMAS;
SELECT * FROM CONTENIDOSXUSUARIOS;
SELECT * FROM USUARIOS;
SELECT * FROM ALERTAS;
SELECT * FROM EMPRESAS;
SELECT * FROM USUARIOSTANDAR;
SELECT * FROM CORREOS;
SELECT * FROM VALORACIONES;
SELECT * FROM ACTUALIZACIONES;
SELECT * FROM SISTEMASRECOMPENSA;
SELECT * FROM PERSONAS;
SELECT * FROM RECONOCIMIENTOS;
SELECT * FROM PERSONASXRECONOCIMIENTOS;
SELECT * FROM ACTORES;
SELECT * FROM CASTING;
SELECT * FROM DIRECTORES;
SELECT * FROM DIRIGIDOS;
