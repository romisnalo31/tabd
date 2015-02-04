--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: articulo; Type: TABLE; Schema: public; Owner: mercado; Tablespace: 
--

CREATE TABLE articulo (
    id integer NOT NULL,
    nombre character varying(100),
    precio money,
    estado integer NOT NULL,
    descripcion character varying(100),
    categoria integer NOT NULL,
    vendedor character varying(30) NOT NULL
);


ALTER TABLE public.articulo OWNER TO mercado;

--
-- Name: articulo_id_seq; Type: SEQUENCE; Schema: public; Owner: mercado
--

CREATE SEQUENCE articulo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.articulo_id_seq OWNER TO mercado;

--
-- Name: articulo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mercado
--

ALTER SEQUENCE articulo_id_seq OWNED BY articulo.id;


--
-- Name: categoria; Type: TABLE; Schema: public; Owner: mercado; Tablespace: 
--

CREATE TABLE categoria (
    cvecategoria integer NOT NULL,
    descripcion character varying(20)
);


ALTER TABLE public.categoria OWNER TO mercado;

--
-- Name: estadoarticulo; Type: TABLE; Schema: public; Owner: mercado; Tablespace: 
--

CREATE TABLE estadoarticulo (
    cveedoarti integer NOT NULL,
    descripcion character varying(20)
);


ALTER TABLE public.estadoarticulo OWNER TO mercado;

--
-- Name: articuloscomputo; Type: VIEW; Schema: public; Owner: mercado
--

CREATE VIEW articuloscomputo AS
 SELECT articulo.nombre,
    articulo.precio,
    estadoarticulo.descripcion AS estado,
    articulo.descripcion,
    categoria.descripcion AS categoria
   FROM ((articulo
     JOIN estadoarticulo ON ((estadoarticulo.cveedoarti = articulo.estado)))
     JOIN categoria ON ((articulo.categoria = categoria.cvecategoria)))
  WHERE (articulo.categoria IN ( SELECT categoria_1.cvecategoria
           FROM categoria categoria_1
          WHERE ((categoria_1.descripcion)::text = 'Computacion'::text)));


ALTER TABLE public.articuloscomputo OWNER TO mercado;

--
-- Name: articulosmaverick; Type: VIEW; Schema: public; Owner: mercado
--

CREATE VIEW articulosmaverick AS
 SELECT articulo.nombre,
    articulo.precio,
    estadoarticulo.descripcion AS estado,
    articulo.descripcion,
    categoria.descripcion AS categoria
   FROM ((articulo
     JOIN estadoarticulo ON ((articulo.estado = estadoarticulo.cveedoarti)))
     JOIN categoria ON ((articulo.categoria = categoria.cvecategoria)))
  WHERE ((articulo.vendedor)::text = 'Maverick'::text);


ALTER TABLE public.articulosmaverick OWNER TO mercado;

--
-- Name: categoria_cvecategoria_seq; Type: SEQUENCE; Schema: public; Owner: mercado
--

CREATE SEQUENCE categoria_cvecategoria_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categoria_cvecategoria_seq OWNER TO mercado;

--
-- Name: categoria_cvecategoria_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mercado
--

ALTER SEQUENCE categoria_cvecategoria_seq OWNED BY categoria.cvecategoria;


--
-- Name: clastransaccion; Type: TABLE; Schema: public; Owner: mercado; Tablespace: 
--

CREATE TABLE clastransaccion (
    cveclastran integer NOT NULL,
    descripcion character varying(30)
);


ALTER TABLE public.clastransaccion OWNER TO mercado;

--
-- Name: estadoarticulo_cveedoarti_seq; Type: SEQUENCE; Schema: public; Owner: mercado
--

CREATE SEQUENCE estadoarticulo_cveedoarti_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.estadoarticulo_cveedoarti_seq OWNER TO mercado;

--
-- Name: estadoarticulo_cveedoarti_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mercado
--

ALTER SEQUENCE estadoarticulo_cveedoarti_seq OWNED BY estadoarticulo.cveedoarti;


