--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4
-- Dumped by pg_dump version 16.4

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
-- Name: TagInfo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."TagInfo" (
    "tagID" integer NOT NULL,
    content text NOT NULL
);


ALTER TABLE public."TagInfo" OWNER TO postgres;

--
-- Name: Users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Users" (
    "UserID" integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public."Users" OWNER TO postgres;

--
-- Name: genres; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.genres (
    "genreID" integer NOT NULL,
    name text
);


ALTER TABLE public.genres OWNER TO postgres;

--
-- Name: hasagenre; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hasagenre (
    "Movie_ID" integer,
    "Genre_ID" integer
);


ALTER TABLE public.hasagenre OWNER TO postgres;

--
-- Name: movies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.movies (
    "MovieID" integer NOT NULL,
    title text NOT NULL
);


ALTER TABLE public.movies OWNER TO postgres;

--
-- Name: ratings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ratings (
    "UserID" integer NOT NULL,
    "movieID" integer,
    rating numeric(1,0) NOT NULL,
    "timestamp" bigint
);


ALTER TABLE public.ratings OWNER TO postgres;

--
-- Name: tags; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tags (
    "UserID" integer,
    "MovieID" integer,
    "tagID" integer NOT NULL,
    "timestamp" integer
);


ALTER TABLE public.tags OWNER TO postgres;

--
-- Data for Name: TagInfo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."TagInfo" ("tagID", content) FROM stdin;
1	vhsvhgsdvc
2	vhsvhgsdv
3	vhsvhgsd
4	vhsvgsd
5	vhsvsd
\.


--
-- Data for Name: Users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Users" ("UserID", name) FROM stdin;
1	Mayank Vyas
2	Naman
3	Chetan
4	Gaurav
5	Charu
\.


--
-- Data for Name: genres; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.genres ("genreID", name) FROM stdin;
1	vchvdhgcv
2	chvdhgcv
3	chvdhcv
4	chvdcv
5	chvdcvhb
\.


--
-- Data for Name: hasagenre; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.hasagenre ("Movie_ID", "Genre_ID") FROM stdin;
1	5
\.


--
-- Data for Name: movies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.movies ("MovieID", title) FROM stdin;
1	Animal
2	hbsdjhbsf
3	hbsdjhb
4	hbsdjh
5	hbsjh
\.


--
-- Data for Name: ratings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ratings ("UserID", "movieID", rating, "timestamp") FROM stdin;
4	4	0	23
1	4	0	23
\.


--
-- Data for Name: tags; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tags ("UserID", "MovieID", "tagID", "timestamp") FROM stdin;
\.


--
-- Name: TagInfo TagInfo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TagInfo"
    ADD CONSTRAINT "TagInfo_pkey" PRIMARY KEY ("tagID");


--
-- Name: Users Users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_pkey" PRIMARY KEY ("UserID");


--
-- Name: genres genres_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genres
    ADD CONSTRAINT genres_pkey PRIMARY KEY ("genreID");


--
-- Name: movies movies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies
    ADD CONSTRAINT movies_pkey PRIMARY KEY ("MovieID");


--
-- Name: ratings ratings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ratings
    ADD CONSTRAINT ratings_pkey PRIMARY KEY ("UserID");


--
-- Name: tags tags_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY ("tagID");


--
-- Name: ratings values; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.ratings
    ADD CONSTRAINT "values" CHECK (((rating >= (0)::numeric) AND (rating <= (5)::numeric))) NOT VALID;


--
-- Name: hasagenre GenreID; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hasagenre
    ADD CONSTRAINT "GenreID" FOREIGN KEY ("Genre_ID") REFERENCES public.genres("genreID");


--
-- Name: hasagenre MovieID; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hasagenre
    ADD CONSTRAINT "MovieID" FOREIGN KEY ("Movie_ID") REFERENCES public.movies("MovieID");


--
-- Name: ratings MovieId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ratings
    ADD CONSTRAINT "MovieId" FOREIGN KEY ("movieID") REFERENCES public.movies("MovieID");


--
-- Name: tags Movie_ID; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT "Movie_ID" FOREIGN KEY ("MovieID") REFERENCES public.movies("MovieID");


--
-- Name: ratings UserID; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ratings
    ADD CONSTRAINT "UserID" FOREIGN KEY ("UserID") REFERENCES public."Users"("UserID");


--
-- Name: tags UserID; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT "UserID" FOREIGN KEY ("UserID") REFERENCES public."Users"("UserID");


--
-- PostgreSQL database dump complete
--

