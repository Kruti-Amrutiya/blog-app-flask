--
-- PostgreSQL database dump
--

-- Dumped from database version 12.5 (Ubuntu 12.5-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 13.1 (Ubuntu 13.1-1.pgdg20.04+1)

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
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE public.alembic_version OWNER TO postgres;

--
-- Name: comment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comment (
    id integer NOT NULL,
    user_id integer,
    post_id integer NOT NULL,
    body character varying(100) NOT NULL,
    created_date timestamp without time zone
);


ALTER TABLE public.comment OWNER TO postgres;

--
-- Name: comment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.comment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comment_id_seq OWNER TO postgres;

--
-- Name: comment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.comment_id_seq OWNED BY public.comment.id;


--
-- Name: post; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.post (
    id integer NOT NULL,
    title character varying(100) NOT NULL,
    date_posted timestamp without time zone NOT NULL,
    content text NOT NULL,
    user_id integer NOT NULL,
    updated_date timestamp without time zone
);


ALTER TABLE public.post OWNER TO postgres;

--
-- Name: post_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.post_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.post_id_seq OWNER TO postgres;

--
-- Name: post_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.post_id_seq OWNED BY public.post.id;


--
-- Name: post_like; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.post_like (
    id integer NOT NULL,
    user_id integer,
    post_id integer
);


ALTER TABLE public.post_like OWNER TO postgres;

--
-- Name: post_like_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.post_like_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.post_like_id_seq OWNER TO postgres;

--
-- Name: post_like_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.post_like_id_seq OWNED BY public.post_like.id;


--
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."user" (
    id integer NOT NULL,
    username character varying(20) NOT NULL,
    email character varying(120) NOT NULL,
    image_file character varying(20) NOT NULL,
    password character varying(60) NOT NULL
);


ALTER TABLE public."user" OWNER TO postgres;

--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_id_seq OWNER TO postgres;

--
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_id_seq OWNED BY public."user".id;


--
-- Name: comment id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment ALTER COLUMN id SET DEFAULT nextval('public.comment_id_seq'::regclass);


--
-- Name: post id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post ALTER COLUMN id SET DEFAULT nextval('public.post_id_seq'::regclass);


--
-- Name: post_like id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_like ALTER COLUMN id SET DEFAULT nextval('public.post_like_id_seq'::regclass);


--
-- Name: user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);


--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.alembic_version (version_num) FROM stdin;
ed32d31fb9a9
\.


--
-- Data for Name: comment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.comment (id, user_id, post_id, body, created_date) FROM stdin;
6	1	19	helloklnglf	2021-04-29 06:58:14.352214
7	1	16	this is my comment	2021-04-29 07:03:24.066452
8	1	13	this is testing	2021-04-29 07:04:04.164609
9	2	16	kffl	2021-04-29 07:04:25.032821
10	2	19	it's a nice post	2021-04-29 09:07:22.944394
11	2	17	nice post	2021-04-29 13:19:30.735013
12	2	13	the latest comment	2021-04-29 13:20:23.498992
18	2	18	hello	2021-04-30 11:07:33.852424
22	2	19	testing	2021-05-03 06:24:33.942134
24	2	4	test the comment	2021-05-03 06:25:41.464265
25	2	17	nice wordings	2021-05-03 06:26:10.177439
26	2	17	the latest comment	2021-05-03 06:26:50.299686
27	2	18	soo....amazing post	2021-05-03 06:58:07.578695
28	2	14	it's an amazing post	2021-05-03 06:58:58.968097
29	2	4	jhghg	2021-05-04 05:41:16.811621
\.