--
-- Name: estadosubasta; Type: TABLE; Schema: public; Owner: mercado; Tablespace: 
--

CREATE TABLE estadosubasta (
    cveedosuba integer NOT NULL,
    descripcion character varying(30)
);


ALTER TABLE public.estadosubasta OWNER TO mercado;

--
-- Name: estadotransaccion; Type: TABLE; Schema: public; Owner: mercado; Tablespace: 
--

CREATE TABLE estadotransaccion (
    cveedotran integer NOT NULL,
    descripcion character varying(20)
);


ALTER TABLE public.estadotransaccion OWNER TO mercado;

--
-- Name: estadotransaccion_cveedotran_seq; Type: SEQUENCE; Schema: public; Owner: mercado
--

CREATE SEQUENCE estadotransaccion_cveedotran_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.estadotransaccion_cveedotran_seq OWNER TO mercado;

--
-- Name: estadotransaccion_cveedotran_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mercado
--

ALTER SEQUENCE estadotransaccion_cveedotran_seq OWNED BY estadotransaccion.cveedotran;


--
-- Name: usuario; Type: TABLE; Schema: public; Owner: mercado; Tablespace: 
--

CREATE TABLE usuario (
    seudonimo character varying(30) NOT NULL,
    "contraseña" character varying(20),
    correo character varying(100),
    nombre character varying(30),
    pais character varying(30),
    repuvendedor integer,
    repucomprador integer
);


ALTER TABLE public.usuario OWNER TO mercado;

--
-- Name: reputacionmaverick; Type: VIEW; Schema: public; Owner: mercado
--

CREATE VIEW reputacionmaverick AS
 SELECT usuario.seudonimo,
    usuario.repuvendedor AS "Reputación como Vendedor",
    usuario.repucomprador AS "Reputación como Comprador"
   FROM usuario
  WHERE ((usuario.seudonimo)::text = 'Maverick'::text);


ALTER TABLE public.reputacionmaverick OWNER TO mercado;

--
-- Name: subasta; Type: TABLE; Schema: public; Owner: mercado; Tablespace: 
--

CREATE TABLE subasta (
    numsubasta integer NOT NULL,
    fechainicio date,
    fechatermino date,
    estado integer NOT NULL
);


ALTER TABLE public.subasta OWNER TO mercado;

--
-- Name: subasta_numsubasta_seq; Type: SEQUENCE; Schema: public; Owner: mercado
--

CREATE SEQUENCE subasta_numsubasta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.subasta_numsubasta_seq OWNER TO mercado;

--
-- Name: subasta_numsubasta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mercado
--

ALTER SEQUENCE subasta_numsubasta_seq OWNED BY subasta.numsubasta;


--
-- Name: transaccion; Type: TABLE; Schema: public; Owner: mercado; Tablespace: 
--

CREATE TABLE transaccion (
    seudonimo character varying(30) NOT NULL,
    idarticulo integer NOT NULL,
    tipo integer NOT NULL,
    estado integer NOT NULL,
    fecha date,
    clase integer,
    numesubasta integer
);


ALTER TABLE public.transaccion OWNER TO mercado;

--
-- Name: subastasporterminar; Type: VIEW; Schema: public; Owner: mercado
--

CREATE VIEW subastasporterminar AS
 SELECT DISTINCT articulo.nombre,
    subasta.fechainicio,
    subasta.fechatermino,
    estadosubasta.descripcion AS estado
   FROM (((articulo
     JOIN transaccion ON ((articulo.id = transaccion.idarticulo)))
     JOIN subasta ON ((transaccion.numesubasta = subasta.numsubasta)))
     JOIN estadosubasta ON ((estadosubasta.cveedosuba = subasta.estado)));


ALTER TABLE public.subastasporterminar OWNER TO mercado;

--
-- Name: tipotransaccion; Type: TABLE; Schema: public; Owner: mercado; Tablespace: 
--

CREATE TABLE tipotransaccion (
    cvetipotran integer NOT NULL,
    descripcion character varying(20)
);


ALTER TABLE public.tipotransaccion OWNER TO mercado;

