--
-- PostgreSQL database dump
--

-- Dumped from database version 16.1
-- Dumped by pg_dump version 16.1

-- Started on 2025-06-13 11:38:14

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
-- TOC entry 4908 (class 1262 OID 17003)
-- Name: budgetquest; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE budgetquest WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Italian_Italy.1252';


ALTER DATABASE budgetquest OWNER TO postgres;

\connect budgetquest

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
-- TOC entry 228 (class 1259 OID 17270)
-- Name: achievements; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.achievements (
    id integer NOT NULL,
    code character varying(50) NOT NULL,
    name character varying(100) NOT NULL,
    description text NOT NULL,
    points_reward integer DEFAULT 0,
    xp_reward integer DEFAULT 0,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.achievements OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 17269)
-- Name: achievements_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.achievements_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.achievements_id_seq OWNER TO postgres;

--
-- TOC entry 4909 (class 0 OID 0)
-- Dependencies: 227
-- Name: achievements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.achievements_id_seq OWNED BY public.achievements.id;


--
-- TOC entry 218 (class 1259 OID 17090)
-- Name: assets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.assets (
    id integer NOT NULL,
    user_id integer,
    name character varying(100) NOT NULL,
    type character varying(50) NOT NULL,
    value numeric(12,2) NOT NULL,
    acquired_date date,
    notes text,
    is_liquid boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    last_updated timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    is_deleted boolean DEFAULT false
);


ALTER TABLE public.assets OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 17089)
-- Name: assets_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.assets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.assets_id_seq OWNER TO postgres;

--
-- TOC entry 4910 (class 0 OID 0)
-- Dependencies: 217
-- Name: assets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.assets_id_seq OWNED BY public.assets.id;


--
-- TOC entry 224 (class 1259 OID 17169)
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    id integer NOT NULL,
    user_id integer NOT NULL,
    name character varying(50) NOT NULL,
    type character varying(20) NOT NULL,
    is_deleted boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT categories_type_check CHECK (((type)::text = ANY ((ARRAY['income'::character varying, 'expense'::character varying])::text[])))
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 17168)
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categories_id_seq OWNER TO postgres;

--
-- TOC entry 4911 (class 0 OID 0)
-- Dependencies: 223
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- TOC entry 222 (class 1259 OID 17135)
-- Name: liabilities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.liabilities (
    id integer NOT NULL,
    user_id integer NOT NULL,
    name character varying(100) NOT NULL,
    type character varying(50) NOT NULL,
    amount numeric(12,2) NOT NULL,
    amount_remaining numeric(12,2),
    interest_rate numeric(5,2),
    start_date date,
    due_date date,
    notes text,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    last_updated timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    is_deleted boolean DEFAULT false
);


ALTER TABLE public.liabilities OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 17134)
-- Name: liabilities_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.liabilities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.liabilities_id_seq OWNER TO postgres;

--
-- TOC entry 4912 (class 0 OID 0)
-- Dependencies: 221
-- Name: liabilities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.liabilities_id_seq OWNED BY public.liabilities.id;


--
-- TOC entry 231 (class 1259 OID 17346)
-- Name: net_worth_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.net_worth_history (
    id integer NOT NULL,
    user_id integer NOT NULL,
    date date NOT NULL,
    assets_value numeric(12,2) NOT NULL,
    liabilities_value numeric(12,2) NOT NULL,
    net_worth numeric(12,2) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.net_worth_history OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 17345)
-- Name: net_worth_history_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.net_worth_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.net_worth_history_id_seq OWNER TO postgres;

--
-- TOC entry 4913 (class 0 OID 0)
-- Dependencies: 230
-- Name: net_worth_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.net_worth_history_id_seq OWNED BY public.net_worth_history.id;


--
-- TOC entry 226 (class 1259 OID 17204)
-- Name: transactions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transactions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    category_id integer,
    name character varying(50) NOT NULL,
    date date NOT NULL,
    amount numeric(12,2) NOT NULL,
    description text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.transactions OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 17203)
-- Name: transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.transactions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.transactions_id_seq OWNER TO postgres;

--
-- TOC entry 4914 (class 0 OID 0)
-- Dependencies: 225
-- Name: transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.transactions_id_seq OWNED BY public.transactions.id;


