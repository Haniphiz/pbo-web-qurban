--
-- PostgreSQL database dump
--

\restrict CfLmqXJyfUncAepZ4cgkZfDHMCEtdF3AJ29G2g3g9l43dkhAB1UMh4Ag9FRfSW9

-- Dumped from database version 18.1
-- Dumped by pg_dump version 18.1

-- Started on 2026-01-01 21:38:06

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- TOC entry 219 (class 1259 OID 16385)
-- Name: animal_categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.animal_categories (
    category_id integer NOT NULL,
    name character varying(50) NOT NULL,
    description text
);


ALTER TABLE public.animal_categories OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16392)
-- Name: animal_categories_category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.animal_categories_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.animal_categories_category_id_seq OWNER TO postgres;

--
-- TOC entry 5125 (class 0 OID 0)
-- Dependencies: 220
-- Name: animal_categories_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.animal_categories_category_id_seq OWNED BY public.animal_categories.category_id;


--
-- TOC entry 221 (class 1259 OID 16393)
-- Name: animals; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.animals (
    animal_id integer NOT NULL,
    category_id integer,
    name character varying(100) NOT NULL,
    age integer,
    weight numeric(6,2),
    price numeric(12,2) NOT NULL,
    description text,
    stock integer DEFAULT 1,
    photo character varying(255),
    status character varying(20) DEFAULT 'available'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT animals_status_check CHECK (((status)::text = ANY (ARRAY[('available'::character varying)::text, ('sold'::character varying)::text, ('unavailable'::character varying)::text])))
);


ALTER TABLE public.animals OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16405)
-- Name: animals_animal_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.animals_animal_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.animals_animal_id_seq OWNER TO postgres;

--
-- TOC entry 5126 (class 0 OID 0)
-- Dependencies: 222
-- Name: animals_animal_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.animals_animal_id_seq OWNED BY public.animals.animal_id;


--
-- TOC entry 223 (class 1259 OID 16406)
-- Name: delivery_schedule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.delivery_schedule (
    delivery_id integer NOT NULL,
    order_id integer,
    delivery_date date,
    address text,
    driver_name character varying(100),
    status character varying(20) DEFAULT 'scheduled'::character varying,
    province character varying(100),
    city character varying(100),
    district character varying(100),
    postal_code character varying(10),
    CONSTRAINT delivery_schedule_status_check CHECK (((status)::text = ANY (ARRAY[('scheduled'::character varying)::text, ('sent'::character varying)::text, ('delivered'::character varying)::text])))
);


ALTER TABLE public.delivery_schedule OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16414)
-- Name: delivery_schedule_delivery_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.delivery_schedule_delivery_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.delivery_schedule_delivery_id_seq OWNER TO postgres;

--
-- TOC entry 5127 (class 0 OID 0)
-- Dependencies: 224
-- Name: delivery_schedule_delivery_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.delivery_schedule_delivery_id_seq OWNED BY public.delivery_schedule.delivery_id;


--
-- TOC entry 225 (class 1259 OID 16415)
-- Name: order_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_items (
    item_id integer NOT NULL,
    order_id integer,
    animal_id integer,
    quantity integer DEFAULT 1,
    price numeric(12,2)
);


ALTER TABLE public.order_items OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16420)
-- Name: order_items_item_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_items_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.order_items_item_id_seq OWNER TO postgres;

--
-- TOC entry 5128 (class 0 OID 0)
-- Dependencies: 226
-- Name: order_items_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_items_item_id_seq OWNED BY public.order_items.item_id;


--
-- TOC entry 227 (class 1259 OID 16421)
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    order_id integer NOT NULL,
    user_id integer,
    order_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    total_amount numeric(12,2),
    status character varying(20) DEFAULT 'pending'::character varying,
    notes text,
    is_confirmed boolean DEFAULT false,
    CONSTRAINT orders_status_check CHECK (((status)::text = ANY (ARRAY[('pending'::character varying)::text, ('paid'::character varying)::text, ('processed'::character varying)::text, ('shipped'::character varying)::text, ('completed'::character varying)::text, ('canceled'::character varying)::text])))
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16430)
-- Name: orders_order_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_order_id_seq OWNER TO postgres;

--
-- TOC entry 5129 (class 0 OID 0)
-- Dependencies: 228
-- Name: orders_order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_order_id_seq OWNED BY public.orders.order_id;