--
-- Name: tipotransaccion_cvetipotran_seq; Type: SEQUENCE; Schema: public; Owner: mercado
--

CREATE SEQUENCE tipotransaccion_cvetipotran_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tipotransaccion_cvetipotran_seq OWNER TO mercado;

--
-- Name: tipotransaccion_cvetipotran_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mercado
--

ALTER SEQUENCE tipotransaccion_cvetipotran_seq OWNED BY tipotransaccion.cvetipotran;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mercado
--

ALTER TABLE ONLY articulo ALTER COLUMN id SET DEFAULT nextval('articulo_id_seq'::regclass);


--
-- Name: cvecategoria; Type: DEFAULT; Schema: public; Owner: mercado
--

ALTER TABLE ONLY categoria ALTER COLUMN cvecategoria SET DEFAULT nextval('categoria_cvecategoria_seq'::regclass);


--
-- Name: cveedoarti; Type: DEFAULT; Schema: public; Owner: mercado
--

ALTER TABLE ONLY estadoarticulo ALTER COLUMN cveedoarti SET DEFAULT nextval('estadoarticulo_cveedoarti_seq'::regclass);


--
-- Name: cveedotran; Type: DEFAULT; Schema: public; Owner: mercado
--

ALTER TABLE ONLY estadotransaccion ALTER COLUMN cveedotran SET DEFAULT nextval('estadotransaccion_cveedotran_seq'::regclass);


--
-- Name: numsubasta; Type: DEFAULT; Schema: public; Owner: mercado
--

ALTER TABLE ONLY subasta ALTER COLUMN numsubasta SET DEFAULT nextval('subasta_numsubasta_seq'::regclass);


--
-- Name: cvetipotran; Type: DEFAULT; Schema: public; Owner: mercado
--

ALTER TABLE ONLY tipotransaccion ALTER COLUMN cvetipotran SET DEFAULT nextval('tipotransaccion_cvetipotran_seq'::regclass);


--
-- Data for Name: articulo; Type: TABLE DATA; Schema: public; Owner: mercado
--

COPY articulo (id, nombre, precio, estado, descripcion, categoria, vendedor) FROM stdin;
4	Laptop	$ 100.00	3	Esta chida-lira	2	romisnalo
6	Playera	$ 50.00	3	Esta chida-lira	3	peeleto
8	Licuadora	$ 150.00	3	Buena para los licuados	1	coconutfest
9	Taladro	$ 275.00	4	Es mi mejor amigo :)	6	peeleto
10	Figura Batman	$ 1,500.00	4	Es original, lo juro	4	romisnalo
7	iPhone 5s	$ 5,100.00	4	En perfecto estado	5	coconutfest
12	Pony	$ 129.00	3	Está bonis	4	Maverick
14	Martillo	$ 129.00	4	Está fuerte	6	Maverick
\.


--
-- Name: articulo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mercado
--

SELECT pg_catalog.setval('articulo_id_seq', 14, true);


--
-- Data for Name: categoria; Type: TABLE DATA; Schema: public; Owner: mercado
--

COPY categoria (cvecategoria, descripcion) FROM stdin;
1	Electronica
2	Computacion
3	Ropa
4	Coleccionables
5	Telefonia
6	Industria
\.


--
-- Name: categoria_cvecategoria_seq; Type: SEQUENCE SET; Schema: public; Owner: mercado
--

SELECT pg_catalog.setval('categoria_cvecategoria_seq', 6, true);


--
-- Data for Name: clastransaccion; Type: TABLE DATA; Schema: public; Owner: mercado
--

COPY clastransaccion (cveclastran, descripcion) FROM stdin;
1	Tradicional
2	Subasta
\.


--
-- Data for Name: estadoarticulo; Type: TABLE DATA; Schema: public; Owner: mercado
--

COPY estadoarticulo (cveedoarti, descripcion) FROM stdin;
3	Nuevo
4	usado
\.


--
-- Name: estadoarticulo_cveedoarti_seq; Type: SEQUENCE SET; Schema: public; Owner: mercado
--

SELECT pg_catalog.setval('estadoarticulo_cveedoarti_seq', 4, true);