--
-- TOC entry 229 (class 1259 OID 17283)
-- Name: user_achievements; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_achievements (
    user_id integer NOT NULL,
    achievement_id integer NOT NULL,
    unlocked_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.user_achievements OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 17072)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(50) NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    email character varying(100) NOT NULL,
    password_hash text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    is_deleted boolean DEFAULT false,
    xp integer DEFAULT 0,
    level integer DEFAULT 1,
    points integer DEFAULT 0,
    last_login timestamp without time zone,
    preferred_currency character varying(10) DEFAULT 'EUR'::character varying,
    currency_symbol character varying(5) DEFAULT '€'::character varying,
    last_streak_date date,
    current_streak integer DEFAULT 0,
    theme character varying(20) DEFAULT 'light'::character varying
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 17071)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 4915 (class 0 OID 0)
-- Dependencies: 215
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 220 (class 1259 OID 17108)
-- Name: xp_givers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.xp_givers (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    description character varying(200) NOT NULL,
    value integer DEFAULT 50,
    is_deleted boolean DEFAULT false
);


ALTER TABLE public.xp_givers OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 17107)
-- Name: xp_givers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.xp_givers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.xp_givers_id_seq OWNER TO postgres;

--
-- TOC entry 4916 (class 0 OID 0)
-- Dependencies: 219
-- Name: xp_givers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.xp_givers_id_seq OWNED BY public.xp_givers.id;


--
-- TOC entry 4701 (class 2604 OID 17273)
-- Name: achievements id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.achievements ALTER COLUMN id SET DEFAULT nextval('public.achievements_id_seq'::regclass);


--
-- TOC entry 4683 (class 2604 OID 17093)
-- Name: assets id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assets ALTER COLUMN id SET DEFAULT nextval('public.assets_id_seq'::regclass);


--
-- TOC entry 4696 (class 2604 OID 17172)
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- TOC entry 4691 (class 2604 OID 17138)
-- Name: liabilities id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.liabilities ALTER COLUMN id SET DEFAULT nextval('public.liabilities_id_seq'::regclass);


--
-- TOC entry 4706 (class 2604 OID 17349)
-- Name: net_worth_history id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.net_worth_history ALTER COLUMN id SET DEFAULT nextval('public.net_worth_history_id_seq'::regclass);


--
-- TOC entry 4699 (class 2604 OID 17207)
-- Name: transactions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions ALTER COLUMN id SET DEFAULT nextval('public.transactions_id_seq'::regclass);


--
-- TOC entry 4673 (class 2604 OID 17075)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 4688 (class 2604 OID 17111)
-- Name: xp_givers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.xp_givers ALTER COLUMN id SET DEFAULT nextval('public.xp_givers_id_seq'::regclass);


--
-- TOC entry 4899 (class 0 OID 17270)
-- Dependencies: 228
-- Data for Name: achievements; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.achievements VALUES (1, 'FIRST_EXPENSE', 'First Expense', 'Log your first expense', 100, 500, '2025-06-12 16:13:54.576348');
INSERT INTO public.achievements VALUES (2, 'FIRST_INCOME', 'First Income', 'Log your first income', 100, 1000, '2025-06-12 16:13:54.576348');
INSERT INTO public.achievements VALUES (7, 'FIRST_BIG_EXPENSE', 'This was a big one!', 'Log your first big expense', 1000, 1000, '2025-06-12 16:13:54.576');
INSERT INTO public.achievements VALUES (8, 'FIRST_BIG_INCOME', 'Get that check!', 'Log your first big income', 1000, 5000, '2025-06-12 16:13:54.576');
INSERT INTO public.achievements VALUES (5, 'LEVEL_10', 'Level Up!', 'Reach level 10', 100, 500, '2025-06-12 16:13:54.576348');
INSERT INTO public.achievements VALUES (9, 'LEVEL_50', 'Half way there!', 'Get to level 50', 1000, 5000, '2025-06-12 16:13:54.576');
INSERT INTO public.achievements VALUES (10, 'LEVEL_100', 'Conquered the peak ... or did you?', 'Get to level 100', 1000, 10000, '2025-06-12 16:13:54.576');
INSERT INTO public.achievements VALUES (12, 'LOGIN_STREAK_14_DAYS', '14 days!', 'You logged in for 14 days straight.\\nGood job!', 200, 500, '2025-06-12 21:51:27.089761');
INSERT INTO public.achievements VALUES (11, 'LOGIN_STREAK_7_DAYS', '7 days!', 'You logged in for 7 days straight.\\nGood job!', 100, 500, '2025-06-12 21:43:31.284929');
INSERT INTO public.achievements VALUES (13, 'LOGIN_STREAK_30_DAYS', '30 days!', 'You logged in for 30 days straight.\\nGood job!', 500, 1000, '2025-06-12 21:52:13.289764');