--
-- TOC entry 229 (class 1259 OID 16431)
-- Name: payments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payments (
    payment_id integer NOT NULL,
    order_id integer NOT NULL,
    payment_method character varying(50) NOT NULL,
    payment_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    amount numeric(12,2) NOT NULL,
    proof_image character varying(255),
    status character varying(20) DEFAULT 'pending'::character varying,
    CONSTRAINT payments_payment_method_check CHECK (((payment_method)::text = ANY (ARRAY[('transfer_bank_bca'::character varying)::text, ('transfer_bank_mandiri'::character varying)::text]))),
    CONSTRAINT payments_status_check CHECK (((status)::text = ANY (ARRAY[('pending'::character varying)::text, ('verified'::character varying)::text, ('rejected'::character varying)::text])))
);


ALTER TABLE public.payments OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 16442)
-- Name: payments_payment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payments_payment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payments_payment_id_seq OWNER TO postgres;

--
-- TOC entry 5130 (class 0 OID 0)
-- Dependencies: 230
-- Name: payments_payment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payments_payment_id_seq OWNED BY public.payments.payment_id;


--
-- TOC entry 231 (class 1259 OID 16443)
-- Name: reviews; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reviews (
    review_id integer NOT NULL,
    user_id integer,
    animal_id integer,
    rating integer,
    comment text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT reviews_rating_check CHECK (((rating >= 1) AND (rating <= 5)))
);


ALTER TABLE public.reviews OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 16451)
-- Name: reviews_review_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reviews_review_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reviews_review_id_seq OWNER TO postgres;

--
-- TOC entry 5131 (class 0 OID 0)
-- Dependencies: 232
-- Name: reviews_review_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reviews_review_id_seq OWNED BY public.reviews.review_id;


--
-- TOC entry 236 (class 1259 OID 16577)
-- Name: user_address; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_address (
    address_id integer NOT NULL,
    user_id integer NOT NULL,
    address character varying(255),
    is_default boolean DEFAULT true,
    province character varying(100),
    city character varying(100),
    district character varying(100),
    postal_code character varying(10)
);


ALTER TABLE public.user_address OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 16576)
-- Name: user_address_address_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_address_address_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_address_address_id_seq OWNER TO postgres;

--
-- TOC entry 5132 (class 0 OID 0)
-- Dependencies: 235
-- Name: user_address_address_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_address_address_id_seq OWNED BY public.user_address.address_id;


--
-- TOC entry 233 (class 1259 OID 16452)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    name character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    password character varying(255) NOT NULL,
    phone character varying(20),
    role character varying(20) DEFAULT 'customer'::character varying NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT users_role_check CHECK (((role)::text = ANY (ARRAY[('admin'::character varying)::text, ('customer'::character varying)::text])))
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 16465)
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_user_id_seq OWNER TO postgres;

--
-- TOC entry 5133 (class 0 OID 0)
-- Dependencies: 234
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- TOC entry 4896 (class 2604 OID 16466)
-- Name: animal_categories category_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.animal_categories ALTER COLUMN category_id SET DEFAULT nextval('public.animal_categories_category_id_seq'::regclass);


--
-- TOC entry 4897 (class 2604 OID 16467)
-- Name: animals animal_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.animals ALTER COLUMN animal_id SET DEFAULT nextval('public.animals_animal_id_seq'::regclass);


--
-- TOC entry 4901 (class 2604 OID 16468)
-- Name: delivery_schedule delivery_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.delivery_schedule ALTER COLUMN delivery_id SET DEFAULT nextval('public.delivery_schedule_delivery_id_seq'::regclass);


--
-- TOC entry 4903 (class 2604 OID 16469)
-- Name: order_items item_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items ALTER COLUMN item_id SET DEFAULT nextval('public.order_items_item_id_seq'::regclass);


--
-- TOC entry 4905 (class 2604 OID 16470)
-- Name: orders order_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders ALTER COLUMN order_id SET DEFAULT nextval('public.orders_order_id_seq'::regclass);


--
-- TOC entry 4909 (class 2604 OID 16471)
-- Name: payments payment_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments ALTER COLUMN payment_id SET DEFAULT nextval('public.payments_payment_id_seq'::regclass);


--
-- TOC entry 4912 (class 2604 OID 16472)
-- Name: reviews review_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews ALTER COLUMN review_id SET DEFAULT nextval('public.reviews_review_id_seq'::regclass);