--
-- Data for Name: estadosubasta; Type: TABLE DATA; Schema: public; Owner: mercado
--

COPY estadosubasta (cveedosuba, descripcion) FROM stdin;
1	Iniciada
2	Por terminar
3	Terminada
\.


--
-- Data for Name: estadotransaccion; Type: TABLE DATA; Schema: public; Owner: mercado
--

COPY estadotransaccion (cveedotran, descripcion) FROM stdin;
1	En proceso
2	Finalizada
\.


--
-- Name: estadotransaccion_cveedotran_seq; Type: SEQUENCE SET; Schema: public; Owner: mercado
--

SELECT pg_catalog.setval('estadotransaccion_cveedotran_seq', 2, true);


--
-- Data for Name: subasta; Type: TABLE DATA; Schema: public; Owner: mercado
--

COPY subasta (numsubasta, fechainicio, fechatermino, estado) FROM stdin;
1	2015-01-31	2015-02-04	2
\.


--
-- Name: subasta_numsubasta_seq; Type: SEQUENCE SET; Schema: public; Owner: mercado
--

SELECT pg_catalog.setval('subasta_numsubasta_seq', 1, true);


--
-- Data for Name: tipotransaccion; Type: TABLE DATA; Schema: public; Owner: mercado
--

COPY tipotransaccion (cvetipotran, descripcion) FROM stdin;
1	Compra
2	Venta
\.


--
-- Name: tipotransaccion_cvetipotran_seq; Type: SEQUENCE SET; Schema: public; Owner: mercado
--

SELECT pg_catalog.setval('tipotransaccion_cvetipotran_seq', 2, true);


--
-- Data for Name: transaccion; Type: TABLE DATA; Schema: public; Owner: mercado
--

COPY transaccion (seudonimo, idarticulo, tipo, estado, fecha, clase, numesubasta) FROM stdin;
romisnalo	4	2	1	2015-01-31	1	\N
coconutfest	7	1	2	2015-01-31	1	\N
peeleto	4	2	1	2015-01-31	1	\N
romisnalo	6	1	2	2015-01-31	2	1
coconutfest	6	2	1	2015-01-31	2	1
\.


--
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: mercado
--

COPY usuario (seudonimo, "contraseña", correo, nombre, pais, repuvendedor, repucomprador) FROM stdin;
romisnalo	1234	romis_nalo@hotmail.com	R.Navarro	Mexico	3	5
peeleto	1234	peeleto@gmail.com	D. Lopez	Chile	1	2
coconutfest	1234	coconutfest31@yahoo.com.mx	C. Leon	Peru	4	4
Maverick	1234	maverick@hotmail.com	R. Martinez	Colombia	5	1
\.


--
-- Name: articulopk; Type: CONSTRAINT; Schema: public; Owner: mercado; Tablespace: 
--

ALTER TABLE ONLY articulo
    ADD CONSTRAINT articulopk PRIMARY KEY (id);


--
-- Name: categoriapk; Type: CONSTRAINT; Schema: public; Owner: mercado; Tablespace: 
--

ALTER TABLE ONLY categoria
    ADD CONSTRAINT categoriapk PRIMARY KEY (cvecategoria);


--
-- Name: clastransaccionpk; Type: CONSTRAINT; Schema: public; Owner: mercado; Tablespace: 
--

ALTER TABLE ONLY clastransaccion
    ADD CONSTRAINT clastransaccionpk PRIMARY KEY (cveclastran);


--
-- Name: estadoarticulopk; Type: CONSTRAINT; Schema: public; Owner: mercado; Tablespace: 
--

ALTER TABLE ONLY estadoarticulo
    ADD CONSTRAINT estadoarticulopk PRIMARY KEY (cveedoarti);


--
-- Name: estadosubastapk; Type: CONSTRAINT; Schema: public; Owner: mercado; Tablespace: 
--

ALTER TABLE ONLY estadosubasta
    ADD CONSTRAINT estadosubastapk PRIMARY KEY (cveedosuba);