--
-- TOC entry 4889 (class 0 OID 17090)
-- Dependencies: 218
-- Data for Name: assets; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.assets VALUES (66, 8, 'asset1', 'asset1', 100000.00, '2025-06-13', '', true, '2025-06-13 11:30:53.880566', '2025-06-13 11:30:53.880566', false);
INSERT INTO public.assets VALUES (67, 8, 'asset2', 'asset2', 10000000.00, '2025-06-15', '', false, '2025-06-13 11:32:09.1899', '2025-06-13 11:32:09.1899', false);


--
-- TOC entry 4895 (class 0 OID 17169)
-- Dependencies: 224
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4893 (class 0 OID 17135)
-- Dependencies: 222
-- Data for Name: liabilities; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.liabilities VALUES (5, 8, 'liability1', 'liability1', 500000.00, 500000.00, 2.00, '2025-06-13', '2025-06-15', '', true, '2025-06-13 11:31:46.465403', '2025-06-13 11:31:46.465403', false);


--
-- TOC entry 4902 (class 0 OID 17346)
-- Dependencies: 231
-- Data for Name: net_worth_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.net_worth_history VALUES (1, 8, '2025-06-13', 100000.00, 0.00, 100000.00, '2025-06-13 11:31:15.002148');
INSERT INTO public.net_worth_history VALUES (2, 8, '2025-06-14', 10100000.00, 500000.00, 9600000.00, '2025-06-13 11:32:26.634387');


--
-- TOC entry 4897 (class 0 OID 17204)
-- Dependencies: 226
-- Data for Name: transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4900 (class 0 OID 17283)
-- Dependencies: 229
-- Data for Name: user_achievements; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.user_achievements VALUES (8, 11, '2025-06-12 21:54:11.509537');
INSERT INTO public.user_achievements VALUES (8, 12, '2025-06-12 21:54:58.765955');
INSERT INTO public.user_achievements VALUES (8, 13, '2025-06-12 21:56:06.608037');


--
-- TOC entry 4887 (class 0 OID 17072)
-- Dependencies: 216
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users VALUES (12, 'test2', 'test2', 'test2', 'test2', '$2a$10$s0pGe1aKoociGePuUeqSTeVAW0wcDCK2awmFR.72M7V7Wn8aLaSS6', '2025-06-13 11:25:20.065', false, 0, 1, 1000, NULL, 'EUR', '€', NULL, 0, 'light');
INSERT INTO public.users VALUES (8, 'dadepremo', 'Davide', 'Premoli', 'davide.premoli03@gmail.com', '$2a$10$NGzsk80P4fICp2Sy8b5M3.iSYmHvJODnjVBc9Hfll37mQyY9tv9jO', '2025-06-10 22:17:00.124', false, 1000, 3, 2000, '2025-06-13 11:34:07.128902', 'EUR', '€', '2025-06-13', 1, 'dark');
INSERT INTO public.users VALUES (11, 'test1', 'test1', 'test1', 'test1', '$2a$10$GXVs/bhEfbFO2LH2aujZve0oYV.GLUVWhLV42r7o4d9Xr8Ljki34G', '2025-06-12 13:41:36.471', false, 0, 1, 0, '2025-06-12 20:26:20.770369', 'GBP', '£', NULL, 0, 'light');
INSERT INTO public.users VALUES (10, 'admin', 'admin', 'admin', 'admin', '$2a$10$tcTEBmAFIMywWA3s/yihsOMxK0rOtAIMIzGFcHBnQ.BEydJDfpiO6', '2025-06-11 00:29:48.219', false, 0, 1, 0, '2025-06-11 00:29:53.894759', 'EUR', '€', NULL, 0, 'light');


--
-- TOC entry 4891 (class 0 OID 17108)
-- Dependencies: 220
-- Data for Name: xp_givers; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.xp_givers VALUES (2, 'normalLiabilityBonus', 'Bonus given when a liability is added to the portfolio', -500, false);
INSERT INTO public.xp_givers VALUES (1, 'normalAssetBonus', 'Bonus given when an asset is added to the portfolio', 1000, false);