--
-- TOC entry 4917 (class 2604 OID 16580)
-- Name: user_address address_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_address ALTER COLUMN address_id SET DEFAULT nextval('public.user_address_address_id_seq'::regclass);


--
-- TOC entry 4914 (class 2604 OID 16473)
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- TOC entry 5102 (class 0 OID 16385)
-- Dependencies: 219
-- Data for Name: animal_categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.animal_categories (category_id, name, description) FROM stdin;
1	Sapi	Kategori untuk hewan sapi
2	Kambing	Kategori untuk hewan kambing
3	Domba	Kategori untuk hewan domba
\.


--
-- TOC entry 5104 (class 0 OID 16393)
-- Dependencies: 221
-- Data for Name: animals; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.animals (animal_id, category_id, name, age, weight, price, description, stock, photo, status, created_at) FROM stdin;
19	1	Sapi sulsel	5	70.00	25000000.00	bagus	1	4d03f9cb-f03d-4b8e-9f58-45eb8ff8a328_20251209_213237_lmc_8.4.jpg	available	2025-12-31 14:34:05.081521
20	1	sapi limosin	6	250.00	31500000.00	sapi kuat djadadassd adiasdadjk adjavs asdkjafa\r\nfkfakfnas\r\najfi\r\nsdjakdadawhfbge\r\nfaejgasf\r\nfaejsfiheaf\r\nfajenkgdbslfawkfonklf	1	37199259-d2a0-4b4b-aa51-335480b18a8f_HanipHizbulHaq_0110224029.png	available	2025-12-31 19:08:06.816435
21	2	kambing sunda	4	50.00	3700000.00	sehat	0	5707bb48-3813-4db8-8aed-45c986075b22_HanipHizbulHaq_0110224029.png	sold	2026-01-01 20:11:14.310167
\.


--
-- TOC entry 5106 (class 0 OID 16406)
-- Dependencies: 223
-- Data for Name: delivery_schedule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.delivery_schedule (delivery_id, order_id, delivery_date, address, driver_name, status, province, city, district, postal_code) FROM stdin;
37	49	2025-12-31	ba	\N	scheduled	jawa barat	bogor	parungpanjang	16360
38	50	2025-12-31	baca	\N	scheduled	jawa barat	bogor	parungpanjang	16360
39	51	2025-12-31	adakda	\N	scheduled	jawa barat	bogor	parungpanjang	16360
40	52	2025-12-31	ccc	\N	scheduled	jawa barat	bogor	parungpanjang	16360
41	53	2025-12-31	baca	\N	scheduled	jawa barat	bogor	parungpanjang	16360
42	54	2026-01-01	basdad	\N	scheduled	jawa barat	bogor	parungpanjang	16360
43	55	2026-01-01	bacaada	\N	scheduled	jawa barat	bogor	parungpanjang	16360
44	56	2026-01-01	baca	\N	scheduled	jawa barat	bogor	parungpanjang	16360
45	57	2026-01-01	baca	\N	scheduled	jawa barat	bogor	parungpanjang	16360
46	58	2026-01-01	baca	\N	scheduled	jawa barat	bogor	parungpanjang	16360
47	59	2026-01-01	baca	\N	scheduled	jawa barat	bogor	parungpanjang	16360
48	60	2026-01-01	baca	\N	scheduled	jawa barat	bogor	parungpanjang	16360
49	61	2026-01-01	baca	\N	scheduled	jawa barat	bogor	parungpanjang	16360
50	62	2026-01-01	baca	\N	scheduled	jawa barat	bogor	parungpanjang	16360
\.


--
-- TOC entry 5108 (class 0 OID 16415)
-- Dependencies: 225
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_items (item_id, order_id, animal_id, quantity, price) FROM stdin;
37	49	19	1	25000000.00
38	50	20	1	31500000.00
39	51	20	1	31500000.00
40	52	19	1	25000000.00
41	53	19	1	25000000.00
42	54	19	1	25000000.00
43	55	19	1	25000000.00
44	56	19	1	25000000.00
45	57	20	1	31500000.00
46	58	19	1	25000000.00
47	59	19	1	25000000.00
48	60	20	1	31500000.00
49	61	21	1	3700000.00
50	62	21	1	3700000.00
\.


