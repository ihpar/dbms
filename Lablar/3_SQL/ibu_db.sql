--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2


SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 3618 (class 1262 OID 16394)
-- Name: ibu; Type: DATABASE; Schema: -; Owner: -
--

CREATE DATABASE ibu WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = icu LOCALE = 'en_US.UTF-8' ICU_LOCALE = 'en-US';


\connect ibu

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 216 (class 1259 OID 16401)
-- Name: basvurular; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.basvurular (
    ogr_id integer,
    okul_adi character varying(256),
    ana_dal character varying(256),
    sonuc "char"
);


--
-- TOC entry 215 (class 1259 OID 16398)
-- Name: ogrenciler; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ogrenciler (
    ogr_id integer,
    ogr_adi character varying(128),
    ort real,
    lis_mev integer
);


--
-- TOC entry 214 (class 1259 OID 16395)
-- Name: okullar; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.okullar (
    okul_adi character varying(256),
    sehir character varying(64),
    kayit_sayisi integer
);


--
-- TOC entry 3612 (class 0 OID 16401)
-- Dependencies: 216
-- Data for Name: basvurular; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.basvurular VALUES (100, 'Boğaziçi', 'Bilg. Müh.', 'K');
INSERT INTO public.basvurular VALUES (102, 'Ankara', 'Bilg. Müh.', 'K');
INSERT INTO public.basvurular VALUES (102, 'Gazi', 'Elk. Müh.', 'R');
INSERT INTO public.basvurular VALUES (103, 'Ankara', 'Bilg. Müh.', 'K');
INSERT INTO public.basvurular VALUES (104, 'Bilkent', 'Bilg. Müh.', 'R');
INSERT INTO public.basvurular VALUES (105, 'İTÜ', 'Elk. Müh.', 'R');
INSERT INTO public.basvurular VALUES (105, 'Marmara', 'Genetik Müh.', 'K');
INSERT INTO public.basvurular VALUES (106, 'BAİBÜ', 'Bilg. Müh.', 'K');
INSERT INTO public.basvurular VALUES (108, 'Ege', 'Genetik. Müh.', 'K');
INSERT INTO public.basvurular VALUES (108, 'İYTE', 'Biyoloji', 'R');
INSERT INTO public.basvurular VALUES (108, 'Boğaziçi', 'Biyoloji', 'K');
INSERT INTO public.basvurular VALUES (108, 'Ankara', 'İnşaat Müh.', 'R');
INSERT INTO public.basvurular VALUES (109, 'Gazi', 'Bilg. Müh.', 'R');
INSERT INTO public.basvurular VALUES (109, 'Bilkent', 'İşletme', 'K');
INSERT INTO public.basvurular VALUES (110, 'Ege', 'İşletme', 'K');
INSERT INTO public.basvurular VALUES (111, 'İYTE', 'Bilg. Müh.', 'K');
INSERT INTO public.basvurular VALUES (112, 'BAİBÜ', 'İktisat', 'R');
INSERT INTO public.basvurular VALUES (112, 'Ankara', 'İktisat', 'K');
INSERT INTO public.basvurular VALUES (113, 'Marmara', 'İşletme', 'K');
INSERT INTO public.basvurular VALUES (114, 'Marmara', 'GSF', 'R');
INSERT INTO public.basvurular VALUES (115, 'İTÜ', 'Elk. Müh.', 'R');
INSERT INTO public.basvurular VALUES (115, 'Boğaziçi', 'Elk. Müh.', 'K');
INSERT INTO public.basvurular VALUES (116, 'BAİBÜ', 'GSF', 'R');
INSERT INTO public.basvurular VALUES (119, 'BAİBÜ', 'Biyoloji', 'K');


--
-- TOC entry 3611 (class 0 OID 16398)
-- Dependencies: 215
-- Data for Name: ogrenciler; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.ogrenciler VALUES (100, 'Gazi', 3.7, 1200);
INSERT INTO public.ogrenciler VALUES (101, 'Ali', 3, 1000);
INSERT INTO public.ogrenciler VALUES (102, 'Ayşe', 3.9, 200);
INSERT INTO public.ogrenciler VALUES (103, 'Hasan', 2.7, 500);
INSERT INTO public.ogrenciler VALUES (104, 'İsmail', 2.24, 400);
INSERT INTO public.ogrenciler VALUES (105, 'Kemal', 3.2, 800);
INSERT INTO public.ogrenciler VALUES (106, 'Tuğçe', 2.7, 700);
INSERT INTO public.ogrenciler VALUES (107, 'Nimet', 2.9, 700);
INSERT INTO public.ogrenciler VALUES (108, 'Osman', 4, 1200);
INSERT INTO public.ogrenciler VALUES (109, 'Ozan', 4, 1600);
INSERT INTO public.ogrenciler VALUES (110, 'Ali', 2.55, 150);
INSERT INTO public.ogrenciler VALUES (111, 'Tarık', 3.15, 120);
INSERT INTO public.ogrenciler VALUES (112, 'Gamze', 3.25, 100);
INSERT INTO public.ogrenciler VALUES (114, 'Ahmet', 2.75, 100);
INSERT INTO public.ogrenciler VALUES (115, 'Burçin', 2.27, 600);
INSERT INTO public.ogrenciler VALUES (116, 'Fatma', 2, 880);
INSERT INTO public.ogrenciler VALUES (117, 'Ahmet', 2.1, 500);
INSERT INTO public.ogrenciler VALUES (118, 'Mehmet', 2.88, 400);
INSERT INTO public.ogrenciler VALUES (119, 'Emine', 3.88, 360);
INSERT INTO public.ogrenciler VALUES (113, 'Marmara', 3.44, 200);


--
-- TOC entry 3610 (class 0 OID 16395)
-- Dependencies: 214
-- Data for Name: okullar; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.okullar VALUES ('Ankara', 'Ankara', 15000);
INSERT INTO public.okullar VALUES ('Gazi', 'Ankara', 25000);
INSERT INTO public.okullar VALUES ('Bilkent', 'Ankara', 9000);
INSERT INTO public.okullar VALUES ('İTÜ', 'İstanbul', 19000);
INSERT INTO public.okullar VALUES ('Boğaziçi', 'İstanbul', 14000);
INSERT INTO public.okullar VALUES ('Marmara', 'İstanbul', 27000);
INSERT INTO public.okullar VALUES ('BAİBÜ', 'Bolu', 15500);
INSERT INTO public.okullar VALUES ('Ege', 'İzmir', 19000);
INSERT INTO public.okullar VALUES ('İYTE', 'İzmir', 9000);

--
-- PostgreSQL database dump complete
--