--
-- Data for Name: post; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.post (id, title, date_posted, content, user_id, updated_date) FROM stdin;
4	This is my first post	2021-04-23 10:20:59.031473	blog post-testing\r\nthis is a post	2	\N
7	Microsoft Story Labs	2021-04-23 12:43:31.510796	Microsoft’s business spans across several different industries. From innovative PC hardware to their venerable productivity software and beyond, few companies have greater global reach or impact on how the world uses computers. Microsoft's Story Labs blog covers all kinds of stories around their products.	3	\N
8	Musicians Friend: The HUB	2021-04-23 12:43:56.716812	Shopping for musical instruments can be challenging due to the incredible range of options for any given product category. Plus, quality can vary wildly between different pieces of equipment at different price points. For a newcomer, this can make for an intimidating shopping experience.	3	\N
9	Shopify Blog	2021-04-23 12:44:31.268382	Few companies do e-commerce blogging better than Shopify. Their blog covers a broad range of topics related to business, marketing, and the Web.	3	\N
11	ModCloth	2021-04-23 12:45:49.537617	Buying clothes online can be a hassle when you can’t try anything on. It’s even harder when an online store doesn’t have a physical counterpart where you can drop off returns. The Modcloth Blog helps make things easier by sharing style tips, showing off new products, and more.	2	\N
12	The Home Depot Blog	2021-04-23 12:46:11.226894	DIY projects make excellent blog fodder. Home Depot capitalizes on this with a blog that focuses on actionable advice for completing all kinds of different home improvement tasks, and more.	2	\N
13	Smart Passive Income	2021-04-23 12:46:32.377857	Smart Passive Income founder Pat Flynn is a blogging machine. He’s built an immensely profitable business and he shares his advice willingly.	2	\N
14	Chris Brogan	2021-04-23 12:46:55.132405	When you arrive on Chris Brogan’s website, there’s a promise that you’ll learn how to “use media and community to earn customers.” And that’s exactly what you’ll find once you look around on his blog. Brogan has written several marketing books and also offers some great free resources.	2	\N
16	Boing Boing	2021-04-23 12:48:08.221842	There’s a good chance you’ve heard of Boing Boing. If you haven’t, it describes itself as, “A Directory of Mostly Wonderful Things.” That gives you some idea of what you’ll find here, which is a wide variety of interesting stories loosely revolving around art, culture, technology, and beyond.	1	\N
17	Evernote	2021-04-23 12:48:30.738175	As one of the premier personal and organizational apps out there, it makes sense that Evernote’s blog would focus heavily on productivity and getting organized. That includes sharing use cases for their product, and posts about organization and productivity in general.	1	\N
22	abcd	2021-04-29 14:04:17.267735	hello there	1	2021-04-29 14:05:13.277798
15	Think With Google	2021-04-23 12:47:43.643266	If you think Google would know how to create great content, you’d be correct. They publish several different blogs, but for this post, take a look at Think With Google	1	2021-04-29 14:07:22.711108
18	Bad Red Head Media	2021-04-23 12:48:54.553302	It might sound ironic, but authors aren’t always great marketers. Sure, both involve writing and storytelling chops, but that’s where the similarities end. Bad Red Head Media is here to help authors close gaps in their skill sets so they can learn not only how to write great books, but understand how to market them, too	1	2021-04-29 14:11:11.084773
23	Ramayana	2021-04-30 05:16:14.084141	Valmiki is the author of this book	2	2021-04-30 06:38:25.250418
19	The Zen of Python	2021-04-26 05:08:42.735245	Beautiful is better than ugly.\r\nExplicit is better than implicit.\r\nSimple is better than complex.\r\nThe complex is better than the complicated.\r\nThe flat is better than the nested.\r\nSparse is better than dense.\r\nReadability counts.\r\nSpecial cases aren't special enough to break the rules.\r\nAlthough practicality beats purity.\r\nErrors should never pass silently.\r\nUnless explicitly silenced.\r\nIn the face of ambiguity, refuse the temptation to guess.\r\nThere should be one-- and preferably only one --obvious way to do it.\r\nAlthough that way may not be obvious at first unless you're Dutch.\r\nNow is better than never. Although never is often better than *right* now.\r\nIf the implementation is hard to explain, it's a bad idea.\r\nIf the implementation is easy to explain, it may be a good idea	4	2021-05-03 10:00:25.909991
\.


--
-- Data for Name: post_like; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.post_like (id, user_id, post_id) FROM stdin;
83	3	7
84	3	9
88	3	16
96	3	17
97	3	14
98	1	14
99	1	12
100	1	8
101	1	13
102	2	8
24	3	19
25	3	18
27	1	17
28	1	16
29	1	19
103	2	13
104	2	22
32	2	17
105	2	14
38	2	16
110	2	4
44	2	19
45	1	15
47	2	23
48	4	19
49	4	\N
50	4	16
51	4	23
58	3	15
63	2	15
67	2	18
71	2	9
72	2	7
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."user" (id, username, email, image_file, password) FROM stdin;
3	Raj	raj@gmail.com	ff82b7201ebe87fd.jpg	$2b$12$APF23PTNJm/O/pWQ7.f80u3pYq.hWa0.0yMiRepSpLb74EDXwii32
1	Hema	hema@gmail.com	default.jpg	$2b$12$4pV5mdv6MIUaTR1qE.FfiOBw5EJ..fnCJD4Bq.r4KxeVsmgcT0jwC
4	Heena	heena@gmail.com	ca933efa17ac123a.jpg	$2b$12$FtreKWK3mMC5vC8OLSxBnu.YcZcrL/yI7/j6.Di9O.CxKxM0KcrT2
2	Kruti	krutiamrutiya1998@gmail.com	e7773d32a090f3d0.jpg	$2b$12$z5rNJMaI8l5wnSWxiBiCVuUNurQqLgjOQ6/.EIghnmeH/0/rIJAte
\.


--
-- Name: comment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.comment_id_seq', 29, true);


--
-- Name: post_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.post_id_seq', 23, true);


--
-- Name: post_like_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.post_like_id_seq', 110, true);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_id_seq', 4, true);


--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: comment comment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_pkey PRIMARY KEY (id);


--
-- Name: post_like post_like_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_like
    ADD CONSTRAINT post_like_pkey PRIMARY KEY (id);


--
-- Name: post post_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post
    ADD CONSTRAINT post_pkey PRIMARY KEY (id);


--
-- Name: user user_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key UNIQUE (email);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: user user_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key UNIQUE (username);


--
-- Name: comment comment_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.post(id);


--
-- Name: comment comment_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: post_like post_like_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_like
    ADD CONSTRAINT post_like_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.post(id);


--
-- Name: post_like post_like_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_like
    ADD CONSTRAINT post_like_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: post post_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post
    ADD CONSTRAINT post_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- PostgreSQL database dump complete
--