--
-- TOC entry 5110 (class 0 OID 16421)
-- Dependencies: 227
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (order_id, user_id, order_date, total_amount, status, notes, is_confirmed) FROM stdin;
49	4	2025-12-31 21:02:25.311777	25000000.00	pending	\N	f
50	4	2025-12-31 21:19:01.872852	31500000.00	paid	\N	t
51	4	2025-12-31 21:32:38.481737	31500000.00	paid	\N	f
52	4	2025-12-31 21:55:02.379515	25000000.00	paid	\N	f
54	4	2026-01-01 13:17:31.420932	25000000.00	pending	\N	f
55	4	2026-01-01 13:20:48.142474	25000000.00	paid	\N	f
56	4	2026-01-01 13:46:04.141217	25000000.00	pending	\N	f
57	4	2026-01-01 15:26:35.732405	31500000.00	pending	\N	f
58	4	2026-01-01 15:51:21.745127	25000000.00	pending	\N	f
59	4	2026-01-01 16:01:14.866928	25000000.00	pending	\N	f
60	4	2026-01-01 20:09:34.676318	31500000.00	pending	\N	f
53	4	2025-12-31 22:03:10.312295	25000000.00	paid	\N	f
61	4	2026-01-01 20:11:47.899283	3700000.00	paid	\N	f
62	4	2026-01-01 21:26:29.725541	3700000.00	paid	\N	f
\.


--
-- TOC entry 5112 (class 0 OID 16431)
-- Dependencies: 229
-- Data for Name: payments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payments (payment_id, order_id, payment_method, payment_date, amount, proof_image, status) FROM stdin;
20	49	transfer_bank_mandiri	2025-12-31 21:02:34.292281	25000000.00	HanipHizbulHaq_0110224029.png	verified
21	50	transfer_bank_bca	2025-12-31 21:19:13.21292	31500000.00	Screenshot 2025-01-11 093416.png	verified
22	51	transfer_bank_bca	2025-12-31 21:32:48.207659	31500000.00	HanipHizbulHaq_0110224029.png	verified
23	52	transfer_bank_mandiri	2025-12-31 21:55:11.31097	25000000.00	HanipHizbulHaq_0110224029.png	verified
25	54	transfer_bank_bca	2026-01-01 13:17:43.784367	25000000.00	1767248263568_Screenshot 2025-01-09 072425.png	pending
26	55	transfer_bank_mandiri	2026-01-01 13:21:07.106851	25000000.00	1767248467007_Screenshot 2025-01-11 093218.png	verified
27	56	transfer_bank_mandiri	2026-01-01 13:46:19.550525	25000000.00	1767249979430_Screenshot 2025-12-23 142443.png	pending
28	60	transfer_bank_bca	2026-01-01 20:09:46.695708	31500000.00	1767272986523_Screenshot 2025-01-11 095518.png	pending
24	53	transfer_bank_bca	2025-12-31 22:03:19.643401	25000000.00	HanipHizbulHaq_0110224029.png	verified
29	61	transfer_bank_mandiri	2026-01-01 20:12:10.64243	3700000.00	1767273130518_Screenshot 2025-12-25 143624.png	verified
30	62	transfer_bank_bca	2026-01-01 21:26:49.996241	3700000.00	1767277609890_Screenshot 2026-01-01 160339.png	verified
\.


--
-- TOC entry 5114 (class 0 OID 16443)
-- Dependencies: 231
-- Data for Name: reviews; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reviews (review_id, user_id, animal_id, rating, comment, created_at) FROM stdin;
\.


--
-- TOC entry 5119 (class 0 OID 16577)
-- Dependencies: 236
-- Data for Name: user_address; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_address (address_id, user_id, address, is_default, province, city, district, postal_code) FROM stdin;
1	4	baca	t	jawa barat	bogor	parungpanjang	16360
\.


--
-- TOC entry 5116 (class 0 OID 16452)
-- Dependencies: 233
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (user_id, name, email, password, phone, role, created_at) FROM stdin;
8	Admin	admin@gmail.com	admin123	08123456789	admin	2025-12-16 14:33:01.787682
9	han	han@gmail.com	han12	123	customer	2025-12-16 16:42:51.844771
4	Hanip hizbul haq	haniphiz132@gmail.com	haha1	081287820440	customer	2025-12-11 15:21:41.411243
10	isan	isan@gmail.com	isan	011	customer	2025-12-28 20:13:07.059287
\.


--
-- TOC entry 5134 (class 0 OID 0)
-- Dependencies: 220
-- Name: animal_categories_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.animal_categories_category_id_seq', 1, false);


