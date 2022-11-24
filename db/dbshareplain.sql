--
-- PostgreSQL database dump
--

-- Dumped from database version 15.1
-- Dumped by pg_dump version 15.1

-- Started on 2022-11-24 02:31:53

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
-- TOC entry 3406 (class 1262 OID 5)
-- Name: postgres; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';


ALTER DATABASE postgres OWNER TO postgres;

\connect postgres

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
-- TOC entry 3407 (class 0 OID 0)
-- Dependencies: 3406
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- TOC entry 2 (class 3079 OID 16384)
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- TOC entry 3408 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


--
-- TOC entry 228 (class 1259 OID 24576)
-- Name: aith_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.aith_id_seq
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.aith_id_seq OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 215 (class 1259 OID 16394)
-- Name: authorize; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authorize (
    a_id integer DEFAULT nextval('public.aith_id_seq'::regclass) NOT NULL,
    u_id integer,
    v_id integer
);


ALTER TABLE public.authorize OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 24580)
-- Name: driver_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.driver_id_seq
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.driver_id_seq OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16397)
-- Name: driver; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.driver (
    driver_id integer DEFAULT nextval('public.driver_id_seq'::regclass) NOT NULL,
    u_id integer NOT NULL,
    license text NOT NULL
);


ALTER TABLE public.driver OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16402)
-- Name: driver_rides; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.driver_rides (
    driver_id integer NOT NULL,
    ride_id integer NOT NULL
);


ALTER TABLE public.driver_rides OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 24578)
-- Name: pass_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pass_id_seq
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pass_id_seq OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 24592)
-- Name: pass_ride_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pass_ride_seq
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pass_ride_seq OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16405)
-- Name: passenger; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.passenger (
    p_id integer DEFAULT nextval('public.pass_id_seq'::regclass) NOT NULL,
    u_id integer,
    p_address character varying(50)
);


ALTER TABLE public.passenger OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16408)
-- Name: passenger_ride; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.passenger_ride (
    p_id integer DEFAULT nextval('public.pass_ride_seq'::regclass) NOT NULL,
    ride_id integer NOT NULL
);


ALTER TABLE public.passenger_ride OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16549)
-- Name: rev_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rev_id_seq
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rev_id_seq OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16411)
-- Name: reviews; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reviews (
    review_id integer DEFAULT nextval('public.rev_id_seq'::regclass) NOT NULL,
    driver_review text,
    passenger_review text
);


ALTER TABLE public.reviews OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16551)
-- Name: ride_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ride_id_seq
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ride_id_seq OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16416)
-- Name: ride; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ride (
    r_id integer DEFAULT nextval('public.ride_id_seq'::regclass) NOT NULL,
    r_date date,
    r_time time without time zone,
    r_from character varying,
    r_to character varying,
    v_id integer,
    r_fee integer,
    driver_id integer,
    p_id integer,
    review_id integer
);


ALTER TABLE public.ride OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16517)
-- Name: test_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.test_id_seq
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.test_id_seq OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16421)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    u_id integer DEFAULT nextval('public.test_id_seq'::regclass) NOT NULL,
    u_name character varying,
    u_email character varying,
    u_password character varying NOT NULL,
    u_phone character varying
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16542)
-- Name: veh_reg_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.veh_reg_seq
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.veh_reg_seq OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16426)
-- Name: vehicle; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vehicle (
    v_id integer DEFAULT nextval('public.veh_reg_seq'::regclass) NOT NULL,
    model text,
    capacity integer,
    license_plate character varying NOT NULL,
    color text
);


ALTER TABLE public.vehicle OWNER TO postgres;

--
-- TOC entry 3222 (class 2606 OID 16432)
-- Name: authorize authorize_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authorize
    ADD CONSTRAINT authorize_pkey PRIMARY KEY (a_id);


--
-- TOC entry 3224 (class 2606 OID 24595)
-- Name: driver driver_license_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.driver
    ADD CONSTRAINT driver_license_key UNIQUE (license);


--
-- TOC entry 3226 (class 2606 OID 16436)
-- Name: driver driver_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.driver
    ADD CONSTRAINT driver_pkey PRIMARY KEY (driver_id);


--
-- TOC entry 3228 (class 2606 OID 16438)
-- Name: driver_rides driver_rides_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.driver_rides
    ADD CONSTRAINT driver_rides_pkey PRIMARY KEY (driver_id, ride_id);


