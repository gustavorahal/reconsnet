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
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: activities; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE activities (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    summary character varying(255) NOT NULL,
    description text,
    activity_type character varying(255),
    parent_id integer,
    internal_only boolean DEFAULT false,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: activities_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE activities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: activities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE activities_id_seq OWNED BY activities.id;


--
-- Name: addresses; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE addresses (
    id integer NOT NULL,
    label character varying(255),
    line1 character varying(255),
    city character varying(255),
    state character varying(255),
    zip character varying(255),
    country character varying(255),
    addressable_id integer,
    addressable_type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: addresses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE addresses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE addresses_id_seq OWNED BY addresses.id;


--
-- Name: assets; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE assets (
    id integer NOT NULL,
    name character varying(255),
    description character varying(255),
    file_file_name character varying(255),
    file_content_type character varying(255),
    file_file_size integer,
    file_updated_at timestamp without time zone,
    assetable_id integer,
    assetable_type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: assets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE assets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: assets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE assets_id_seq OWNED BY assets.id;


--
-- Name: events; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE events (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    start timestamp without time zone NOT NULL,
    finish timestamp without time zone NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    activity_id integer
);


--
-- Name: events_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE events_id_seq OWNED BY events.id;


--
-- Name: participations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE participations (
    id integer NOT NULL,
    event_id integer NOT NULL,
    person_id integer NOT NULL,
    participation_type character varying(255) NOT NULL,
    status character varying(255) NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: participations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE participations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: participations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE participations_id_seq OWNED BY participations.id;


--
-- Name: people; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE people (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    gender character varying(255),
    email character varying(255),
    date_of_birth date,
    occupation character varying(255),
    nationality character varying(255),
    marketing boolean,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: people_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE people_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: people_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE people_id_seq OWNED BY people.id;


--
-- Name: phone_numbers; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE phone_numbers (
    id integer NOT NULL,
    label character varying(255),
    number character varying(255) NOT NULL,
    provider character varying(255),
    phone_type character varying(255) NOT NULL,
    phonable_id integer,
    phonable_type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: phone_numbers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE phone_numbers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: phone_numbers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE phone_numbers_id_seq OWNED BY phone_numbers.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: tmks; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE tmks (
    id integer NOT NULL,
    with_who_id integer NOT NULL,
    from_who_id integer NOT NULL,
    event_id integer NOT NULL,
    "when" timestamp without time zone,
    contact_type character varying(255),
    notes character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: tmks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tmks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tmks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tmks_id_seq OWNED BY tmks.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    name character varying(255),
    "group" character varying(255),
    person_id integer
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: volunteers; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE volunteers (
    id integer NOT NULL,
    person_id integer NOT NULL,
    admission date,
    area_of_operation character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: volunteers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE volunteers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: volunteers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE volunteers_id_seq OWNED BY volunteers.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY activities ALTER COLUMN id SET DEFAULT nextval('activities_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY addresses ALTER COLUMN id SET DEFAULT nextval('addresses_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY assets ALTER COLUMN id SET DEFAULT nextval('assets_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY events ALTER COLUMN id SET DEFAULT nextval('events_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY participations ALTER COLUMN id SET DEFAULT nextval('participations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY people ALTER COLUMN id SET DEFAULT nextval('people_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY phone_numbers ALTER COLUMN id SET DEFAULT nextval('phone_numbers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY tmks ALTER COLUMN id SET DEFAULT nextval('tmks_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY volunteers ALTER COLUMN id SET DEFAULT nextval('volunteers_id_seq'::regclass);


--
-- Name: activities_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY activities
    ADD CONSTRAINT activities_pkey PRIMARY KEY (id);


--
-- Name: addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY addresses
    ADD CONSTRAINT addresses_pkey PRIMARY KEY (id);


--
-- Name: assets_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY assets
    ADD CONSTRAINT assets_pkey PRIMARY KEY (id);


--
-- Name: events_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- Name: participations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY participations
    ADD CONSTRAINT participations_pkey PRIMARY KEY (id);


--
-- Name: people_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY people
    ADD CONSTRAINT people_pkey PRIMARY KEY (id);


--
-- Name: phone_numbers_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY phone_numbers
    ADD CONSTRAINT phone_numbers_pkey PRIMARY KEY (id);


--
-- Name: tmks_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY tmks
    ADD CONSTRAINT tmks_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: volunteers_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY volunteers
    ADD CONSTRAINT volunteers_pkey PRIMARY KEY (id);


--
-- Name: index_addresses_on_addressable_type_and_addressable_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_addresses_on_addressable_type_and_addressable_id ON addresses USING btree (addressable_type, addressable_id);


--
-- Name: index_assets_on_assetable_type_and_assetable_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_assets_on_assetable_type_and_assetable_id ON assets USING btree (assetable_type, assetable_id);


--
-- Name: index_assets_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_assets_on_name ON assets USING btree (name);


--
-- Name: index_events_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_events_on_name ON events USING btree (name);


--
-- Name: index_participations_on_event_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_participations_on_event_id ON participations USING btree (event_id);


--
-- Name: index_participations_on_person_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_participations_on_person_id ON participations USING btree (person_id);


--
-- Name: index_people_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_people_on_name ON people USING btree (name);


--
-- Name: index_phone_numbers_on_number; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_phone_numbers_on_number ON phone_numbers USING btree (number);


--
-- Name: index_phone_numbers_on_phonable_type_and_phonable_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_phone_numbers_on_phonable_type_and_phonable_id ON phone_numbers USING btree (phonable_type, phonable_id);


--
-- Name: index_tmks_on_event_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_tmks_on_event_id ON tmks USING btree (event_id);


--
-- Name: index_tmks_on_from_who_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_tmks_on_from_who_id ON tmks USING btree (from_who_id);


--
-- Name: index_tmks_on_with_who_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_tmks_on_with_who_id ON tmks USING btree (with_who_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_person_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_on_person_id ON users USING btree (person_id);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: index_volunteers_on_person_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_volunteers_on_person_id ON volunteers USING btree (person_id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20140330205100');

INSERT INTO schema_migrations (version) VALUES ('20140330210526');

INSERT INTO schema_migrations (version) VALUES ('20140330210756');

INSERT INTO schema_migrations (version) VALUES ('20140330220644');

INSERT INTO schema_migrations (version) VALUES ('20140330221658');

INSERT INTO schema_migrations (version) VALUES ('20140330221728');

INSERT INTO schema_migrations (version) VALUES ('20140504200029');

INSERT INTO schema_migrations (version) VALUES ('20140504200030');

INSERT INTO schema_migrations (version) VALUES ('20140601175536');

INSERT INTO schema_migrations (version) VALUES ('20140618034452');

INSERT INTO schema_migrations (version) VALUES ('20140624000637');

INSERT INTO schema_migrations (version) VALUES ('20140707171124');

INSERT INTO schema_migrations (version) VALUES ('20140708165800');

INSERT INTO schema_migrations (version) VALUES ('20140708171211');

