--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.3
-- Dumped by pg_dump version 9.5.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

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
-- Name: category; Type: TABLE; Schema: public; Owner: crud
--

CREATE TABLE category (
    id integer NOT NULL,
    name character varying(120)
);


ALTER TABLE category OWNER TO crud;

--
-- Name: category_id_seq; Type: SEQUENCE; Schema: public; Owner: crud
--

CREATE SEQUENCE category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE category_id_seq OWNER TO crud;

--
-- Name: category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: crud
--

ALTER SEQUENCE category_id_seq OWNED BY category.id;


--
-- Name: item; Type: TABLE; Schema: public; Owner: crud
--

CREATE TABLE item (
    id integer NOT NULL,
    name character varying(120),
    "desc" character varying(500),
    cat_name character varying(120)
);


ALTER TABLE item OWNER TO crud;

--
-- Name: item_id_seq; Type: SEQUENCE; Schema: public; Owner: crud
--

CREATE SEQUENCE item_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE item_id_seq OWNER TO crud;

--
-- Name: item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: crud
--

ALTER SEQUENCE item_id_seq OWNED BY item.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: crud
--

ALTER TABLE ONLY category ALTER COLUMN id SET DEFAULT nextval('category_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: crud
--

ALTER TABLE ONLY item ALTER COLUMN id SET DEFAULT nextval('item_id_seq'::regclass);


--
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: crud
--

COPY category (id, name) FROM stdin;
1	Soccer
2	Basketball
3	Baseball
4	Frisbee
5	Snowboarding
6	Rock Climbing
7	Foosball
8	Skating
9	Hockey
\.


--
-- Name: category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: crud
--

SELECT pg_catalog.setval('category_id_seq', 10, true);


--
-- Data for Name: item; Type: TABLE DATA; Schema: public; Owner: crud
--

COPY item (id, name, "desc", cat_name) FROM stdin;
6	Stick	Yup	Hockey
7	Half Court	Half Court	Basketball
8	Full Court	Full Court Play	Basketball
2	Snowboard	Yes i Know	Snowboarding
5	Soccer	This is a Good shit	Soccer
\.


--
-- Name: item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: crud
--

SELECT pg_catalog.setval('item_id_seq', 8, true);


--
-- Name: category_name_key; Type: CONSTRAINT; Schema: public; Owner: crud
--

ALTER TABLE ONLY category
    ADD CONSTRAINT category_name_key UNIQUE (name);


--
-- Name: category_pkey; Type: CONSTRAINT; Schema: public; Owner: crud
--

ALTER TABLE ONLY category
    ADD CONSTRAINT category_pkey PRIMARY KEY (id);


--
-- Name: item_name_key; Type: CONSTRAINT; Schema: public; Owner: crud
--

ALTER TABLE ONLY item
    ADD CONSTRAINT item_name_key UNIQUE (name);


--
-- Name: item_pkey; Type: CONSTRAINT; Schema: public; Owner: crud
--

ALTER TABLE ONLY item
    ADD CONSTRAINT item_pkey PRIMARY KEY (id);


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