--
-- Name: estadotransaccionpk; Type: CONSTRAINT; Schema: public; Owner: mercado; Tablespace: 
--

ALTER TABLE ONLY estadotransaccion
    ADD CONSTRAINT estadotransaccionpk PRIMARY KEY (cveedotran);


--
-- Name: subastapk; Type: CONSTRAINT; Schema: public; Owner: mercado; Tablespace: 
--

ALTER TABLE ONLY subasta
    ADD CONSTRAINT subastapk PRIMARY KEY (numsubasta);


--
-- Name: tipotransaccionpk; Type: CONSTRAINT; Schema: public; Owner: mercado; Tablespace: 
--

ALTER TABLE ONLY tipotransaccion
    ADD CONSTRAINT tipotransaccionpk PRIMARY KEY (cvetipotran);


--
-- Name: tranpk; Type: CONSTRAINT; Schema: public; Owner: mercado; Tablespace: 
--

ALTER TABLE ONLY transaccion
    ADD CONSTRAINT tranpk PRIMARY KEY (seudonimo, idarticulo);


--
-- Name: usuariopk; Type: CONSTRAINT; Schema: public; Owner: mercado; Tablespace: 
--

ALTER TABLE ONLY usuario
    ADD CONSTRAINT usuariopk PRIMARY KEY (seudonimo);


--
-- Name: articulofk1; Type: FK CONSTRAINT; Schema: public; Owner: mercado
--

ALTER TABLE ONLY articulo
    ADD CONSTRAINT articulofk1 FOREIGN KEY (estado) REFERENCES estadoarticulo(cveedoarti);


--
-- Name: articulofk2; Type: FK CONSTRAINT; Schema: public; Owner: mercado
--

ALTER TABLE ONLY articulo
    ADD CONSTRAINT articulofk2 FOREIGN KEY (categoria) REFERENCES categoria(cvecategoria);


--
-- Name: articulofk3; Type: FK CONSTRAINT; Schema: public; Owner: mercado
--

ALTER TABLE ONLY articulo
    ADD CONSTRAINT articulofk3 FOREIGN KEY (vendedor) REFERENCES usuario(seudonimo);


--
-- Name: subastafk; Type: FK CONSTRAINT; Schema: public; Owner: mercado
--

ALTER TABLE ONLY subasta
    ADD CONSTRAINT subastafk FOREIGN KEY (estado) REFERENCES estadosubasta(cveedosuba);


--
-- Name: tranfk1; Type: FK CONSTRAINT; Schema: public; Owner: mercado
--

ALTER TABLE ONLY transaccion
    ADD CONSTRAINT tranfk1 FOREIGN KEY (seudonimo) REFERENCES usuario(seudonimo);


--
-- Name: tranfk2; Type: FK CONSTRAINT; Schema: public; Owner: mercado
--

ALTER TABLE ONLY transaccion
    ADD CONSTRAINT tranfk2 FOREIGN KEY (idarticulo) REFERENCES articulo(id);


--
-- Name: tranfk3; Type: FK CONSTRAINT; Schema: public; Owner: mercado
--

ALTER TABLE ONLY transaccion
    ADD CONSTRAINT tranfk3 FOREIGN KEY (estado) REFERENCES estadotransaccion(cveedotran);


--
-- Name: tranfk4; Type: FK CONSTRAINT; Schema: public; Owner: mercado
--

ALTER TABLE ONLY transaccion
    ADD CONSTRAINT tranfk4 FOREIGN KEY (tipo) REFERENCES tipotransaccion(cvetipotran);


--
-- Name: transaccionfkclase; Type: FK CONSTRAINT; Schema: public; Owner: mercado
--

ALTER TABLE ONLY transaccion
    ADD CONSTRAINT transaccionfkclase FOREIGN KEY (clase) REFERENCES clastransaccion(cveclastran);


--
-- Name: trnsaccionfksubasta; Type: FK CONSTRAINT; Schema: public; Owner: mercado
--

ALTER TABLE ONLY transaccion
    ADD CONSTRAINT trnsaccionfksubasta FOREIGN KEY (numesubasta) REFERENCES subasta(numsubasta);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

