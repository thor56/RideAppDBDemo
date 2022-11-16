--
-- fknrjvfiwtagmtQL database dump
--

-- Dumped from database version 14.5
-- Dumped by pg_dump version 14.5

-- Started on 2022-11-12 21:30:46

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
-- TOC entry 211 (class 1259 OID 25741)
-- Name: authorize; Type: TABLE; Schema: public; Owner: fknrjvfiwtagmt
--

CREATE TABLE public.authorize (
    a_id integer NOT NULL,
    u_id integer,
    v_id integer
);


ALTER TABLE public.authorize OWNER TO fknrjvfiwtagmt;

--
-- TOC entry 212 (class 1259 OID 25765)
-- Name: driver; Type: TABLE; Schema: public; Owner: fknrjvfiwtagmt
--

CREATE TABLE public.driver (
    driver_id integer NOT NULL,
    u_id integer,
    license character varying NOT NULL
);


ALTER TABLE public.driver OWNER TO fknrjvfiwtagmt;

--
-- TOC entry 216 (class 1259 OID 25845)
-- Name: driver_rides; Type: TABLE; Schema: public; Owner: fknrjvfiwtagmt
--

CREATE TABLE public.driver_rides (
    driver_id integer NOT NULL,
    ride_id integer NOT NULL
);


ALTER TABLE public.driver_rides OWNER TO fknrjvfiwtagmt;

--
-- TOC entry 213 (class 1259 OID 25779)
-- Name: passenger; Type: TABLE; Schema: public; Owner: fknrjvfiwtagmt
--

CREATE TABLE public.passenger (
    p_id integer NOT NULL,
    u_id integer,
    p_address character varying(50)
);


ALTER TABLE public.passenger OWNER TO fknrjvfiwtagmt;

--
-- TOC entry 217 (class 1259 OID 25860)
-- Name: passenger_ride; Type: TABLE; Schema: public; Owner: fknrjvfiwtagmt
--

CREATE TABLE public.passenger_ride (
    p_id integer NOT NULL,
    ride_id integer NOT NULL
);


ALTER TABLE public.passenger_ride OWNER TO fknrjvfiwtagmt;

--
-- TOC entry 214 (class 1259 OID 25789)
-- Name: reviews; Type: TABLE; Schema: public; Owner: fknrjvfiwtagmt
--

CREATE TABLE public.reviews (
    review_id integer NOT NULL,
    driver_review character varying,
    passenger_review character varying
);


ALTER TABLE public.reviews OWNER TO fknrjvfiwtagmt;

--
-- TOC entry 215 (class 1259 OID 25818)
-- Name: ride; Type: TABLE; Schema: public; Owner: fknrjvfiwtagmt
--