--
-- TOC entry 3230 (class 2606 OID 16440)
-- Name: passenger passenger_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.passenger
    ADD CONSTRAINT passenger_pkey PRIMARY KEY (p_id);


--
-- TOC entry 3232 (class 2606 OID 16442)
-- Name: passenger_ride passenger_ride_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.passenger_ride
    ADD CONSTRAINT passenger_ride_pkey PRIMARY KEY (p_id, ride_id);


--
-- TOC entry 3234 (class 2606 OID 16444)
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (review_id);


--
-- TOC entry 3236 (class 2606 OID 16446)
-- Name: ride ride_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ride
    ADD CONSTRAINT ride_pkey PRIMARY KEY (r_id);


--
-- TOC entry 3238 (class 2606 OID 16448)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (u_id);


--
-- TOC entry 3240 (class 2606 OID 16450)
-- Name: users users_u_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_u_email_key UNIQUE (u_email);


--
-- TOC entry 3242 (class 2606 OID 16452)
-- Name: users users_u_phone_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_u_phone_key UNIQUE (u_phone);


--
-- TOC entry 3244 (class 2606 OID 16454)
-- Name: vehicle vehicle_license_plate_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicle
    ADD CONSTRAINT vehicle_license_plate_key UNIQUE (license_plate);


--
-- TOC entry 3246 (class 2606 OID 16456)
-- Name: vehicle vehicle_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicle
    ADD CONSTRAINT vehicle_pkey PRIMARY KEY (v_id);


--
-- TOC entry 3250 (class 2606 OID 16457)
-- Name: driver_rides d_ride; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.driver_rides
    ADD CONSTRAINT d_ride FOREIGN KEY (ride_id) REFERENCES public.ride(r_id);


--
-- TOC entry 3249 (class 2606 OID 16462)
-- Name: driver d_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.driver
    ADD CONSTRAINT d_user FOREIGN KEY (u_id) REFERENCES public.users(u_id);


--
-- TOC entry 3251 (class 2606 OID 16467)
-- Name: driver_rides d_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.driver_rides
    ADD CONSTRAINT d_user FOREIGN KEY (driver_id) REFERENCES public.driver(driver_id);


--
-- TOC entry 3247 (class 2606 OID 16472)
-- Name: authorize fk_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authorize
    ADD CONSTRAINT fk_user FOREIGN KEY (u_id) REFERENCES public.users(u_id);


--
-- TOC entry 3253 (class 2606 OID 16477)
-- Name: passenger_ride p_ride; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.passenger_ride
    ADD CONSTRAINT p_ride FOREIGN KEY (ride_id) REFERENCES public.ride(r_id);


--
-- TOC entry 3252 (class 2606 OID 16482)
-- Name: passenger p_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.passenger
    ADD CONSTRAINT p_user FOREIGN KEY (u_id) REFERENCES public.users(u_id);


--
-- TOC entry 3254 (class 2606 OID 16487)
-- Name: passenger_ride p_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.passenger_ride
    ADD CONSTRAINT p_user FOREIGN KEY (p_id) REFERENCES public.passenger(p_id);


--
-- TOC entry 3255 (class 2606 OID 16492)
-- Name: ride rev_ride; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ride
    ADD CONSTRAINT rev_ride FOREIGN KEY (review_id) REFERENCES public.reviews(review_id);


--
-- TOC entry 3256 (class 2606 OID 16497)
-- Name: ride ride_d; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ride
    ADD CONSTRAINT ride_d FOREIGN KEY (driver_id) REFERENCES public.driver(driver_id);


--
-- TOC entry 3257 (class 2606 OID 16502)
-- Name: ride ride_p; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ride
    ADD CONSTRAINT ride_p FOREIGN KEY (p_id) REFERENCES public.passenger(p_id);


--
-- TOC entry 3258 (class 2606 OID 16507)
-- Name: ride ride_v; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ride
    ADD CONSTRAINT ride_v FOREIGN KEY (v_id) REFERENCES public.vehicle(v_id);


--
-- TOC entry 3248 (class 2606 OID 16512)
-- Name: authorize v_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authorize
    ADD CONSTRAINT v_user FOREIGN KEY (v_id) REFERENCES public.vehicle(v_id);


-- Completed on 2022-11-24 02:31:54

--
-- PostgreSQL database dump complete
--