--
-- TOC entry 5135 (class 0 OID 0)
-- Dependencies: 222
-- Name: animals_animal_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.animals_animal_id_seq', 21, true);


--
-- TOC entry 5136 (class 0 OID 0)
-- Dependencies: 224
-- Name: delivery_schedule_delivery_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.delivery_schedule_delivery_id_seq', 50, true);


--
-- TOC entry 5137 (class 0 OID 0)
-- Dependencies: 226
-- Name: order_items_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_items_item_id_seq', 50, true);


--
-- TOC entry 5138 (class 0 OID 0)
-- Dependencies: 228
-- Name: orders_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_order_id_seq', 62, true);


--
-- TOC entry 5139 (class 0 OID 0)
-- Dependencies: 230
-- Name: payments_payment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payments_payment_id_seq', 30, true);


--
-- TOC entry 5140 (class 0 OID 0)
-- Dependencies: 232
-- Name: reviews_review_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reviews_review_id_seq', 1, true);


--
-- TOC entry 5141 (class 0 OID 0)
-- Dependencies: 235
-- Name: user_address_address_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_address_address_id_seq', 1, true);


--
-- TOC entry 5142 (class 0 OID 0)
-- Dependencies: 234
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_user_id_seq', 10, true);


--
-- TOC entry 4927 (class 2606 OID 16475)
-- Name: animal_categories animal_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.animal_categories
    ADD CONSTRAINT animal_categories_pkey PRIMARY KEY (category_id);


--
-- TOC entry 4929 (class 2606 OID 16477)
-- Name: animals animals_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.animals
    ADD CONSTRAINT animals_pkey PRIMARY KEY (animal_id);


--
-- TOC entry 4931 (class 2606 OID 16479)
-- Name: delivery_schedule delivery_schedule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.delivery_schedule
    ADD CONSTRAINT delivery_schedule_pkey PRIMARY KEY (delivery_id);


--
-- TOC entry 4933 (class 2606 OID 16481)
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (item_id);


--
-- TOC entry 4935 (class 2606 OID 16483)
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_id);


--
-- TOC entry 4937 (class 2606 OID 16485)
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (payment_id);


--
-- TOC entry 4939 (class 2606 OID 16487)
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (review_id);


--
-- TOC entry 4945 (class 2606 OID 16585)
-- Name: user_address user_address_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_address
    ADD CONSTRAINT user_address_pkey PRIMARY KEY (address_id);


--
-- TOC entry 4941 (class 2606 OID 16489)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 4943 (class 2606 OID 16491)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- TOC entry 4946 (class 2606 OID 16492)
-- Name: animals animals_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.animals
    ADD CONSTRAINT animals_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.animal_categories(category_id) ON DELETE CASCADE;


--
-- TOC entry 4947 (class 2606 OID 16497)
-- Name: delivery_schedule delivery_schedule_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.delivery_schedule
    ADD CONSTRAINT delivery_schedule_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(order_id) ON DELETE CASCADE;


--
-- TOC entry 4951 (class 2606 OID 16502)
-- Name: payments fk_payment_order; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT fk_payment_order FOREIGN KEY (order_id) REFERENCES public.orders(order_id);


--
-- TOC entry 4948 (class 2606 OID 16507)
-- Name: order_items order_items_animal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_animal_id_fkey FOREIGN KEY (animal_id) REFERENCES public.animals(animal_id) ON DELETE SET NULL;


--
-- TOC entry 4949 (class 2606 OID 16512)
-- Name: order_items order_items_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(order_id) ON DELETE CASCADE;


--
-- TOC entry 4950 (class 2606 OID 16517)
-- Name: orders orders_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- TOC entry 4952 (class 2606 OID 16522)
-- Name: reviews reviews_animal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_animal_id_fkey FOREIGN KEY (animal_id) REFERENCES public.animals(animal_id) ON DELETE CASCADE;


--
-- TOC entry 4953 (class 2606 OID 16527)
-- Name: reviews reviews_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- TOC entry 4954 (class 2606 OID 16586)
-- Name: user_address user_address_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_address
    ADD CONSTRAINT user_address_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


-- Completed on 2026-01-01 21:38:07

--
-- PostgreSQL database dump complete
--

\unrestrict CfLmqXJyfUncAepZ4cgkZfDHMCEtdF3AJ29G2g3g9l43dkhAB1UMh4Ag9FRfSW9

