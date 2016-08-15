--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'Standard public schema';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: events; Type: TABLE; Schema: public; Owner: sinanserver; Tablespace:
--

CREATE TABLE events (
    id character varying(40) NOT NULL,
    user_id character varying(40),
    name character varying(255),
    city character varying(255),
    place character varying(255),
    "eventDate" timestamp without time zone,
    price double precision,
    tickets integer
);


ALTER TABLE public.events OWNER TO sinanserver;

--
-- Name: messages; Type: TABLE; Schema: public; Owner: sinanserver; Tablespace:
--

CREATE TABLE messages (
    id character varying(40) NOT NULL,
    recipient_id character varying(40),
    sender_id character varying(40),
    event_id character varying(40),
    title character varying(255),
    message text,
    readed smallint
);


ALTER TABLE public.messages OWNER TO sinanserver;

--
-- Name: reservations; Type: TABLE; Schema: public; Owner: sinanserver; Tablespace:
--

CREATE TABLE reservations (
    id character varying(40) NOT NULL,
    event_id character varying(40),
    user_id character varying(40),
    tickets integer
);


ALTER TABLE public.reservations OWNER TO sinanserver;

--
-- Name: users; Type: TABLE; Schema: public; Owner: sinanserver; Tablespace:
--

CREATE TABLE users (
    id character varying(40) NOT NULL,
    email character varying(50) DEFAULT '0'::character varying NOT NULL,
    "password" character varying(50) DEFAULT '0'::character varying NOT NULL,
    "type" character varying(50) DEFAULT '0'::character varying NOT NULL
);


ALTER TABLE public.users OWNER TO sinanserver;

--
-- Data for Name: events; Type: TABLE DATA; Schema: public; Owner: sinanserver
--



--
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: sinanserver
--



--
-- Data for Name: reservations; Type: TABLE DATA; Schema: public; Owner: sinanserver
--



--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: sinanserver
--

INSERT INTO users VALUES ('11:8f48a03d-6858-472d-b18b-6e8c133a3cec', 'pezhman128@gmail.com', 'e3ceb5881a0a1fdaad01296d7554868d', 'organizator');


--
-- Name: events_pkey; Type: CONSTRAINT; Schema: public; Owner: sinanserver; Tablespace:
--

ALTER TABLE ONLY events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- Name: messages_pkey; Type: CONSTRAINT; Schema: public; Owner: sinanserver; Tablespace:
--

ALTER TABLE ONLY messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: reservations_pkey; Type: CONSTRAINT; Schema: public; Owner: sinanserver; Tablespace:
--

ALTER TABLE ONLY reservations
    ADD CONSTRAINT reservations_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: sinanserver; Tablespace:
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- Name: events; Type: ACL; Schema: public; Owner: sinanserver
--

REVOKE ALL ON TABLE events FROM PUBLIC;
REVOKE ALL ON TABLE events FROM sinanserver;
GRANT ALL ON TABLE events TO sinanserver;
GRANT ALL ON TABLE events TO PUBLIC;
GRANT ALL ON TABLE events TO sinanser_bk_usr;
GRANT ALL ON TABLE events TO sinanser_booking_psgre;


--
-- Name: messages; Type: ACL; Schema: public; Owner: sinanserver
--

REVOKE ALL ON TABLE messages FROM PUBLIC;
REVOKE ALL ON TABLE messages FROM sinanserver;
GRANT ALL ON TABLE messages TO sinanserver;
GRANT ALL ON TABLE messages TO PUBLIC;
GRANT ALL ON TABLE messages TO sinanser_bk_usr;
GRANT ALL ON TABLE messages TO sinanser_booking_psgre;


--
-- Name: reservations; Type: ACL; Schema: public; Owner: sinanserver
--

REVOKE ALL ON TABLE reservations FROM PUBLIC;
REVOKE ALL ON TABLE reservations FROM sinanserver;
GRANT ALL ON TABLE reservations TO sinanserver;
GRANT ALL ON TABLE reservations TO PUBLIC;
GRANT ALL ON TABLE reservations TO sinanser_bk_usr;
GRANT ALL ON TABLE reservations TO sinanser_booking_psgre;


--
-- Name: users; Type: ACL; Schema: public; Owner: sinanserver
--

REVOKE ALL ON TABLE users FROM PUBLIC;
REVOKE ALL ON TABLE users FROM sinanserver;
GRANT ALL ON TABLE users TO sinanserver;
GRANT ALL ON TABLE users TO PUBLIC;
GRANT ALL ON TABLE users TO sinanser_bk_usr;
GRANT ALL ON TABLE users TO sinanser_booking_psgre;


--
-- PostgreSQL database dump complete
--