--
-- TOC entry 4917 (class 0 OID 0)
-- Dependencies: 227
-- Name: achievements_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.achievements_id_seq', 13, true);


--
-- TOC entry 4918 (class 0 OID 0)
-- Dependencies: 217
-- Name: assets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.assets_id_seq', 67, true);


--
-- TOC entry 4919 (class 0 OID 0)
-- Dependencies: 223
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_id_seq', 23, true);


--
-- TOC entry 4920 (class 0 OID 0)
-- Dependencies: 221
-- Name: liabilities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.liabilities_id_seq', 5, true);


--
-- TOC entry 4921 (class 0 OID 0)
-- Dependencies: 230
-- Name: net_worth_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.net_worth_history_id_seq', 2, true);


--
-- TOC entry 4922 (class 0 OID 0)
-- Dependencies: 225
-- Name: transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.transactions_id_seq', 106, true);


--
-- TOC entry 4923 (class 0 OID 0)
-- Dependencies: 215
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 12, true);


--
-- TOC entry 4924 (class 0 OID 0)
-- Dependencies: 219
-- Name: xp_givers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.xp_givers_id_seq', 1, true);


--
-- TOC entry 4726 (class 2606 OID 17282)
-- Name: achievements achievements_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.achievements
    ADD CONSTRAINT achievements_code_key UNIQUE (code);


--
-- TOC entry 4728 (class 2606 OID 17280)
-- Name: achievements achievements_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.achievements
    ADD CONSTRAINT achievements_pkey PRIMARY KEY (id);


--
-- TOC entry 4716 (class 2606 OID 17101)
-- Name: assets assets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assets
    ADD CONSTRAINT assets_pkey PRIMARY KEY (id);


--
-- TOC entry 4722 (class 2606 OID 17177)
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- TOC entry 4720 (class 2606 OID 17146)
-- Name: liabilities liabilities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.liabilities
    ADD CONSTRAINT liabilities_pkey PRIMARY KEY (id);


--
-- TOC entry 4732 (class 2606 OID 17352)
-- Name: net_worth_history net_worth_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.net_worth_history
    ADD CONSTRAINT net_worth_history_pkey PRIMARY KEY (id);


--
-- TOC entry 4724 (class 2606 OID 17212)
-- Name: transactions transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (id);


--
-- TOC entry 4734 (class 2606 OID 17354)
-- Name: net_worth_history unique_user_date; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.net_worth_history
    ADD CONSTRAINT unique_user_date UNIQUE (user_id, date);


--
-- TOC entry 4730 (class 2606 OID 17288)
-- Name: user_achievements user_achievements_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_achievements
    ADD CONSTRAINT user_achievements_pkey PRIMARY KEY (user_id, achievement_id);


--
-- TOC entry 4710 (class 2606 OID 17086)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 4712 (class 2606 OID 17084)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 4714 (class 2606 OID 17088)
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- TOC entry 4718 (class 2606 OID 17115)
-- Name: xp_givers xp_givers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.xp_givers
    ADD CONSTRAINT xp_givers_pkey PRIMARY KEY (id);


--
-- TOC entry 4735 (class 2606 OID 17102)
-- Name: assets assets_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assets
    ADD CONSTRAINT assets_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 4737 (class 2606 OID 17178)
-- Name: categories categories_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 4742 (class 2606 OID 17355)
-- Name: net_worth_history fk_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.net_worth_history
    ADD CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 4736 (class 2606 OID 17147)
-- Name: liabilities liabilities_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.liabilities
    ADD CONSTRAINT liabilities_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 4738 (class 2606 OID 17218)
-- Name: transactions transactions_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id) ON DELETE SET NULL;


--
-- TOC entry 4739 (class 2606 OID 17213)
-- Name: transactions transactions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 4740 (class 2606 OID 17294)
-- Name: user_achievements user_achievements_achievement_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_achievements
    ADD CONSTRAINT user_achievements_achievement_id_fkey FOREIGN KEY (achievement_id) REFERENCES public.achievements(id) ON DELETE CASCADE;


--
-- TOC entry 4741 (class 2606 OID 17289)
-- Name: user_achievements user_achievements_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_achievements
    ADD CONSTRAINT user_achievements_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


-- Completed on 2025-06-13 11:38:14

--
-- PostgreSQL database dump complete
--