CREATE TABLE public.ride (
    r_id integer NOT NULL,
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


ALTER TABLE public.ride OWNER TO fknrjvfiwtagmt;

--
-- TOC entry 209 (class 1259 OID 25721)
-- Name: users; Type: TABLE; Schema: public; Owner: fknrjvfiwtagmt
--

CREATE TABLE public.users (
    u_id integer NOT NULL,
    u_name character varying,
    u_email character varying,
    u_password character varying NOT NULL,
    u_phone character varying
);


ALTER TABLE public.users OWNER TO fknrjvfiwtagmt;

--
-- TOC entry 210 (class 1259 OID 25732)
-- Name: vehicle; Type: TABLE; Schema: public; Owner: fknrjvfiwtagmt
--

CREATE TABLE public.vehicle (
    v_id integer NOT NULL,
    model character varying,
    capacity integer,
    license_plate character varying NOT NULL,
    color character varying
);


ALTER TABLE public.vehicle OWNER TO fknrjvfiwtagmt;

--
-- TOC entry 3374 (class 0 OID 25741)
-- Dependencies: 211
-- Data for Name: authorize; Type: TABLE DATA; Schema: public; Owner: fknrjvfiwtagmt
--

COPY public.authorize (a_id, u_id, v_id) FROM stdin;
\.


--
-- TOC entry 3375 (class 0 OID 25765)
-- Dependencies: 212
-- Data for Name: driver; Type: TABLE DATA; Schema: public; Owner: fknrjvfiwtagmt
--

COPY public.driver (driver_id, u_id, license) FROM stdin;
\.


--
-- TOC entry 3379 (class 0 OID 25845)
-- Dependencies: 216
-- Data for Name: driver_rides; Type: TABLE DATA; Schema: public; Owner: fknrjvfiwtagmt
--

COPY public.driver_rides (driver_id, ride_id) FROM stdin;
\.


--
-- TOC entry 3376 (class 0 OID 25779)
-- Dependencies: 213
-- Data for Name: passenger; Type: TABLE DATA; Schema: public; Owner: fknrjvfiwtagmt
--

COPY public.passenger (p_id, u_id, p_address) FROM stdin;
\.


--
-- TOC entry 3380 (class 0 OID 25860)
-- Dependencies: 217
-- Data for Name: passenger_ride; Type: TABLE DATA; Schema: public; Owner: fknrjvfiwtagmt
--

COPY public.passenger_ride (p_id, ride_id) FROM stdin;
\.


--
-- TOC entry 3377 (class 0 OID 25789)
-- Dependencies: 214
-- Data for Name: reviews; Type: TABLE DATA; Schema: public; Owner: fknrjvfiwtagmt
--

COPY public.reviews (review_id, driver_review, passenger_review) FROM stdin;
\.


--
-- TOC entry 3378 (class 0 OID 25818)
-- Dependencies: 215
-- Data for Name: ride; Type: TABLE DATA; Schema: public; Owner: fknrjvfiwtagmt
--

COPY public.ride (r_id, r_date, r_time, r_from, r_to, v_id, r_fee, driver_id, p_id, review_id) FROM stdin;
\.


--
-- TOC entry 3372 (class 0 OID 25721)
-- Dependencies: 209
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: fknrjvfiwtagmt
--

COPY public.users (u_id, u_name, u_email, u_password, u_phone) FROM stdin;
\.


--
-- TOC entry 3373 (class 0 OID 25732)
-- Dependencies: 210
-- Data for Name: vehicle; Type: TABLE DATA; Schema: public; Owner: fknrjvfiwtagmt
--

COPY public.vehicle (v_id, model, capacity, license_plate, color) FROM stdin;
\.


--
-- TOC entry 3206 (class 2606 OID 25745)
-- Name: authorize authorize_pkey; Type: CONSTRAINT; Schema: public; Owner: fknrjvfiwtagmt
--

ALTER TABLE ONLY public.authorize
    ADD CONSTRAINT authorize_pkey PRIMARY KEY (a_id);


--
-- TOC entry 3208 (class 2606 OID 25773)
-- Name: driver driver_license_key; Type: CONSTRAINT; Schema: public; Owner: fknrjvfiwtagmt
--

ALTER TABLE ONLY public.driver
    ADD CONSTRAINT driver_license_key UNIQUE (license);


--
-- TOC entry 3210 (class 2606 OID 25771)
-- Name: driver driver_pkey; Type: CONSTRAINT; Schema: public; Owner: fknrjvfiwtagmt
--

ALTER TABLE ONLY public.driver
    ADD CONSTRAINT driver_pkey PRIMARY KEY (driver_id);


--
-- TOC entry 3218 (class 2606 OID 25849)
-- Name: driver_rides driver_rides_pkey; Type: CONSTRAINT; Schema: public; Owner: fknrjvfiwtagmt
--

ALTER TABLE ONLY public.driver_rides
    ADD CONSTRAINT driver_rides_pkey PRIMARY KEY (driver_id, ride_id);


--
-- TOC entry 3212 (class 2606 OID 25783)
-- Name: passenger passenger_pkey; Type: CONSTRAINT; Schema: public; Owner: fknrjvfiwtagmt
--

ALTER TABLE ONLY public.passenger
    ADD CONSTRAINT passenger_pkey PRIMARY KEY (p_id);


--
-- TOC entry 3220 (class 2606 OID 25864)
-- Name: passenger_ride passenger_ride_pkey; Type: CONSTRAINT; Schema: public; Owner: fknrjvfiwtagmt
--

ALTER TABLE ONLY public.passenger_ride
    ADD CONSTRAINT passenger_ride_pkey PRIMARY KEY (p_id, ride_id);


--
-- TOC entry 3214 (class 2606 OID 25795)
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: fknrjvfiwtagmt
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (review_id);


--
-- TOC entry 3216 (class 2606 OID 25824)
-- Name: ride ride_pkey; Type: CONSTRAINT; Schema: public; Owner: fknrjvfiwtagmt
--

ALTER TABLE ONLY public.ride
    ADD CONSTRAINT ride_pkey PRIMARY KEY (r_id);


--
-- TOC entry 3196 (class 2606 OID 25727)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: fknrjvfiwtagmt
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (u_id);


--
-- TOC entry 3198 (class 2606 OID 25729)
-- Name: users users_u_email_key; Type: CONSTRAINT; Schema: public; Owner: fknrjvfiwtagmt
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_u_email_key UNIQUE (u_email);


--
-- TOC entry 3200 (class 2606 OID 25731)
-- Name: users users_u_phone_key; Type: CONSTRAINT; Schema: public; Owner: fknrjvfiwtagmt
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_u_phone_key UNIQUE (u_phone);


--
-- TOC entry 3202 (class 2606 OID 25740)
-- Name: vehicle vehicle_license_plate_key; Type: CONSTRAINT; Schema: public; Owner: fknrjvfiwtagmt
--

ALTER TABLE ONLY public.vehicle
    ADD CONSTRAINT vehicle_license_plate_key UNIQUE (license_plate);


--
-- TOC entry 3204 (class 2606 OID 25738)
-- Name: vehicle vehicle_pkey; Type: CONSTRAINT; Schema: public; Owner: fknrjvfiwtagmt
--

ALTER TABLE ONLY public.vehicle
    ADD CONSTRAINT vehicle_pkey PRIMARY KEY (v_id);


--
-- TOC entry 3230 (class 2606 OID 25855)
-- Name: driver_rides d_ride; Type: FK CONSTRAINT; Schema: public; Owner: fknrjvfiwtagmt
--

ALTER TABLE ONLY public.driver_rides
    ADD CONSTRAINT d_ride FOREIGN KEY (ride_id) REFERENCES public.ride(r_id);


--
-- TOC entry 3223 (class 2606 OID 25774)
-- Name: driver d_user; Type: FK CONSTRAINT; Schema: public; Owner: fknrjvfiwtagmt
--

ALTER TABLE ONLY public.driver
    ADD CONSTRAINT d_user FOREIGN KEY (u_id) REFERENCES public.users(u_id);


--
-- TOC entry 3229 (class 2606 OID 25850)
-- Name: driver_rides d_user; Type: FK CONSTRAINT; Schema: public; Owner: fknrjvfiwtagmt
--

ALTER TABLE ONLY public.driver_rides
    ADD CONSTRAINT d_user FOREIGN KEY (driver_id) REFERENCES public.driver(driver_id);


--
-- TOC entry 3221 (class 2606 OID 25746)
-- Name: authorize fk_user; Type: FK CONSTRAINT; Schema: public; Owner: fknrjvfiwtagmt
--

ALTER TABLE ONLY public.authorize
    ADD CONSTRAINT fk_user FOREIGN KEY (u_id) REFERENCES public.users(u_id);


--
-- TOC entry 3232 (class 2606 OID 25870)
-- Name: passenger_ride p_ride; Type: FK CONSTRAINT; Schema: public; Owner: fknrjvfiwtagmt
--

ALTER TABLE ONLY public.passenger_ride
    ADD CONSTRAINT p_ride FOREIGN KEY (ride_id) REFERENCES public.ride(r_id);


--
-- TOC entry 3224 (class 2606 OID 25784)
-- Name: passenger p_user; Type: FK CONSTRAINT; Schema: public; Owner: fknrjvfiwtagmt
--

ALTER TABLE ONLY public.passenger
    ADD CONSTRAINT p_user FOREIGN KEY (u_id) REFERENCES public.users(u_id);


--
-- TOC entry 3231 (class 2606 OID 25865)
-- Name: passenger_ride p_user; Type: FK CONSTRAINT; Schema: public; Owner: fknrjvfiwtagmt
--

ALTER TABLE ONLY public.passenger_ride
    ADD CONSTRAINT p_user FOREIGN KEY (p_id) REFERENCES public.passenger(p_id);


--
-- TOC entry 3225 (class 2606 OID 25825)
-- Name: ride rev_ride; Type: FK CONSTRAINT; Schema: public; Owner: fknrjvfiwtagmt
--

ALTER TABLE ONLY public.ride
    ADD CONSTRAINT rev_ride FOREIGN KEY (review_id) REFERENCES public.reviews(review_id);


--
-- TOC entry 3228 (class 2606 OID 25840)
-- Name: ride ride_d; Type: FK CONSTRAINT; Schema: public; Owner: fknrjvfiwtagmt
--

ALTER TABLE ONLY public.ride
    ADD CONSTRAINT ride_d FOREIGN KEY (driver_id) REFERENCES public.driver(driver_id);


--
-- TOC entry 3227 (class 2606 OID 25835)
-- Name: ride ride_p; Type: FK CONSTRAINT; Schema: public; Owner: fknrjvfiwtagmt
--

ALTER TABLE ONLY public.ride
    ADD CONSTRAINT ride_p FOREIGN KEY (p_id) REFERENCES public.passenger(p_id);


--
-- TOC entry 3226 (class 2606 OID 25830)
-- Name: ride ride_v; Type: FK CONSTRAINT; Schema: public; Owner: fknrjvfiwtagmt
--

ALTER TABLE ONLY public.ride
    ADD CONSTRAINT ride_v FOREIGN KEY (v_id) REFERENCES public.vehicle(v_id);


--
-- TOC entry 3222 (class 2606 OID 25751)
-- Name: authorize v_user; Type: FK CONSTRAINT; Schema: public; Owner: fknrjvfiwtagmt
--

ALTER TABLE ONLY public.authorize
    ADD CONSTRAINT v_user FOREIGN KEY (v_id) REFERENCES public.vehicle(v_id);


-- Completed on 2022-11-12 21:30:46

--
-- fknrjvfiwtagmtQL database dump complete
--

