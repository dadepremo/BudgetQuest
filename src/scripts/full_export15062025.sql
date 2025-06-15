--
-- PostgreSQL database dump
--

-- Dumped from database version 16.1
-- Dumped by pg_dump version 16.1

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
-- Name: achievements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.achievements_id_seq OWNED BY public.achievements.id;


--
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
-- Name: assets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.assets_id_seq OWNED BY public.assets.id;


--
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
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
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
-- Name: liabilities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.liabilities_id_seq OWNED BY public.liabilities.id;


--
-- Name: login_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.login_history (
    id integer NOT NULL,
    user_id integer NOT NULL,
    login_date date NOT NULL
);


ALTER TABLE public.login_history OWNER TO postgres;

--
-- Name: login_history_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.login_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.login_history_id_seq OWNER TO postgres;

--
-- Name: login_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.login_history_id_seq OWNED BY public.login_history.id;


--
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
-- Name: net_worth_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.net_worth_history_id_seq OWNED BY public.net_worth_history.id;


--
-- Name: shop_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shop_items (
    id integer NOT NULL,
    name text NOT NULL,
    description text,
    price integer NOT NULL,
    category text,
    available boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.shop_items OWNER TO postgres;

--
-- Name: shop_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.shop_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.shop_items_id_seq OWNER TO postgres;

--
-- Name: shop_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.shop_items_id_seq OWNED BY public.shop_items.id;


--
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
-- Name: transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.transactions_id_seq OWNED BY public.transactions.id;


--
-- Name: user_achievements; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_achievements (
    user_id integer NOT NULL,
    achievement_id integer NOT NULL,
    unlocked_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.user_achievements OWNER TO postgres;

--
-- Name: user_friends; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_friends (
    user_id integer NOT NULL,
    friend_id integer NOT NULL,
    status character varying(20) DEFAULT 'pending'::character varying NOT NULL,
    requested_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    accepted_at timestamp without time zone,
    CONSTRAINT user_friends_no_self_friend CHECK ((user_id <> friend_id))
);


ALTER TABLE public.user_friends OWNER TO postgres;

--
-- Name: user_purchases; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_purchases (
    id integer NOT NULL,
    user_id integer NOT NULL,
    item_id integer NOT NULL,
    purchased_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.user_purchases OWNER TO postgres;

--
-- Name: user_purchases_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_purchases_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_purchases_id_seq OWNER TO postgres;

--
-- Name: user_purchases_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_purchases_id_seq OWNED BY public.user_purchases.id;


--
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
    points integer DEFAULT 0 NOT NULL,
    last_login timestamp without time zone,
    preferred_currency character varying(10) DEFAULT 'EUR'::character varying,
    currency_symbol character varying(5) DEFAULT '€'::character varying,
    last_streak_date date,
    current_streak integer DEFAULT 0,
    theme character varying(20) DEFAULT 'light'::character varying
);


ALTER TABLE public.users OWNER TO postgres;

--
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
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
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
-- Name: xp_givers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.xp_givers_id_seq OWNED BY public.xp_givers.id;


--
-- Name: achievements id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.achievements ALTER COLUMN id SET DEFAULT nextval('public.achievements_id_seq'::regclass);


--
-- Name: assets id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assets ALTER COLUMN id SET DEFAULT nextval('public.assets_id_seq'::regclass);


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: liabilities id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.liabilities ALTER COLUMN id SET DEFAULT nextval('public.liabilities_id_seq'::regclass);


--
-- Name: login_history id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.login_history ALTER COLUMN id SET DEFAULT nextval('public.login_history_id_seq'::regclass);


--
-- Name: net_worth_history id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.net_worth_history ALTER COLUMN id SET DEFAULT nextval('public.net_worth_history_id_seq'::regclass);


--
-- Name: shop_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shop_items ALTER COLUMN id SET DEFAULT nextval('public.shop_items_id_seq'::regclass);


--
-- Name: transactions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions ALTER COLUMN id SET DEFAULT nextval('public.transactions_id_seq'::regclass);


--
-- Name: user_purchases id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_purchases ALTER COLUMN id SET DEFAULT nextval('public.user_purchases_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: xp_givers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.xp_givers ALTER COLUMN id SET DEFAULT nextval('public.xp_givers_id_seq'::regclass);


--
-- Data for Name: achievements; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.achievements (id, code, name, description, points_reward, xp_reward, created_at) FROM stdin;
1	FIRST_EXPENSE	First Expense	Log your first expense	100	500	2025-06-12 16:13:54.576348
2	FIRST_INCOME	First Income	Log your first income	100	1000	2025-06-12 16:13:54.576348
12	LOGIN_STREAK_14_DAYS	14 days!	You logged in for 14 days straight.&Good job!	200	500	2025-06-12 21:51:27.089761
7	FIRST_BIG_EXPENSE	This was a big one!	Log your first big expense	1000	1000	2025-06-12 16:13:54.576
8	FIRST_BIG_INCOME	Get that check!	Log your first big income	1000	5000	2025-06-12 16:13:54.576
5	LEVEL_10	Level Up!	Reach level 10	100	500	2025-06-12 16:13:54.576348
9	LEVEL_50	Half way there!	Get to level 50	1000	5000	2025-06-12 16:13:54.576
10	LEVEL_100	Conquered the peak ... or did you?	Get to level 100	1000	10000	2025-06-12 16:13:54.576
11	LOGIN_STREAK_7_DAYS	7 days!	You logged in for 7 days straight.&Good job!	100	500	2025-06-12 21:43:31.284929
14	WEEKLY_SAVER	Weekly Saver	Save money every week for a month	500	2000	2025-06-13 11:46:21.288174
15	MONTHLY_BUDGET_MASTER	Monthly Budget Master	Stick to your budget for a month	200	1200	2025-06-13 11:46:21.288174
16	CATEGORY_TRACKER	Category Tracker	Track spending in 5 different categories	200	800	2025-06-13 11:46:21.288174
17	DAILY_LOGGER_7	Daily Logger	Log a transaction every day for a week	300	900	2025-06-13 11:46:21.288174
18	DAILY_LOGGER_30	Consistent Logger	Log a transaction daily for 30 days	1000	3000	2025-06-13 11:46:21.288174
19	SAVED_1000	Saved 1000	Save a total of 1000 credits	500	2500	2025-06-13 11:46:21.288174
20	SAVED_10000	Saved 10k	Save a total of 10,000 credits	1000	5000	2025-06-13 11:46:21.288174
21	TRACKED_100_EXPENSES	Expense Analyst	Track 100 expenses	700	2000	2025-06-13 11:46:21.288174
22	TRACKED_100_INCOMES	Income Tracker	Track 100 income entries	700	2000	2025-06-13 11:46:21.288174
23	NO_SPENDING_WEEK	No-Spend Week	Spend nothing for 7 days straight	1000	1500	2025-06-13 11:46:21.288174
24	ADDED_10_CATEGORIES	Organizer	Add 10 custom categories	300	900	2025-06-13 11:46:21.288174
25	ADDED_50_CATEGORIES	Master Organizer	Add 50 custom categories	600	1800	2025-06-13 11:46:21.288174
26	BUDGET_SET_5	Budget Beginner	Set 5 budgets	300	700	2025-06-13 11:46:21.288174
27	BUDGET_SET_20	Budget Pro	Set 20 budgets	800	1600	2025-06-13 11:46:21.288174
28	BUDGET_GOAL_REACHED	Goal Achiever	Reach a budget goal	400	1000	2025-06-13 11:46:21.288174
29	EXPENSE_TAGGER	Tag It!	Tag 50 expenses	300	600	2025-06-13 11:46:21.288174
30	INCOME_TAGGER	Smart Earner	Tag 50 incomes	300	600	2025-06-13 11:46:21.288174
31	REVIEWED_STATS	Data Lover	Check your statistics page	100	250	2025-06-13 11:46:21.288174
32	EXPORT_CSV	Export Master	Export your data to CSV	100	300	2025-06-13 11:46:21.288174
33	THEMES_CHANGED	Style Changer	Try both light and dark themes	200	400	2025-06-13 11:46:21.288174
34	FIRST_GOAL_SET	First Goal!	Set your first saving goal	200	500	2025-06-13 11:46:21.288174
35	GOAL_REACHED	Goal Met!	Reach a saving goal	400	1200	2025-06-13 11:46:21.288174
36	GOAL_REACHED_5X	Serial Achiever	Reach 5 saving goals	800	2000	2025-06-13 11:46:21.288174
37	TRACKED_100_TRANSACTIONS	Money Mover	Track 100 transactions total	600	1800	2025-06-13 11:46:21.288174
38	TRACKED_1000_TRANSACTIONS	Money Manager	Track 1000 transactions total	1200	3500	2025-06-13 11:46:21.288174
39	DELETED_TRANSACTION	Oops!	Delete a transaction	50	150	2025-06-13 11:46:21.288174
40	FIRST_TAG_CREATED	Custom Tagger	Create a custom tag	150	400	2025-06-13 11:46:21.288174
41	FREQUENT_LOGGER	Habitual Logger	Log at least once a day for 60 days	1500	5000	2025-06-13 11:46:21.288174
42	LONG_STREAK_100	100-Day Streak!	Login 100 days in a row	2000	6000	2025-06-13 11:46:21.288174
43	APP_SHARED	Sharing is Caring	Share the app with a friend	200	1000	2025-06-13 11:46:21.288174
44	BILL_REMINDER_SET	On Schedule	Set a bill reminder	100	250	2025-06-13 11:46:21.288174
45	BILL_REMINDER_COMPLETED	Paid On Time	Mark a bill as paid	200	600	2025-06-13 11:46:21.288174
46	WEEKLY_SUMMARY_READ	Check In	Read your weekly summary	150	300	2025-06-13 11:46:21.288174
47	DAILY_NOTES_WRITTEN_10	Note Taker	Write 10 notes in your transactions	250	800	2025-06-13 11:46:21.288174
48	DAILY_NOTES_WRITTEN_100	Writer	Write 100 notes	600	2000	2025-06-13 11:46:21.288174
49	CURRENCY_SWITCHED	Explorer	Switch your app currency	100	300	2025-06-13 11:46:21.288174
50	LONG_TERM_USER	Old Friend	Use the app for 365 days	2500	8000	2025-06-13 11:46:21.288174
51	PROFILE_PICTURE_SET	Looking Good	Set a profile picture	150	400	2025-06-13 11:46:21.288174
52	DAILY_SPENDING_LIMIT	Disciplined	Set a daily spending limit	300	1000	2025-06-13 11:46:21.288174
53	LIMIT_REACHED_5X	Budget Slayer	Reach your spending limit 5 times	500	1500	2025-06-13 11:46:21.288174
54	CATEGORIES_CLEANUP	Organizer Pro	Delete 10 unused categories	250	800	2025-06-13 11:46:21.288174
55	ARCHIVED_OLD_DATA	Archivist	Archive old transactions	200	500	2025-06-13 11:46:21.288174
56	TAGGED_ALL_ENTRIES	Tag Champ	All entries tagged for a full month	800	2500	2025-06-13 11:46:21.288174
57	DAILY_SUMMARY_OPENED	Quick Peek	Open the daily summary 10 times	100	400	2025-06-13 11:46:21.288174
58	TWEAKED_SETTINGS	Personalizer	Update your settings/preferences	100	300	2025-06-13 11:46:21.288174
59	DAILY_REMINDER_SET	Reminded	Set a daily reminder	150	350	2025-06-13 11:46:21.288174
60	DAILY_REMINDER_USED_30	Disciplined Tracker	Use reminders 30 days in a row	800	2500	2025-06-13 11:46:21.288174
13	LOGIN_STREAK_30_DAYS	30 days!	You logged in for 30 days straight.&Good job!	500	1000	2025-06-12 21:52:13.289764
\.


--
-- Data for Name: assets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.assets (id, user_id, name, type, value, acquired_date, notes, is_liquid, created_at, last_updated, is_deleted) FROM stdin;
1	1	Asset1	Asset1	100000.00	2025-06-15		f	2025-06-15 09:21:09.091213	2025-06-15 09:21:09.091213	f
2	1	aaaaa	aaaaa	11111111.00	\N		f	2025-06-15 09:27:08.839722	2025-06-15 09:27:08.839722	f
3	1	aaaa	aaaa	100000.00	\N		f	2025-06-15 09:40:50.308482	2025-06-15 09:40:50.308482	f
4	1	aaaa	aaaa	100.00	\N		f	2025-06-15 09:41:36.260256	2025-06-15 09:41:36.260256	f
5	1	confetti	confetti	10000.00	\N		f	2025-06-15 09:43:10.527043	2025-06-15 09:43:10.527043	f
6	1	confetti	confetti	10000.00	\N		f	2025-06-15 09:43:16.246159	2025-06-15 09:43:16.246159	f
7	1	aaa	aaa	2344.00	\N		f	2025-06-15 09:44:35.723908	2025-06-15 09:44:35.723908	f
8	1	aaaa	aaa	2232.00	\N		f	2025-06-15 09:45:08.665191	2025-06-15 09:45:08.665191	f
9	1	aa	aaa	2134.00	\N		f	2025-06-15 09:45:32.581638	2025-06-15 09:45:32.581638	f
10	1	aaa	aaaaa	344444.00	\N		f	2025-06-15 09:47:58.655957	2025-06-15 09:47:58.655957	f
11	1	dadsf	23444	32442.00	\N		f	2025-06-15 09:48:18.88431	2025-06-15 09:48:18.88431	f
12	1	aaa	aaaa	32342344.00	\N		f	2025-06-15 10:28:17.920058	2025-06-15 10:28:17.920058	f
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories (id, user_id, name, type, is_deleted, created_at) FROM stdin;
1	1	Salary	income	f	2025-06-15 08:42:33.450034
2	1	Freelance	income	f	2025-06-15 08:42:33.450034
3	1	Investment	income	f	2025-06-15 08:42:33.450034
4	1	Groceries	expense	f	2025-06-15 08:42:33.450034
5	1	Rent	expense	f	2025-06-15 08:42:33.450034
6	1	Utilities	expense	f	2025-06-15 08:42:33.450034
7	1	Entertainment	expense	f	2025-06-15 08:42:33.450034
8	1	Transportation	expense	f	2025-06-15 08:42:33.450034
9	1	Healthcare	expense	f	2025-06-15 08:42:33.450034
10	2	Salary	income	f	2025-06-15 08:42:58.507731
11	2	Freelance	income	f	2025-06-15 08:42:58.507731
12	2	Investment	income	f	2025-06-15 08:42:58.507731
13	2	Groceries	expense	f	2025-06-15 08:42:58.507731
14	2	Rent	expense	f	2025-06-15 08:42:58.507731
15	2	Utilities	expense	f	2025-06-15 08:42:58.507731
16	2	Entertainment	expense	f	2025-06-15 08:42:58.507731
17	2	Transportation	expense	f	2025-06-15 08:42:58.507731
18	2	Healthcare	expense	f	2025-06-15 08:42:58.507731
19	2	Dining Out	expense	f	2025-06-15 08:42:58.507731
20	2	Clothing	expense	f	2025-06-15 08:42:58.507731
21	3	Salary	income	f	2025-06-15 08:43:24.147707
22	3	Freelance	income	f	2025-06-15 08:43:24.147707
23	3	Investment	income	f	2025-06-15 08:43:24.147707
24	3	Rental Income	income	f	2025-06-15 08:43:24.147707
25	3	Dividends	income	f	2025-06-15 08:43:24.147707
26	3	Groceries	expense	f	2025-06-15 08:43:24.147707
27	3	Rent	expense	f	2025-06-15 08:43:24.147707
28	3	Utilities	expense	f	2025-06-15 08:43:24.147707
29	3	Entertainment	expense	f	2025-06-15 08:43:24.147707
30	3	Transportation	expense	f	2025-06-15 08:43:24.147707
31	4	Salary	income	f	2025-06-15 08:43:33.821777
32	4	Freelance	income	f	2025-06-15 08:43:33.821777
33	4	Investment	income	f	2025-06-15 08:43:33.821777
34	4	Rental Income	income	f	2025-06-15 08:43:33.821777
35	4	Dividends	income	f	2025-06-15 08:43:33.821777
36	4	Groceries	expense	f	2025-06-15 08:43:33.821777
37	4	Rent	expense	f	2025-06-15 08:43:33.821777
38	4	Utilities	expense	f	2025-06-15 08:43:33.821777
39	4	Entertainment	expense	f	2025-06-15 08:43:33.821777
40	4	Transportation	expense	f	2025-06-15 08:43:33.821777
41	4	Healthcare	expense	f	2025-06-15 08:43:33.821777
42	4	Dining Out	expense	f	2025-06-15 08:43:33.821777
43	4	Clothing	expense	f	2025-06-15 08:43:33.821777
44	5	Salary	income	f	2025-06-15 08:43:43.160813
45	5	Freelance	income	f	2025-06-15 08:43:43.160813
46	5	Investment	income	f	2025-06-15 08:43:43.160813
47	5	Rental Income	income	f	2025-06-15 08:43:43.160813
48	5	Dividends	income	f	2025-06-15 08:43:43.160813
49	5	Groceries	expense	f	2025-06-15 08:43:43.160813
50	5	Rent	expense	f	2025-06-15 08:43:43.160813
51	5	Utilities	expense	f	2025-06-15 08:43:43.160813
52	5	Entertainment	expense	f	2025-06-15 08:43:43.160813
53	5	Transportation	expense	f	2025-06-15 08:43:43.160813
54	5	Healthcare	expense	f	2025-06-15 08:43:43.160813
55	5	Dining Out	expense	f	2025-06-15 08:43:43.160813
\.


--
-- Data for Name: liabilities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.liabilities (id, user_id, name, type, amount, amount_remaining, interest_rate, start_date, due_date, notes, is_active, created_at, last_updated, is_deleted) FROM stdin;
1	1	test	test	20000.00	20000.00	1.00	\N	\N		t	2025-06-15 09:26:38.959093	2025-06-15 09:26:38.959093	f
2	1	test	test	100000.00	100000.00	1.00	\N	\N		t	2025-06-15 09:26:55.103328	2025-06-15 09:26:55.103328	f
\.


--
-- Data for Name: login_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.login_history (id, user_id, login_date) FROM stdin;
1	59	2025-06-15
2	60	2025-06-15
3	1	2025-06-15
4	2	2025-06-15
5	3	2025-06-15
6	4	2025-06-15
7	5	2025-06-15
8	6	2025-06-15
9	7	2025-06-15
10	8	2025-06-15
11	9	2025-06-15
12	10	2025-06-15
13	11	2025-06-15
14	12	2025-06-15
15	13	2025-06-15
16	14	2025-06-15
17	15	2025-06-15
\.


--
-- Data for Name: net_worth_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.net_worth_history (id, user_id, date, assets_value, liabilities_value, net_worth, created_at) FROM stdin;
\.


--
-- Data for Name: shop_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.shop_items (id, name, description, price, category, available, created_at) FROM stdin;
3	Dark Mode Theme	Switch to a sleek dark interface.	300	Theme	t	2025-06-14 13:54:58.178461
19	Daily Motivation Quotes	Receive inspiring quotes daily in the app.	120	Fun	t	2025-06-14 14:24:06.550364
21	Dashboard Title Animation	The dashboard title slides in and pulses.	100	Animation	t	2025-06-15 03:00:57.006909
22	Make your username BIG	The username is visualized in caps lock.	50	Graphic	t	2025-06-15 09:17:32.536461
23	Expenses are no good!	Make the expenses total RED.	50	Cosmetics	t	2025-06-15 09:23:53.749827
24	Incomes are so good!	Make the expenses total GREEN.	50	Cosmetics	t	2025-06-15 09:23:53.749827
25	Streak calendar	Be able to visualize your login streak calendar.	50	Cosmetics	t	2025-06-15 09:28:52.871129
26	Celebrate your new assets!	Have confetti celebrations when you add a new asset.	50	Animation	t	2025-06-15 09:47:09.219812
27	Liabilities are no good!	Make the expenses total RED.	50	Cosmetics	t	2025-06-15 09:50:37.636846
28	Assets are so good!	Make the expenses total GREEN.	50	Cosmetics	t	2025-06-15 09:50:37.636846
29	Income pie chart	Visualize your income divided by categories in a pie chart.	50	Functionality	t	2025-06-15 10:02:00.098103
30	Expenses pie chart	Visualize your expenses divided by categories in a pie chart.	50	Functionality	t	2025-06-15 10:02:00.098103
31	Net Worth details	Visualize your net worth details.	50	Functionality	t	2025-06-15 10:19:21.751372
32	Bicolor Xp Bar	Animate your xp bar with two colors.	50	Animation	t	2025-06-15 10:43:29.544556
33	Fire it up!	Light your streak button on fire.	50	Cosmetics	t	2025-06-15 11:26:36.42331
34	Refreshing	Animate your refresh button.	50	Animation	t	2025-06-15 11:28:01.407733
1	Golden Badge	A shiny golden badge for financial excellence.	150	Badge	f	2025-06-14 13:54:58.178461
2	Streak Master Badge	Awarded for maintaining a 30-day savings streak.	200	Badge	f	2025-06-14 13:54:58.178461
4	Ocean Theme	A relaxing ocean-blue UI theme.	250	Theme	f	2025-06-14 13:54:58.178461
5	Daily Double Boost	Double your reward points for the next 24 hours.	500	Boost	f	2025-06-14 13:54:58.178461
6	Expense Tracker Pro	Unlocks advanced analytics and forecasting.	750	Boost	f	2025-06-14 13:54:58.178461
8	Confetti Celebration	Adds confetti animations on achievements.	100	Fun	f	2025-06-14 13:54:58.178461
9	Financial Toolkit	Downloadable PDF with advanced budgeting templates.	400	Tool	f	2025-06-14 13:54:58.178461
10	Weekly Budget Reminder	Set up automated weekly budget push alerts.	150	Tool	f	2025-06-14 13:54:58.178461
11	Silver Star Badge	Awarded for reaching silver-level savings goals.	100	Badge	f	2025-06-14 14:24:06.550364
12	Holiday Theme	Festive holiday colors and icons for your app.	280	Theme	f	2025-06-14 14:24:06.550364
13	XP Booster	Earn double experience points for 12 hours.	450	Boost	f	2025-06-14 14:24:06.550364
15	Spending Insights Pro	Unlock deeper spending insights and reports.	800	Boost	f	2025-06-14 14:24:06.550364
16	Monthly Savings Challenge	Participate in monthly savings challenges.	350	Boost	f	2025-06-14 14:24:06.550364
17	Animated Badge Pack	Get badges with cool animations.	220	Fun	f	2025-06-14 14:24:06.550364
18	Personalized Budget Planner	Custom budget planner tailored to your habits.	500	Tool	f	2025-06-14 14:24:06.550364
35	TransACTING	Animate the add transaction button.	50	Animation	t	2025-06-15 12:10:06.053195
\.


--
-- Data for Name: transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transactions (id, user_id, category_id, name, date, amount, description, created_at) FROM stdin;
1	1	6	Transaction #1	2025-05-24	129.55	Auto-generated transaction entry #1	2025-06-15 08:46:01.23332
2	1	5	Transaction #2	2025-06-08	565.42	Auto-generated transaction entry #2	2025-06-15 08:46:01.23332
3	1	4	Transaction #3	2025-05-16	410.42	Auto-generated transaction entry #3	2025-06-15 08:46:01.23332
4	1	4	Transaction #4	2025-05-31	199.91	Auto-generated transaction entry #4	2025-06-15 08:46:01.23332
5	1	7	Transaction #5	2025-05-20	897.21	Auto-generated transaction entry #5	2025-06-15 08:46:01.23332
6	1	5	Transaction #6	2025-05-24	403.00	Auto-generated transaction entry #6	2025-06-15 08:46:01.23332
7	1	8	Transaction #7	2025-05-25	808.94	Auto-generated transaction entry #7	2025-06-15 08:46:01.23332
8	1	5	Transaction #8	2025-05-17	115.95	Auto-generated transaction entry #8	2025-06-15 08:46:01.23332
9	1	6	Transaction #9	2025-05-17	102.02	Auto-generated transaction entry #9	2025-06-15 08:46:01.23332
10	1	9	Transaction #10	2025-05-29	362.72	Auto-generated transaction entry #10	2025-06-15 08:46:01.23332
11	1	4	Transaction #11	2025-06-05	652.16	Auto-generated transaction entry #11	2025-06-15 08:46:01.23332
12	1	5	Transaction #12	2025-05-30	860.44	Auto-generated transaction entry #12	2025-06-15 08:46:01.23332
13	1	4	Transaction #13	2025-05-28	541.77	Auto-generated transaction entry #13	2025-06-15 08:46:01.23332
14	1	4	Transaction #14	2025-05-26	411.63	Auto-generated transaction entry #14	2025-06-15 08:46:01.23332
15	1	4	Transaction #15	2025-06-14	673.94	Auto-generated transaction entry #15	2025-06-15 08:46:01.23332
16	1	9	Transaction #16	2025-05-22	74.08	Auto-generated transaction entry #16	2025-06-15 08:46:01.23332
17	1	9	Transaction #17	2025-06-05	896.07	Auto-generated transaction entry #17	2025-06-15 08:46:01.23332
18	1	8	Transaction #18	2025-05-31	397.76	Auto-generated transaction entry #18	2025-06-15 08:46:01.23332
19	1	9	Transaction #19	2025-05-28	831.76	Auto-generated transaction entry #19	2025-06-15 08:46:01.23332
20	1	6	Transaction #20	2025-05-27	291.87	Auto-generated transaction entry #20	2025-06-15 08:46:01.23332
21	1	9	Transaction #21	2025-05-29	927.41	Auto-generated transaction entry #21	2025-06-15 08:46:01.23332
22	1	6	Transaction #22	2025-06-05	891.32	Auto-generated transaction entry #22	2025-06-15 08:46:01.23332
23	1	8	Transaction #23	2025-06-12	630.56	Auto-generated transaction entry #23	2025-06-15 08:46:01.23332
24	1	5	Transaction #24	2025-05-25	295.97	Auto-generated transaction entry #24	2025-06-15 08:46:01.23332
25	1	9	Transaction #25	2025-06-12	265.93	Auto-generated transaction entry #25	2025-06-15 08:46:01.23332
26	1	7	Transaction #26	2025-05-25	949.22	Auto-generated transaction entry #26	2025-06-15 08:46:01.23332
27	1	7	Transaction #27	2025-05-29	770.98	Auto-generated transaction entry #27	2025-06-15 08:46:01.23332
28	1	5	Transaction #28	2025-05-19	543.22	Auto-generated transaction entry #28	2025-06-15 08:46:01.23332
29	1	8	Transaction #29	2025-06-15	129.95	Auto-generated transaction entry #29	2025-06-15 08:46:01.23332
30	1	5	Transaction #30	2025-05-31	115.83	Auto-generated transaction entry #30	2025-06-15 08:46:01.23332
31	1	7	Transaction #31	2025-06-02	640.52	Auto-generated transaction entry #31	2025-06-15 08:46:01.23332
32	1	7	Transaction #32	2025-05-20	336.35	Auto-generated transaction entry #32	2025-06-15 08:46:01.23332
33	1	6	Transaction #33	2025-06-10	116.09	Auto-generated transaction entry #33	2025-06-15 08:46:01.23332
34	1	4	Transaction #34	2025-05-22	137.77	Auto-generated transaction entry #34	2025-06-15 08:46:01.23332
35	1	7	Transaction #35	2025-05-24	206.55	Auto-generated transaction entry #35	2025-06-15 08:46:01.23332
36	1	5	Transaction #36	2025-06-12	251.82	Auto-generated transaction entry #36	2025-06-15 08:46:01.23332
37	1	5	Transaction #37	2025-06-02	758.30	Auto-generated transaction entry #37	2025-06-15 08:46:01.23332
38	1	8	Transaction #38	2025-06-04	419.07	Auto-generated transaction entry #38	2025-06-15 08:46:01.23332
39	1	9	Transaction #39	2025-05-28	986.16	Auto-generated transaction entry #39	2025-06-15 08:46:01.23332
40	1	6	Transaction #40	2025-06-02	465.49	Auto-generated transaction entry #40	2025-06-15 08:46:01.23332
41	1	5	Transaction #41	2025-05-23	809.56	Auto-generated transaction entry #41	2025-06-15 08:46:01.23332
42	1	5	Transaction #42	2025-05-17	616.28	Auto-generated transaction entry #42	2025-06-15 08:46:01.23332
43	1	4	Transaction #43	2025-05-29	642.28	Auto-generated transaction entry #43	2025-06-15 08:46:01.23332
44	1	4	Transaction #44	2025-06-09	211.03	Auto-generated transaction entry #44	2025-06-15 08:46:01.23332
45	1	4	Transaction #45	2025-05-25	861.11	Auto-generated transaction entry #45	2025-06-15 08:46:01.23332
46	1	4	Transaction #46	2025-05-18	999.74	Auto-generated transaction entry #46	2025-06-15 08:46:01.23332
47	1	5	Transaction #47	2025-05-21	201.24	Auto-generated transaction entry #47	2025-06-15 08:46:01.23332
48	1	7	Transaction #48	2025-05-21	932.46	Auto-generated transaction entry #48	2025-06-15 08:46:01.23332
49	1	4	Transaction #49	2025-06-05	80.35	Auto-generated transaction entry #49	2025-06-15 08:46:01.23332
50	1	5	Transaction #50	2025-05-27	248.48	Auto-generated transaction entry #50	2025-06-15 08:46:01.23332
51	1	9	Transaction #51	2025-06-09	706.22	Auto-generated transaction entry #51	2025-06-15 08:46:01.23332
52	1	7	Transaction #52	2025-06-10	135.03	Auto-generated transaction entry #52	2025-06-15 08:46:01.23332
53	1	5	Transaction #53	2025-06-13	556.41	Auto-generated transaction entry #53	2025-06-15 08:46:01.23332
54	1	8	Transaction #54	2025-05-24	239.53	Auto-generated transaction entry #54	2025-06-15 08:46:01.23332
55	1	4	Transaction #55	2025-06-07	783.52	Auto-generated transaction entry #55	2025-06-15 08:46:01.23332
56	1	5	Transaction #56	2025-05-19	126.08	Auto-generated transaction entry #56	2025-06-15 08:46:01.23332
57	1	7	Transaction #57	2025-05-26	905.11	Auto-generated transaction entry #57	2025-06-15 08:46:01.23332
58	1	6	Transaction #58	2025-06-08	148.81	Auto-generated transaction entry #58	2025-06-15 08:46:01.23332
59	1	4	Transaction #59	2025-06-02	694.30	Auto-generated transaction entry #59	2025-06-15 08:46:01.23332
60	1	7	Transaction #60	2025-05-20	958.22	Auto-generated transaction entry #60	2025-06-15 08:46:01.23332
61	1	6	Transaction #61	2025-06-13	720.70	Auto-generated transaction entry #61	2025-06-15 08:46:01.23332
62	1	5	Transaction #62	2025-05-20	471.35	Auto-generated transaction entry #62	2025-06-15 08:46:01.23332
63	1	7	Transaction #63	2025-06-05	903.29	Auto-generated transaction entry #63	2025-06-15 08:46:01.23332
64	1	6	Transaction #64	2025-06-12	620.50	Auto-generated transaction entry #64	2025-06-15 08:46:01.23332
65	1	8	Transaction #65	2025-05-25	200.93	Auto-generated transaction entry #65	2025-06-15 08:46:01.23332
66	1	7	Transaction #66	2025-06-01	647.71	Auto-generated transaction entry #66	2025-06-15 08:46:01.23332
67	1	6	Transaction #67	2025-05-28	640.78	Auto-generated transaction entry #67	2025-06-15 08:46:01.23332
68	1	7	Transaction #68	2025-05-17	591.75	Auto-generated transaction entry #68	2025-06-15 08:46:01.23332
69	1	7	Transaction #69	2025-05-20	977.21	Auto-generated transaction entry #69	2025-06-15 08:46:01.23332
70	1	4	Transaction #70	2025-06-05	404.03	Auto-generated transaction entry #70	2025-06-15 08:46:01.23332
71	1	7	Transaction #71	2025-06-07	981.60	Auto-generated transaction entry #71	2025-06-15 08:46:01.23332
72	1	9	Transaction #72	2025-06-13	748.07	Auto-generated transaction entry #72	2025-06-15 08:46:01.23332
73	1	8	Transaction #73	2025-06-05	528.19	Auto-generated transaction entry #73	2025-06-15 08:46:01.23332
74	1	4	Transaction #74	2025-06-10	725.12	Auto-generated transaction entry #74	2025-06-15 08:46:01.23332
75	1	4	Transaction #75	2025-06-12	218.83	Auto-generated transaction entry #75	2025-06-15 08:46:01.23332
76	1	8	Transaction #76	2025-05-20	590.13	Auto-generated transaction entry #76	2025-06-15 08:46:01.23332
77	1	9	Transaction #77	2025-06-03	948.18	Auto-generated transaction entry #77	2025-06-15 08:46:01.23332
78	1	7	Transaction #78	2025-06-02	165.74	Auto-generated transaction entry #78	2025-06-15 08:46:01.23332
79	1	6	Transaction #79	2025-06-07	443.41	Auto-generated transaction entry #79	2025-06-15 08:46:01.23332
80	1	8	Transaction #80	2025-05-30	788.26	Auto-generated transaction entry #80	2025-06-15 08:46:01.23332
81	1	8	Transaction #81	2025-06-09	672.19	Auto-generated transaction entry #81	2025-06-15 08:46:01.23332
82	1	9	Transaction #82	2025-05-27	838.92	Auto-generated transaction entry #82	2025-06-15 08:46:01.23332
83	1	5	Transaction #83	2025-06-03	642.06	Auto-generated transaction entry #83	2025-06-15 08:46:01.23332
84	1	8	Transaction #84	2025-05-21	389.33	Auto-generated transaction entry #84	2025-06-15 08:46:01.23332
85	1	8	Transaction #85	2025-06-06	591.00	Auto-generated transaction entry #85	2025-06-15 08:46:01.23332
86	1	5	Transaction #86	2025-06-10	202.49	Auto-generated transaction entry #86	2025-06-15 08:46:01.23332
87	1	8	Transaction #87	2025-06-06	417.97	Auto-generated transaction entry #87	2025-06-15 08:46:01.23332
88	1	4	Transaction #88	2025-05-27	831.98	Auto-generated transaction entry #88	2025-06-15 08:46:01.23332
89	1	7	Transaction #89	2025-05-25	725.06	Auto-generated transaction entry #89	2025-06-15 08:46:01.23332
90	1	7	Transaction #90	2025-05-25	743.39	Auto-generated transaction entry #90	2025-06-15 08:46:01.23332
91	1	8	Transaction #91	2025-05-16	132.35	Auto-generated transaction entry #91	2025-06-15 08:46:01.23332
92	1	4	Transaction #92	2025-06-14	669.38	Auto-generated transaction entry #92	2025-06-15 08:46:01.23332
93	1	4	Transaction #93	2025-06-11	569.87	Auto-generated transaction entry #93	2025-06-15 08:46:01.23332
94	1	9	Transaction #94	2025-06-11	729.21	Auto-generated transaction entry #94	2025-06-15 08:46:01.23332
95	1	8	Transaction #95	2025-06-08	434.64	Auto-generated transaction entry #95	2025-06-15 08:46:01.23332
96	1	7	Transaction #96	2025-06-15	966.48	Auto-generated transaction entry #96	2025-06-15 08:46:01.23332
97	1	4	Transaction #97	2025-06-05	421.21	Auto-generated transaction entry #97	2025-06-15 08:46:01.23332
98	1	9	Transaction #98	2025-05-17	207.13	Auto-generated transaction entry #98	2025-06-15 08:46:01.23332
99	1	9	Transaction #99	2025-05-16	705.54	Auto-generated transaction entry #99	2025-06-15 08:46:01.23332
100	1	7	Transaction #100	2025-06-10	638.34	Auto-generated transaction entry #100	2025-06-15 08:46:01.23332
101	1	9	Transaction #101	2025-05-23	327.63	Auto-generated transaction entry #101	2025-06-15 08:46:01.23332
102	1	7	Transaction #102	2025-05-29	358.52	Auto-generated transaction entry #102	2025-06-15 08:46:01.23332
103	1	9	Transaction #103	2025-06-01	253.52	Auto-generated transaction entry #103	2025-06-15 08:46:01.23332
104	1	7	Transaction #104	2025-05-28	247.01	Auto-generated transaction entry #104	2025-06-15 08:46:01.23332
105	1	5	Transaction #105	2025-05-27	239.40	Auto-generated transaction entry #105	2025-06-15 08:46:01.23332
106	1	7	Transaction #106	2025-05-18	438.44	Auto-generated transaction entry #106	2025-06-15 08:46:01.23332
107	1	8	Transaction #107	2025-06-02	290.95	Auto-generated transaction entry #107	2025-06-15 08:46:01.23332
108	1	6	Transaction #108	2025-06-08	464.36	Auto-generated transaction entry #108	2025-06-15 08:46:01.23332
109	1	5	Transaction #109	2025-06-15	574.54	Auto-generated transaction entry #109	2025-06-15 08:46:01.23332
110	1	5	Transaction #110	2025-05-31	803.75	Auto-generated transaction entry #110	2025-06-15 08:46:01.23332
111	1	6	Transaction #111	2025-05-17	781.20	Auto-generated transaction entry #111	2025-06-15 08:46:01.23332
112	1	8	Transaction #112	2025-06-05	392.09	Auto-generated transaction entry #112	2025-06-15 08:46:01.23332
113	1	9	Transaction #113	2025-06-07	489.41	Auto-generated transaction entry #113	2025-06-15 08:46:01.23332
114	1	5	Transaction #114	2025-05-21	370.05	Auto-generated transaction entry #114	2025-06-15 08:46:01.23332
115	1	7	Transaction #115	2025-06-02	605.28	Auto-generated transaction entry #115	2025-06-15 08:46:01.23332
116	1	6	Transaction #116	2025-06-01	389.37	Auto-generated transaction entry #116	2025-06-15 08:46:01.23332
117	1	8	Transaction #117	2025-06-10	832.43	Auto-generated transaction entry #117	2025-06-15 08:46:01.23332
118	1	8	Transaction #118	2025-06-12	693.02	Auto-generated transaction entry #118	2025-06-15 08:46:01.23332
119	1	4	Transaction #119	2025-05-20	189.67	Auto-generated transaction entry #119	2025-06-15 08:46:01.23332
120	1	7	Transaction #120	2025-06-04	486.77	Auto-generated transaction entry #120	2025-06-15 08:46:01.23332
121	1	4	Transaction #121	2025-06-05	624.97	Auto-generated transaction entry #121	2025-06-15 08:46:01.23332
122	1	6	Transaction #122	2025-05-20	171.47	Auto-generated transaction entry #122	2025-06-15 08:46:01.23332
123	1	5	Transaction #123	2025-06-02	614.99	Auto-generated transaction entry #123	2025-06-15 08:46:01.23332
124	1	7	Transaction #124	2025-06-04	725.33	Auto-generated transaction entry #124	2025-06-15 08:46:01.23332
125	1	7	Transaction #125	2025-06-04	884.38	Auto-generated transaction entry #125	2025-06-15 08:46:01.23332
126	1	6	Transaction #126	2025-06-15	574.88	Auto-generated transaction entry #126	2025-06-15 08:46:01.23332
127	1	8	Transaction #127	2025-05-26	880.37	Auto-generated transaction entry #127	2025-06-15 08:46:01.23332
128	1	8	Transaction #128	2025-05-19	710.05	Auto-generated transaction entry #128	2025-06-15 08:46:01.23332
129	1	8	Transaction #129	2025-05-31	776.76	Auto-generated transaction entry #129	2025-06-15 08:46:01.23332
130	1	9	Transaction #130	2025-05-27	497.32	Auto-generated transaction entry #130	2025-06-15 08:46:01.23332
131	1	6	Transaction #131	2025-06-12	640.36	Auto-generated transaction entry #131	2025-06-15 08:46:01.23332
132	1	5	Transaction #132	2025-06-02	299.64	Auto-generated transaction entry #132	2025-06-15 08:46:01.23332
133	1	4	Transaction #133	2025-05-26	987.63	Auto-generated transaction entry #133	2025-06-15 08:46:01.23332
134	1	5	Transaction #134	2025-05-24	175.51	Auto-generated transaction entry #134	2025-06-15 08:46:01.23332
135	1	7	Transaction #135	2025-05-29	440.61	Auto-generated transaction entry #135	2025-06-15 08:46:01.23332
136	1	9	Transaction #136	2025-05-23	466.40	Auto-generated transaction entry #136	2025-06-15 08:46:01.23332
137	1	8	Transaction #137	2025-05-18	544.41	Auto-generated transaction entry #137	2025-06-15 08:46:01.23332
138	1	9	Transaction #138	2025-06-06	409.64	Auto-generated transaction entry #138	2025-06-15 08:46:01.23332
139	1	4	Transaction #139	2025-05-20	532.02	Auto-generated transaction entry #139	2025-06-15 08:46:01.23332
140	1	6	Transaction #140	2025-06-05	185.25	Auto-generated transaction entry #140	2025-06-15 08:46:01.23332
141	1	6	Transaction #141	2025-06-05	419.88	Auto-generated transaction entry #141	2025-06-15 08:46:01.23332
142	1	6	Transaction #142	2025-05-29	709.92	Auto-generated transaction entry #142	2025-06-15 08:46:01.23332
143	1	5	Transaction #143	2025-06-08	573.77	Auto-generated transaction entry #143	2025-06-15 08:46:01.23332
144	1	8	Transaction #144	2025-06-03	680.46	Auto-generated transaction entry #144	2025-06-15 08:46:01.23332
145	1	4	Transaction #145	2025-06-04	426.75	Auto-generated transaction entry #145	2025-06-15 08:46:01.23332
146	1	5	Transaction #146	2025-06-12	740.53	Auto-generated transaction entry #146	2025-06-15 08:46:01.23332
147	1	4	Transaction #147	2025-05-19	460.14	Auto-generated transaction entry #147	2025-06-15 08:46:01.23332
148	1	8	Transaction #148	2025-05-23	159.59	Auto-generated transaction entry #148	2025-06-15 08:46:01.23332
149	1	5	Transaction #149	2025-05-27	145.32	Auto-generated transaction entry #149	2025-06-15 08:46:01.23332
150	1	8	Transaction #150	2025-06-02	919.71	Auto-generated transaction entry #150	2025-06-15 08:46:01.23332
151	1	9	Transaction #151	2025-06-04	562.91	Auto-generated transaction entry #151	2025-06-15 08:46:01.23332
152	1	8	Transaction #152	2025-05-31	404.14	Auto-generated transaction entry #152	2025-06-15 08:46:01.23332
153	1	4	Transaction #153	2025-06-12	388.49	Auto-generated transaction entry #153	2025-06-15 08:46:01.23332
154	1	9	Transaction #154	2025-05-23	441.65	Auto-generated transaction entry #154	2025-06-15 08:46:01.23332
155	1	4	Transaction #155	2025-06-13	604.51	Auto-generated transaction entry #155	2025-06-15 08:46:01.23332
156	1	8	Transaction #156	2025-06-02	885.79	Auto-generated transaction entry #156	2025-06-15 08:46:01.23332
157	1	5	Transaction #157	2025-06-03	941.94	Auto-generated transaction entry #157	2025-06-15 08:46:01.23332
158	1	5	Transaction #158	2025-06-01	986.33	Auto-generated transaction entry #158	2025-06-15 08:46:01.23332
159	1	9	Transaction #159	2025-05-27	916.96	Auto-generated transaction entry #159	2025-06-15 08:46:01.23332
160	1	4	Transaction #160	2025-05-23	277.72	Auto-generated transaction entry #160	2025-06-15 08:46:01.23332
161	1	5	Transaction #161	2025-05-29	97.14	Auto-generated transaction entry #161	2025-06-15 08:46:01.23332
162	1	8	Transaction #162	2025-05-17	474.70	Auto-generated transaction entry #162	2025-06-15 08:46:01.23332
163	1	4	Transaction #163	2025-06-13	522.70	Auto-generated transaction entry #163	2025-06-15 08:46:01.23332
164	1	7	Transaction #164	2025-06-06	168.90	Auto-generated transaction entry #164	2025-06-15 08:46:01.23332
165	1	7	Transaction #165	2025-05-22	348.27	Auto-generated transaction entry #165	2025-06-15 08:46:01.23332
166	1	7	Transaction #166	2025-06-14	711.90	Auto-generated transaction entry #166	2025-06-15 08:46:01.23332
167	1	9	Transaction #167	2025-05-22	528.73	Auto-generated transaction entry #167	2025-06-15 08:46:01.23332
168	1	8	Transaction #168	2025-05-18	221.64	Auto-generated transaction entry #168	2025-06-15 08:46:01.23332
169	1	5	Transaction #169	2025-05-26	989.91	Auto-generated transaction entry #169	2025-06-15 08:46:01.23332
170	1	9	Transaction #170	2025-06-09	788.99	Auto-generated transaction entry #170	2025-06-15 08:46:01.23332
171	1	6	Transaction #171	2025-06-07	523.55	Auto-generated transaction entry #171	2025-06-15 08:46:01.23332
172	1	4	Transaction #172	2025-05-18	543.01	Auto-generated transaction entry #172	2025-06-15 08:46:01.23332
173	1	4	Transaction #173	2025-06-08	565.21	Auto-generated transaction entry #173	2025-06-15 08:46:01.23332
174	1	5	Transaction #174	2025-05-18	298.44	Auto-generated transaction entry #174	2025-06-15 08:46:01.23332
175	1	5	Transaction #175	2025-05-30	694.13	Auto-generated transaction entry #175	2025-06-15 08:46:01.23332
176	1	4	Transaction #176	2025-05-23	976.60	Auto-generated transaction entry #176	2025-06-15 08:46:01.23332
177	1	4	Transaction #177	2025-06-05	912.69	Auto-generated transaction entry #177	2025-06-15 08:46:01.23332
178	1	9	Transaction #178	2025-05-26	641.16	Auto-generated transaction entry #178	2025-06-15 08:46:01.23332
179	1	7	Transaction #179	2025-06-03	643.85	Auto-generated transaction entry #179	2025-06-15 08:46:01.23332
180	1	7	Transaction #180	2025-05-23	181.05	Auto-generated transaction entry #180	2025-06-15 08:46:01.23332
181	1	4	Transaction #181	2025-06-14	813.94	Auto-generated transaction entry #181	2025-06-15 08:46:01.23332
182	1	9	Transaction #182	2025-06-06	196.98	Auto-generated transaction entry #182	2025-06-15 08:46:01.23332
183	1	9	Transaction #183	2025-05-23	748.65	Auto-generated transaction entry #183	2025-06-15 08:46:01.23332
184	1	6	Transaction #184	2025-05-23	548.65	Auto-generated transaction entry #184	2025-06-15 08:46:01.23332
185	1	9	Transaction #185	2025-06-01	152.10	Auto-generated transaction entry #185	2025-06-15 08:46:01.23332
186	1	7	Transaction #186	2025-06-05	463.41	Auto-generated transaction entry #186	2025-06-15 08:46:01.23332
187	1	6	Transaction #187	2025-05-28	207.38	Auto-generated transaction entry #187	2025-06-15 08:46:01.23332
188	1	8	Transaction #188	2025-05-25	280.09	Auto-generated transaction entry #188	2025-06-15 08:46:01.23332
189	1	7	Transaction #189	2025-05-23	726.97	Auto-generated transaction entry #189	2025-06-15 08:46:01.23332
190	1	4	Transaction #190	2025-06-05	388.43	Auto-generated transaction entry #190	2025-06-15 08:46:01.23332
191	1	5	Transaction #191	2025-06-05	130.28	Auto-generated transaction entry #191	2025-06-15 08:46:01.23332
192	1	7	Transaction #192	2025-05-21	954.14	Auto-generated transaction entry #192	2025-06-15 08:46:01.23332
193	1	8	Transaction #193	2025-05-29	701.17	Auto-generated transaction entry #193	2025-06-15 08:46:01.23332
194	1	8	Transaction #194	2025-05-22	475.23	Auto-generated transaction entry #194	2025-06-15 08:46:01.23332
195	1	9	Transaction #195	2025-05-17	170.15	Auto-generated transaction entry #195	2025-06-15 08:46:01.23332
196	1	7	Transaction #196	2025-05-28	838.69	Auto-generated transaction entry #196	2025-06-15 08:46:01.23332
197	1	6	Transaction #197	2025-06-13	380.36	Auto-generated transaction entry #197	2025-06-15 08:46:01.23332
198	1	5	Transaction #198	2025-05-26	920.24	Auto-generated transaction entry #198	2025-06-15 08:46:01.23332
199	1	5	Transaction #199	2025-05-31	658.31	Auto-generated transaction entry #199	2025-06-15 08:46:01.23332
200	1	6	Transaction #200	2025-06-11	622.06	Auto-generated transaction entry #200	2025-06-15 08:46:01.23332
201	1	9	Transaction #201	2025-05-27	905.69	Auto-generated transaction entry #201	2025-06-15 08:46:01.23332
202	1	9	Transaction #202	2025-06-04	622.82	Auto-generated transaction entry #202	2025-06-15 08:46:01.23332
203	1	9	Transaction #203	2025-05-25	194.48	Auto-generated transaction entry #203	2025-06-15 08:46:01.23332
204	1	7	Transaction #204	2025-06-14	335.07	Auto-generated transaction entry #204	2025-06-15 08:46:01.23332
205	1	8	Transaction #205	2025-05-23	739.34	Auto-generated transaction entry #205	2025-06-15 08:46:01.23332
206	1	7	Transaction #206	2025-06-01	59.09	Auto-generated transaction entry #206	2025-06-15 08:46:01.23332
207	1	7	Transaction #207	2025-06-04	981.10	Auto-generated transaction entry #207	2025-06-15 08:46:01.23332
208	1	5	Transaction #208	2025-06-01	410.05	Auto-generated transaction entry #208	2025-06-15 08:46:01.23332
209	1	6	Transaction #209	2025-05-25	951.87	Auto-generated transaction entry #209	2025-06-15 08:46:01.23332
210	1	5	Transaction #210	2025-05-31	707.73	Auto-generated transaction entry #210	2025-06-15 08:46:01.23332
211	1	6	Transaction #211	2025-05-18	627.41	Auto-generated transaction entry #211	2025-06-15 08:46:01.23332
212	1	9	Transaction #212	2025-05-23	937.14	Auto-generated transaction entry #212	2025-06-15 08:46:01.23332
213	1	8	Transaction #213	2025-06-09	668.11	Auto-generated transaction entry #213	2025-06-15 08:46:01.23332
214	1	9	Transaction #214	2025-06-01	890.66	Auto-generated transaction entry #214	2025-06-15 08:46:01.23332
215	1	6	Transaction #215	2025-05-16	406.70	Auto-generated transaction entry #215	2025-06-15 08:46:01.23332
216	1	4	Transaction #216	2025-06-06	705.59	Auto-generated transaction entry #216	2025-06-15 08:46:01.23332
217	1	5	Transaction #217	2025-06-02	361.56	Auto-generated transaction entry #217	2025-06-15 08:46:01.23332
218	1	5	Transaction #218	2025-06-01	890.74	Auto-generated transaction entry #218	2025-06-15 08:46:01.23332
219	1	6	Transaction #219	2025-05-19	255.53	Auto-generated transaction entry #219	2025-06-15 08:46:01.23332
220	1	5	Transaction #220	2025-06-05	577.50	Auto-generated transaction entry #220	2025-06-15 08:46:01.23332
221	1	7	Transaction #221	2025-05-17	680.60	Auto-generated transaction entry #221	2025-06-15 08:46:01.23332
222	1	6	Transaction #222	2025-06-11	341.37	Auto-generated transaction entry #222	2025-06-15 08:46:01.23332
223	1	5	Transaction #223	2025-06-12	944.22	Auto-generated transaction entry #223	2025-06-15 08:46:01.23332
224	1	8	Transaction #224	2025-06-07	795.62	Auto-generated transaction entry #224	2025-06-15 08:46:01.23332
225	1	7	Transaction #225	2025-06-11	456.34	Auto-generated transaction entry #225	2025-06-15 08:46:01.23332
226	1	8	Transaction #226	2025-06-05	204.10	Auto-generated transaction entry #226	2025-06-15 08:46:01.23332
227	1	6	Transaction #227	2025-06-13	99.27	Auto-generated transaction entry #227	2025-06-15 08:46:01.23332
228	1	9	Transaction #228	2025-05-19	612.53	Auto-generated transaction entry #228	2025-06-15 08:46:01.23332
229	1	6	Transaction #229	2025-05-22	806.91	Auto-generated transaction entry #229	2025-06-15 08:46:01.23332
230	1	9	Transaction #230	2025-06-03	163.44	Auto-generated transaction entry #230	2025-06-15 08:46:01.23332
231	1	7	Transaction #231	2025-06-08	579.15	Auto-generated transaction entry #231	2025-06-15 08:46:01.23332
232	1	4	Transaction #232	2025-05-18	926.60	Auto-generated transaction entry #232	2025-06-15 08:46:01.23332
233	1	5	Transaction #233	2025-05-23	167.89	Auto-generated transaction entry #233	2025-06-15 08:46:01.23332
234	1	8	Transaction #234	2025-06-07	716.54	Auto-generated transaction entry #234	2025-06-15 08:46:01.23332
235	1	6	Transaction #235	2025-06-10	146.54	Auto-generated transaction entry #235	2025-06-15 08:46:01.23332
236	1	4	Transaction #236	2025-05-30	296.26	Auto-generated transaction entry #236	2025-06-15 08:46:01.23332
237	1	9	Transaction #237	2025-05-29	66.86	Auto-generated transaction entry #237	2025-06-15 08:46:01.23332
238	1	7	Transaction #238	2025-05-19	86.40	Auto-generated transaction entry #238	2025-06-15 08:46:01.23332
239	1	7	Transaction #239	2025-06-05	374.51	Auto-generated transaction entry #239	2025-06-15 08:46:01.23332
240	1	9	Transaction #240	2025-05-29	208.55	Auto-generated transaction entry #240	2025-06-15 08:46:01.23332
241	1	6	Transaction #241	2025-05-26	852.39	Auto-generated transaction entry #241	2025-06-15 08:46:01.23332
242	1	4	Transaction #242	2025-05-16	629.82	Auto-generated transaction entry #242	2025-06-15 08:46:01.23332
243	1	4	Transaction #243	2025-05-30	152.11	Auto-generated transaction entry #243	2025-06-15 08:46:01.23332
244	1	4	Transaction #244	2025-05-29	738.12	Auto-generated transaction entry #244	2025-06-15 08:46:01.23332
245	1	7	Transaction #245	2025-05-20	696.21	Auto-generated transaction entry #245	2025-06-15 08:46:01.23332
246	1	4	Transaction #246	2025-06-02	873.23	Auto-generated transaction entry #246	2025-06-15 08:46:01.23332
247	1	6	Transaction #247	2025-05-30	413.09	Auto-generated transaction entry #247	2025-06-15 08:46:01.23332
248	1	4	Transaction #248	2025-05-23	81.97	Auto-generated transaction entry #248	2025-06-15 08:46:01.23332
249	1	5	Transaction #249	2025-06-09	898.45	Auto-generated transaction entry #249	2025-06-15 08:46:01.23332
250	1	6	Transaction #250	2025-05-18	352.90	Auto-generated transaction entry #250	2025-06-15 08:46:01.23332
251	1	5	Transaction #251	2025-06-05	532.80	Auto-generated transaction entry #251	2025-06-15 08:46:01.23332
252	1	5	Transaction #252	2025-05-19	902.22	Auto-generated transaction entry #252	2025-06-15 08:46:01.23332
253	1	4	Transaction #253	2025-05-17	913.35	Auto-generated transaction entry #253	2025-06-15 08:46:01.23332
254	1	7	Transaction #254	2025-06-08	706.23	Auto-generated transaction entry #254	2025-06-15 08:46:01.23332
255	1	4	Transaction #255	2025-05-23	784.44	Auto-generated transaction entry #255	2025-06-15 08:46:01.23332
256	1	5	Transaction #256	2025-05-23	231.57	Auto-generated transaction entry #256	2025-06-15 08:46:01.23332
257	1	8	Transaction #257	2025-06-08	549.31	Auto-generated transaction entry #257	2025-06-15 08:46:01.23332
258	1	5	Transaction #258	2025-05-24	905.62	Auto-generated transaction entry #258	2025-06-15 08:46:01.23332
259	1	8	Transaction #259	2025-06-03	306.84	Auto-generated transaction entry #259	2025-06-15 08:46:01.23332
260	1	4	Transaction #260	2025-06-11	950.77	Auto-generated transaction entry #260	2025-06-15 08:46:01.23332
261	1	5	Transaction #261	2025-05-31	824.51	Auto-generated transaction entry #261	2025-06-15 08:46:01.23332
262	1	4	Transaction #262	2025-05-23	297.38	Auto-generated transaction entry #262	2025-06-15 08:46:01.23332
263	1	5	Transaction #263	2025-05-28	920.89	Auto-generated transaction entry #263	2025-06-15 08:46:01.23332
264	1	4	Transaction #264	2025-05-17	791.01	Auto-generated transaction entry #264	2025-06-15 08:46:01.23332
265	1	5	Transaction #265	2025-05-23	982.95	Auto-generated transaction entry #265	2025-06-15 08:46:01.23332
266	1	6	Transaction #266	2025-05-20	605.74	Auto-generated transaction entry #266	2025-06-15 08:46:01.23332
267	1	8	Transaction #267	2025-05-19	120.33	Auto-generated transaction entry #267	2025-06-15 08:46:01.23332
268	1	9	Transaction #268	2025-06-12	587.45	Auto-generated transaction entry #268	2025-06-15 08:46:01.23332
269	1	5	Transaction #269	2025-05-28	690.65	Auto-generated transaction entry #269	2025-06-15 08:46:01.23332
270	1	8	Transaction #270	2025-06-04	873.56	Auto-generated transaction entry #270	2025-06-15 08:46:01.23332
271	1	8	Transaction #271	2025-06-11	227.60	Auto-generated transaction entry #271	2025-06-15 08:46:01.23332
272	1	4	Transaction #272	2025-05-30	186.70	Auto-generated transaction entry #272	2025-06-15 08:46:01.23332
273	1	9	Transaction #273	2025-06-01	959.81	Auto-generated transaction entry #273	2025-06-15 08:46:01.23332
274	1	6	Transaction #274	2025-05-17	259.61	Auto-generated transaction entry #274	2025-06-15 08:46:01.23332
275	1	5	Transaction #275	2025-06-13	266.41	Auto-generated transaction entry #275	2025-06-15 08:46:01.23332
276	1	6	Transaction #276	2025-05-16	323.67	Auto-generated transaction entry #276	2025-06-15 08:46:01.23332
277	1	9	Transaction #277	2025-06-07	396.34	Auto-generated transaction entry #277	2025-06-15 08:46:01.23332
278	1	7	Transaction #278	2025-05-24	896.69	Auto-generated transaction entry #278	2025-06-15 08:46:01.23332
279	1	8	Transaction #279	2025-05-23	314.96	Auto-generated transaction entry #279	2025-06-15 08:46:01.23332
280	1	6	Transaction #280	2025-06-02	797.28	Auto-generated transaction entry #280	2025-06-15 08:46:01.23332
281	1	8	Transaction #281	2025-05-17	834.45	Auto-generated transaction entry #281	2025-06-15 08:46:01.23332
282	1	5	Transaction #282	2025-06-08	492.60	Auto-generated transaction entry #282	2025-06-15 08:46:01.23332
283	1	6	Transaction #283	2025-06-14	220.16	Auto-generated transaction entry #283	2025-06-15 08:46:01.23332
284	1	7	Transaction #284	2025-06-03	261.59	Auto-generated transaction entry #284	2025-06-15 08:46:01.23332
285	1	9	Transaction #285	2025-05-23	246.91	Auto-generated transaction entry #285	2025-06-15 08:46:01.23332
286	1	5	Transaction #286	2025-06-15	174.78	Auto-generated transaction entry #286	2025-06-15 08:46:01.23332
287	1	5	Transaction #287	2025-05-18	965.07	Auto-generated transaction entry #287	2025-06-15 08:46:01.23332
288	1	4	Transaction #288	2025-05-31	878.89	Auto-generated transaction entry #288	2025-06-15 08:46:01.23332
289	1	7	Transaction #289	2025-06-14	112.55	Auto-generated transaction entry #289	2025-06-15 08:46:01.23332
290	1	8	Transaction #290	2025-05-26	203.13	Auto-generated transaction entry #290	2025-06-15 08:46:01.23332
291	1	4	Transaction #291	2025-06-06	226.27	Auto-generated transaction entry #291	2025-06-15 08:46:01.23332
292	1	9	Transaction #292	2025-05-16	618.70	Auto-generated transaction entry #292	2025-06-15 08:46:01.23332
293	1	9	Transaction #293	2025-06-08	955.15	Auto-generated transaction entry #293	2025-06-15 08:46:01.23332
294	1	9	Transaction #294	2025-05-25	695.04	Auto-generated transaction entry #294	2025-06-15 08:46:01.23332
295	1	6	Transaction #295	2025-05-23	280.03	Auto-generated transaction entry #295	2025-06-15 08:46:01.23332
296	1	8	Transaction #296	2025-05-25	349.11	Auto-generated transaction entry #296	2025-06-15 08:46:01.23332
297	1	7	Transaction #297	2025-05-30	962.06	Auto-generated transaction entry #297	2025-06-15 08:46:01.23332
298	1	7	Transaction #298	2025-06-09	96.67	Auto-generated transaction entry #298	2025-06-15 08:46:01.23332
299	1	7	Transaction #299	2025-05-18	970.72	Auto-generated transaction entry #299	2025-06-15 08:46:01.23332
300	1	8	Transaction #300	2025-05-27	567.61	Auto-generated transaction entry #300	2025-06-15 08:46:01.23332
301	1	8	Transaction #301	2025-05-20	885.68	Auto-generated transaction entry #301	2025-06-15 08:46:01.23332
302	1	8	Transaction #302	2025-06-08	543.93	Auto-generated transaction entry #302	2025-06-15 08:46:01.23332
303	1	5	Transaction #303	2025-05-25	303.84	Auto-generated transaction entry #303	2025-06-15 08:46:01.23332
304	1	9	Transaction #304	2025-05-25	465.75	Auto-generated transaction entry #304	2025-06-15 08:46:01.23332
305	1	8	Transaction #305	2025-05-27	550.53	Auto-generated transaction entry #305	2025-06-15 08:46:01.23332
306	1	6	Transaction #306	2025-05-21	989.66	Auto-generated transaction entry #306	2025-06-15 08:46:01.23332
307	1	4	Transaction #307	2025-05-27	324.93	Auto-generated transaction entry #307	2025-06-15 08:46:01.23332
308	1	7	Transaction #308	2025-06-04	284.58	Auto-generated transaction entry #308	2025-06-15 08:46:01.23332
309	1	8	Transaction #309	2025-05-21	999.75	Auto-generated transaction entry #309	2025-06-15 08:46:01.23332
310	1	6	Transaction #310	2025-05-26	283.25	Auto-generated transaction entry #310	2025-06-15 08:46:01.23332
311	1	4	Transaction #311	2025-06-02	687.54	Auto-generated transaction entry #311	2025-06-15 08:46:01.23332
312	1	4	Transaction #312	2025-05-22	789.26	Auto-generated transaction entry #312	2025-06-15 08:46:01.23332
313	1	7	Transaction #313	2025-05-16	143.76	Auto-generated transaction entry #313	2025-06-15 08:46:01.23332
314	1	9	Transaction #314	2025-05-25	921.50	Auto-generated transaction entry #314	2025-06-15 08:46:01.23332
315	1	4	Transaction #315	2025-06-04	308.06	Auto-generated transaction entry #315	2025-06-15 08:46:01.23332
316	1	8	Transaction #316	2025-05-30	492.23	Auto-generated transaction entry #316	2025-06-15 08:46:01.23332
317	1	9	Transaction #317	2025-06-11	220.00	Auto-generated transaction entry #317	2025-06-15 08:46:01.23332
318	1	5	Transaction #318	2025-06-09	548.43	Auto-generated transaction entry #318	2025-06-15 08:46:01.23332
319	1	4	Transaction #319	2025-05-25	921.94	Auto-generated transaction entry #319	2025-06-15 08:46:01.23332
320	1	8	Transaction #320	2025-05-17	556.81	Auto-generated transaction entry #320	2025-06-15 08:46:01.23332
321	1	4	Transaction #321	2025-06-11	739.38	Auto-generated transaction entry #321	2025-06-15 08:46:01.23332
322	1	7	Transaction #322	2025-05-29	311.44	Auto-generated transaction entry #322	2025-06-15 08:46:01.23332
323	1	6	Transaction #323	2025-06-02	630.02	Auto-generated transaction entry #323	2025-06-15 08:46:01.23332
324	1	4	Transaction #324	2025-05-17	817.74	Auto-generated transaction entry #324	2025-06-15 08:46:01.23332
325	1	9	Transaction #325	2025-06-14	409.84	Auto-generated transaction entry #325	2025-06-15 08:46:01.23332
326	1	8	Transaction #326	2025-05-21	721.59	Auto-generated transaction entry #326	2025-06-15 08:46:01.23332
327	1	8	Transaction #327	2025-05-26	936.65	Auto-generated transaction entry #327	2025-06-15 08:46:01.23332
328	1	9	Transaction #328	2025-05-26	373.95	Auto-generated transaction entry #328	2025-06-15 08:46:01.23332
329	1	9	Transaction #329	2025-06-01	638.72	Auto-generated transaction entry #329	2025-06-15 08:46:01.23332
330	1	9	Transaction #330	2025-05-27	429.76	Auto-generated transaction entry #330	2025-06-15 08:46:01.23332
331	1	8	Transaction #331	2025-05-27	482.13	Auto-generated transaction entry #331	2025-06-15 08:46:01.23332
332	1	9	Transaction #332	2025-05-27	424.04	Auto-generated transaction entry #332	2025-06-15 08:46:01.23332
333	1	5	Transaction #333	2025-06-01	466.75	Auto-generated transaction entry #333	2025-06-15 08:46:01.23332
334	1	4	Transaction #334	2025-05-26	104.78	Auto-generated transaction entry #334	2025-06-15 08:46:01.23332
335	1	9	Transaction #335	2025-05-20	186.83	Auto-generated transaction entry #335	2025-06-15 08:46:01.23332
336	1	7	Transaction #336	2025-06-12	393.91	Auto-generated transaction entry #336	2025-06-15 08:46:01.23332
337	1	8	Transaction #337	2025-05-17	903.06	Auto-generated transaction entry #337	2025-06-15 08:46:01.23332
338	1	6	Transaction #338	2025-05-20	962.13	Auto-generated transaction entry #338	2025-06-15 08:46:01.23332
339	1	4	Transaction #339	2025-05-26	160.18	Auto-generated transaction entry #339	2025-06-15 08:46:01.23332
340	1	6	Transaction #340	2025-06-04	515.03	Auto-generated transaction entry #340	2025-06-15 08:46:01.23332
341	1	9	Transaction #341	2025-06-08	478.35	Auto-generated transaction entry #341	2025-06-15 08:46:01.23332
342	1	4	Transaction #342	2025-06-10	459.65	Auto-generated transaction entry #342	2025-06-15 08:46:01.23332
343	1	6	Transaction #343	2025-06-08	578.66	Auto-generated transaction entry #343	2025-06-15 08:46:01.23332
344	1	4	Transaction #344	2025-05-28	564.19	Auto-generated transaction entry #344	2025-06-15 08:46:01.23332
345	1	6	Transaction #345	2025-05-17	763.14	Auto-generated transaction entry #345	2025-06-15 08:46:01.23332
346	1	9	Transaction #346	2025-06-05	785.43	Auto-generated transaction entry #346	2025-06-15 08:46:01.23332
347	1	9	Transaction #347	2025-05-24	889.06	Auto-generated transaction entry #347	2025-06-15 08:46:01.23332
348	1	6	Transaction #348	2025-05-23	882.66	Auto-generated transaction entry #348	2025-06-15 08:46:01.23332
349	1	9	Transaction #349	2025-05-29	799.85	Auto-generated transaction entry #349	2025-06-15 08:46:01.23332
350	1	5	Transaction #350	2025-06-04	178.18	Auto-generated transaction entry #350	2025-06-15 08:46:01.23332
351	1	4	Transaction #351	2025-05-26	885.72	Auto-generated transaction entry #351	2025-06-15 08:46:01.23332
352	1	7	Transaction #352	2025-06-05	337.10	Auto-generated transaction entry #352	2025-06-15 08:46:01.23332
353	1	9	Transaction #353	2025-05-26	640.66	Auto-generated transaction entry #353	2025-06-15 08:46:01.23332
354	1	4	Transaction #354	2025-06-01	874.42	Auto-generated transaction entry #354	2025-06-15 08:46:01.23332
355	1	9	Transaction #355	2025-06-11	958.43	Auto-generated transaction entry #355	2025-06-15 08:46:01.23332
356	1	4	Transaction #356	2025-05-24	381.47	Auto-generated transaction entry #356	2025-06-15 08:46:01.23332
357	1	4	Transaction #357	2025-06-03	406.66	Auto-generated transaction entry #357	2025-06-15 08:46:01.23332
358	1	6	Transaction #358	2025-06-10	751.13	Auto-generated transaction entry #358	2025-06-15 08:46:01.23332
359	1	4	Transaction #359	2025-06-14	205.13	Auto-generated transaction entry #359	2025-06-15 08:46:01.23332
360	1	6	Transaction #360	2025-05-28	658.93	Auto-generated transaction entry #360	2025-06-15 08:46:01.23332
361	1	5	Transaction #361	2025-05-27	336.83	Auto-generated transaction entry #361	2025-06-15 08:46:01.23332
362	1	5	Transaction #362	2025-05-29	296.44	Auto-generated transaction entry #362	2025-06-15 08:46:01.23332
363	1	5	Transaction #363	2025-05-25	886.63	Auto-generated transaction entry #363	2025-06-15 08:46:01.23332
364	1	6	Transaction #364	2025-05-28	682.73	Auto-generated transaction entry #364	2025-06-15 08:46:01.23332
365	1	4	Transaction #365	2025-05-24	849.14	Auto-generated transaction entry #365	2025-06-15 08:46:01.23332
366	1	7	Transaction #366	2025-06-10	800.17	Auto-generated transaction entry #366	2025-06-15 08:46:01.23332
367	1	8	Transaction #367	2025-06-10	65.45	Auto-generated transaction entry #367	2025-06-15 08:46:01.23332
368	1	8	Transaction #368	2025-05-23	92.69	Auto-generated transaction entry #368	2025-06-15 08:46:01.23332
369	1	9	Transaction #369	2025-05-24	298.79	Auto-generated transaction entry #369	2025-06-15 08:46:01.23332
370	1	6	Transaction #370	2025-06-05	95.33	Auto-generated transaction entry #370	2025-06-15 08:46:01.23332
371	1	4	Transaction #371	2025-06-11	556.61	Auto-generated transaction entry #371	2025-06-15 08:46:01.23332
372	1	9	Transaction #372	2025-05-25	233.31	Auto-generated transaction entry #372	2025-06-15 08:46:01.23332
373	1	7	Transaction #373	2025-05-24	963.05	Auto-generated transaction entry #373	2025-06-15 08:46:01.23332
374	1	4	Transaction #374	2025-06-02	885.78	Auto-generated transaction entry #374	2025-06-15 08:46:01.23332
375	1	7	Transaction #375	2025-05-21	429.78	Auto-generated transaction entry #375	2025-06-15 08:46:01.23332
376	1	5	Transaction #376	2025-05-23	777.13	Auto-generated transaction entry #376	2025-06-15 08:46:01.23332
377	1	5	Transaction #377	2025-06-10	998.59	Auto-generated transaction entry #377	2025-06-15 08:46:01.23332
378	1	7	Transaction #378	2025-06-14	536.82	Auto-generated transaction entry #378	2025-06-15 08:46:01.23332
379	1	4	Transaction #379	2025-05-21	71.66	Auto-generated transaction entry #379	2025-06-15 08:46:01.23332
380	1	7	Transaction #380	2025-05-21	691.58	Auto-generated transaction entry #380	2025-06-15 08:46:01.23332
381	1	7	Transaction #381	2025-05-27	391.02	Auto-generated transaction entry #381	2025-06-15 08:46:01.23332
382	1	7	Transaction #382	2025-06-12	390.13	Auto-generated transaction entry #382	2025-06-15 08:46:01.23332
383	1	7	Transaction #383	2025-06-05	52.94	Auto-generated transaction entry #383	2025-06-15 08:46:01.23332
384	1	9	Transaction #384	2025-06-11	618.30	Auto-generated transaction entry #384	2025-06-15 08:46:01.23332
385	1	8	Transaction #385	2025-05-22	487.68	Auto-generated transaction entry #385	2025-06-15 08:46:01.23332
386	1	7	Transaction #386	2025-06-01	66.15	Auto-generated transaction entry #386	2025-06-15 08:46:01.23332
387	1	5	Transaction #387	2025-05-26	983.59	Auto-generated transaction entry #387	2025-06-15 08:46:01.23332
388	1	8	Transaction #388	2025-05-23	606.42	Auto-generated transaction entry #388	2025-06-15 08:46:01.23332
389	1	4	Transaction #389	2025-05-24	727.40	Auto-generated transaction entry #389	2025-06-15 08:46:01.23332
390	1	6	Transaction #390	2025-05-29	310.89	Auto-generated transaction entry #390	2025-06-15 08:46:01.23332
391	1	7	Transaction #391	2025-05-20	905.29	Auto-generated transaction entry #391	2025-06-15 08:46:01.23332
392	1	8	Transaction #392	2025-05-17	216.64	Auto-generated transaction entry #392	2025-06-15 08:46:01.23332
393	1	6	Transaction #393	2025-06-09	904.64	Auto-generated transaction entry #393	2025-06-15 08:46:01.23332
394	1	4	Transaction #394	2025-06-13	399.40	Auto-generated transaction entry #394	2025-06-15 08:46:01.23332
395	1	5	Transaction #395	2025-05-22	231.36	Auto-generated transaction entry #395	2025-06-15 08:46:01.23332
396	1	8	Transaction #396	2025-06-07	264.11	Auto-generated transaction entry #396	2025-06-15 08:46:01.23332
397	1	6	Transaction #397	2025-06-11	769.78	Auto-generated transaction entry #397	2025-06-15 08:46:01.23332
398	1	8	Transaction #398	2025-06-04	450.50	Auto-generated transaction entry #398	2025-06-15 08:46:01.23332
399	1	5	Transaction #399	2025-06-15	831.97	Auto-generated transaction entry #399	2025-06-15 08:46:01.23332
400	1	4	Transaction #400	2025-05-18	937.60	Auto-generated transaction entry #400	2025-06-15 08:46:01.23332
401	1	9	Transaction #401	2025-06-09	319.01	Auto-generated transaction entry #401	2025-06-15 08:46:01.23332
402	1	7	Transaction #402	2025-05-19	732.28	Auto-generated transaction entry #402	2025-06-15 08:46:01.23332
403	1	8	Transaction #403	2025-05-21	283.25	Auto-generated transaction entry #403	2025-06-15 08:46:01.23332
404	1	5	Transaction #404	2025-06-07	110.28	Auto-generated transaction entry #404	2025-06-15 08:46:01.23332
405	1	7	Transaction #405	2025-05-20	863.39	Auto-generated transaction entry #405	2025-06-15 08:46:01.23332
406	1	4	Transaction #406	2025-05-26	706.49	Auto-generated transaction entry #406	2025-06-15 08:46:01.23332
407	1	9	Transaction #407	2025-06-10	571.68	Auto-generated transaction entry #407	2025-06-15 08:46:01.23332
408	1	5	Transaction #408	2025-05-26	307.89	Auto-generated transaction entry #408	2025-06-15 08:46:01.23332
409	1	6	Transaction #409	2025-05-17	533.84	Auto-generated transaction entry #409	2025-06-15 08:46:01.23332
410	1	5	Transaction #410	2025-06-02	716.98	Auto-generated transaction entry #410	2025-06-15 08:46:01.23332
411	1	9	Transaction #411	2025-05-24	964.39	Auto-generated transaction entry #411	2025-06-15 08:46:01.23332
412	1	6	Transaction #412	2025-05-20	882.13	Auto-generated transaction entry #412	2025-06-15 08:46:01.23332
413	1	8	Transaction #413	2025-05-21	976.29	Auto-generated transaction entry #413	2025-06-15 08:46:01.23332
414	1	4	Transaction #414	2025-06-07	998.54	Auto-generated transaction entry #414	2025-06-15 08:46:01.23332
415	1	4	Transaction #415	2025-05-17	829.99	Auto-generated transaction entry #415	2025-06-15 08:46:01.23332
416	1	6	Transaction #416	2025-06-02	454.75	Auto-generated transaction entry #416	2025-06-15 08:46:01.23332
417	1	7	Transaction #417	2025-05-17	946.62	Auto-generated transaction entry #417	2025-06-15 08:46:01.23332
418	1	9	Transaction #418	2025-05-21	131.41	Auto-generated transaction entry #418	2025-06-15 08:46:01.23332
419	1	4	Transaction #419	2025-06-10	435.98	Auto-generated transaction entry #419	2025-06-15 08:46:01.23332
420	1	8	Transaction #420	2025-05-20	829.79	Auto-generated transaction entry #420	2025-06-15 08:46:01.23332
421	1	6	Transaction #421	2025-06-01	529.27	Auto-generated transaction entry #421	2025-06-15 08:46:01.23332
422	1	5	Transaction #422	2025-05-23	453.66	Auto-generated transaction entry #422	2025-06-15 08:46:01.23332
423	1	9	Transaction #423	2025-05-16	751.96	Auto-generated transaction entry #423	2025-06-15 08:46:01.23332
424	1	9	Transaction #424	2025-05-19	861.54	Auto-generated transaction entry #424	2025-06-15 08:46:01.23332
425	1	5	Transaction #425	2025-06-03	150.03	Auto-generated transaction entry #425	2025-06-15 08:46:01.23332
426	1	7	Transaction #426	2025-06-13	276.55	Auto-generated transaction entry #426	2025-06-15 08:46:01.23332
427	1	7	Transaction #427	2025-05-27	808.55	Auto-generated transaction entry #427	2025-06-15 08:46:01.23332
428	1	7	Transaction #428	2025-06-08	269.19	Auto-generated transaction entry #428	2025-06-15 08:46:01.23332
429	1	8	Transaction #429	2025-06-11	511.49	Auto-generated transaction entry #429	2025-06-15 08:46:01.23332
430	1	9	Transaction #430	2025-06-01	771.83	Auto-generated transaction entry #430	2025-06-15 08:46:01.23332
431	1	4	Transaction #431	2025-06-07	106.09	Auto-generated transaction entry #431	2025-06-15 08:46:01.23332
432	1	5	Transaction #432	2025-06-01	237.67	Auto-generated transaction entry #432	2025-06-15 08:46:01.23332
433	1	6	Transaction #433	2025-05-27	146.29	Auto-generated transaction entry #433	2025-06-15 08:46:01.23332
434	1	8	Transaction #434	2025-05-19	118.45	Auto-generated transaction entry #434	2025-06-15 08:46:01.23332
435	1	9	Transaction #435	2025-06-05	310.36	Auto-generated transaction entry #435	2025-06-15 08:46:01.23332
436	1	8	Transaction #436	2025-05-22	717.27	Auto-generated transaction entry #436	2025-06-15 08:46:01.23332
437	1	5	Transaction #437	2025-05-20	899.49	Auto-generated transaction entry #437	2025-06-15 08:46:01.23332
438	1	9	Transaction #438	2025-06-10	309.98	Auto-generated transaction entry #438	2025-06-15 08:46:01.23332
439	1	8	Transaction #439	2025-06-14	516.83	Auto-generated transaction entry #439	2025-06-15 08:46:01.23332
440	1	5	Transaction #440	2025-06-05	67.74	Auto-generated transaction entry #440	2025-06-15 08:46:01.23332
441	1	6	Transaction #441	2025-05-25	365.31	Auto-generated transaction entry #441	2025-06-15 08:46:01.23332
442	1	5	Transaction #442	2025-06-09	573.25	Auto-generated transaction entry #442	2025-06-15 08:46:01.23332
443	1	4	Transaction #443	2025-06-04	106.25	Auto-generated transaction entry #443	2025-06-15 08:46:01.23332
444	1	9	Transaction #444	2025-06-03	736.13	Auto-generated transaction entry #444	2025-06-15 08:46:01.23332
445	1	9	Transaction #445	2025-06-09	360.34	Auto-generated transaction entry #445	2025-06-15 08:46:01.23332
446	1	5	Transaction #446	2025-06-14	824.13	Auto-generated transaction entry #446	2025-06-15 08:46:01.23332
447	1	9	Transaction #447	2025-05-21	956.36	Auto-generated transaction entry #447	2025-06-15 08:46:01.23332
448	1	9	Transaction #448	2025-06-11	647.40	Auto-generated transaction entry #448	2025-06-15 08:46:01.23332
449	1	4	Transaction #449	2025-06-13	591.79	Auto-generated transaction entry #449	2025-06-15 08:46:01.23332
450	1	6	Transaction #450	2025-06-09	692.28	Auto-generated transaction entry #450	2025-06-15 08:46:01.23332
451	1	7	Transaction #451	2025-06-02	805.36	Auto-generated transaction entry #451	2025-06-15 08:46:01.23332
452	1	6	Transaction #452	2025-06-14	580.17	Auto-generated transaction entry #452	2025-06-15 08:46:01.23332
453	1	9	Transaction #453	2025-06-06	180.65	Auto-generated transaction entry #453	2025-06-15 08:46:01.23332
454	1	7	Transaction #454	2025-06-02	653.12	Auto-generated transaction entry #454	2025-06-15 08:46:01.23332
455	1	8	Transaction #455	2025-06-13	219.90	Auto-generated transaction entry #455	2025-06-15 08:46:01.23332
456	1	4	Transaction #456	2025-05-31	844.74	Auto-generated transaction entry #456	2025-06-15 08:46:01.23332
457	1	6	Transaction #457	2025-05-23	300.22	Auto-generated transaction entry #457	2025-06-15 08:46:01.23332
458	1	8	Transaction #458	2025-06-04	933.98	Auto-generated transaction entry #458	2025-06-15 08:46:01.23332
459	1	7	Transaction #459	2025-06-15	385.19	Auto-generated transaction entry #459	2025-06-15 08:46:01.23332
460	1	6	Transaction #460	2025-06-15	652.56	Auto-generated transaction entry #460	2025-06-15 08:46:01.23332
461	1	5	Transaction #461	2025-06-01	509.80	Auto-generated transaction entry #461	2025-06-15 08:46:01.23332
462	1	8	Transaction #462	2025-05-26	387.33	Auto-generated transaction entry #462	2025-06-15 08:46:01.23332
463	1	6	Transaction #463	2025-06-07	148.63	Auto-generated transaction entry #463	2025-06-15 08:46:01.23332
464	1	7	Transaction #464	2025-05-24	129.32	Auto-generated transaction entry #464	2025-06-15 08:46:01.23332
465	1	6	Transaction #465	2025-06-03	339.22	Auto-generated transaction entry #465	2025-06-15 08:46:01.23332
466	1	7	Transaction #466	2025-06-11	591.05	Auto-generated transaction entry #466	2025-06-15 08:46:01.23332
467	1	7	Transaction #467	2025-06-14	710.74	Auto-generated transaction entry #467	2025-06-15 08:46:01.23332
468	1	9	Transaction #468	2025-05-16	647.14	Auto-generated transaction entry #468	2025-06-15 08:46:01.23332
469	1	4	Transaction #469	2025-05-18	989.38	Auto-generated transaction entry #469	2025-06-15 08:46:01.23332
470	1	6	Transaction #470	2025-06-14	205.43	Auto-generated transaction entry #470	2025-06-15 08:46:01.23332
471	1	7	Transaction #471	2025-05-21	113.48	Auto-generated transaction entry #471	2025-06-15 08:46:01.23332
472	1	7	Transaction #472	2025-06-12	137.33	Auto-generated transaction entry #472	2025-06-15 08:46:01.23332
473	1	5	Transaction #473	2025-05-29	823.80	Auto-generated transaction entry #473	2025-06-15 08:46:01.23332
474	1	9	Transaction #474	2025-06-02	161.36	Auto-generated transaction entry #474	2025-06-15 08:46:01.23332
475	1	6	Transaction #475	2025-05-19	269.65	Auto-generated transaction entry #475	2025-06-15 08:46:01.23332
476	1	4	Transaction #476	2025-06-02	440.85	Auto-generated transaction entry #476	2025-06-15 08:46:01.23332
477	1	4	Transaction #477	2025-05-19	232.23	Auto-generated transaction entry #477	2025-06-15 08:46:01.23332
478	1	6	Transaction #478	2025-06-06	911.10	Auto-generated transaction entry #478	2025-06-15 08:46:01.23332
479	1	4	Transaction #479	2025-05-27	528.77	Auto-generated transaction entry #479	2025-06-15 08:46:01.23332
480	1	8	Transaction #480	2025-06-05	394.77	Auto-generated transaction entry #480	2025-06-15 08:46:01.23332
481	1	4	Transaction #481	2025-05-30	141.16	Auto-generated transaction entry #481	2025-06-15 08:46:01.23332
482	1	7	Transaction #482	2025-06-07	575.82	Auto-generated transaction entry #482	2025-06-15 08:46:01.23332
483	1	5	Transaction #483	2025-05-19	981.82	Auto-generated transaction entry #483	2025-06-15 08:46:01.23332
484	1	5	Transaction #484	2025-06-01	842.50	Auto-generated transaction entry #484	2025-06-15 08:46:01.23332
485	1	7	Transaction #485	2025-06-03	118.59	Auto-generated transaction entry #485	2025-06-15 08:46:01.23332
486	1	8	Transaction #486	2025-06-13	520.34	Auto-generated transaction entry #486	2025-06-15 08:46:01.23332
487	1	9	Transaction #487	2025-06-04	678.78	Auto-generated transaction entry #487	2025-06-15 08:46:01.23332
488	1	4	Transaction #488	2025-05-28	92.24	Auto-generated transaction entry #488	2025-06-15 08:46:01.23332
489	1	8	Transaction #489	2025-06-09	431.21	Auto-generated transaction entry #489	2025-06-15 08:46:01.23332
490	1	5	Transaction #490	2025-06-01	919.37	Auto-generated transaction entry #490	2025-06-15 08:46:01.23332
491	1	4	Transaction #491	2025-06-01	722.76	Auto-generated transaction entry #491	2025-06-15 08:46:01.23332
492	1	5	Transaction #492	2025-06-02	536.34	Auto-generated transaction entry #492	2025-06-15 08:46:01.23332
493	1	9	Transaction #493	2025-05-26	846.53	Auto-generated transaction entry #493	2025-06-15 08:46:01.23332
494	1	6	Transaction #494	2025-05-21	236.59	Auto-generated transaction entry #494	2025-06-15 08:46:01.23332
495	1	5	Transaction #495	2025-06-04	578.97	Auto-generated transaction entry #495	2025-06-15 08:46:01.23332
496	1	5	Transaction #496	2025-06-08	198.72	Auto-generated transaction entry #496	2025-06-15 08:46:01.23332
497	1	6	Transaction #497	2025-06-02	453.88	Auto-generated transaction entry #497	2025-06-15 08:46:01.23332
498	1	4	Transaction #498	2025-06-04	725.63	Auto-generated transaction entry #498	2025-06-15 08:46:01.23332
499	1	6	Transaction #499	2025-05-30	585.11	Auto-generated transaction entry #499	2025-06-15 08:46:01.23332
500	1	4	Transaction #500	2025-05-19	888.98	Auto-generated transaction entry #500	2025-06-15 08:46:01.23332
501	1	1	Transaction #1	2025-05-27	764.51	Auto-generated transaction entry #1	2025-06-15 08:46:27.912073
502	1	3	Transaction #2	2025-05-18	770.39	Auto-generated transaction entry #2	2025-06-15 08:46:27.912073
503	1	2	Transaction #3	2025-05-26	348.49	Auto-generated transaction entry #3	2025-06-15 08:46:27.912073
504	1	2	Transaction #4	2025-06-02	558.69	Auto-generated transaction entry #4	2025-06-15 08:46:27.912073
505	1	2	Transaction #5	2025-05-30	801.18	Auto-generated transaction entry #5	2025-06-15 08:46:27.912073
506	1	2	Transaction #6	2025-05-27	168.52	Auto-generated transaction entry #6	2025-06-15 08:46:27.912073
507	1	1	Transaction #7	2025-06-09	710.76	Auto-generated transaction entry #7	2025-06-15 08:46:27.912073
508	1	2	Transaction #8	2025-06-09	825.04	Auto-generated transaction entry #8	2025-06-15 08:46:27.912073
509	1	3	Transaction #9	2025-05-26	231.51	Auto-generated transaction entry #9	2025-06-15 08:46:27.912073
510	1	3	Transaction #10	2025-05-30	351.35	Auto-generated transaction entry #10	2025-06-15 08:46:27.912073
511	1	3	Transaction #11	2025-06-04	588.82	Auto-generated transaction entry #11	2025-06-15 08:46:27.912073
512	1	2	Transaction #12	2025-06-03	370.19	Auto-generated transaction entry #12	2025-06-15 08:46:27.912073
513	1	2	Transaction #13	2025-05-19	422.79	Auto-generated transaction entry #13	2025-06-15 08:46:27.912073
514	1	2	Transaction #14	2025-05-21	286.69	Auto-generated transaction entry #14	2025-06-15 08:46:27.912073
515	1	3	Transaction #15	2025-05-21	526.70	Auto-generated transaction entry #15	2025-06-15 08:46:27.912073
516	1	3	Transaction #16	2025-06-03	751.22	Auto-generated transaction entry #16	2025-06-15 08:46:27.912073
517	1	1	Transaction #17	2025-06-10	534.77	Auto-generated transaction entry #17	2025-06-15 08:46:27.912073
518	1	1	Transaction #18	2025-05-21	620.29	Auto-generated transaction entry #18	2025-06-15 08:46:27.912073
519	1	1	Transaction #19	2025-06-12	684.58	Auto-generated transaction entry #19	2025-06-15 08:46:27.912073
520	1	1	Transaction #20	2025-06-05	797.48	Auto-generated transaction entry #20	2025-06-15 08:46:27.912073
521	1	3	Transaction #21	2025-05-22	431.38	Auto-generated transaction entry #21	2025-06-15 08:46:27.912073
522	1	3	Transaction #22	2025-06-14	300.31	Auto-generated transaction entry #22	2025-06-15 08:46:27.912073
523	1	2	Transaction #23	2025-06-11	784.63	Auto-generated transaction entry #23	2025-06-15 08:46:27.912073
524	1	3	Transaction #24	2025-05-28	682.00	Auto-generated transaction entry #24	2025-06-15 08:46:27.912073
525	1	2	Transaction #25	2025-05-18	575.64	Auto-generated transaction entry #25	2025-06-15 08:46:27.912073
526	1	3	Transaction #26	2025-05-20	883.13	Auto-generated transaction entry #26	2025-06-15 08:46:27.912073
527	1	3	Transaction #27	2025-05-28	168.15	Auto-generated transaction entry #27	2025-06-15 08:46:27.912073
528	1	3	Transaction #28	2025-05-23	205.69	Auto-generated transaction entry #28	2025-06-15 08:46:27.912073
529	1	3	Transaction #29	2025-06-04	616.49	Auto-generated transaction entry #29	2025-06-15 08:46:27.912073
530	1	1	Transaction #30	2025-06-11	244.37	Auto-generated transaction entry #30	2025-06-15 08:46:27.912073
531	1	3	Transaction #31	2025-06-12	50.40	Auto-generated transaction entry #31	2025-06-15 08:46:27.912073
532	1	3	Transaction #32	2025-06-14	163.96	Auto-generated transaction entry #32	2025-06-15 08:46:27.912073
533	1	3	Transaction #33	2025-05-27	551.31	Auto-generated transaction entry #33	2025-06-15 08:46:27.912073
534	1	2	Transaction #34	2025-05-24	666.34	Auto-generated transaction entry #34	2025-06-15 08:46:27.912073
535	1	1	Transaction #35	2025-06-08	540.29	Auto-generated transaction entry #35	2025-06-15 08:46:27.912073
536	1	2	Transaction #36	2025-06-10	967.04	Auto-generated transaction entry #36	2025-06-15 08:46:27.912073
537	1	2	Transaction #37	2025-05-21	202.43	Auto-generated transaction entry #37	2025-06-15 08:46:27.912073
538	1	1	Transaction #38	2025-05-17	398.99	Auto-generated transaction entry #38	2025-06-15 08:46:27.912073
539	1	1	Transaction #39	2025-05-29	242.91	Auto-generated transaction entry #39	2025-06-15 08:46:27.912073
540	1	3	Transaction #40	2025-06-12	608.01	Auto-generated transaction entry #40	2025-06-15 08:46:27.912073
541	1	1	Transaction #41	2025-05-20	354.50	Auto-generated transaction entry #41	2025-06-15 08:46:27.912073
542	1	3	Transaction #42	2025-05-24	330.38	Auto-generated transaction entry #42	2025-06-15 08:46:27.912073
543	1	2	Transaction #43	2025-06-11	918.81	Auto-generated transaction entry #43	2025-06-15 08:46:27.912073
544	1	1	Transaction #44	2025-06-02	382.47	Auto-generated transaction entry #44	2025-06-15 08:46:27.912073
545	1	2	Transaction #45	2025-05-31	956.44	Auto-generated transaction entry #45	2025-06-15 08:46:27.912073
546	1	1	Transaction #46	2025-06-11	916.43	Auto-generated transaction entry #46	2025-06-15 08:46:27.912073
547	1	2	Transaction #47	2025-06-11	973.41	Auto-generated transaction entry #47	2025-06-15 08:46:27.912073
548	1	2	Transaction #48	2025-05-23	303.63	Auto-generated transaction entry #48	2025-06-15 08:46:27.912073
549	1	2	Transaction #49	2025-06-12	806.34	Auto-generated transaction entry #49	2025-06-15 08:46:27.912073
550	1	3	Transaction #50	2025-06-14	651.23	Auto-generated transaction entry #50	2025-06-15 08:46:27.912073
551	1	3	Transaction #51	2025-05-20	389.14	Auto-generated transaction entry #51	2025-06-15 08:46:27.912073
552	1	3	Transaction #52	2025-05-24	379.30	Auto-generated transaction entry #52	2025-06-15 08:46:27.912073
553	1	2	Transaction #53	2025-05-29	460.64	Auto-generated transaction entry #53	2025-06-15 08:46:27.912073
554	1	1	Transaction #54	2025-06-09	501.55	Auto-generated transaction entry #54	2025-06-15 08:46:27.912073
555	1	2	Transaction #55	2025-05-28	963.05	Auto-generated transaction entry #55	2025-06-15 08:46:27.912073
556	1	2	Transaction #56	2025-06-13	746.49	Auto-generated transaction entry #56	2025-06-15 08:46:27.912073
557	1	1	Transaction #57	2025-06-05	626.54	Auto-generated transaction entry #57	2025-06-15 08:46:27.912073
558	1	1	Transaction #58	2025-06-05	160.73	Auto-generated transaction entry #58	2025-06-15 08:46:27.912073
559	1	3	Transaction #59	2025-05-17	124.55	Auto-generated transaction entry #59	2025-06-15 08:46:27.912073
560	1	2	Transaction #60	2025-05-27	564.99	Auto-generated transaction entry #60	2025-06-15 08:46:27.912073
561	1	2	Transaction #61	2025-05-31	193.36	Auto-generated transaction entry #61	2025-06-15 08:46:27.912073
562	1	2	Transaction #62	2025-05-25	589.00	Auto-generated transaction entry #62	2025-06-15 08:46:27.912073
563	1	3	Transaction #63	2025-06-15	478.88	Auto-generated transaction entry #63	2025-06-15 08:46:27.912073
564	1	2	Transaction #64	2025-05-18	790.14	Auto-generated transaction entry #64	2025-06-15 08:46:27.912073
565	1	2	Transaction #65	2025-05-26	942.15	Auto-generated transaction entry #65	2025-06-15 08:46:27.912073
566	1	3	Transaction #66	2025-06-02	878.54	Auto-generated transaction entry #66	2025-06-15 08:46:27.912073
567	1	1	Transaction #67	2025-05-17	302.34	Auto-generated transaction entry #67	2025-06-15 08:46:27.912073
568	1	3	Transaction #68	2025-06-14	439.53	Auto-generated transaction entry #68	2025-06-15 08:46:27.912073
569	1	3	Transaction #69	2025-06-06	158.31	Auto-generated transaction entry #69	2025-06-15 08:46:27.912073
570	1	3	Transaction #70	2025-05-28	158.68	Auto-generated transaction entry #70	2025-06-15 08:46:27.912073
571	1	2	Transaction #71	2025-06-03	561.77	Auto-generated transaction entry #71	2025-06-15 08:46:27.912073
572	1	3	Transaction #72	2025-06-01	281.89	Auto-generated transaction entry #72	2025-06-15 08:46:27.912073
573	1	2	Transaction #73	2025-06-03	963.95	Auto-generated transaction entry #73	2025-06-15 08:46:27.912073
574	1	3	Transaction #74	2025-05-20	453.92	Auto-generated transaction entry #74	2025-06-15 08:46:27.912073
575	1	2	Transaction #75	2025-05-28	121.48	Auto-generated transaction entry #75	2025-06-15 08:46:27.912073
576	1	1	Transaction #76	2025-05-29	637.96	Auto-generated transaction entry #76	2025-06-15 08:46:27.912073
577	1	3	Transaction #77	2025-05-24	160.97	Auto-generated transaction entry #77	2025-06-15 08:46:27.912073
578	1	1	Transaction #78	2025-05-21	755.23	Auto-generated transaction entry #78	2025-06-15 08:46:27.912073
579	1	3	Transaction #79	2025-06-08	382.17	Auto-generated transaction entry #79	2025-06-15 08:46:27.912073
580	1	3	Transaction #80	2025-06-07	949.64	Auto-generated transaction entry #80	2025-06-15 08:46:27.912073
581	1	1	Transaction #81	2025-06-07	791.48	Auto-generated transaction entry #81	2025-06-15 08:46:27.912073
582	1	3	Transaction #82	2025-05-23	795.41	Auto-generated transaction entry #82	2025-06-15 08:46:27.912073
583	1	3	Transaction #83	2025-06-15	137.75	Auto-generated transaction entry #83	2025-06-15 08:46:27.912073
584	1	2	Transaction #84	2025-05-19	615.15	Auto-generated transaction entry #84	2025-06-15 08:46:27.912073
585	1	1	Transaction #85	2025-05-23	114.18	Auto-generated transaction entry #85	2025-06-15 08:46:27.912073
586	1	1	Transaction #86	2025-06-03	54.80	Auto-generated transaction entry #86	2025-06-15 08:46:27.912073
587	1	2	Transaction #87	2025-06-15	244.98	Auto-generated transaction entry #87	2025-06-15 08:46:27.912073
588	1	2	Transaction #88	2025-06-12	439.72	Auto-generated transaction entry #88	2025-06-15 08:46:27.912073
589	1	1	Transaction #89	2025-05-29	247.84	Auto-generated transaction entry #89	2025-06-15 08:46:27.912073
590	1	3	Transaction #90	2025-06-04	392.75	Auto-generated transaction entry #90	2025-06-15 08:46:27.912073
591	1	3	Transaction #91	2025-06-13	80.17	Auto-generated transaction entry #91	2025-06-15 08:46:27.912073
592	1	2	Transaction #92	2025-06-11	620.82	Auto-generated transaction entry #92	2025-06-15 08:46:27.912073
593	1	3	Transaction #93	2025-05-25	704.57	Auto-generated transaction entry #93	2025-06-15 08:46:27.912073
594	1	3	Transaction #94	2025-06-15	794.53	Auto-generated transaction entry #94	2025-06-15 08:46:27.912073
595	1	1	Transaction #95	2025-05-25	880.54	Auto-generated transaction entry #95	2025-06-15 08:46:27.912073
596	1	3	Transaction #96	2025-05-31	528.31	Auto-generated transaction entry #96	2025-06-15 08:46:27.912073
597	1	2	Transaction #97	2025-06-03	169.58	Auto-generated transaction entry #97	2025-06-15 08:46:27.912073
598	1	2	Transaction #98	2025-06-10	698.25	Auto-generated transaction entry #98	2025-06-15 08:46:27.912073
599	1	1	Transaction #99	2025-06-07	947.39	Auto-generated transaction entry #99	2025-06-15 08:46:27.912073
600	1	2	Transaction #100	2025-06-11	108.04	Auto-generated transaction entry #100	2025-06-15 08:46:27.912073
601	1	3	Transaction #101	2025-05-23	336.32	Auto-generated transaction entry #101	2025-06-15 08:46:27.912073
602	1	3	Transaction #102	2025-05-28	877.86	Auto-generated transaction entry #102	2025-06-15 08:46:27.912073
603	1	1	Transaction #103	2025-05-22	320.81	Auto-generated transaction entry #103	2025-06-15 08:46:27.912073
604	1	3	Transaction #104	2025-05-26	88.32	Auto-generated transaction entry #104	2025-06-15 08:46:27.912073
605	1	3	Transaction #105	2025-05-20	84.31	Auto-generated transaction entry #105	2025-06-15 08:46:27.912073
606	1	2	Transaction #106	2025-05-29	287.97	Auto-generated transaction entry #106	2025-06-15 08:46:27.912073
607	1	2	Transaction #107	2025-06-04	313.05	Auto-generated transaction entry #107	2025-06-15 08:46:27.912073
608	1	3	Transaction #108	2025-05-17	568.32	Auto-generated transaction entry #108	2025-06-15 08:46:27.912073
609	1	1	Transaction #109	2025-06-10	447.29	Auto-generated transaction entry #109	2025-06-15 08:46:27.912073
610	1	2	Transaction #110	2025-05-28	149.79	Auto-generated transaction entry #110	2025-06-15 08:46:27.912073
611	1	1	Transaction #111	2025-06-12	673.76	Auto-generated transaction entry #111	2025-06-15 08:46:27.912073
612	1	1	Transaction #112	2025-06-06	678.01	Auto-generated transaction entry #112	2025-06-15 08:46:27.912073
613	1	2	Transaction #113	2025-05-29	279.49	Auto-generated transaction entry #113	2025-06-15 08:46:27.912073
614	1	1	Transaction #114	2025-06-14	305.14	Auto-generated transaction entry #114	2025-06-15 08:46:27.912073
615	1	3	Transaction #115	2025-05-18	728.89	Auto-generated transaction entry #115	2025-06-15 08:46:27.912073
616	1	2	Transaction #116	2025-06-09	367.09	Auto-generated transaction entry #116	2025-06-15 08:46:27.912073
617	1	1	Transaction #117	2025-05-24	870.42	Auto-generated transaction entry #117	2025-06-15 08:46:27.912073
618	1	1	Transaction #118	2025-06-01	80.24	Auto-generated transaction entry #118	2025-06-15 08:46:27.912073
619	1	1	Transaction #119	2025-06-06	948.14	Auto-generated transaction entry #119	2025-06-15 08:46:27.912073
620	1	2	Transaction #120	2025-05-31	457.71	Auto-generated transaction entry #120	2025-06-15 08:46:27.912073
621	1	2	Transaction #121	2025-05-21	294.75	Auto-generated transaction entry #121	2025-06-15 08:46:27.912073
622	1	3	Transaction #122	2025-05-25	905.47	Auto-generated transaction entry #122	2025-06-15 08:46:27.912073
623	1	1	Transaction #123	2025-06-04	711.03	Auto-generated transaction entry #123	2025-06-15 08:46:27.912073
624	1	1	Transaction #124	2025-06-09	420.81	Auto-generated transaction entry #124	2025-06-15 08:46:27.912073
625	1	1	Transaction #125	2025-05-30	61.44	Auto-generated transaction entry #125	2025-06-15 08:46:27.912073
626	1	1	Transaction #126	2025-06-07	380.06	Auto-generated transaction entry #126	2025-06-15 08:46:27.912073
627	1	2	Transaction #127	2025-06-06	350.11	Auto-generated transaction entry #127	2025-06-15 08:46:27.912073
628	1	3	Transaction #128	2025-05-20	470.80	Auto-generated transaction entry #128	2025-06-15 08:46:27.912073
629	1	1	Transaction #129	2025-05-30	465.10	Auto-generated transaction entry #129	2025-06-15 08:46:27.912073
630	1	2	Transaction #130	2025-05-26	816.68	Auto-generated transaction entry #130	2025-06-15 08:46:27.912073
631	1	2	Transaction #131	2025-05-18	210.34	Auto-generated transaction entry #131	2025-06-15 08:46:27.912073
632	1	3	Transaction #132	2025-06-03	954.69	Auto-generated transaction entry #132	2025-06-15 08:46:27.912073
633	1	2	Transaction #133	2025-05-20	759.99	Auto-generated transaction entry #133	2025-06-15 08:46:27.912073
634	1	2	Transaction #134	2025-05-25	519.14	Auto-generated transaction entry #134	2025-06-15 08:46:27.912073
635	1	2	Transaction #135	2025-06-11	680.24	Auto-generated transaction entry #135	2025-06-15 08:46:27.912073
636	1	3	Transaction #136	2025-06-01	635.52	Auto-generated transaction entry #136	2025-06-15 08:46:27.912073
637	1	1	Transaction #137	2025-05-24	769.76	Auto-generated transaction entry #137	2025-06-15 08:46:27.912073
638	1	3	Transaction #138	2025-06-12	393.13	Auto-generated transaction entry #138	2025-06-15 08:46:27.912073
639	1	2	Transaction #139	2025-05-26	610.21	Auto-generated transaction entry #139	2025-06-15 08:46:27.912073
640	1	1	Transaction #140	2025-05-17	144.12	Auto-generated transaction entry #140	2025-06-15 08:46:27.912073
641	1	2	Transaction #141	2025-06-07	105.40	Auto-generated transaction entry #141	2025-06-15 08:46:27.912073
642	1	3	Transaction #142	2025-05-28	170.12	Auto-generated transaction entry #142	2025-06-15 08:46:27.912073
643	1	3	Transaction #143	2025-05-27	124.50	Auto-generated transaction entry #143	2025-06-15 08:46:27.912073
644	1	3	Transaction #144	2025-05-30	810.83	Auto-generated transaction entry #144	2025-06-15 08:46:27.912073
645	1	3	Transaction #145	2025-06-11	535.49	Auto-generated transaction entry #145	2025-06-15 08:46:27.912073
646	1	3	Transaction #146	2025-06-05	529.50	Auto-generated transaction entry #146	2025-06-15 08:46:27.912073
647	1	2	Transaction #147	2025-06-09	363.78	Auto-generated transaction entry #147	2025-06-15 08:46:27.912073
648	1	3	Transaction #148	2025-06-09	314.57	Auto-generated transaction entry #148	2025-06-15 08:46:27.912073
649	1	1	Transaction #149	2025-06-04	347.18	Auto-generated transaction entry #149	2025-06-15 08:46:27.912073
650	1	2	Transaction #150	2025-05-26	554.54	Auto-generated transaction entry #150	2025-06-15 08:46:27.912073
651	1	1	Transaction #151	2025-06-02	651.06	Auto-generated transaction entry #151	2025-06-15 08:46:27.912073
652	1	2	Transaction #152	2025-05-16	600.96	Auto-generated transaction entry #152	2025-06-15 08:46:27.912073
653	1	2	Transaction #153	2025-06-01	924.87	Auto-generated transaction entry #153	2025-06-15 08:46:27.912073
654	1	2	Transaction #154	2025-06-06	305.88	Auto-generated transaction entry #154	2025-06-15 08:46:27.912073
655	1	1	Transaction #155	2025-06-03	528.82	Auto-generated transaction entry #155	2025-06-15 08:46:27.912073
656	1	1	Transaction #156	2025-06-14	842.85	Auto-generated transaction entry #156	2025-06-15 08:46:27.912073
657	1	2	Transaction #157	2025-05-28	920.11	Auto-generated transaction entry #157	2025-06-15 08:46:27.912073
658	1	1	Transaction #158	2025-06-05	483.10	Auto-generated transaction entry #158	2025-06-15 08:46:27.912073
659	1	2	Transaction #159	2025-05-29	506.28	Auto-generated transaction entry #159	2025-06-15 08:46:27.912073
660	1	3	Transaction #160	2025-05-31	265.21	Auto-generated transaction entry #160	2025-06-15 08:46:27.912073
661	1	2	Transaction #161	2025-05-22	217.01	Auto-generated transaction entry #161	2025-06-15 08:46:27.912073
662	1	1	Transaction #162	2025-05-18	299.01	Auto-generated transaction entry #162	2025-06-15 08:46:27.912073
663	1	3	Transaction #163	2025-06-08	162.78	Auto-generated transaction entry #163	2025-06-15 08:46:27.912073
664	1	1	Transaction #164	2025-05-24	905.35	Auto-generated transaction entry #164	2025-06-15 08:46:27.912073
665	1	1	Transaction #165	2025-05-19	380.86	Auto-generated transaction entry #165	2025-06-15 08:46:27.912073
666	1	1	Transaction #166	2025-06-01	837.82	Auto-generated transaction entry #166	2025-06-15 08:46:27.912073
667	1	3	Transaction #167	2025-06-13	678.61	Auto-generated transaction entry #167	2025-06-15 08:46:27.912073
668	1	3	Transaction #168	2025-06-02	312.45	Auto-generated transaction entry #168	2025-06-15 08:46:27.912073
669	1	1	Transaction #169	2025-06-06	644.53	Auto-generated transaction entry #169	2025-06-15 08:46:27.912073
670	1	3	Transaction #170	2025-05-20	417.49	Auto-generated transaction entry #170	2025-06-15 08:46:27.912073
671	1	2	Transaction #171	2025-05-30	901.36	Auto-generated transaction entry #171	2025-06-15 08:46:27.912073
672	1	3	Transaction #172	2025-05-25	558.24	Auto-generated transaction entry #172	2025-06-15 08:46:27.912073
673	1	2	Transaction #173	2025-06-03	541.06	Auto-generated transaction entry #173	2025-06-15 08:46:27.912073
674	1	3	Transaction #174	2025-06-04	281.63	Auto-generated transaction entry #174	2025-06-15 08:46:27.912073
675	1	3	Transaction #175	2025-05-22	425.36	Auto-generated transaction entry #175	2025-06-15 08:46:27.912073
676	1	3	Transaction #176	2025-06-06	102.27	Auto-generated transaction entry #176	2025-06-15 08:46:27.912073
677	1	2	Transaction #177	2025-06-05	291.23	Auto-generated transaction entry #177	2025-06-15 08:46:27.912073
678	1	2	Transaction #178	2025-05-20	171.42	Auto-generated transaction entry #178	2025-06-15 08:46:27.912073
679	1	3	Transaction #179	2025-06-03	535.28	Auto-generated transaction entry #179	2025-06-15 08:46:27.912073
680	1	3	Transaction #180	2025-05-19	707.63	Auto-generated transaction entry #180	2025-06-15 08:46:27.912073
681	1	1	Transaction #181	2025-05-20	158.63	Auto-generated transaction entry #181	2025-06-15 08:46:27.912073
682	1	2	Transaction #182	2025-06-06	237.04	Auto-generated transaction entry #182	2025-06-15 08:46:27.912073
683	1	3	Transaction #183	2025-06-04	247.42	Auto-generated transaction entry #183	2025-06-15 08:46:27.912073
684	1	3	Transaction #184	2025-05-26	497.84	Auto-generated transaction entry #184	2025-06-15 08:46:27.912073
685	1	3	Transaction #185	2025-06-13	259.27	Auto-generated transaction entry #185	2025-06-15 08:46:27.912073
686	1	2	Transaction #186	2025-06-05	879.79	Auto-generated transaction entry #186	2025-06-15 08:46:27.912073
687	1	1	Transaction #187	2025-06-12	832.46	Auto-generated transaction entry #187	2025-06-15 08:46:27.912073
688	1	1	Transaction #188	2025-06-04	474.20	Auto-generated transaction entry #188	2025-06-15 08:46:27.912073
689	1	1	Transaction #189	2025-05-18	523.53	Auto-generated transaction entry #189	2025-06-15 08:46:27.912073
690	1	2	Transaction #190	2025-06-14	187.47	Auto-generated transaction entry #190	2025-06-15 08:46:27.912073
691	1	1	Transaction #191	2025-06-06	274.58	Auto-generated transaction entry #191	2025-06-15 08:46:27.912073
692	1	2	Transaction #192	2025-05-22	159.46	Auto-generated transaction entry #192	2025-06-15 08:46:27.912073
693	1	3	Transaction #193	2025-05-20	225.14	Auto-generated transaction entry #193	2025-06-15 08:46:27.912073
694	1	1	Transaction #194	2025-05-24	829.59	Auto-generated transaction entry #194	2025-06-15 08:46:27.912073
695	1	2	Transaction #195	2025-05-25	526.36	Auto-generated transaction entry #195	2025-06-15 08:46:27.912073
696	1	2	Transaction #196	2025-06-04	888.28	Auto-generated transaction entry #196	2025-06-15 08:46:27.912073
697	1	2	Transaction #197	2025-06-15	333.29	Auto-generated transaction entry #197	2025-06-15 08:46:27.912073
698	1	2	Transaction #198	2025-05-31	113.79	Auto-generated transaction entry #198	2025-06-15 08:46:27.912073
699	1	3	Transaction #199	2025-06-06	828.84	Auto-generated transaction entry #199	2025-06-15 08:46:27.912073
700	1	2	Transaction #200	2025-06-11	273.38	Auto-generated transaction entry #200	2025-06-15 08:46:27.912073
701	1	3	Transaction #201	2025-05-25	884.08	Auto-generated transaction entry #201	2025-06-15 08:46:27.912073
702	1	1	Transaction #202	2025-06-13	191.19	Auto-generated transaction entry #202	2025-06-15 08:46:27.912073
703	1	3	Transaction #203	2025-05-20	633.95	Auto-generated transaction entry #203	2025-06-15 08:46:27.912073
704	1	3	Transaction #204	2025-05-26	744.40	Auto-generated transaction entry #204	2025-06-15 08:46:27.912073
705	1	1	Transaction #205	2025-05-24	287.61	Auto-generated transaction entry #205	2025-06-15 08:46:27.912073
706	1	3	Transaction #206	2025-06-03	906.96	Auto-generated transaction entry #206	2025-06-15 08:46:27.912073
707	1	2	Transaction #207	2025-05-19	368.60	Auto-generated transaction entry #207	2025-06-15 08:46:27.912073
708	1	1	Transaction #208	2025-05-18	314.73	Auto-generated transaction entry #208	2025-06-15 08:46:27.912073
709	1	2	Transaction #209	2025-06-10	661.76	Auto-generated transaction entry #209	2025-06-15 08:46:27.912073
710	1	3	Transaction #210	2025-05-18	124.85	Auto-generated transaction entry #210	2025-06-15 08:46:27.912073
711	1	2	Transaction #211	2025-05-26	343.82	Auto-generated transaction entry #211	2025-06-15 08:46:27.912073
712	1	2	Transaction #212	2025-05-24	513.65	Auto-generated transaction entry #212	2025-06-15 08:46:27.912073
713	1	1	Transaction #213	2025-06-07	419.50	Auto-generated transaction entry #213	2025-06-15 08:46:27.912073
714	1	2	Transaction #214	2025-05-29	750.13	Auto-generated transaction entry #214	2025-06-15 08:46:27.912073
715	1	2	Transaction #215	2025-06-09	142.36	Auto-generated transaction entry #215	2025-06-15 08:46:27.912073
716	1	2	Transaction #216	2025-05-29	649.17	Auto-generated transaction entry #216	2025-06-15 08:46:27.912073
717	1	3	Transaction #217	2025-05-19	225.66	Auto-generated transaction entry #217	2025-06-15 08:46:27.912073
718	1	3	Transaction #218	2025-05-16	552.49	Auto-generated transaction entry #218	2025-06-15 08:46:27.912073
719	1	3	Transaction #219	2025-05-26	709.48	Auto-generated transaction entry #219	2025-06-15 08:46:27.912073
720	1	3	Transaction #220	2025-05-18	446.97	Auto-generated transaction entry #220	2025-06-15 08:46:27.912073
721	1	2	Transaction #221	2025-06-02	501.44	Auto-generated transaction entry #221	2025-06-15 08:46:27.912073
722	1	2	Transaction #222	2025-05-17	182.73	Auto-generated transaction entry #222	2025-06-15 08:46:27.912073
723	1	3	Transaction #223	2025-05-26	620.61	Auto-generated transaction entry #223	2025-06-15 08:46:27.912073
724	1	3	Transaction #224	2025-05-29	204.12	Auto-generated transaction entry #224	2025-06-15 08:46:27.912073
725	1	3	Transaction #225	2025-05-27	999.14	Auto-generated transaction entry #225	2025-06-15 08:46:27.912073
726	1	2	Transaction #226	2025-06-09	246.25	Auto-generated transaction entry #226	2025-06-15 08:46:27.912073
727	1	1	Transaction #227	2025-06-09	970.75	Auto-generated transaction entry #227	2025-06-15 08:46:27.912073
728	1	3	Transaction #228	2025-05-31	236.90	Auto-generated transaction entry #228	2025-06-15 08:46:27.912073
729	1	2	Transaction #229	2025-05-17	110.28	Auto-generated transaction entry #229	2025-06-15 08:46:27.912073
730	1	2	Transaction #230	2025-05-22	760.66	Auto-generated transaction entry #230	2025-06-15 08:46:27.912073
731	1	1	Transaction #231	2025-05-28	501.90	Auto-generated transaction entry #231	2025-06-15 08:46:27.912073
732	1	2	Transaction #232	2025-05-24	546.81	Auto-generated transaction entry #232	2025-06-15 08:46:27.912073
733	1	2	Transaction #233	2025-06-12	884.27	Auto-generated transaction entry #233	2025-06-15 08:46:27.912073
734	1	3	Transaction #234	2025-05-24	124.01	Auto-generated transaction entry #234	2025-06-15 08:46:27.912073
735	1	2	Transaction #235	2025-05-30	794.27	Auto-generated transaction entry #235	2025-06-15 08:46:27.912073
736	1	3	Transaction #236	2025-05-20	478.62	Auto-generated transaction entry #236	2025-06-15 08:46:27.912073
737	1	1	Transaction #237	2025-05-20	534.06	Auto-generated transaction entry #237	2025-06-15 08:46:27.912073
738	1	3	Transaction #238	2025-06-01	421.78	Auto-generated transaction entry #238	2025-06-15 08:46:27.912073
739	1	3	Transaction #239	2025-06-12	381.53	Auto-generated transaction entry #239	2025-06-15 08:46:27.912073
740	1	2	Transaction #240	2025-05-27	56.67	Auto-generated transaction entry #240	2025-06-15 08:46:27.912073
741	1	1	Transaction #241	2025-05-23	376.47	Auto-generated transaction entry #241	2025-06-15 08:46:27.912073
742	1	2	Transaction #242	2025-05-17	242.45	Auto-generated transaction entry #242	2025-06-15 08:46:27.912073
743	1	2	Transaction #243	2025-06-05	440.18	Auto-generated transaction entry #243	2025-06-15 08:46:27.912073
744	1	1	Transaction #244	2025-06-14	109.98	Auto-generated transaction entry #244	2025-06-15 08:46:27.912073
745	1	2	Transaction #245	2025-06-03	195.04	Auto-generated transaction entry #245	2025-06-15 08:46:27.912073
746	1	3	Transaction #246	2025-06-12	926.61	Auto-generated transaction entry #246	2025-06-15 08:46:27.912073
747	1	3	Transaction #247	2025-05-25	462.22	Auto-generated transaction entry #247	2025-06-15 08:46:27.912073
748	1	2	Transaction #248	2025-05-19	595.74	Auto-generated transaction entry #248	2025-06-15 08:46:27.912073
749	1	3	Transaction #249	2025-05-20	983.06	Auto-generated transaction entry #249	2025-06-15 08:46:27.912073
750	1	3	Transaction #250	2025-05-25	241.10	Auto-generated transaction entry #250	2025-06-15 08:46:27.912073
751	1	2	Transaction #251	2025-05-29	610.66	Auto-generated transaction entry #251	2025-06-15 08:46:27.912073
752	1	2	Transaction #252	2025-06-13	804.59	Auto-generated transaction entry #252	2025-06-15 08:46:27.912073
753	1	3	Transaction #253	2025-06-05	942.65	Auto-generated transaction entry #253	2025-06-15 08:46:27.912073
754	1	1	Transaction #254	2025-05-30	107.83	Auto-generated transaction entry #254	2025-06-15 08:46:27.912073
755	1	1	Transaction #255	2025-05-30	362.49	Auto-generated transaction entry #255	2025-06-15 08:46:27.912073
756	1	1	Transaction #256	2025-05-18	193.86	Auto-generated transaction entry #256	2025-06-15 08:46:27.912073
757	1	1	Transaction #257	2025-06-12	482.22	Auto-generated transaction entry #257	2025-06-15 08:46:27.912073
758	1	1	Transaction #258	2025-06-06	426.98	Auto-generated transaction entry #258	2025-06-15 08:46:27.912073
759	1	1	Transaction #259	2025-05-31	549.05	Auto-generated transaction entry #259	2025-06-15 08:46:27.912073
760	1	1	Transaction #260	2025-06-06	963.24	Auto-generated transaction entry #260	2025-06-15 08:46:27.912073
761	1	3	Transaction #261	2025-05-22	179.21	Auto-generated transaction entry #261	2025-06-15 08:46:27.912073
762	1	3	Transaction #262	2025-05-20	387.31	Auto-generated transaction entry #262	2025-06-15 08:46:27.912073
763	1	3	Transaction #263	2025-06-10	808.56	Auto-generated transaction entry #263	2025-06-15 08:46:27.912073
764	1	3	Transaction #264	2025-06-03	826.93	Auto-generated transaction entry #264	2025-06-15 08:46:27.912073
765	1	3	Transaction #265	2025-05-28	821.23	Auto-generated transaction entry #265	2025-06-15 08:46:27.912073
766	1	1	Transaction #266	2025-05-24	667.45	Auto-generated transaction entry #266	2025-06-15 08:46:27.912073
767	1	2	Transaction #267	2025-06-07	294.79	Auto-generated transaction entry #267	2025-06-15 08:46:27.912073
768	1	2	Transaction #268	2025-06-04	577.91	Auto-generated transaction entry #268	2025-06-15 08:46:27.912073
769	1	2	Transaction #269	2025-05-17	476.56	Auto-generated transaction entry #269	2025-06-15 08:46:27.912073
770	1	2	Transaction #270	2025-05-17	432.61	Auto-generated transaction entry #270	2025-06-15 08:46:27.912073
771	1	3	Transaction #271	2025-05-18	155.66	Auto-generated transaction entry #271	2025-06-15 08:46:27.912073
772	1	2	Transaction #272	2025-06-05	538.36	Auto-generated transaction entry #272	2025-06-15 08:46:27.912073
773	1	1	Transaction #273	2025-06-12	943.93	Auto-generated transaction entry #273	2025-06-15 08:46:27.912073
774	1	3	Transaction #274	2025-05-19	245.24	Auto-generated transaction entry #274	2025-06-15 08:46:27.912073
775	1	1	Transaction #275	2025-05-28	986.89	Auto-generated transaction entry #275	2025-06-15 08:46:27.912073
776	1	3	Transaction #276	2025-06-08	374.77	Auto-generated transaction entry #276	2025-06-15 08:46:27.912073
777	1	1	Transaction #277	2025-06-13	417.20	Auto-generated transaction entry #277	2025-06-15 08:46:27.912073
778	1	3	Transaction #278	2025-05-30	894.18	Auto-generated transaction entry #278	2025-06-15 08:46:27.912073
779	1	3	Transaction #279	2025-05-18	387.42	Auto-generated transaction entry #279	2025-06-15 08:46:27.912073
780	1	3	Transaction #280	2025-05-16	766.88	Auto-generated transaction entry #280	2025-06-15 08:46:27.912073
781	1	2	Transaction #281	2025-05-19	537.70	Auto-generated transaction entry #281	2025-06-15 08:46:27.912073
782	1	1	Transaction #282	2025-06-03	815.66	Auto-generated transaction entry #282	2025-06-15 08:46:27.912073
783	1	1	Transaction #283	2025-05-31	77.41	Auto-generated transaction entry #283	2025-06-15 08:46:27.912073
784	1	3	Transaction #284	2025-06-14	260.05	Auto-generated transaction entry #284	2025-06-15 08:46:27.912073
785	1	2	Transaction #285	2025-05-24	456.74	Auto-generated transaction entry #285	2025-06-15 08:46:27.912073
786	1	3	Transaction #286	2025-06-04	267.15	Auto-generated transaction entry #286	2025-06-15 08:46:27.912073
787	1	2	Transaction #287	2025-05-27	332.13	Auto-generated transaction entry #287	2025-06-15 08:46:27.912073
788	1	1	Transaction #288	2025-06-11	620.87	Auto-generated transaction entry #288	2025-06-15 08:46:27.912073
789	1	3	Transaction #289	2025-06-07	939.41	Auto-generated transaction entry #289	2025-06-15 08:46:27.912073
790	1	2	Transaction #290	2025-05-16	769.66	Auto-generated transaction entry #290	2025-06-15 08:46:27.912073
791	1	1	Transaction #291	2025-06-01	795.01	Auto-generated transaction entry #291	2025-06-15 08:46:27.912073
792	1	1	Transaction #292	2025-06-15	224.61	Auto-generated transaction entry #292	2025-06-15 08:46:27.912073
793	1	3	Transaction #293	2025-05-22	357.25	Auto-generated transaction entry #293	2025-06-15 08:46:27.912073
794	1	1	Transaction #294	2025-06-04	793.89	Auto-generated transaction entry #294	2025-06-15 08:46:27.912073
795	1	1	Transaction #295	2025-05-27	805.86	Auto-generated transaction entry #295	2025-06-15 08:46:27.912073
796	1	3	Transaction #296	2025-06-07	254.54	Auto-generated transaction entry #296	2025-06-15 08:46:27.912073
797	1	2	Transaction #297	2025-05-22	126.03	Auto-generated transaction entry #297	2025-06-15 08:46:27.912073
798	1	1	Transaction #298	2025-05-20	231.34	Auto-generated transaction entry #298	2025-06-15 08:46:27.912073
799	1	1	Transaction #299	2025-06-11	545.92	Auto-generated transaction entry #299	2025-06-15 08:46:27.912073
800	1	3	Transaction #300	2025-05-23	864.36	Auto-generated transaction entry #300	2025-06-15 08:46:27.912073
801	1	1	Transaction #301	2025-05-26	960.65	Auto-generated transaction entry #301	2025-06-15 08:46:27.912073
802	1	2	Transaction #302	2025-06-14	581.35	Auto-generated transaction entry #302	2025-06-15 08:46:27.912073
803	1	2	Transaction #303	2025-05-25	452.59	Auto-generated transaction entry #303	2025-06-15 08:46:27.912073
804	1	2	Transaction #304	2025-06-05	321.69	Auto-generated transaction entry #304	2025-06-15 08:46:27.912073
805	1	1	Transaction #305	2025-05-30	280.90	Auto-generated transaction entry #305	2025-06-15 08:46:27.912073
806	1	1	Transaction #306	2025-05-28	620.40	Auto-generated transaction entry #306	2025-06-15 08:46:27.912073
807	1	3	Transaction #307	2025-06-06	442.32	Auto-generated transaction entry #307	2025-06-15 08:46:27.912073
808	1	2	Transaction #308	2025-05-18	186.88	Auto-generated transaction entry #308	2025-06-15 08:46:27.912073
809	1	1	Transaction #309	2025-06-09	375.83	Auto-generated transaction entry #309	2025-06-15 08:46:27.912073
810	1	2	Transaction #310	2025-06-12	403.81	Auto-generated transaction entry #310	2025-06-15 08:46:27.912073
811	1	1	Transaction #311	2025-05-21	534.06	Auto-generated transaction entry #311	2025-06-15 08:46:27.912073
812	1	3	Transaction #312	2025-05-20	84.55	Auto-generated transaction entry #312	2025-06-15 08:46:27.912073
813	1	1	Transaction #313	2025-06-12	714.26	Auto-generated transaction entry #313	2025-06-15 08:46:27.912073
814	1	2	Transaction #314	2025-06-10	366.91	Auto-generated transaction entry #314	2025-06-15 08:46:27.912073
815	1	2	Transaction #315	2025-05-22	824.08	Auto-generated transaction entry #315	2025-06-15 08:46:27.912073
816	1	1	Transaction #316	2025-06-05	657.50	Auto-generated transaction entry #316	2025-06-15 08:46:27.912073
817	1	3	Transaction #317	2025-05-30	435.93	Auto-generated transaction entry #317	2025-06-15 08:46:27.912073
818	1	3	Transaction #318	2025-05-19	997.82	Auto-generated transaction entry #318	2025-06-15 08:46:27.912073
819	1	1	Transaction #319	2025-06-06	886.22	Auto-generated transaction entry #319	2025-06-15 08:46:27.912073
820	1	1	Transaction #320	2025-06-06	132.83	Auto-generated transaction entry #320	2025-06-15 08:46:27.912073
821	1	2	Transaction #321	2025-06-12	319.62	Auto-generated transaction entry #321	2025-06-15 08:46:27.912073
822	1	2	Transaction #322	2025-06-07	263.15	Auto-generated transaction entry #322	2025-06-15 08:46:27.912073
823	1	1	Transaction #323	2025-06-01	162.77	Auto-generated transaction entry #323	2025-06-15 08:46:27.912073
824	1	1	Transaction #324	2025-06-09	237.70	Auto-generated transaction entry #324	2025-06-15 08:46:27.912073
825	1	1	Transaction #325	2025-05-30	938.26	Auto-generated transaction entry #325	2025-06-15 08:46:27.912073
826	1	3	Transaction #326	2025-06-01	265.60	Auto-generated transaction entry #326	2025-06-15 08:46:27.912073
827	1	2	Transaction #327	2025-06-11	581.54	Auto-generated transaction entry #327	2025-06-15 08:46:27.912073
828	1	3	Transaction #328	2025-06-12	302.97	Auto-generated transaction entry #328	2025-06-15 08:46:27.912073
829	1	3	Transaction #329	2025-06-10	968.59	Auto-generated transaction entry #329	2025-06-15 08:46:27.912073
830	1	3	Transaction #330	2025-05-30	681.45	Auto-generated transaction entry #330	2025-06-15 08:46:27.912073
831	1	1	Transaction #331	2025-06-07	829.23	Auto-generated transaction entry #331	2025-06-15 08:46:27.912073
832	1	3	Transaction #332	2025-05-20	642.10	Auto-generated transaction entry #332	2025-06-15 08:46:27.912073
833	1	1	Transaction #333	2025-06-03	313.54	Auto-generated transaction entry #333	2025-06-15 08:46:27.912073
834	1	3	Transaction #334	2025-06-13	107.55	Auto-generated transaction entry #334	2025-06-15 08:46:27.912073
835	1	1	Transaction #335	2025-06-01	133.73	Auto-generated transaction entry #335	2025-06-15 08:46:27.912073
836	1	3	Transaction #336	2025-05-21	861.57	Auto-generated transaction entry #336	2025-06-15 08:46:27.912073
837	1	2	Transaction #337	2025-05-23	573.95	Auto-generated transaction entry #337	2025-06-15 08:46:27.912073
838	1	3	Transaction #338	2025-05-24	68.88	Auto-generated transaction entry #338	2025-06-15 08:46:27.912073
839	1	1	Transaction #339	2025-05-23	579.58	Auto-generated transaction entry #339	2025-06-15 08:46:27.912073
840	1	2	Transaction #340	2025-05-17	670.43	Auto-generated transaction entry #340	2025-06-15 08:46:27.912073
841	1	1	Transaction #341	2025-05-28	348.53	Auto-generated transaction entry #341	2025-06-15 08:46:27.912073
842	1	3	Transaction #342	2025-05-23	174.00	Auto-generated transaction entry #342	2025-06-15 08:46:27.912073
843	1	2	Transaction #343	2025-06-03	684.84	Auto-generated transaction entry #343	2025-06-15 08:46:27.912073
844	1	2	Transaction #344	2025-06-14	644.70	Auto-generated transaction entry #344	2025-06-15 08:46:27.912073
845	1	2	Transaction #345	2025-05-25	978.04	Auto-generated transaction entry #345	2025-06-15 08:46:27.912073
846	1	3	Transaction #346	2025-06-06	790.62	Auto-generated transaction entry #346	2025-06-15 08:46:27.912073
847	1	2	Transaction #347	2025-05-24	918.41	Auto-generated transaction entry #347	2025-06-15 08:46:27.912073
848	1	1	Transaction #348	2025-06-12	173.13	Auto-generated transaction entry #348	2025-06-15 08:46:27.912073
849	1	2	Transaction #349	2025-06-14	707.05	Auto-generated transaction entry #349	2025-06-15 08:46:27.912073
850	1	3	Transaction #350	2025-05-27	720.56	Auto-generated transaction entry #350	2025-06-15 08:46:27.912073
851	1	3	Transaction #351	2025-05-27	980.13	Auto-generated transaction entry #351	2025-06-15 08:46:27.912073
852	1	1	Transaction #352	2025-05-30	561.79	Auto-generated transaction entry #352	2025-06-15 08:46:27.912073
853	1	1	Transaction #353	2025-05-16	899.52	Auto-generated transaction entry #353	2025-06-15 08:46:27.912073
854	1	2	Transaction #354	2025-05-19	728.57	Auto-generated transaction entry #354	2025-06-15 08:46:27.912073
855	1	3	Transaction #355	2025-06-02	149.22	Auto-generated transaction entry #355	2025-06-15 08:46:27.912073
856	1	3	Transaction #356	2025-06-07	203.56	Auto-generated transaction entry #356	2025-06-15 08:46:27.912073
857	1	1	Transaction #357	2025-06-01	81.40	Auto-generated transaction entry #357	2025-06-15 08:46:27.912073
858	1	2	Transaction #358	2025-06-06	372.59	Auto-generated transaction entry #358	2025-06-15 08:46:27.912073
859	1	1	Transaction #359	2025-05-19	238.97	Auto-generated transaction entry #359	2025-06-15 08:46:27.912073
860	1	1	Transaction #360	2025-05-17	78.46	Auto-generated transaction entry #360	2025-06-15 08:46:27.912073
861	1	2	Transaction #361	2025-06-01	979.31	Auto-generated transaction entry #361	2025-06-15 08:46:27.912073
862	1	1	Transaction #362	2025-05-21	265.49	Auto-generated transaction entry #362	2025-06-15 08:46:27.912073
863	1	1	Transaction #363	2025-06-08	783.06	Auto-generated transaction entry #363	2025-06-15 08:46:27.912073
864	1	3	Transaction #364	2025-06-07	472.50	Auto-generated transaction entry #364	2025-06-15 08:46:27.912073
865	1	2	Transaction #365	2025-05-26	797.30	Auto-generated transaction entry #365	2025-06-15 08:46:27.912073
866	1	3	Transaction #366	2025-06-02	113.24	Auto-generated transaction entry #366	2025-06-15 08:46:27.912073
867	1	1	Transaction #367	2025-05-31	153.68	Auto-generated transaction entry #367	2025-06-15 08:46:27.912073
868	1	3	Transaction #368	2025-05-29	566.99	Auto-generated transaction entry #368	2025-06-15 08:46:27.912073
869	1	2	Transaction #369	2025-06-10	286.50	Auto-generated transaction entry #369	2025-06-15 08:46:27.912073
870	1	1	Transaction #370	2025-05-27	849.23	Auto-generated transaction entry #370	2025-06-15 08:46:27.912073
871	1	2	Transaction #371	2025-05-25	92.05	Auto-generated transaction entry #371	2025-06-15 08:46:27.912073
872	1	1	Transaction #372	2025-05-29	152.15	Auto-generated transaction entry #372	2025-06-15 08:46:27.912073
873	1	2	Transaction #373	2025-06-02	280.23	Auto-generated transaction entry #373	2025-06-15 08:46:27.912073
874	1	3	Transaction #374	2025-06-11	700.54	Auto-generated transaction entry #374	2025-06-15 08:46:27.912073
875	1	1	Transaction #375	2025-06-09	399.04	Auto-generated transaction entry #375	2025-06-15 08:46:27.912073
876	1	1	Transaction #376	2025-05-29	652.04	Auto-generated transaction entry #376	2025-06-15 08:46:27.912073
877	1	3	Transaction #377	2025-06-06	806.73	Auto-generated transaction entry #377	2025-06-15 08:46:27.912073
878	1	1	Transaction #378	2025-06-09	980.84	Auto-generated transaction entry #378	2025-06-15 08:46:27.912073
879	1	3	Transaction #379	2025-05-19	216.53	Auto-generated transaction entry #379	2025-06-15 08:46:27.912073
880	1	1	Transaction #380	2025-06-08	231.61	Auto-generated transaction entry #380	2025-06-15 08:46:27.912073
881	1	1	Transaction #381	2025-05-22	212.69	Auto-generated transaction entry #381	2025-06-15 08:46:27.912073
882	1	1	Transaction #382	2025-06-01	613.00	Auto-generated transaction entry #382	2025-06-15 08:46:27.912073
883	1	1	Transaction #383	2025-06-04	616.01	Auto-generated transaction entry #383	2025-06-15 08:46:27.912073
884	1	2	Transaction #384	2025-06-07	434.52	Auto-generated transaction entry #384	2025-06-15 08:46:27.912073
885	1	3	Transaction #385	2025-06-08	965.66	Auto-generated transaction entry #385	2025-06-15 08:46:27.912073
886	1	2	Transaction #386	2025-05-31	571.77	Auto-generated transaction entry #386	2025-06-15 08:46:27.912073
887	1	1	Transaction #387	2025-06-09	267.88	Auto-generated transaction entry #387	2025-06-15 08:46:27.912073
888	1	3	Transaction #388	2025-06-13	864.16	Auto-generated transaction entry #388	2025-06-15 08:46:27.912073
889	1	2	Transaction #389	2025-05-25	463.26	Auto-generated transaction entry #389	2025-06-15 08:46:27.912073
890	1	1	Transaction #390	2025-06-09	866.17	Auto-generated transaction entry #390	2025-06-15 08:46:27.912073
891	1	3	Transaction #391	2025-05-25	760.01	Auto-generated transaction entry #391	2025-06-15 08:46:27.912073
892	1	2	Transaction #392	2025-06-08	479.45	Auto-generated transaction entry #392	2025-06-15 08:46:27.912073
893	1	3	Transaction #393	2025-06-05	154.24	Auto-generated transaction entry #393	2025-06-15 08:46:27.912073
894	1	2	Transaction #394	2025-06-02	525.39	Auto-generated transaction entry #394	2025-06-15 08:46:27.912073
895	1	1	Transaction #395	2025-06-10	534.82	Auto-generated transaction entry #395	2025-06-15 08:46:27.912073
896	1	3	Transaction #396	2025-05-22	389.31	Auto-generated transaction entry #396	2025-06-15 08:46:27.912073
897	1	3	Transaction #397	2025-05-30	815.35	Auto-generated transaction entry #397	2025-06-15 08:46:27.912073
898	1	2	Transaction #398	2025-05-21	218.40	Auto-generated transaction entry #398	2025-06-15 08:46:27.912073
899	1	1	Transaction #399	2025-06-08	762.87	Auto-generated transaction entry #399	2025-06-15 08:46:27.912073
900	1	3	Transaction #400	2025-06-02	462.90	Auto-generated transaction entry #400	2025-06-15 08:46:27.912073
901	1	1	Transaction #401	2025-05-30	995.80	Auto-generated transaction entry #401	2025-06-15 08:46:27.912073
902	1	3	Transaction #402	2025-06-14	715.91	Auto-generated transaction entry #402	2025-06-15 08:46:27.912073
903	1	3	Transaction #403	2025-05-30	456.83	Auto-generated transaction entry #403	2025-06-15 08:46:27.912073
904	1	3	Transaction #404	2025-06-06	298.68	Auto-generated transaction entry #404	2025-06-15 08:46:27.912073
905	1	1	Transaction #405	2025-05-16	593.83	Auto-generated transaction entry #405	2025-06-15 08:46:27.912073
906	1	1	Transaction #406	2025-06-01	556.36	Auto-generated transaction entry #406	2025-06-15 08:46:27.912073
907	1	2	Transaction #407	2025-06-11	356.82	Auto-generated transaction entry #407	2025-06-15 08:46:27.912073
908	1	3	Transaction #408	2025-06-12	95.38	Auto-generated transaction entry #408	2025-06-15 08:46:27.912073
909	1	1	Transaction #409	2025-05-28	277.62	Auto-generated transaction entry #409	2025-06-15 08:46:27.912073
910	1	3	Transaction #410	2025-05-22	544.56	Auto-generated transaction entry #410	2025-06-15 08:46:27.912073
911	1	3	Transaction #411	2025-06-05	448.25	Auto-generated transaction entry #411	2025-06-15 08:46:27.912073
912	1	2	Transaction #412	2025-06-06	487.97	Auto-generated transaction entry #412	2025-06-15 08:46:27.912073
913	1	1	Transaction #413	2025-06-06	211.85	Auto-generated transaction entry #413	2025-06-15 08:46:27.912073
914	1	1	Transaction #414	2025-05-18	889.98	Auto-generated transaction entry #414	2025-06-15 08:46:27.912073
915	1	2	Transaction #415	2025-06-10	171.79	Auto-generated transaction entry #415	2025-06-15 08:46:27.912073
916	1	3	Transaction #416	2025-06-05	640.78	Auto-generated transaction entry #416	2025-06-15 08:46:27.912073
917	1	2	Transaction #417	2025-05-31	683.06	Auto-generated transaction entry #417	2025-06-15 08:46:27.912073
918	1	2	Transaction #418	2025-05-26	540.78	Auto-generated transaction entry #418	2025-06-15 08:46:27.912073
919	1	3	Transaction #419	2025-05-26	500.61	Auto-generated transaction entry #419	2025-06-15 08:46:27.912073
920	1	3	Transaction #420	2025-06-12	612.73	Auto-generated transaction entry #420	2025-06-15 08:46:27.912073
921	1	3	Transaction #421	2025-05-20	386.39	Auto-generated transaction entry #421	2025-06-15 08:46:27.912073
922	1	2	Transaction #422	2025-05-25	816.33	Auto-generated transaction entry #422	2025-06-15 08:46:27.912073
923	1	1	Transaction #423	2025-06-13	817.17	Auto-generated transaction entry #423	2025-06-15 08:46:27.912073
924	1	2	Transaction #424	2025-05-24	350.32	Auto-generated transaction entry #424	2025-06-15 08:46:27.912073
925	1	1	Transaction #425	2025-06-14	355.83	Auto-generated transaction entry #425	2025-06-15 08:46:27.912073
926	1	3	Transaction #426	2025-05-24	465.27	Auto-generated transaction entry #426	2025-06-15 08:46:27.912073
927	1	3	Transaction #427	2025-06-05	535.39	Auto-generated transaction entry #427	2025-06-15 08:46:27.912073
928	1	1	Transaction #428	2025-06-13	662.30	Auto-generated transaction entry #428	2025-06-15 08:46:27.912073
929	1	2	Transaction #429	2025-06-11	117.04	Auto-generated transaction entry #429	2025-06-15 08:46:27.912073
930	1	2	Transaction #430	2025-06-09	620.91	Auto-generated transaction entry #430	2025-06-15 08:46:27.912073
931	1	3	Transaction #431	2025-06-07	320.24	Auto-generated transaction entry #431	2025-06-15 08:46:27.912073
932	1	2	Transaction #432	2025-06-11	245.00	Auto-generated transaction entry #432	2025-06-15 08:46:27.912073
933	1	2	Transaction #433	2025-06-15	112.48	Auto-generated transaction entry #433	2025-06-15 08:46:27.912073
934	1	2	Transaction #434	2025-05-29	476.89	Auto-generated transaction entry #434	2025-06-15 08:46:27.912073
935	1	1	Transaction #435	2025-05-24	616.75	Auto-generated transaction entry #435	2025-06-15 08:46:27.912073
936	1	3	Transaction #436	2025-06-02	261.67	Auto-generated transaction entry #436	2025-06-15 08:46:27.912073
937	1	1	Transaction #437	2025-05-30	489.83	Auto-generated transaction entry #437	2025-06-15 08:46:27.912073
938	1	3	Transaction #438	2025-05-25	704.39	Auto-generated transaction entry #438	2025-06-15 08:46:27.912073
939	1	2	Transaction #439	2025-06-14	529.50	Auto-generated transaction entry #439	2025-06-15 08:46:27.912073
940	1	3	Transaction #440	2025-05-16	814.75	Auto-generated transaction entry #440	2025-06-15 08:46:27.912073
941	1	2	Transaction #441	2025-06-06	917.17	Auto-generated transaction entry #441	2025-06-15 08:46:27.912073
942	1	1	Transaction #442	2025-06-09	937.45	Auto-generated transaction entry #442	2025-06-15 08:46:27.912073
943	1	2	Transaction #443	2025-05-21	844.95	Auto-generated transaction entry #443	2025-06-15 08:46:27.912073
944	1	2	Transaction #444	2025-06-06	367.43	Auto-generated transaction entry #444	2025-06-15 08:46:27.912073
945	1	2	Transaction #445	2025-05-23	646.94	Auto-generated transaction entry #445	2025-06-15 08:46:27.912073
946	1	1	Transaction #446	2025-06-01	470.71	Auto-generated transaction entry #446	2025-06-15 08:46:27.912073
947	1	2	Transaction #447	2025-06-15	221.94	Auto-generated transaction entry #447	2025-06-15 08:46:27.912073
948	1	3	Transaction #448	2025-06-05	259.97	Auto-generated transaction entry #448	2025-06-15 08:46:27.912073
949	1	2	Transaction #449	2025-05-20	474.34	Auto-generated transaction entry #449	2025-06-15 08:46:27.912073
950	1	1	Transaction #450	2025-06-05	371.00	Auto-generated transaction entry #450	2025-06-15 08:46:27.912073
951	1	2	Transaction #451	2025-05-27	552.60	Auto-generated transaction entry #451	2025-06-15 08:46:27.912073
952	1	1	Transaction #452	2025-05-29	970.40	Auto-generated transaction entry #452	2025-06-15 08:46:27.912073
953	1	3	Transaction #453	2025-05-31	329.30	Auto-generated transaction entry #453	2025-06-15 08:46:27.912073
954	1	2	Transaction #454	2025-05-22	252.63	Auto-generated transaction entry #454	2025-06-15 08:46:27.912073
955	1	3	Transaction #455	2025-06-02	495.72	Auto-generated transaction entry #455	2025-06-15 08:46:27.912073
956	1	3	Transaction #456	2025-05-25	821.72	Auto-generated transaction entry #456	2025-06-15 08:46:27.912073
957	1	3	Transaction #457	2025-06-14	145.12	Auto-generated transaction entry #457	2025-06-15 08:46:27.912073
958	1	1	Transaction #458	2025-06-03	85.71	Auto-generated transaction entry #458	2025-06-15 08:46:27.912073
959	1	1	Transaction #459	2025-06-13	387.46	Auto-generated transaction entry #459	2025-06-15 08:46:27.912073
960	1	3	Transaction #460	2025-05-21	711.73	Auto-generated transaction entry #460	2025-06-15 08:46:27.912073
961	1	3	Transaction #461	2025-05-30	679.40	Auto-generated transaction entry #461	2025-06-15 08:46:27.912073
962	1	2	Transaction #462	2025-06-15	221.73	Auto-generated transaction entry #462	2025-06-15 08:46:27.912073
963	1	3	Transaction #463	2025-06-04	887.98	Auto-generated transaction entry #463	2025-06-15 08:46:27.912073
964	1	3	Transaction #464	2025-06-05	625.07	Auto-generated transaction entry #464	2025-06-15 08:46:27.912073
965	1	3	Transaction #465	2025-05-19	455.05	Auto-generated transaction entry #465	2025-06-15 08:46:27.912073
966	1	3	Transaction #466	2025-05-20	705.40	Auto-generated transaction entry #466	2025-06-15 08:46:27.912073
967	1	1	Transaction #467	2025-05-31	481.11	Auto-generated transaction entry #467	2025-06-15 08:46:27.912073
968	1	3	Transaction #468	2025-05-25	913.24	Auto-generated transaction entry #468	2025-06-15 08:46:27.912073
969	1	3	Transaction #469	2025-05-27	789.80	Auto-generated transaction entry #469	2025-06-15 08:46:27.912073
970	1	3	Transaction #470	2025-06-05	560.61	Auto-generated transaction entry #470	2025-06-15 08:46:27.912073
971	1	3	Transaction #471	2025-05-18	663.03	Auto-generated transaction entry #471	2025-06-15 08:46:27.912073
972	1	1	Transaction #472	2025-06-13	307.80	Auto-generated transaction entry #472	2025-06-15 08:46:27.912073
973	1	3	Transaction #473	2025-06-08	962.52	Auto-generated transaction entry #473	2025-06-15 08:46:27.912073
974	1	1	Transaction #474	2025-06-08	494.97	Auto-generated transaction entry #474	2025-06-15 08:46:27.912073
975	1	2	Transaction #475	2025-05-23	472.05	Auto-generated transaction entry #475	2025-06-15 08:46:27.912073
976	1	1	Transaction #476	2025-05-17	112.88	Auto-generated transaction entry #476	2025-06-15 08:46:27.912073
977	1	1	Transaction #477	2025-05-24	656.72	Auto-generated transaction entry #477	2025-06-15 08:46:27.912073
978	1	1	Transaction #478	2025-06-10	866.00	Auto-generated transaction entry #478	2025-06-15 08:46:27.912073
979	1	3	Transaction #479	2025-05-22	216.62	Auto-generated transaction entry #479	2025-06-15 08:46:27.912073
980	1	2	Transaction #480	2025-05-24	65.07	Auto-generated transaction entry #480	2025-06-15 08:46:27.912073
981	1	3	Transaction #481	2025-06-14	590.18	Auto-generated transaction entry #481	2025-06-15 08:46:27.912073
982	1	2	Transaction #482	2025-05-31	360.99	Auto-generated transaction entry #482	2025-06-15 08:46:27.912073
983	1	1	Transaction #483	2025-05-23	120.15	Auto-generated transaction entry #483	2025-06-15 08:46:27.912073
984	1	1	Transaction #484	2025-05-29	908.18	Auto-generated transaction entry #484	2025-06-15 08:46:27.912073
985	1	3	Transaction #485	2025-05-24	243.56	Auto-generated transaction entry #485	2025-06-15 08:46:27.912073
986	1	3	Transaction #486	2025-06-12	402.00	Auto-generated transaction entry #486	2025-06-15 08:46:27.912073
987	1	2	Transaction #487	2025-06-11	857.98	Auto-generated transaction entry #487	2025-06-15 08:46:27.912073
988	1	2	Transaction #488	2025-05-24	114.71	Auto-generated transaction entry #488	2025-06-15 08:46:27.912073
989	1	1	Transaction #489	2025-05-25	765.17	Auto-generated transaction entry #489	2025-06-15 08:46:27.912073
990	1	1	Transaction #490	2025-06-09	83.88	Auto-generated transaction entry #490	2025-06-15 08:46:27.912073
991	1	2	Transaction #491	2025-05-18	120.67	Auto-generated transaction entry #491	2025-06-15 08:46:27.912073
992	1	3	Transaction #492	2025-06-06	866.94	Auto-generated transaction entry #492	2025-06-15 08:46:27.912073
993	1	2	Transaction #493	2025-06-04	367.59	Auto-generated transaction entry #493	2025-06-15 08:46:27.912073
994	1	3	Transaction #494	2025-05-17	435.57	Auto-generated transaction entry #494	2025-06-15 08:46:27.912073
995	1	1	Transaction #495	2025-05-27	271.68	Auto-generated transaction entry #495	2025-06-15 08:46:27.912073
996	1	1	Transaction #496	2025-05-18	943.47	Auto-generated transaction entry #496	2025-06-15 08:46:27.912073
997	1	2	Transaction #497	2025-05-23	506.39	Auto-generated transaction entry #497	2025-06-15 08:46:27.912073
998	1	2	Transaction #498	2025-05-25	593.98	Auto-generated transaction entry #498	2025-06-15 08:46:27.912073
999	1	1	Transaction #499	2025-06-01	814.46	Auto-generated transaction entry #499	2025-06-15 08:46:27.912073
1000	1	1	Transaction #500	2025-05-21	892.79	Auto-generated transaction entry #500	2025-06-15 08:46:27.912073
1001	2	11	Transaction #1	2025-06-15	271.14	Auto-generated transaction entry #1	2025-06-15 08:46:39.472275
1002	2	12	Transaction #2	2025-05-28	274.32	Auto-generated transaction entry #2	2025-06-15 08:46:39.472275
1003	2	11	Transaction #3	2025-05-18	714.45	Auto-generated transaction entry #3	2025-06-15 08:46:39.472275
1004	2	12	Transaction #4	2025-05-26	947.85	Auto-generated transaction entry #4	2025-06-15 08:46:39.472275
1005	2	10	Transaction #5	2025-06-04	580.01	Auto-generated transaction entry #5	2025-06-15 08:46:39.472275
1006	2	11	Transaction #6	2025-05-23	777.05	Auto-generated transaction entry #6	2025-06-15 08:46:39.472275
1007	2	11	Transaction #7	2025-06-05	130.57	Auto-generated transaction entry #7	2025-06-15 08:46:39.472275
1008	2	10	Transaction #8	2025-05-17	848.39	Auto-generated transaction entry #8	2025-06-15 08:46:39.472275
1009	2	11	Transaction #9	2025-05-27	340.36	Auto-generated transaction entry #9	2025-06-15 08:46:39.472275
1010	2	12	Transaction #10	2025-06-08	687.59	Auto-generated transaction entry #10	2025-06-15 08:46:39.472275
1011	2	12	Transaction #11	2025-06-08	81.88	Auto-generated transaction entry #11	2025-06-15 08:46:39.472275
1012	2	10	Transaction #12	2025-06-14	821.06	Auto-generated transaction entry #12	2025-06-15 08:46:39.472275
1013	2	12	Transaction #13	2025-06-03	326.26	Auto-generated transaction entry #13	2025-06-15 08:46:39.472275
1014	2	11	Transaction #14	2025-05-28	703.92	Auto-generated transaction entry #14	2025-06-15 08:46:39.472275
1015	2	11	Transaction #15	2025-05-29	422.10	Auto-generated transaction entry #15	2025-06-15 08:46:39.472275
1016	2	10	Transaction #16	2025-05-25	365.32	Auto-generated transaction entry #16	2025-06-15 08:46:39.472275
1017	2	12	Transaction #17	2025-06-15	887.18	Auto-generated transaction entry #17	2025-06-15 08:46:39.472275
1018	2	12	Transaction #18	2025-05-25	335.89	Auto-generated transaction entry #18	2025-06-15 08:46:39.472275
1019	2	10	Transaction #19	2025-05-19	581.20	Auto-generated transaction entry #19	2025-06-15 08:46:39.472275
1020	2	10	Transaction #20	2025-05-24	411.70	Auto-generated transaction entry #20	2025-06-15 08:46:39.472275
1021	2	12	Transaction #21	2025-06-12	971.11	Auto-generated transaction entry #21	2025-06-15 08:46:39.472275
1022	2	10	Transaction #22	2025-06-03	275.03	Auto-generated transaction entry #22	2025-06-15 08:46:39.472275
1023	2	10	Transaction #23	2025-06-10	553.30	Auto-generated transaction entry #23	2025-06-15 08:46:39.472275
1024	2	10	Transaction #24	2025-06-14	383.10	Auto-generated transaction entry #24	2025-06-15 08:46:39.472275
1025	2	11	Transaction #25	2025-05-25	498.32	Auto-generated transaction entry #25	2025-06-15 08:46:39.472275
1026	2	12	Transaction #26	2025-05-19	464.48	Auto-generated transaction entry #26	2025-06-15 08:46:39.472275
1027	2	12	Transaction #27	2025-06-14	827.22	Auto-generated transaction entry #27	2025-06-15 08:46:39.472275
1028	2	11	Transaction #28	2025-06-07	905.30	Auto-generated transaction entry #28	2025-06-15 08:46:39.472275
1029	2	12	Transaction #29	2025-05-20	121.74	Auto-generated transaction entry #29	2025-06-15 08:46:39.472275
1030	2	10	Transaction #30	2025-05-28	854.88	Auto-generated transaction entry #30	2025-06-15 08:46:39.472275
1031	2	11	Transaction #31	2025-05-18	257.07	Auto-generated transaction entry #31	2025-06-15 08:46:39.472275
1032	2	12	Transaction #32	2025-05-30	239.67	Auto-generated transaction entry #32	2025-06-15 08:46:39.472275
1033	2	12	Transaction #33	2025-06-09	68.45	Auto-generated transaction entry #33	2025-06-15 08:46:39.472275
1034	2	12	Transaction #34	2025-05-26	384.00	Auto-generated transaction entry #34	2025-06-15 08:46:39.472275
1035	2	11	Transaction #35	2025-06-02	93.07	Auto-generated transaction entry #35	2025-06-15 08:46:39.472275
1036	2	10	Transaction #36	2025-05-27	874.21	Auto-generated transaction entry #36	2025-06-15 08:46:39.472275
1037	2	10	Transaction #37	2025-05-31	790.11	Auto-generated transaction entry #37	2025-06-15 08:46:39.472275
1038	2	11	Transaction #38	2025-05-25	391.22	Auto-generated transaction entry #38	2025-06-15 08:46:39.472275
1039	2	10	Transaction #39	2025-06-06	736.75	Auto-generated transaction entry #39	2025-06-15 08:46:39.472275
1040	2	10	Transaction #40	2025-06-02	466.83	Auto-generated transaction entry #40	2025-06-15 08:46:39.472275
1041	2	10	Transaction #41	2025-05-31	61.26	Auto-generated transaction entry #41	2025-06-15 08:46:39.472275
1042	2	12	Transaction #42	2025-05-26	636.28	Auto-generated transaction entry #42	2025-06-15 08:46:39.472275
1043	2	12	Transaction #43	2025-06-07	246.33	Auto-generated transaction entry #43	2025-06-15 08:46:39.472275
1044	2	11	Transaction #44	2025-06-11	371.50	Auto-generated transaction entry #44	2025-06-15 08:46:39.472275
1045	2	12	Transaction #45	2025-05-20	958.14	Auto-generated transaction entry #45	2025-06-15 08:46:39.472275
1046	2	12	Transaction #46	2025-05-27	513.54	Auto-generated transaction entry #46	2025-06-15 08:46:39.472275
1047	2	10	Transaction #47	2025-05-20	61.15	Auto-generated transaction entry #47	2025-06-15 08:46:39.472275
1048	2	11	Transaction #48	2025-06-14	770.59	Auto-generated transaction entry #48	2025-06-15 08:46:39.472275
1049	2	11	Transaction #49	2025-05-21	88.96	Auto-generated transaction entry #49	2025-06-15 08:46:39.472275
1050	2	12	Transaction #50	2025-06-10	195.70	Auto-generated transaction entry #50	2025-06-15 08:46:39.472275
1051	2	12	Transaction #51	2025-05-21	284.39	Auto-generated transaction entry #51	2025-06-15 08:46:39.472275
1052	2	11	Transaction #52	2025-06-13	755.15	Auto-generated transaction entry #52	2025-06-15 08:46:39.472275
1053	2	11	Transaction #53	2025-06-07	815.68	Auto-generated transaction entry #53	2025-06-15 08:46:39.472275
1054	2	11	Transaction #54	2025-05-22	634.19	Auto-generated transaction entry #54	2025-06-15 08:46:39.472275
1055	2	12	Transaction #55	2025-06-09	495.57	Auto-generated transaction entry #55	2025-06-15 08:46:39.472275
1056	2	11	Transaction #56	2025-06-13	324.42	Auto-generated transaction entry #56	2025-06-15 08:46:39.472275
1057	2	10	Transaction #57	2025-06-13	268.66	Auto-generated transaction entry #57	2025-06-15 08:46:39.472275
1058	2	10	Transaction #58	2025-06-04	811.44	Auto-generated transaction entry #58	2025-06-15 08:46:39.472275
1059	2	12	Transaction #59	2025-05-30	101.30	Auto-generated transaction entry #59	2025-06-15 08:46:39.472275
1060	2	12	Transaction #60	2025-06-04	532.66	Auto-generated transaction entry #60	2025-06-15 08:46:39.472275
1061	2	11	Transaction #61	2025-06-01	902.41	Auto-generated transaction entry #61	2025-06-15 08:46:39.472275
1062	2	10	Transaction #62	2025-05-20	593.88	Auto-generated transaction entry #62	2025-06-15 08:46:39.472275
1063	2	10	Transaction #63	2025-05-21	206.89	Auto-generated transaction entry #63	2025-06-15 08:46:39.472275
1064	2	12	Transaction #64	2025-06-01	204.32	Auto-generated transaction entry #64	2025-06-15 08:46:39.472275
1065	2	11	Transaction #65	2025-05-28	333.00	Auto-generated transaction entry #65	2025-06-15 08:46:39.472275
1066	2	10	Transaction #66	2025-06-11	794.99	Auto-generated transaction entry #66	2025-06-15 08:46:39.472275
1067	2	11	Transaction #67	2025-06-02	440.72	Auto-generated transaction entry #67	2025-06-15 08:46:39.472275
1068	2	12	Transaction #68	2025-05-17	772.38	Auto-generated transaction entry #68	2025-06-15 08:46:39.472275
1069	2	12	Transaction #69	2025-05-21	885.96	Auto-generated transaction entry #69	2025-06-15 08:46:39.472275
1070	2	12	Transaction #70	2025-06-13	819.16	Auto-generated transaction entry #70	2025-06-15 08:46:39.472275
1071	2	12	Transaction #71	2025-06-11	252.75	Auto-generated transaction entry #71	2025-06-15 08:46:39.472275
1072	2	10	Transaction #72	2025-06-12	613.79	Auto-generated transaction entry #72	2025-06-15 08:46:39.472275
1073	2	10	Transaction #73	2025-06-01	60.55	Auto-generated transaction entry #73	2025-06-15 08:46:39.472275
1074	2	10	Transaction #74	2025-06-09	698.69	Auto-generated transaction entry #74	2025-06-15 08:46:39.472275
1075	2	11	Transaction #75	2025-05-25	920.99	Auto-generated transaction entry #75	2025-06-15 08:46:39.472275
1076	2	10	Transaction #76	2025-06-07	133.11	Auto-generated transaction entry #76	2025-06-15 08:46:39.472275
1077	2	12	Transaction #77	2025-05-27	998.12	Auto-generated transaction entry #77	2025-06-15 08:46:39.472275
1078	2	10	Transaction #78	2025-05-28	186.64	Auto-generated transaction entry #78	2025-06-15 08:46:39.472275
1079	2	11	Transaction #79	2025-06-11	750.91	Auto-generated transaction entry #79	2025-06-15 08:46:39.472275
1080	2	10	Transaction #80	2025-05-30	399.99	Auto-generated transaction entry #80	2025-06-15 08:46:39.472275
1081	2	11	Transaction #81	2025-06-06	744.27	Auto-generated transaction entry #81	2025-06-15 08:46:39.472275
1082	2	11	Transaction #82	2025-06-02	996.36	Auto-generated transaction entry #82	2025-06-15 08:46:39.472275
1083	2	10	Transaction #83	2025-06-12	643.66	Auto-generated transaction entry #83	2025-06-15 08:46:39.472275
1084	2	10	Transaction #84	2025-05-19	719.60	Auto-generated transaction entry #84	2025-06-15 08:46:39.472275
1085	2	11	Transaction #85	2025-05-30	346.19	Auto-generated transaction entry #85	2025-06-15 08:46:39.472275
1086	2	10	Transaction #86	2025-05-20	583.67	Auto-generated transaction entry #86	2025-06-15 08:46:39.472275
1087	2	12	Transaction #87	2025-05-29	561.37	Auto-generated transaction entry #87	2025-06-15 08:46:39.472275
1088	2	11	Transaction #88	2025-05-26	514.96	Auto-generated transaction entry #88	2025-06-15 08:46:39.472275
1089	2	12	Transaction #89	2025-05-30	352.73	Auto-generated transaction entry #89	2025-06-15 08:46:39.472275
1090	2	12	Transaction #90	2025-06-03	897.39	Auto-generated transaction entry #90	2025-06-15 08:46:39.472275
1091	2	10	Transaction #91	2025-05-17	546.11	Auto-generated transaction entry #91	2025-06-15 08:46:39.472275
1092	2	11	Transaction #92	2025-05-25	309.82	Auto-generated transaction entry #92	2025-06-15 08:46:39.472275
1093	2	11	Transaction #93	2025-05-29	965.69	Auto-generated transaction entry #93	2025-06-15 08:46:39.472275
1094	2	11	Transaction #94	2025-05-25	405.33	Auto-generated transaction entry #94	2025-06-15 08:46:39.472275
1095	2	11	Transaction #95	2025-06-10	124.75	Auto-generated transaction entry #95	2025-06-15 08:46:39.472275
1096	2	12	Transaction #96	2025-06-03	820.28	Auto-generated transaction entry #96	2025-06-15 08:46:39.472275
1097	2	12	Transaction #97	2025-05-29	599.98	Auto-generated transaction entry #97	2025-06-15 08:46:39.472275
1098	2	12	Transaction #98	2025-06-03	752.45	Auto-generated transaction entry #98	2025-06-15 08:46:39.472275
1099	2	12	Transaction #99	2025-05-17	144.16	Auto-generated transaction entry #99	2025-06-15 08:46:39.472275
1100	2	12	Transaction #100	2025-05-29	56.62	Auto-generated transaction entry #100	2025-06-15 08:46:39.472275
1101	2	10	Transaction #101	2025-06-10	888.55	Auto-generated transaction entry #101	2025-06-15 08:46:39.472275
1102	2	10	Transaction #102	2025-05-17	830.60	Auto-generated transaction entry #102	2025-06-15 08:46:39.472275
1103	2	10	Transaction #103	2025-05-31	983.57	Auto-generated transaction entry #103	2025-06-15 08:46:39.472275
1104	2	11	Transaction #104	2025-05-21	624.32	Auto-generated transaction entry #104	2025-06-15 08:46:39.472275
1105	2	11	Transaction #105	2025-06-11	977.58	Auto-generated transaction entry #105	2025-06-15 08:46:39.472275
1106	2	12	Transaction #106	2025-05-29	225.15	Auto-generated transaction entry #106	2025-06-15 08:46:39.472275
1107	2	10	Transaction #107	2025-06-14	320.65	Auto-generated transaction entry #107	2025-06-15 08:46:39.472275
1108	2	10	Transaction #108	2025-06-11	585.01	Auto-generated transaction entry #108	2025-06-15 08:46:39.472275
1109	2	10	Transaction #109	2025-05-31	635.71	Auto-generated transaction entry #109	2025-06-15 08:46:39.472275
1110	2	11	Transaction #110	2025-05-17	366.00	Auto-generated transaction entry #110	2025-06-15 08:46:39.472275
1111	2	12	Transaction #111	2025-06-04	931.91	Auto-generated transaction entry #111	2025-06-15 08:46:39.472275
1112	2	11	Transaction #112	2025-06-08	388.21	Auto-generated transaction entry #112	2025-06-15 08:46:39.472275
1113	2	11	Transaction #113	2025-06-11	797.29	Auto-generated transaction entry #113	2025-06-15 08:46:39.472275
1114	2	10	Transaction #114	2025-05-22	850.65	Auto-generated transaction entry #114	2025-06-15 08:46:39.472275
1115	2	10	Transaction #115	2025-05-31	723.48	Auto-generated transaction entry #115	2025-06-15 08:46:39.472275
1116	2	10	Transaction #116	2025-06-08	577.13	Auto-generated transaction entry #116	2025-06-15 08:46:39.472275
1117	2	11	Transaction #117	2025-06-06	786.08	Auto-generated transaction entry #117	2025-06-15 08:46:39.472275
1118	2	11	Transaction #118	2025-06-10	961.96	Auto-generated transaction entry #118	2025-06-15 08:46:39.472275
1119	2	10	Transaction #119	2025-05-18	319.78	Auto-generated transaction entry #119	2025-06-15 08:46:39.472275
1120	2	11	Transaction #120	2025-05-31	591.68	Auto-generated transaction entry #120	2025-06-15 08:46:39.472275
1121	2	10	Transaction #121	2025-06-14	819.58	Auto-generated transaction entry #121	2025-06-15 08:46:39.472275
1122	2	12	Transaction #122	2025-05-25	62.50	Auto-generated transaction entry #122	2025-06-15 08:46:39.472275
1123	2	10	Transaction #123	2025-05-29	780.94	Auto-generated transaction entry #123	2025-06-15 08:46:39.472275
1124	2	11	Transaction #124	2025-06-02	702.70	Auto-generated transaction entry #124	2025-06-15 08:46:39.472275
1125	2	12	Transaction #125	2025-06-03	912.26	Auto-generated transaction entry #125	2025-06-15 08:46:39.472275
1126	2	11	Transaction #126	2025-06-04	624.92	Auto-generated transaction entry #126	2025-06-15 08:46:39.472275
1127	2	12	Transaction #127	2025-05-19	411.80	Auto-generated transaction entry #127	2025-06-15 08:46:39.472275
1128	2	11	Transaction #128	2025-05-19	660.76	Auto-generated transaction entry #128	2025-06-15 08:46:39.472275
1129	2	12	Transaction #129	2025-05-17	528.05	Auto-generated transaction entry #129	2025-06-15 08:46:39.472275
1130	2	12	Transaction #130	2025-06-02	223.93	Auto-generated transaction entry #130	2025-06-15 08:46:39.472275
1131	2	10	Transaction #131	2025-05-20	260.34	Auto-generated transaction entry #131	2025-06-15 08:46:39.472275
1132	2	10	Transaction #132	2025-05-22	656.60	Auto-generated transaction entry #132	2025-06-15 08:46:39.472275
1133	2	12	Transaction #133	2025-05-21	201.75	Auto-generated transaction entry #133	2025-06-15 08:46:39.472275
1134	2	12	Transaction #134	2025-05-23	467.27	Auto-generated transaction entry #134	2025-06-15 08:46:39.472275
1135	2	12	Transaction #135	2025-05-30	70.21	Auto-generated transaction entry #135	2025-06-15 08:46:39.472275
1136	2	11	Transaction #136	2025-06-02	394.48	Auto-generated transaction entry #136	2025-06-15 08:46:39.472275
1137	2	12	Transaction #137	2025-06-04	608.30	Auto-generated transaction entry #137	2025-06-15 08:46:39.472275
1138	2	12	Transaction #138	2025-06-01	102.39	Auto-generated transaction entry #138	2025-06-15 08:46:39.472275
1139	2	10	Transaction #139	2025-06-14	966.38	Auto-generated transaction entry #139	2025-06-15 08:46:39.472275
1140	2	10	Transaction #140	2025-05-24	574.42	Auto-generated transaction entry #140	2025-06-15 08:46:39.472275
1141	2	11	Transaction #141	2025-05-24	903.94	Auto-generated transaction entry #141	2025-06-15 08:46:39.472275
1142	2	11	Transaction #142	2025-06-08	467.56	Auto-generated transaction entry #142	2025-06-15 08:46:39.472275
1143	2	11	Transaction #143	2025-05-20	432.94	Auto-generated transaction entry #143	2025-06-15 08:46:39.472275
1144	2	12	Transaction #144	2025-05-27	67.47	Auto-generated transaction entry #144	2025-06-15 08:46:39.472275
1145	2	10	Transaction #145	2025-06-11	84.70	Auto-generated transaction entry #145	2025-06-15 08:46:39.472275
1146	2	10	Transaction #146	2025-05-28	259.65	Auto-generated transaction entry #146	2025-06-15 08:46:39.472275
1147	2	12	Transaction #147	2025-06-03	760.88	Auto-generated transaction entry #147	2025-06-15 08:46:39.472275
1148	2	12	Transaction #148	2025-05-28	843.82	Auto-generated transaction entry #148	2025-06-15 08:46:39.472275
1149	2	12	Transaction #149	2025-05-22	931.84	Auto-generated transaction entry #149	2025-06-15 08:46:39.472275
1150	2	10	Transaction #150	2025-05-18	748.26	Auto-generated transaction entry #150	2025-06-15 08:46:39.472275
1151	2	12	Transaction #151	2025-05-24	465.54	Auto-generated transaction entry #151	2025-06-15 08:46:39.472275
1152	2	11	Transaction #152	2025-06-08	907.54	Auto-generated transaction entry #152	2025-06-15 08:46:39.472275
1153	2	10	Transaction #153	2025-05-17	394.51	Auto-generated transaction entry #153	2025-06-15 08:46:39.472275
1154	2	12	Transaction #154	2025-05-22	950.60	Auto-generated transaction entry #154	2025-06-15 08:46:39.472275
1155	2	11	Transaction #155	2025-05-17	749.60	Auto-generated transaction entry #155	2025-06-15 08:46:39.472275
1156	2	12	Transaction #156	2025-06-04	221.34	Auto-generated transaction entry #156	2025-06-15 08:46:39.472275
1157	2	12	Transaction #157	2025-06-04	459.70	Auto-generated transaction entry #157	2025-06-15 08:46:39.472275
1158	2	10	Transaction #158	2025-05-22	916.79	Auto-generated transaction entry #158	2025-06-15 08:46:39.472275
1159	2	12	Transaction #159	2025-05-30	814.96	Auto-generated transaction entry #159	2025-06-15 08:46:39.472275
1160	2	11	Transaction #160	2025-05-17	82.84	Auto-generated transaction entry #160	2025-06-15 08:46:39.472275
1161	2	10	Transaction #161	2025-05-20	650.42	Auto-generated transaction entry #161	2025-06-15 08:46:39.472275
1162	2	10	Transaction #162	2025-06-11	210.06	Auto-generated transaction entry #162	2025-06-15 08:46:39.472275
1163	2	12	Transaction #163	2025-05-25	361.68	Auto-generated transaction entry #163	2025-06-15 08:46:39.472275
1164	2	10	Transaction #164	2025-06-10	733.79	Auto-generated transaction entry #164	2025-06-15 08:46:39.472275
1165	2	12	Transaction #165	2025-05-28	957.50	Auto-generated transaction entry #165	2025-06-15 08:46:39.472275
1166	2	11	Transaction #166	2025-06-04	484.28	Auto-generated transaction entry #166	2025-06-15 08:46:39.472275
1167	2	10	Transaction #167	2025-05-28	653.83	Auto-generated transaction entry #167	2025-06-15 08:46:39.472275
1168	2	11	Transaction #168	2025-05-25	388.26	Auto-generated transaction entry #168	2025-06-15 08:46:39.472275
1169	2	11	Transaction #169	2025-05-29	249.53	Auto-generated transaction entry #169	2025-06-15 08:46:39.472275
1170	2	12	Transaction #170	2025-05-21	460.47	Auto-generated transaction entry #170	2025-06-15 08:46:39.472275
1171	2	11	Transaction #171	2025-06-03	66.34	Auto-generated transaction entry #171	2025-06-15 08:46:39.472275
1172	2	11	Transaction #172	2025-05-27	315.15	Auto-generated transaction entry #172	2025-06-15 08:46:39.472275
1173	2	11	Transaction #173	2025-05-24	528.94	Auto-generated transaction entry #173	2025-06-15 08:46:39.472275
1174	2	12	Transaction #174	2025-05-25	890.33	Auto-generated transaction entry #174	2025-06-15 08:46:39.472275
1175	2	11	Transaction #175	2025-05-25	121.46	Auto-generated transaction entry #175	2025-06-15 08:46:39.472275
1176	2	11	Transaction #176	2025-06-12	911.85	Auto-generated transaction entry #176	2025-06-15 08:46:39.472275
1177	2	11	Transaction #177	2025-06-06	674.12	Auto-generated transaction entry #177	2025-06-15 08:46:39.472275
1178	2	11	Transaction #178	2025-05-26	172.05	Auto-generated transaction entry #178	2025-06-15 08:46:39.472275
1179	2	12	Transaction #179	2025-06-15	408.14	Auto-generated transaction entry #179	2025-06-15 08:46:39.472275
1180	2	11	Transaction #180	2025-05-31	950.95	Auto-generated transaction entry #180	2025-06-15 08:46:39.472275
1181	2	10	Transaction #181	2025-05-22	910.43	Auto-generated transaction entry #181	2025-06-15 08:46:39.472275
1182	2	11	Transaction #182	2025-06-12	661.32	Auto-generated transaction entry #182	2025-06-15 08:46:39.472275
1183	2	10	Transaction #183	2025-05-17	353.20	Auto-generated transaction entry #183	2025-06-15 08:46:39.472275
1184	2	11	Transaction #184	2025-05-27	565.34	Auto-generated transaction entry #184	2025-06-15 08:46:39.472275
1185	2	12	Transaction #185	2025-05-27	410.99	Auto-generated transaction entry #185	2025-06-15 08:46:39.472275
1186	2	10	Transaction #186	2025-05-20	834.48	Auto-generated transaction entry #186	2025-06-15 08:46:39.472275
1187	2	12	Transaction #187	2025-06-06	909.22	Auto-generated transaction entry #187	2025-06-15 08:46:39.472275
1188	2	12	Transaction #188	2025-06-15	397.63	Auto-generated transaction entry #188	2025-06-15 08:46:39.472275
1189	2	12	Transaction #189	2025-05-19	109.14	Auto-generated transaction entry #189	2025-06-15 08:46:39.472275
1190	2	11	Transaction #190	2025-05-25	595.84	Auto-generated transaction entry #190	2025-06-15 08:46:39.472275
1191	2	12	Transaction #191	2025-06-10	875.09	Auto-generated transaction entry #191	2025-06-15 08:46:39.472275
1192	2	11	Transaction #192	2025-06-03	531.21	Auto-generated transaction entry #192	2025-06-15 08:46:39.472275
1193	2	10	Transaction #193	2025-06-01	701.11	Auto-generated transaction entry #193	2025-06-15 08:46:39.472275
1194	2	10	Transaction #194	2025-05-22	987.88	Auto-generated transaction entry #194	2025-06-15 08:46:39.472275
1195	2	12	Transaction #195	2025-05-18	63.43	Auto-generated transaction entry #195	2025-06-15 08:46:39.472275
1196	2	12	Transaction #196	2025-06-10	699.92	Auto-generated transaction entry #196	2025-06-15 08:46:39.472275
1197	2	11	Transaction #197	2025-06-09	222.95	Auto-generated transaction entry #197	2025-06-15 08:46:39.472275
1198	2	10	Transaction #198	2025-05-17	798.93	Auto-generated transaction entry #198	2025-06-15 08:46:39.472275
1199	2	12	Transaction #199	2025-05-19	894.35	Auto-generated transaction entry #199	2025-06-15 08:46:39.472275
1200	2	12	Transaction #200	2025-05-25	999.99	Auto-generated transaction entry #200	2025-06-15 08:46:39.472275
1201	2	10	Transaction #201	2025-06-05	62.05	Auto-generated transaction entry #201	2025-06-15 08:46:39.472275
1202	2	12	Transaction #202	2025-06-04	84.89	Auto-generated transaction entry #202	2025-06-15 08:46:39.472275
1203	2	10	Transaction #203	2025-06-14	62.14	Auto-generated transaction entry #203	2025-06-15 08:46:39.472275
1204	2	11	Transaction #204	2025-06-09	304.98	Auto-generated transaction entry #204	2025-06-15 08:46:39.472275
1205	2	11	Transaction #205	2025-05-24	274.61	Auto-generated transaction entry #205	2025-06-15 08:46:39.472275
1206	2	12	Transaction #206	2025-05-22	183.32	Auto-generated transaction entry #206	2025-06-15 08:46:39.472275
1207	2	12	Transaction #207	2025-05-26	287.28	Auto-generated transaction entry #207	2025-06-15 08:46:39.472275
1208	2	12	Transaction #208	2025-06-10	242.24	Auto-generated transaction entry #208	2025-06-15 08:46:39.472275
1209	2	11	Transaction #209	2025-06-05	109.38	Auto-generated transaction entry #209	2025-06-15 08:46:39.472275
1210	2	10	Transaction #210	2025-06-13	186.07	Auto-generated transaction entry #210	2025-06-15 08:46:39.472275
1211	2	12	Transaction #211	2025-05-21	792.36	Auto-generated transaction entry #211	2025-06-15 08:46:39.472275
1212	2	11	Transaction #212	2025-05-31	915.96	Auto-generated transaction entry #212	2025-06-15 08:46:39.472275
1213	2	11	Transaction #213	2025-06-07	494.96	Auto-generated transaction entry #213	2025-06-15 08:46:39.472275
1214	2	11	Transaction #214	2025-05-24	251.07	Auto-generated transaction entry #214	2025-06-15 08:46:39.472275
1215	2	12	Transaction #215	2025-06-14	947.10	Auto-generated transaction entry #215	2025-06-15 08:46:39.472275
1216	2	11	Transaction #216	2025-06-15	841.12	Auto-generated transaction entry #216	2025-06-15 08:46:39.472275
1217	2	12	Transaction #217	2025-06-06	469.37	Auto-generated transaction entry #217	2025-06-15 08:46:39.472275
1218	2	12	Transaction #218	2025-06-15	901.28	Auto-generated transaction entry #218	2025-06-15 08:46:39.472275
1219	2	12	Transaction #219	2025-06-13	677.38	Auto-generated transaction entry #219	2025-06-15 08:46:39.472275
1220	2	10	Transaction #220	2025-06-07	627.28	Auto-generated transaction entry #220	2025-06-15 08:46:39.472275
1221	2	10	Transaction #221	2025-06-04	76.02	Auto-generated transaction entry #221	2025-06-15 08:46:39.472275
1222	2	12	Transaction #222	2025-06-13	496.31	Auto-generated transaction entry #222	2025-06-15 08:46:39.472275
1223	2	12	Transaction #223	2025-06-10	710.45	Auto-generated transaction entry #223	2025-06-15 08:46:39.472275
1224	2	12	Transaction #224	2025-06-05	528.77	Auto-generated transaction entry #224	2025-06-15 08:46:39.472275
1225	2	11	Transaction #225	2025-05-30	726.28	Auto-generated transaction entry #225	2025-06-15 08:46:39.472275
1226	2	11	Transaction #226	2025-05-17	108.08	Auto-generated transaction entry #226	2025-06-15 08:46:39.472275
1227	2	11	Transaction #227	2025-06-08	299.57	Auto-generated transaction entry #227	2025-06-15 08:46:39.472275
1228	2	10	Transaction #228	2025-06-15	332.29	Auto-generated transaction entry #228	2025-06-15 08:46:39.472275
1229	2	10	Transaction #229	2025-06-09	819.20	Auto-generated transaction entry #229	2025-06-15 08:46:39.472275
1230	2	12	Transaction #230	2025-06-09	541.07	Auto-generated transaction entry #230	2025-06-15 08:46:39.472275
1231	2	12	Transaction #231	2025-05-19	742.62	Auto-generated transaction entry #231	2025-06-15 08:46:39.472275
1232	2	11	Transaction #232	2025-05-31	902.05	Auto-generated transaction entry #232	2025-06-15 08:46:39.472275
1233	2	10	Transaction #233	2025-06-03	482.99	Auto-generated transaction entry #233	2025-06-15 08:46:39.472275
1234	2	10	Transaction #234	2025-06-12	986.25	Auto-generated transaction entry #234	2025-06-15 08:46:39.472275
1235	2	12	Transaction #235	2025-06-14	355.83	Auto-generated transaction entry #235	2025-06-15 08:46:39.472275
1236	2	10	Transaction #236	2025-06-06	312.99	Auto-generated transaction entry #236	2025-06-15 08:46:39.472275
1237	2	10	Transaction #237	2025-06-05	762.26	Auto-generated transaction entry #237	2025-06-15 08:46:39.472275
1238	2	12	Transaction #238	2025-05-23	915.63	Auto-generated transaction entry #238	2025-06-15 08:46:39.472275
1239	2	12	Transaction #239	2025-05-23	80.59	Auto-generated transaction entry #239	2025-06-15 08:46:39.472275
1240	2	11	Transaction #240	2025-06-15	746.13	Auto-generated transaction entry #240	2025-06-15 08:46:39.472275
1241	2	12	Transaction #241	2025-06-08	790.40	Auto-generated transaction entry #241	2025-06-15 08:46:39.472275
1242	2	10	Transaction #242	2025-06-14	626.25	Auto-generated transaction entry #242	2025-06-15 08:46:39.472275
1243	2	10	Transaction #243	2025-05-20	516.50	Auto-generated transaction entry #243	2025-06-15 08:46:39.472275
1244	2	11	Transaction #244	2025-06-10	971.26	Auto-generated transaction entry #244	2025-06-15 08:46:39.472275
1245	2	10	Transaction #245	2025-05-31	674.36	Auto-generated transaction entry #245	2025-06-15 08:46:39.472275
1246	2	12	Transaction #246	2025-06-06	233.69	Auto-generated transaction entry #246	2025-06-15 08:46:39.472275
1247	2	10	Transaction #247	2025-06-13	693.09	Auto-generated transaction entry #247	2025-06-15 08:46:39.472275
1248	2	11	Transaction #248	2025-06-15	626.71	Auto-generated transaction entry #248	2025-06-15 08:46:39.472275
1249	2	10	Transaction #249	2025-06-12	183.62	Auto-generated transaction entry #249	2025-06-15 08:46:39.472275
1250	2	10	Transaction #250	2025-05-24	476.64	Auto-generated transaction entry #250	2025-06-15 08:46:39.472275
1251	2	10	Transaction #251	2025-06-06	463.41	Auto-generated transaction entry #251	2025-06-15 08:46:39.472275
1252	2	11	Transaction #252	2025-05-23	916.02	Auto-generated transaction entry #252	2025-06-15 08:46:39.472275
1253	2	10	Transaction #253	2025-05-20	950.51	Auto-generated transaction entry #253	2025-06-15 08:46:39.472275
1254	2	12	Transaction #254	2025-06-14	721.54	Auto-generated transaction entry #254	2025-06-15 08:46:39.472275
1255	2	12	Transaction #255	2025-05-25	435.74	Auto-generated transaction entry #255	2025-06-15 08:46:39.472275
1256	2	11	Transaction #256	2025-05-17	205.34	Auto-generated transaction entry #256	2025-06-15 08:46:39.472275
1257	2	12	Transaction #257	2025-05-26	847.96	Auto-generated transaction entry #257	2025-06-15 08:46:39.472275
1258	2	11	Transaction #258	2025-06-11	992.85	Auto-generated transaction entry #258	2025-06-15 08:46:39.472275
1259	2	10	Transaction #259	2025-05-28	902.60	Auto-generated transaction entry #259	2025-06-15 08:46:39.472275
1260	2	11	Transaction #260	2025-06-09	504.54	Auto-generated transaction entry #260	2025-06-15 08:46:39.472275
1261	2	12	Transaction #261	2025-05-25	368.09	Auto-generated transaction entry #261	2025-06-15 08:46:39.472275
1262	2	12	Transaction #262	2025-06-14	996.43	Auto-generated transaction entry #262	2025-06-15 08:46:39.472275
1263	2	10	Transaction #263	2025-06-06	582.39	Auto-generated transaction entry #263	2025-06-15 08:46:39.472275
1264	2	11	Transaction #264	2025-05-24	290.13	Auto-generated transaction entry #264	2025-06-15 08:46:39.472275
1265	2	11	Transaction #265	2025-06-03	982.56	Auto-generated transaction entry #265	2025-06-15 08:46:39.472275
1266	2	12	Transaction #266	2025-05-22	335.43	Auto-generated transaction entry #266	2025-06-15 08:46:39.472275
1267	2	11	Transaction #267	2025-05-27	202.45	Auto-generated transaction entry #267	2025-06-15 08:46:39.472275
1268	2	12	Transaction #268	2025-05-26	83.93	Auto-generated transaction entry #268	2025-06-15 08:46:39.472275
1269	2	10	Transaction #269	2025-06-08	538.06	Auto-generated transaction entry #269	2025-06-15 08:46:39.472275
1270	2	10	Transaction #270	2025-05-24	258.52	Auto-generated transaction entry #270	2025-06-15 08:46:39.472275
1271	2	10	Transaction #271	2025-06-10	352.71	Auto-generated transaction entry #271	2025-06-15 08:46:39.472275
1272	2	10	Transaction #272	2025-05-18	119.08	Auto-generated transaction entry #272	2025-06-15 08:46:39.472275
1273	2	10	Transaction #273	2025-05-16	993.56	Auto-generated transaction entry #273	2025-06-15 08:46:39.472275
1274	2	11	Transaction #274	2025-05-17	594.46	Auto-generated transaction entry #274	2025-06-15 08:46:39.472275
1275	2	12	Transaction #275	2025-06-13	894.12	Auto-generated transaction entry #275	2025-06-15 08:46:39.472275
1276	2	12	Transaction #276	2025-06-14	121.72	Auto-generated transaction entry #276	2025-06-15 08:46:39.472275
1277	2	11	Transaction #277	2025-06-09	305.43	Auto-generated transaction entry #277	2025-06-15 08:46:39.472275
1278	2	11	Transaction #278	2025-06-04	213.15	Auto-generated transaction entry #278	2025-06-15 08:46:39.472275
1279	2	10	Transaction #279	2025-06-15	910.20	Auto-generated transaction entry #279	2025-06-15 08:46:39.472275
1280	2	11	Transaction #280	2025-05-21	353.36	Auto-generated transaction entry #280	2025-06-15 08:46:39.472275
1281	2	10	Transaction #281	2025-06-09	115.66	Auto-generated transaction entry #281	2025-06-15 08:46:39.472275
1282	2	10	Transaction #282	2025-05-17	851.81	Auto-generated transaction entry #282	2025-06-15 08:46:39.472275
1283	2	10	Transaction #283	2025-05-17	293.99	Auto-generated transaction entry #283	2025-06-15 08:46:39.472275
1284	2	12	Transaction #284	2025-06-07	85.78	Auto-generated transaction entry #284	2025-06-15 08:46:39.472275
1285	2	11	Transaction #285	2025-06-04	640.37	Auto-generated transaction entry #285	2025-06-15 08:46:39.472275
1286	2	10	Transaction #286	2025-06-03	822.57	Auto-generated transaction entry #286	2025-06-15 08:46:39.472275
1287	2	12	Transaction #287	2025-06-12	654.17	Auto-generated transaction entry #287	2025-06-15 08:46:39.472275
1288	2	11	Transaction #288	2025-05-18	365.61	Auto-generated transaction entry #288	2025-06-15 08:46:39.472275
1289	2	12	Transaction #289	2025-05-25	939.51	Auto-generated transaction entry #289	2025-06-15 08:46:39.472275
1290	2	10	Transaction #290	2025-05-18	739.17	Auto-generated transaction entry #290	2025-06-15 08:46:39.472275
1291	2	12	Transaction #291	2025-06-09	863.47	Auto-generated transaction entry #291	2025-06-15 08:46:39.472275
1292	2	11	Transaction #292	2025-06-12	773.00	Auto-generated transaction entry #292	2025-06-15 08:46:39.472275
1293	2	10	Transaction #293	2025-05-24	832.70	Auto-generated transaction entry #293	2025-06-15 08:46:39.472275
1294	2	11	Transaction #294	2025-05-28	355.28	Auto-generated transaction entry #294	2025-06-15 08:46:39.472275
1295	2	10	Transaction #295	2025-06-07	981.22	Auto-generated transaction entry #295	2025-06-15 08:46:39.472275
1296	2	11	Transaction #296	2025-05-29	422.50	Auto-generated transaction entry #296	2025-06-15 08:46:39.472275
1297	2	10	Transaction #297	2025-05-25	887.20	Auto-generated transaction entry #297	2025-06-15 08:46:39.472275
1298	2	11	Transaction #298	2025-06-05	879.75	Auto-generated transaction entry #298	2025-06-15 08:46:39.472275
1299	2	10	Transaction #299	2025-05-25	703.77	Auto-generated transaction entry #299	2025-06-15 08:46:39.472275
1300	2	11	Transaction #300	2025-05-25	670.68	Auto-generated transaction entry #300	2025-06-15 08:46:39.472275
1301	2	10	Transaction #301	2025-06-10	750.78	Auto-generated transaction entry #301	2025-06-15 08:46:39.472275
1302	2	10	Transaction #302	2025-06-12	397.37	Auto-generated transaction entry #302	2025-06-15 08:46:39.472275
1303	2	11	Transaction #303	2025-05-22	824.75	Auto-generated transaction entry #303	2025-06-15 08:46:39.472275
1304	2	10	Transaction #304	2025-05-17	816.35	Auto-generated transaction entry #304	2025-06-15 08:46:39.472275
1305	2	12	Transaction #305	2025-06-12	158.83	Auto-generated transaction entry #305	2025-06-15 08:46:39.472275
1306	2	11	Transaction #306	2025-05-21	758.00	Auto-generated transaction entry #306	2025-06-15 08:46:39.472275
1307	2	10	Transaction #307	2025-05-29	836.73	Auto-generated transaction entry #307	2025-06-15 08:46:39.472275
1308	2	11	Transaction #308	2025-06-09	784.28	Auto-generated transaction entry #308	2025-06-15 08:46:39.472275
1309	2	12	Transaction #309	2025-06-03	155.90	Auto-generated transaction entry #309	2025-06-15 08:46:39.472275
1310	2	10	Transaction #310	2025-06-08	395.47	Auto-generated transaction entry #310	2025-06-15 08:46:39.472275
1311	2	11	Transaction #311	2025-05-28	305.94	Auto-generated transaction entry #311	2025-06-15 08:46:39.472275
1312	2	11	Transaction #312	2025-05-23	887.73	Auto-generated transaction entry #312	2025-06-15 08:46:39.472275
1313	2	10	Transaction #313	2025-05-23	216.63	Auto-generated transaction entry #313	2025-06-15 08:46:39.472275
1314	2	10	Transaction #314	2025-06-07	985.61	Auto-generated transaction entry #314	2025-06-15 08:46:39.472275
1315	2	11	Transaction #315	2025-06-05	446.44	Auto-generated transaction entry #315	2025-06-15 08:46:39.472275
1316	2	10	Transaction #316	2025-06-08	949.06	Auto-generated transaction entry #316	2025-06-15 08:46:39.472275
1317	2	12	Transaction #317	2025-06-13	592.56	Auto-generated transaction entry #317	2025-06-15 08:46:39.472275
1318	2	12	Transaction #318	2025-05-18	487.81	Auto-generated transaction entry #318	2025-06-15 08:46:39.472275
1319	2	10	Transaction #319	2025-05-23	755.11	Auto-generated transaction entry #319	2025-06-15 08:46:39.472275
1320	2	10	Transaction #320	2025-05-19	954.16	Auto-generated transaction entry #320	2025-06-15 08:46:39.472275
1321	2	10	Transaction #321	2025-05-28	375.59	Auto-generated transaction entry #321	2025-06-15 08:46:39.472275
1322	2	12	Transaction #322	2025-05-31	172.09	Auto-generated transaction entry #322	2025-06-15 08:46:39.472275
1323	2	12	Transaction #323	2025-06-04	848.63	Auto-generated transaction entry #323	2025-06-15 08:46:39.472275
1324	2	11	Transaction #324	2025-05-22	947.14	Auto-generated transaction entry #324	2025-06-15 08:46:39.472275
1325	2	10	Transaction #325	2025-05-19	701.64	Auto-generated transaction entry #325	2025-06-15 08:46:39.472275
1326	2	11	Transaction #326	2025-05-20	120.15	Auto-generated transaction entry #326	2025-06-15 08:46:39.472275
1327	2	11	Transaction #327	2025-06-01	253.09	Auto-generated transaction entry #327	2025-06-15 08:46:39.472275
1328	2	10	Transaction #328	2025-06-11	198.40	Auto-generated transaction entry #328	2025-06-15 08:46:39.472275
1329	2	11	Transaction #329	2025-05-20	624.98	Auto-generated transaction entry #329	2025-06-15 08:46:39.472275
1330	2	10	Transaction #330	2025-05-20	653.99	Auto-generated transaction entry #330	2025-06-15 08:46:39.472275
1331	2	11	Transaction #331	2025-06-09	169.75	Auto-generated transaction entry #331	2025-06-15 08:46:39.472275
1332	2	12	Transaction #332	2025-06-07	64.10	Auto-generated transaction entry #332	2025-06-15 08:46:39.472275
1333	2	10	Transaction #333	2025-05-27	202.47	Auto-generated transaction entry #333	2025-06-15 08:46:39.472275
1334	2	10	Transaction #334	2025-06-10	144.74	Auto-generated transaction entry #334	2025-06-15 08:46:39.472275
1335	2	12	Transaction #335	2025-05-26	603.26	Auto-generated transaction entry #335	2025-06-15 08:46:39.472275
1336	2	11	Transaction #336	2025-06-12	172.97	Auto-generated transaction entry #336	2025-06-15 08:46:39.472275
1337	2	12	Transaction #337	2025-06-09	624.57	Auto-generated transaction entry #337	2025-06-15 08:46:39.472275
1338	2	12	Transaction #338	2025-05-25	938.84	Auto-generated transaction entry #338	2025-06-15 08:46:39.472275
1339	2	10	Transaction #339	2025-06-06	409.60	Auto-generated transaction entry #339	2025-06-15 08:46:39.472275
1340	2	10	Transaction #340	2025-06-01	139.41	Auto-generated transaction entry #340	2025-06-15 08:46:39.472275
1341	2	12	Transaction #341	2025-06-06	278.31	Auto-generated transaction entry #341	2025-06-15 08:46:39.472275
1342	2	12	Transaction #342	2025-05-21	719.74	Auto-generated transaction entry #342	2025-06-15 08:46:39.472275
1343	2	10	Transaction #343	2025-05-19	368.18	Auto-generated transaction entry #343	2025-06-15 08:46:39.472275
1344	2	11	Transaction #344	2025-06-13	768.62	Auto-generated transaction entry #344	2025-06-15 08:46:39.472275
1345	2	10	Transaction #345	2025-05-30	389.02	Auto-generated transaction entry #345	2025-06-15 08:46:39.472275
1346	2	12	Transaction #346	2025-05-22	506.36	Auto-generated transaction entry #346	2025-06-15 08:46:39.472275
1347	2	10	Transaction #347	2025-05-28	464.73	Auto-generated transaction entry #347	2025-06-15 08:46:39.472275
1348	2	10	Transaction #348	2025-06-07	568.73	Auto-generated transaction entry #348	2025-06-15 08:46:39.472275
1349	2	12	Transaction #349	2025-06-13	915.49	Auto-generated transaction entry #349	2025-06-15 08:46:39.472275
1350	2	10	Transaction #350	2025-05-23	785.70	Auto-generated transaction entry #350	2025-06-15 08:46:39.472275
1351	2	10	Transaction #351	2025-05-31	82.07	Auto-generated transaction entry #351	2025-06-15 08:46:39.472275
1352	2	10	Transaction #352	2025-06-14	390.85	Auto-generated transaction entry #352	2025-06-15 08:46:39.472275
1353	2	12	Transaction #353	2025-06-02	704.97	Auto-generated transaction entry #353	2025-06-15 08:46:39.472275
1354	2	10	Transaction #354	2025-06-05	564.00	Auto-generated transaction entry #354	2025-06-15 08:46:39.472275
1355	2	12	Transaction #355	2025-06-07	169.23	Auto-generated transaction entry #355	2025-06-15 08:46:39.472275
1356	2	12	Transaction #356	2025-06-15	421.27	Auto-generated transaction entry #356	2025-06-15 08:46:39.472275
1357	2	11	Transaction #357	2025-06-02	519.67	Auto-generated transaction entry #357	2025-06-15 08:46:39.472275
1358	2	12	Transaction #358	2025-06-07	224.87	Auto-generated transaction entry #358	2025-06-15 08:46:39.472275
1359	2	11	Transaction #359	2025-05-17	505.46	Auto-generated transaction entry #359	2025-06-15 08:46:39.472275
1360	2	12	Transaction #360	2025-06-10	926.78	Auto-generated transaction entry #360	2025-06-15 08:46:39.472275
1361	2	12	Transaction #361	2025-06-13	611.12	Auto-generated transaction entry #361	2025-06-15 08:46:39.472275
1362	2	11	Transaction #362	2025-06-10	577.11	Auto-generated transaction entry #362	2025-06-15 08:46:39.472275
1363	2	12	Transaction #363	2025-06-14	54.70	Auto-generated transaction entry #363	2025-06-15 08:46:39.472275
1364	2	10	Transaction #364	2025-05-28	121.60	Auto-generated transaction entry #364	2025-06-15 08:46:39.472275
1365	2	10	Transaction #365	2025-06-01	467.87	Auto-generated transaction entry #365	2025-06-15 08:46:39.472275
1366	2	10	Transaction #366	2025-06-04	355.61	Auto-generated transaction entry #366	2025-06-15 08:46:39.472275
1367	2	12	Transaction #367	2025-05-21	257.12	Auto-generated transaction entry #367	2025-06-15 08:46:39.472275
1368	2	10	Transaction #368	2025-06-01	938.03	Auto-generated transaction entry #368	2025-06-15 08:46:39.472275
1369	2	12	Transaction #369	2025-05-17	246.45	Auto-generated transaction entry #369	2025-06-15 08:46:39.472275
1370	2	10	Transaction #370	2025-06-07	982.72	Auto-generated transaction entry #370	2025-06-15 08:46:39.472275
1371	2	12	Transaction #371	2025-05-17	346.15	Auto-generated transaction entry #371	2025-06-15 08:46:39.472275
1372	2	10	Transaction #372	2025-05-22	574.16	Auto-generated transaction entry #372	2025-06-15 08:46:39.472275
1373	2	12	Transaction #373	2025-05-20	113.98	Auto-generated transaction entry #373	2025-06-15 08:46:39.472275
1374	2	10	Transaction #374	2025-06-14	91.48	Auto-generated transaction entry #374	2025-06-15 08:46:39.472275
1375	2	11	Transaction #375	2025-05-19	930.90	Auto-generated transaction entry #375	2025-06-15 08:46:39.472275
1376	2	12	Transaction #376	2025-05-30	380.30	Auto-generated transaction entry #376	2025-06-15 08:46:39.472275
1377	2	11	Transaction #377	2025-06-11	896.74	Auto-generated transaction entry #377	2025-06-15 08:46:39.472275
1378	2	11	Transaction #378	2025-06-05	639.95	Auto-generated transaction entry #378	2025-06-15 08:46:39.472275
1379	2	11	Transaction #379	2025-05-24	813.56	Auto-generated transaction entry #379	2025-06-15 08:46:39.472275
1380	2	12	Transaction #380	2025-06-14	591.50	Auto-generated transaction entry #380	2025-06-15 08:46:39.472275
1381	2	11	Transaction #381	2025-06-02	73.77	Auto-generated transaction entry #381	2025-06-15 08:46:39.472275
1382	2	11	Transaction #382	2025-06-12	782.84	Auto-generated transaction entry #382	2025-06-15 08:46:39.472275
1383	2	10	Transaction #383	2025-05-19	276.58	Auto-generated transaction entry #383	2025-06-15 08:46:39.472275
1384	2	12	Transaction #384	2025-06-15	684.49	Auto-generated transaction entry #384	2025-06-15 08:46:39.472275
1385	2	12	Transaction #385	2025-06-04	74.59	Auto-generated transaction entry #385	2025-06-15 08:46:39.472275
1386	2	10	Transaction #386	2025-05-25	703.43	Auto-generated transaction entry #386	2025-06-15 08:46:39.472275
1387	2	12	Transaction #387	2025-06-03	927.88	Auto-generated transaction entry #387	2025-06-15 08:46:39.472275
1388	2	10	Transaction #388	2025-06-03	495.24	Auto-generated transaction entry #388	2025-06-15 08:46:39.472275
1389	2	12	Transaction #389	2025-06-01	830.63	Auto-generated transaction entry #389	2025-06-15 08:46:39.472275
1390	2	10	Transaction #390	2025-06-03	966.14	Auto-generated transaction entry #390	2025-06-15 08:46:39.472275
1391	2	10	Transaction #391	2025-05-29	377.09	Auto-generated transaction entry #391	2025-06-15 08:46:39.472275
1392	2	10	Transaction #392	2025-05-20	281.41	Auto-generated transaction entry #392	2025-06-15 08:46:39.472275
1393	2	11	Transaction #393	2025-06-04	567.96	Auto-generated transaction entry #393	2025-06-15 08:46:39.472275
1394	2	12	Transaction #394	2025-06-08	671.03	Auto-generated transaction entry #394	2025-06-15 08:46:39.472275
1395	2	10	Transaction #395	2025-06-10	382.32	Auto-generated transaction entry #395	2025-06-15 08:46:39.472275
1396	2	11	Transaction #396	2025-06-12	205.14	Auto-generated transaction entry #396	2025-06-15 08:46:39.472275
1397	2	11	Transaction #397	2025-05-24	333.01	Auto-generated transaction entry #397	2025-06-15 08:46:39.472275
1398	2	12	Transaction #398	2025-06-09	758.52	Auto-generated transaction entry #398	2025-06-15 08:46:39.472275
1399	2	12	Transaction #399	2025-06-02	536.76	Auto-generated transaction entry #399	2025-06-15 08:46:39.472275
1400	2	12	Transaction #400	2025-06-08	221.32	Auto-generated transaction entry #400	2025-06-15 08:46:39.472275
1401	2	10	Transaction #401	2025-06-14	845.17	Auto-generated transaction entry #401	2025-06-15 08:46:39.472275
1402	2	11	Transaction #402	2025-06-01	634.70	Auto-generated transaction entry #402	2025-06-15 08:46:39.472275
1403	2	12	Transaction #403	2025-05-21	355.60	Auto-generated transaction entry #403	2025-06-15 08:46:39.472275
1404	2	10	Transaction #404	2025-06-10	139.27	Auto-generated transaction entry #404	2025-06-15 08:46:39.472275
1405	2	10	Transaction #405	2025-05-28	895.15	Auto-generated transaction entry #405	2025-06-15 08:46:39.472275
1406	2	12	Transaction #406	2025-06-15	885.26	Auto-generated transaction entry #406	2025-06-15 08:46:39.472275
1407	2	12	Transaction #407	2025-05-23	675.56	Auto-generated transaction entry #407	2025-06-15 08:46:39.472275
1408	2	11	Transaction #408	2025-06-11	913.29	Auto-generated transaction entry #408	2025-06-15 08:46:39.472275
1409	2	11	Transaction #409	2025-05-26	550.90	Auto-generated transaction entry #409	2025-06-15 08:46:39.472275
1410	2	11	Transaction #410	2025-06-14	439.52	Auto-generated transaction entry #410	2025-06-15 08:46:39.472275
1411	2	10	Transaction #411	2025-05-18	937.65	Auto-generated transaction entry #411	2025-06-15 08:46:39.472275
1412	2	11	Transaction #412	2025-06-01	825.69	Auto-generated transaction entry #412	2025-06-15 08:46:39.472275
1413	2	10	Transaction #413	2025-06-09	340.08	Auto-generated transaction entry #413	2025-06-15 08:46:39.472275
1414	2	10	Transaction #414	2025-06-09	975.20	Auto-generated transaction entry #414	2025-06-15 08:46:39.472275
1415	2	10	Transaction #415	2025-06-02	124.26	Auto-generated transaction entry #415	2025-06-15 08:46:39.472275
1416	2	12	Transaction #416	2025-05-30	637.79	Auto-generated transaction entry #416	2025-06-15 08:46:39.472275
1417	2	10	Transaction #417	2025-05-27	747.95	Auto-generated transaction entry #417	2025-06-15 08:46:39.472275
1418	2	10	Transaction #418	2025-05-21	621.44	Auto-generated transaction entry #418	2025-06-15 08:46:39.472275
1419	2	11	Transaction #419	2025-06-06	94.59	Auto-generated transaction entry #419	2025-06-15 08:46:39.472275
1420	2	11	Transaction #420	2025-06-06	550.96	Auto-generated transaction entry #420	2025-06-15 08:46:39.472275
1421	2	11	Transaction #421	2025-06-08	971.22	Auto-generated transaction entry #421	2025-06-15 08:46:39.472275
1422	2	12	Transaction #422	2025-06-14	773.01	Auto-generated transaction entry #422	2025-06-15 08:46:39.472275
1423	2	11	Transaction #423	2025-05-16	370.89	Auto-generated transaction entry #423	2025-06-15 08:46:39.472275
1424	2	12	Transaction #424	2025-06-08	762.95	Auto-generated transaction entry #424	2025-06-15 08:46:39.472275
1425	2	12	Transaction #425	2025-06-03	309.73	Auto-generated transaction entry #425	2025-06-15 08:46:39.472275
1426	2	12	Transaction #426	2025-06-07	131.73	Auto-generated transaction entry #426	2025-06-15 08:46:39.472275
1427	2	11	Transaction #427	2025-06-06	656.25	Auto-generated transaction entry #427	2025-06-15 08:46:39.472275
1428	2	11	Transaction #428	2025-06-02	101.95	Auto-generated transaction entry #428	2025-06-15 08:46:39.472275
1429	2	10	Transaction #429	2025-05-18	677.68	Auto-generated transaction entry #429	2025-06-15 08:46:39.472275
1430	2	12	Transaction #430	2025-06-09	117.75	Auto-generated transaction entry #430	2025-06-15 08:46:39.472275
1431	2	12	Transaction #431	2025-05-21	410.42	Auto-generated transaction entry #431	2025-06-15 08:46:39.472275
1432	2	10	Transaction #432	2025-06-07	564.53	Auto-generated transaction entry #432	2025-06-15 08:46:39.472275
1433	2	11	Transaction #433	2025-06-15	619.79	Auto-generated transaction entry #433	2025-06-15 08:46:39.472275
1434	2	12	Transaction #434	2025-06-11	569.71	Auto-generated transaction entry #434	2025-06-15 08:46:39.472275
1435	2	12	Transaction #435	2025-05-20	135.07	Auto-generated transaction entry #435	2025-06-15 08:46:39.472275
1436	2	12	Transaction #436	2025-06-01	954.46	Auto-generated transaction entry #436	2025-06-15 08:46:39.472275
1437	2	10	Transaction #437	2025-05-27	624.45	Auto-generated transaction entry #437	2025-06-15 08:46:39.472275
1438	2	12	Transaction #438	2025-05-27	246.26	Auto-generated transaction entry #438	2025-06-15 08:46:39.472275
1439	2	11	Transaction #439	2025-06-03	968.71	Auto-generated transaction entry #439	2025-06-15 08:46:39.472275
1440	2	11	Transaction #440	2025-06-13	240.41	Auto-generated transaction entry #440	2025-06-15 08:46:39.472275
1441	2	11	Transaction #441	2025-05-21	254.51	Auto-generated transaction entry #441	2025-06-15 08:46:39.472275
1442	2	10	Transaction #442	2025-05-26	69.84	Auto-generated transaction entry #442	2025-06-15 08:46:39.472275
1443	2	10	Transaction #443	2025-05-18	588.23	Auto-generated transaction entry #443	2025-06-15 08:46:39.472275
1444	2	12	Transaction #444	2025-06-12	687.48	Auto-generated transaction entry #444	2025-06-15 08:46:39.472275
1445	2	12	Transaction #445	2025-06-05	727.55	Auto-generated transaction entry #445	2025-06-15 08:46:39.472275
1446	2	10	Transaction #446	2025-06-11	90.13	Auto-generated transaction entry #446	2025-06-15 08:46:39.472275
1447	2	12	Transaction #447	2025-05-30	934.14	Auto-generated transaction entry #447	2025-06-15 08:46:39.472275
1448	2	11	Transaction #448	2025-06-09	697.43	Auto-generated transaction entry #448	2025-06-15 08:46:39.472275
1449	2	11	Transaction #449	2025-06-11	568.30	Auto-generated transaction entry #449	2025-06-15 08:46:39.472275
1450	2	12	Transaction #450	2025-05-31	982.20	Auto-generated transaction entry #450	2025-06-15 08:46:39.472275
1451	2	12	Transaction #451	2025-05-23	225.37	Auto-generated transaction entry #451	2025-06-15 08:46:39.472275
1452	2	12	Transaction #452	2025-06-15	918.45	Auto-generated transaction entry #452	2025-06-15 08:46:39.472275
1453	2	11	Transaction #453	2025-06-06	182.06	Auto-generated transaction entry #453	2025-06-15 08:46:39.472275
1454	2	12	Transaction #454	2025-06-14	432.55	Auto-generated transaction entry #454	2025-06-15 08:46:39.472275
1455	2	12	Transaction #455	2025-06-13	796.28	Auto-generated transaction entry #455	2025-06-15 08:46:39.472275
1456	2	10	Transaction #456	2025-05-30	121.55	Auto-generated transaction entry #456	2025-06-15 08:46:39.472275
1457	2	12	Transaction #457	2025-06-01	284.87	Auto-generated transaction entry #457	2025-06-15 08:46:39.472275
1458	2	10	Transaction #458	2025-05-25	189.46	Auto-generated transaction entry #458	2025-06-15 08:46:39.472275
1459	2	11	Transaction #459	2025-06-04	369.49	Auto-generated transaction entry #459	2025-06-15 08:46:39.472275
1460	2	11	Transaction #460	2025-05-24	481.12	Auto-generated transaction entry #460	2025-06-15 08:46:39.472275
1461	2	11	Transaction #461	2025-06-01	825.74	Auto-generated transaction entry #461	2025-06-15 08:46:39.472275
1462	2	11	Transaction #462	2025-06-03	488.79	Auto-generated transaction entry #462	2025-06-15 08:46:39.472275
1463	2	10	Transaction #463	2025-05-22	883.19	Auto-generated transaction entry #463	2025-06-15 08:46:39.472275
1464	2	11	Transaction #464	2025-05-19	181.93	Auto-generated transaction entry #464	2025-06-15 08:46:39.472275
1465	2	12	Transaction #465	2025-06-03	409.78	Auto-generated transaction entry #465	2025-06-15 08:46:39.472275
1466	2	11	Transaction #466	2025-06-13	690.57	Auto-generated transaction entry #466	2025-06-15 08:46:39.472275
1467	2	10	Transaction #467	2025-05-25	499.54	Auto-generated transaction entry #467	2025-06-15 08:46:39.472275
1468	2	12	Transaction #468	2025-05-24	601.29	Auto-generated transaction entry #468	2025-06-15 08:46:39.472275
1469	2	11	Transaction #469	2025-06-08	894.30	Auto-generated transaction entry #469	2025-06-15 08:46:39.472275
1470	2	10	Transaction #470	2025-06-07	801.64	Auto-generated transaction entry #470	2025-06-15 08:46:39.472275
1471	2	11	Transaction #471	2025-05-23	307.95	Auto-generated transaction entry #471	2025-06-15 08:46:39.472275
1472	2	12	Transaction #472	2025-06-13	243.67	Auto-generated transaction entry #472	2025-06-15 08:46:39.472275
1473	2	11	Transaction #473	2025-05-20	560.33	Auto-generated transaction entry #473	2025-06-15 08:46:39.472275
1474	2	11	Transaction #474	2025-05-31	247.46	Auto-generated transaction entry #474	2025-06-15 08:46:39.472275
1475	2	11	Transaction #475	2025-05-30	554.94	Auto-generated transaction entry #475	2025-06-15 08:46:39.472275
1476	2	12	Transaction #476	2025-06-02	66.35	Auto-generated transaction entry #476	2025-06-15 08:46:39.472275
1477	2	11	Transaction #477	2025-06-07	890.77	Auto-generated transaction entry #477	2025-06-15 08:46:39.472275
1478	2	10	Transaction #478	2025-06-07	305.15	Auto-generated transaction entry #478	2025-06-15 08:46:39.472275
1479	2	12	Transaction #479	2025-05-26	587.53	Auto-generated transaction entry #479	2025-06-15 08:46:39.472275
1480	2	11	Transaction #480	2025-05-26	436.75	Auto-generated transaction entry #480	2025-06-15 08:46:39.472275
1481	2	12	Transaction #481	2025-05-21	698.15	Auto-generated transaction entry #481	2025-06-15 08:46:39.472275
1482	2	12	Transaction #482	2025-06-13	474.74	Auto-generated transaction entry #482	2025-06-15 08:46:39.472275
1483	2	11	Transaction #483	2025-06-08	787.99	Auto-generated transaction entry #483	2025-06-15 08:46:39.472275
1484	2	11	Transaction #484	2025-05-30	836.70	Auto-generated transaction entry #484	2025-06-15 08:46:39.472275
1485	2	11	Transaction #485	2025-05-24	698.04	Auto-generated transaction entry #485	2025-06-15 08:46:39.472275
1486	2	12	Transaction #486	2025-06-07	598.68	Auto-generated transaction entry #486	2025-06-15 08:46:39.472275
1487	2	12	Transaction #487	2025-05-31	596.77	Auto-generated transaction entry #487	2025-06-15 08:46:39.472275
1488	2	10	Transaction #488	2025-06-11	289.32	Auto-generated transaction entry #488	2025-06-15 08:46:39.472275
1489	2	12	Transaction #489	2025-05-31	573.19	Auto-generated transaction entry #489	2025-06-15 08:46:39.472275
1490	2	12	Transaction #490	2025-06-01	652.67	Auto-generated transaction entry #490	2025-06-15 08:46:39.472275
1491	2	11	Transaction #491	2025-06-14	99.85	Auto-generated transaction entry #491	2025-06-15 08:46:39.472275
1492	2	12	Transaction #492	2025-05-30	387.31	Auto-generated transaction entry #492	2025-06-15 08:46:39.472275
1493	2	12	Transaction #493	2025-05-26	911.77	Auto-generated transaction entry #493	2025-06-15 08:46:39.472275
1494	2	11	Transaction #494	2025-05-21	232.56	Auto-generated transaction entry #494	2025-06-15 08:46:39.472275
1495	2	10	Transaction #495	2025-06-02	735.54	Auto-generated transaction entry #495	2025-06-15 08:46:39.472275
1496	2	11	Transaction #496	2025-06-11	242.44	Auto-generated transaction entry #496	2025-06-15 08:46:39.472275
1497	2	10	Transaction #497	2025-05-21	680.74	Auto-generated transaction entry #497	2025-06-15 08:46:39.472275
1498	2	10	Transaction #498	2025-06-04	150.52	Auto-generated transaction entry #498	2025-06-15 08:46:39.472275
1499	2	10	Transaction #499	2025-06-12	66.07	Auto-generated transaction entry #499	2025-06-15 08:46:39.472275
1500	2	12	Transaction #500	2025-05-17	960.07	Auto-generated transaction entry #500	2025-06-15 08:46:39.472275
1501	2	19	Transaction #1	2025-06-08	948.39	Auto-generated transaction entry #1	2025-06-15 08:46:52.126538
1502	2	18	Transaction #2	2025-05-28	787.73	Auto-generated transaction entry #2	2025-06-15 08:46:52.126538
1503	2	17	Transaction #3	2025-06-01	202.88	Auto-generated transaction entry #3	2025-06-15 08:46:52.126538
1504	2	16	Transaction #4	2025-06-03	441.13	Auto-generated transaction entry #4	2025-06-15 08:46:52.126538
1505	2	13	Transaction #5	2025-06-14	401.84	Auto-generated transaction entry #5	2025-06-15 08:46:52.126538
1506	2	19	Transaction #6	2025-05-30	715.87	Auto-generated transaction entry #6	2025-06-15 08:46:52.126538
1507	2	16	Transaction #7	2025-06-02	662.73	Auto-generated transaction entry #7	2025-06-15 08:46:52.126538
1508	2	20	Transaction #8	2025-06-07	133.27	Auto-generated transaction entry #8	2025-06-15 08:46:52.126538
1509	2	14	Transaction #9	2025-06-02	149.12	Auto-generated transaction entry #9	2025-06-15 08:46:52.126538
1510	2	15	Transaction #10	2025-06-04	601.52	Auto-generated transaction entry #10	2025-06-15 08:46:52.126538
1511	2	14	Transaction #11	2025-06-06	140.68	Auto-generated transaction entry #11	2025-06-15 08:46:52.126538
1512	2	18	Transaction #12	2025-06-14	587.53	Auto-generated transaction entry #12	2025-06-15 08:46:52.126538
1513	2	19	Transaction #13	2025-05-31	820.38	Auto-generated transaction entry #13	2025-06-15 08:46:52.126538
1514	2	16	Transaction #14	2025-06-11	708.39	Auto-generated transaction entry #14	2025-06-15 08:46:52.126538
1515	2	14	Transaction #15	2025-06-10	944.71	Auto-generated transaction entry #15	2025-06-15 08:46:52.126538
1516	2	16	Transaction #16	2025-06-03	121.96	Auto-generated transaction entry #16	2025-06-15 08:46:52.126538
1517	2	17	Transaction #17	2025-05-29	921.20	Auto-generated transaction entry #17	2025-06-15 08:46:52.126538
1518	2	17	Transaction #18	2025-06-06	451.66	Auto-generated transaction entry #18	2025-06-15 08:46:52.126538
1519	2	13	Transaction #19	2025-06-09	435.16	Auto-generated transaction entry #19	2025-06-15 08:46:52.126538
1520	2	13	Transaction #20	2025-06-11	87.65	Auto-generated transaction entry #20	2025-06-15 08:46:52.126538
1521	2	14	Transaction #21	2025-06-14	224.51	Auto-generated transaction entry #21	2025-06-15 08:46:52.126538
1522	2	16	Transaction #22	2025-06-04	190.32	Auto-generated transaction entry #22	2025-06-15 08:46:52.126538
1523	2	20	Transaction #23	2025-05-23	218.67	Auto-generated transaction entry #23	2025-06-15 08:46:52.126538
1524	2	15	Transaction #24	2025-05-21	956.47	Auto-generated transaction entry #24	2025-06-15 08:46:52.126538
1525	2	16	Transaction #25	2025-05-27	852.64	Auto-generated transaction entry #25	2025-06-15 08:46:52.126538
1526	2	19	Transaction #26	2025-06-01	553.46	Auto-generated transaction entry #26	2025-06-15 08:46:52.126538
1527	2	18	Transaction #27	2025-06-06	917.26	Auto-generated transaction entry #27	2025-06-15 08:46:52.126538
1528	2	16	Transaction #28	2025-06-03	143.50	Auto-generated transaction entry #28	2025-06-15 08:46:52.126538
1529	2	18	Transaction #29	2025-05-22	163.85	Auto-generated transaction entry #29	2025-06-15 08:46:52.126538
1530	2	16	Transaction #30	2025-05-28	68.64	Auto-generated transaction entry #30	2025-06-15 08:46:52.126538
1531	2	20	Transaction #31	2025-05-28	687.72	Auto-generated transaction entry #31	2025-06-15 08:46:52.126538
1532	2	16	Transaction #32	2025-05-16	191.27	Auto-generated transaction entry #32	2025-06-15 08:46:52.126538
1533	2	18	Transaction #33	2025-05-18	597.99	Auto-generated transaction entry #33	2025-06-15 08:46:52.126538
1534	2	14	Transaction #34	2025-05-24	867.68	Auto-generated transaction entry #34	2025-06-15 08:46:52.126538
1535	2	19	Transaction #35	2025-06-03	930.50	Auto-generated transaction entry #35	2025-06-15 08:46:52.126538
1536	2	17	Transaction #36	2025-05-20	701.43	Auto-generated transaction entry #36	2025-06-15 08:46:52.126538
1537	2	18	Transaction #37	2025-05-31	145.82	Auto-generated transaction entry #37	2025-06-15 08:46:52.126538
1538	2	19	Transaction #38	2025-06-09	206.37	Auto-generated transaction entry #38	2025-06-15 08:46:52.126538
1539	2	13	Transaction #39	2025-06-01	950.78	Auto-generated transaction entry #39	2025-06-15 08:46:52.126538
1540	2	13	Transaction #40	2025-05-29	284.75	Auto-generated transaction entry #40	2025-06-15 08:46:52.126538
1541	2	16	Transaction #41	2025-06-11	109.48	Auto-generated transaction entry #41	2025-06-15 08:46:52.126538
1542	2	16	Transaction #42	2025-05-31	848.40	Auto-generated transaction entry #42	2025-06-15 08:46:52.126538
1543	2	16	Transaction #43	2025-06-03	465.27	Auto-generated transaction entry #43	2025-06-15 08:46:52.126538
1544	2	14	Transaction #44	2025-05-19	362.30	Auto-generated transaction entry #44	2025-06-15 08:46:52.126538
1545	2	14	Transaction #45	2025-05-20	448.13	Auto-generated transaction entry #45	2025-06-15 08:46:52.126538
1546	2	17	Transaction #46	2025-05-18	633.00	Auto-generated transaction entry #46	2025-06-15 08:46:52.126538
1547	2	13	Transaction #47	2025-06-12	676.12	Auto-generated transaction entry #47	2025-06-15 08:46:52.126538
1548	2	18	Transaction #48	2025-06-10	178.69	Auto-generated transaction entry #48	2025-06-15 08:46:52.126538
1549	2	16	Transaction #49	2025-05-30	705.51	Auto-generated transaction entry #49	2025-06-15 08:46:52.126538
1550	2	17	Transaction #50	2025-05-27	525.65	Auto-generated transaction entry #50	2025-06-15 08:46:52.126538
1551	2	18	Transaction #51	2025-06-02	583.12	Auto-generated transaction entry #51	2025-06-15 08:46:52.126538
1552	2	19	Transaction #52	2025-05-22	248.27	Auto-generated transaction entry #52	2025-06-15 08:46:52.126538
1553	2	16	Transaction #53	2025-06-10	998.81	Auto-generated transaction entry #53	2025-06-15 08:46:52.126538
1554	2	20	Transaction #54	2025-06-11	389.63	Auto-generated transaction entry #54	2025-06-15 08:46:52.126538
1555	2	16	Transaction #55	2025-06-08	469.95	Auto-generated transaction entry #55	2025-06-15 08:46:52.126538
1556	2	19	Transaction #56	2025-05-20	795.95	Auto-generated transaction entry #56	2025-06-15 08:46:52.126538
1557	2	13	Transaction #57	2025-05-26	905.87	Auto-generated transaction entry #57	2025-06-15 08:46:52.126538
1558	2	15	Transaction #58	2025-05-17	130.70	Auto-generated transaction entry #58	2025-06-15 08:46:52.126538
1559	2	14	Transaction #59	2025-06-15	819.72	Auto-generated transaction entry #59	2025-06-15 08:46:52.126538
1560	2	19	Transaction #60	2025-05-29	859.69	Auto-generated transaction entry #60	2025-06-15 08:46:52.126538
1561	2	13	Transaction #61	2025-05-24	564.77	Auto-generated transaction entry #61	2025-06-15 08:46:52.126538
1562	2	20	Transaction #62	2025-05-22	263.45	Auto-generated transaction entry #62	2025-06-15 08:46:52.126538
1563	2	13	Transaction #63	2025-05-20	193.02	Auto-generated transaction entry #63	2025-06-15 08:46:52.126538
1564	2	19	Transaction #64	2025-05-22	581.47	Auto-generated transaction entry #64	2025-06-15 08:46:52.126538
1565	2	19	Transaction #65	2025-06-03	497.31	Auto-generated transaction entry #65	2025-06-15 08:46:52.126538
1566	2	17	Transaction #66	2025-05-31	515.73	Auto-generated transaction entry #66	2025-06-15 08:46:52.126538
1567	2	17	Transaction #67	2025-05-24	453.59	Auto-generated transaction entry #67	2025-06-15 08:46:52.126538
1568	2	19	Transaction #68	2025-06-08	730.01	Auto-generated transaction entry #68	2025-06-15 08:46:52.126538
1569	2	20	Transaction #69	2025-06-09	925.38	Auto-generated transaction entry #69	2025-06-15 08:46:52.126538
1570	2	19	Transaction #70	2025-05-22	535.38	Auto-generated transaction entry #70	2025-06-15 08:46:52.126538
1571	2	17	Transaction #71	2025-06-08	687.77	Auto-generated transaction entry #71	2025-06-15 08:46:52.126538
1572	2	17	Transaction #72	2025-06-11	545.80	Auto-generated transaction entry #72	2025-06-15 08:46:52.126538
1573	2	20	Transaction #73	2025-06-15	298.40	Auto-generated transaction entry #73	2025-06-15 08:46:52.126538
1574	2	13	Transaction #74	2025-06-08	495.96	Auto-generated transaction entry #74	2025-06-15 08:46:52.126538
1575	2	14	Transaction #75	2025-06-03	157.20	Auto-generated transaction entry #75	2025-06-15 08:46:52.126538
1576	2	14	Transaction #76	2025-06-05	192.98	Auto-generated transaction entry #76	2025-06-15 08:46:52.126538
1577	2	15	Transaction #77	2025-06-11	213.92	Auto-generated transaction entry #77	2025-06-15 08:46:52.126538
1578	2	15	Transaction #78	2025-06-13	278.97	Auto-generated transaction entry #78	2025-06-15 08:46:52.126538
1579	2	13	Transaction #79	2025-06-03	782.48	Auto-generated transaction entry #79	2025-06-15 08:46:52.126538
1580	2	20	Transaction #80	2025-05-17	119.04	Auto-generated transaction entry #80	2025-06-15 08:46:52.126538
1581	2	16	Transaction #81	2025-05-26	316.61	Auto-generated transaction entry #81	2025-06-15 08:46:52.126538
1582	2	16	Transaction #82	2025-05-18	388.47	Auto-generated transaction entry #82	2025-06-15 08:46:52.126538
1583	2	13	Transaction #83	2025-05-23	519.99	Auto-generated transaction entry #83	2025-06-15 08:46:52.126538
1584	2	18	Transaction #84	2025-05-19	239.27	Auto-generated transaction entry #84	2025-06-15 08:46:52.126538
1585	2	19	Transaction #85	2025-05-25	91.82	Auto-generated transaction entry #85	2025-06-15 08:46:52.126538
1586	2	16	Transaction #86	2025-06-02	260.16	Auto-generated transaction entry #86	2025-06-15 08:46:52.126538
1587	2	17	Transaction #87	2025-06-14	326.16	Auto-generated transaction entry #87	2025-06-15 08:46:52.126538
1588	2	15	Transaction #88	2025-05-26	334.22	Auto-generated transaction entry #88	2025-06-15 08:46:52.126538
1589	2	16	Transaction #89	2025-06-14	848.62	Auto-generated transaction entry #89	2025-06-15 08:46:52.126538
1590	2	15	Transaction #90	2025-06-02	551.59	Auto-generated transaction entry #90	2025-06-15 08:46:52.126538
1591	2	18	Transaction #91	2025-06-12	718.60	Auto-generated transaction entry #91	2025-06-15 08:46:52.126538
1592	2	20	Transaction #92	2025-06-11	937.35	Auto-generated transaction entry #92	2025-06-15 08:46:52.126538
1593	2	13	Transaction #93	2025-05-17	656.18	Auto-generated transaction entry #93	2025-06-15 08:46:52.126538
1594	2	13	Transaction #94	2025-06-09	477.14	Auto-generated transaction entry #94	2025-06-15 08:46:52.126538
1595	2	19	Transaction #95	2025-06-09	483.88	Auto-generated transaction entry #95	2025-06-15 08:46:52.126538
1596	2	17	Transaction #96	2025-05-20	487.37	Auto-generated transaction entry #96	2025-06-15 08:46:52.126538
1597	2	20	Transaction #97	2025-05-23	59.26	Auto-generated transaction entry #97	2025-06-15 08:46:52.126538
1598	2	20	Transaction #98	2025-06-13	149.27	Auto-generated transaction entry #98	2025-06-15 08:46:52.126538
1599	2	20	Transaction #99	2025-06-13	568.54	Auto-generated transaction entry #99	2025-06-15 08:46:52.126538
1600	2	13	Transaction #100	2025-06-07	638.19	Auto-generated transaction entry #100	2025-06-15 08:46:52.126538
1601	2	16	Transaction #101	2025-05-18	82.73	Auto-generated transaction entry #101	2025-06-15 08:46:52.126538
1602	2	14	Transaction #102	2025-06-11	180.74	Auto-generated transaction entry #102	2025-06-15 08:46:52.126538
1603	2	20	Transaction #103	2025-06-09	451.04	Auto-generated transaction entry #103	2025-06-15 08:46:52.126538
1604	2	16	Transaction #104	2025-05-29	183.36	Auto-generated transaction entry #104	2025-06-15 08:46:52.126538
1605	2	19	Transaction #105	2025-05-28	942.34	Auto-generated transaction entry #105	2025-06-15 08:46:52.126538
1606	2	20	Transaction #106	2025-05-21	727.66	Auto-generated transaction entry #106	2025-06-15 08:46:52.126538
1607	2	19	Transaction #107	2025-06-01	59.63	Auto-generated transaction entry #107	2025-06-15 08:46:52.126538
1608	2	17	Transaction #108	2025-06-11	973.98	Auto-generated transaction entry #108	2025-06-15 08:46:52.126538
1609	2	17	Transaction #109	2025-05-28	379.63	Auto-generated transaction entry #109	2025-06-15 08:46:52.126538
1610	2	14	Transaction #110	2025-05-20	227.93	Auto-generated transaction entry #110	2025-06-15 08:46:52.126538
1611	2	13	Transaction #111	2025-06-05	502.79	Auto-generated transaction entry #111	2025-06-15 08:46:52.126538
1612	2	13	Transaction #112	2025-06-03	671.49	Auto-generated transaction entry #112	2025-06-15 08:46:52.126538
1613	2	19	Transaction #113	2025-05-30	662.39	Auto-generated transaction entry #113	2025-06-15 08:46:52.126538
1614	2	20	Transaction #114	2025-06-05	538.87	Auto-generated transaction entry #114	2025-06-15 08:46:52.126538
1615	2	20	Transaction #115	2025-05-17	856.34	Auto-generated transaction entry #115	2025-06-15 08:46:52.126538
1616	2	18	Transaction #116	2025-06-12	68.19	Auto-generated transaction entry #116	2025-06-15 08:46:52.126538
1617	2	15	Transaction #117	2025-06-06	664.83	Auto-generated transaction entry #117	2025-06-15 08:46:52.126538
1618	2	19	Transaction #118	2025-05-18	645.44	Auto-generated transaction entry #118	2025-06-15 08:46:52.126538
1619	2	14	Transaction #119	2025-05-27	485.46	Auto-generated transaction entry #119	2025-06-15 08:46:52.126538
1620	2	14	Transaction #120	2025-05-18	188.25	Auto-generated transaction entry #120	2025-06-15 08:46:52.126538
1621	2	14	Transaction #121	2025-05-17	693.73	Auto-generated transaction entry #121	2025-06-15 08:46:52.126538
1622	2	15	Transaction #122	2025-05-31	331.53	Auto-generated transaction entry #122	2025-06-15 08:46:52.126538
1623	2	16	Transaction #123	2025-06-11	621.43	Auto-generated transaction entry #123	2025-06-15 08:46:52.126538
1624	2	17	Transaction #124	2025-05-31	842.10	Auto-generated transaction entry #124	2025-06-15 08:46:52.126538
1625	2	18	Transaction #125	2025-06-09	378.58	Auto-generated transaction entry #125	2025-06-15 08:46:52.126538
1626	2	16	Transaction #126	2025-05-21	184.29	Auto-generated transaction entry #126	2025-06-15 08:46:52.126538
1627	2	16	Transaction #127	2025-06-08	837.97	Auto-generated transaction entry #127	2025-06-15 08:46:52.126538
1628	2	15	Transaction #128	2025-06-01	397.51	Auto-generated transaction entry #128	2025-06-15 08:46:52.126538
1629	2	18	Transaction #129	2025-05-26	956.91	Auto-generated transaction entry #129	2025-06-15 08:46:52.126538
1630	2	16	Transaction #130	2025-05-20	853.16	Auto-generated transaction entry #130	2025-06-15 08:46:52.126538
1631	2	17	Transaction #131	2025-06-14	831.86	Auto-generated transaction entry #131	2025-06-15 08:46:52.126538
1632	2	17	Transaction #132	2025-05-27	298.53	Auto-generated transaction entry #132	2025-06-15 08:46:52.126538
1633	2	15	Transaction #133	2025-06-10	913.04	Auto-generated transaction entry #133	2025-06-15 08:46:52.126538
1634	2	13	Transaction #134	2025-05-22	131.08	Auto-generated transaction entry #134	2025-06-15 08:46:52.126538
1635	2	17	Transaction #135	2025-05-24	822.79	Auto-generated transaction entry #135	2025-06-15 08:46:52.126538
1636	2	17	Transaction #136	2025-06-01	811.73	Auto-generated transaction entry #136	2025-06-15 08:46:52.126538
1637	2	14	Transaction #137	2025-05-30	931.89	Auto-generated transaction entry #137	2025-06-15 08:46:52.126538
1638	2	18	Transaction #138	2025-06-01	611.34	Auto-generated transaction entry #138	2025-06-15 08:46:52.126538
1639	2	17	Transaction #139	2025-06-04	419.97	Auto-generated transaction entry #139	2025-06-15 08:46:52.126538
1640	2	19	Transaction #140	2025-05-31	131.24	Auto-generated transaction entry #140	2025-06-15 08:46:52.126538
1641	2	16	Transaction #141	2025-05-17	633.26	Auto-generated transaction entry #141	2025-06-15 08:46:52.126538
1642	2	18	Transaction #142	2025-05-21	333.70	Auto-generated transaction entry #142	2025-06-15 08:46:52.126538
1643	2	19	Transaction #143	2025-05-20	202.46	Auto-generated transaction entry #143	2025-06-15 08:46:52.126538
1644	2	14	Transaction #144	2025-05-19	834.72	Auto-generated transaction entry #144	2025-06-15 08:46:52.126538
1645	2	19	Transaction #145	2025-06-12	249.87	Auto-generated transaction entry #145	2025-06-15 08:46:52.126538
1646	2	18	Transaction #146	2025-06-14	562.48	Auto-generated transaction entry #146	2025-06-15 08:46:52.126538
1647	2	14	Transaction #147	2025-06-12	476.30	Auto-generated transaction entry #147	2025-06-15 08:46:52.126538
1648	2	14	Transaction #148	2025-06-07	738.81	Auto-generated transaction entry #148	2025-06-15 08:46:52.126538
1649	2	16	Transaction #149	2025-06-04	215.27	Auto-generated transaction entry #149	2025-06-15 08:46:52.126538
1650	2	16	Transaction #150	2025-06-01	806.46	Auto-generated transaction entry #150	2025-06-15 08:46:52.126538
1651	2	14	Transaction #151	2025-06-14	930.89	Auto-generated transaction entry #151	2025-06-15 08:46:52.126538
1652	2	15	Transaction #152	2025-06-05	484.09	Auto-generated transaction entry #152	2025-06-15 08:46:52.126538
1653	2	13	Transaction #153	2025-05-21	426.37	Auto-generated transaction entry #153	2025-06-15 08:46:52.126538
1654	2	20	Transaction #154	2025-05-25	655.62	Auto-generated transaction entry #154	2025-06-15 08:46:52.126538
1655	2	18	Transaction #155	2025-06-14	345.96	Auto-generated transaction entry #155	2025-06-15 08:46:52.126538
1656	2	13	Transaction #156	2025-06-03	708.56	Auto-generated transaction entry #156	2025-06-15 08:46:52.126538
1657	2	15	Transaction #157	2025-05-25	399.18	Auto-generated transaction entry #157	2025-06-15 08:46:52.126538
1658	2	18	Transaction #158	2025-06-09	437.50	Auto-generated transaction entry #158	2025-06-15 08:46:52.126538
1659	2	14	Transaction #159	2025-05-28	816.91	Auto-generated transaction entry #159	2025-06-15 08:46:52.126538
1660	2	18	Transaction #160	2025-05-17	519.54	Auto-generated transaction entry #160	2025-06-15 08:46:52.126538
1661	2	20	Transaction #161	2025-05-26	579.78	Auto-generated transaction entry #161	2025-06-15 08:46:52.126538
1662	2	14	Transaction #162	2025-05-30	956.37	Auto-generated transaction entry #162	2025-06-15 08:46:52.126538
1663	2	17	Transaction #163	2025-05-24	913.08	Auto-generated transaction entry #163	2025-06-15 08:46:52.126538
1664	2	14	Transaction #164	2025-06-01	61.65	Auto-generated transaction entry #164	2025-06-15 08:46:52.126538
1665	2	15	Transaction #165	2025-05-20	864.63	Auto-generated transaction entry #165	2025-06-15 08:46:52.126538
1666	2	13	Transaction #166	2025-05-31	298.98	Auto-generated transaction entry #166	2025-06-15 08:46:52.126538
1667	2	19	Transaction #167	2025-05-18	547.32	Auto-generated transaction entry #167	2025-06-15 08:46:52.126538
1668	2	18	Transaction #168	2025-06-07	604.84	Auto-generated transaction entry #168	2025-06-15 08:46:52.126538
1669	2	17	Transaction #169	2025-06-15	655.07	Auto-generated transaction entry #169	2025-06-15 08:46:52.126538
1670	2	20	Transaction #170	2025-06-02	789.54	Auto-generated transaction entry #170	2025-06-15 08:46:52.126538
1671	2	15	Transaction #171	2025-06-15	90.10	Auto-generated transaction entry #171	2025-06-15 08:46:52.126538
1672	2	18	Transaction #172	2025-05-19	657.41	Auto-generated transaction entry #172	2025-06-15 08:46:52.126538
1673	2	16	Transaction #173	2025-06-15	401.10	Auto-generated transaction entry #173	2025-06-15 08:46:52.126538
1674	2	13	Transaction #174	2025-06-04	604.55	Auto-generated transaction entry #174	2025-06-15 08:46:52.126538
1675	2	17	Transaction #175	2025-05-18	245.63	Auto-generated transaction entry #175	2025-06-15 08:46:52.126538
1676	2	15	Transaction #176	2025-06-04	304.08	Auto-generated transaction entry #176	2025-06-15 08:46:52.126538
1677	2	19	Transaction #177	2025-06-11	517.64	Auto-generated transaction entry #177	2025-06-15 08:46:52.126538
1678	2	19	Transaction #178	2025-05-30	932.85	Auto-generated transaction entry #178	2025-06-15 08:46:52.126538
1679	2	15	Transaction #179	2025-06-13	139.98	Auto-generated transaction entry #179	2025-06-15 08:46:52.126538
1680	2	17	Transaction #180	2025-06-12	640.40	Auto-generated transaction entry #180	2025-06-15 08:46:52.126538
1681	2	18	Transaction #181	2025-05-28	313.29	Auto-generated transaction entry #181	2025-06-15 08:46:52.126538
1682	2	14	Transaction #182	2025-05-27	229.05	Auto-generated transaction entry #182	2025-06-15 08:46:52.126538
1683	2	20	Transaction #183	2025-06-06	141.02	Auto-generated transaction entry #183	2025-06-15 08:46:52.126538
1684	2	17	Transaction #184	2025-06-07	169.56	Auto-generated transaction entry #184	2025-06-15 08:46:52.126538
1685	2	13	Transaction #185	2025-05-23	786.68	Auto-generated transaction entry #185	2025-06-15 08:46:52.126538
1686	2	17	Transaction #186	2025-06-12	294.41	Auto-generated transaction entry #186	2025-06-15 08:46:52.126538
1687	2	18	Transaction #187	2025-06-06	373.35	Auto-generated transaction entry #187	2025-06-15 08:46:52.126538
1688	2	15	Transaction #188	2025-05-26	861.19	Auto-generated transaction entry #188	2025-06-15 08:46:52.126538
1689	2	17	Transaction #189	2025-05-20	870.95	Auto-generated transaction entry #189	2025-06-15 08:46:52.126538
1690	2	17	Transaction #190	2025-06-02	63.15	Auto-generated transaction entry #190	2025-06-15 08:46:52.126538
1691	2	18	Transaction #191	2025-05-23	873.54	Auto-generated transaction entry #191	2025-06-15 08:46:52.126538
1692	2	20	Transaction #192	2025-06-06	668.98	Auto-generated transaction entry #192	2025-06-15 08:46:52.126538
1693	2	13	Transaction #193	2025-06-15	311.85	Auto-generated transaction entry #193	2025-06-15 08:46:52.126538
1694	2	20	Transaction #194	2025-05-28	801.11	Auto-generated transaction entry #194	2025-06-15 08:46:52.126538
1695	2	20	Transaction #195	2025-05-31	388.14	Auto-generated transaction entry #195	2025-06-15 08:46:52.126538
1696	2	17	Transaction #196	2025-05-27	388.87	Auto-generated transaction entry #196	2025-06-15 08:46:52.126538
1697	2	17	Transaction #197	2025-05-17	91.72	Auto-generated transaction entry #197	2025-06-15 08:46:52.126538
1698	2	20	Transaction #198	2025-05-18	658.88	Auto-generated transaction entry #198	2025-06-15 08:46:52.126538
1699	2	14	Transaction #199	2025-06-14	66.85	Auto-generated transaction entry #199	2025-06-15 08:46:52.126538
1700	2	16	Transaction #200	2025-06-14	294.00	Auto-generated transaction entry #200	2025-06-15 08:46:52.126538
1701	2	13	Transaction #201	2025-05-25	98.15	Auto-generated transaction entry #201	2025-06-15 08:46:52.126538
1702	2	15	Transaction #202	2025-05-31	611.80	Auto-generated transaction entry #202	2025-06-15 08:46:52.126538
1703	2	15	Transaction #203	2025-06-15	613.48	Auto-generated transaction entry #203	2025-06-15 08:46:52.126538
1704	2	15	Transaction #204	2025-06-06	218.94	Auto-generated transaction entry #204	2025-06-15 08:46:52.126538
1705	2	16	Transaction #205	2025-05-30	959.93	Auto-generated transaction entry #205	2025-06-15 08:46:52.126538
1706	2	18	Transaction #206	2025-05-30	215.96	Auto-generated transaction entry #206	2025-06-15 08:46:52.126538
1707	2	20	Transaction #207	2025-05-27	731.74	Auto-generated transaction entry #207	2025-06-15 08:46:52.126538
1708	2	16	Transaction #208	2025-05-20	143.97	Auto-generated transaction entry #208	2025-06-15 08:46:52.126538
1709	2	18	Transaction #209	2025-06-12	199.87	Auto-generated transaction entry #209	2025-06-15 08:46:52.126538
1710	2	16	Transaction #210	2025-06-07	382.50	Auto-generated transaction entry #210	2025-06-15 08:46:52.126538
1711	2	19	Transaction #211	2025-05-28	352.20	Auto-generated transaction entry #211	2025-06-15 08:46:52.126538
1712	2	15	Transaction #212	2025-05-21	237.87	Auto-generated transaction entry #212	2025-06-15 08:46:52.126538
1713	2	20	Transaction #213	2025-06-12	61.22	Auto-generated transaction entry #213	2025-06-15 08:46:52.126538
1714	2	15	Transaction #214	2025-06-07	60.85	Auto-generated transaction entry #214	2025-06-15 08:46:52.126538
1715	2	18	Transaction #215	2025-05-22	883.80	Auto-generated transaction entry #215	2025-06-15 08:46:52.126538
1716	2	17	Transaction #216	2025-06-02	127.84	Auto-generated transaction entry #216	2025-06-15 08:46:52.126538
1717	2	18	Transaction #217	2025-05-28	256.53	Auto-generated transaction entry #217	2025-06-15 08:46:52.126538
1718	2	16	Transaction #218	2025-05-31	364.68	Auto-generated transaction entry #218	2025-06-15 08:46:52.126538
1719	2	15	Transaction #219	2025-06-10	420.32	Auto-generated transaction entry #219	2025-06-15 08:46:52.126538
1720	2	17	Transaction #220	2025-05-20	845.18	Auto-generated transaction entry #220	2025-06-15 08:46:52.126538
1721	2	13	Transaction #221	2025-05-30	55.93	Auto-generated transaction entry #221	2025-06-15 08:46:52.126538
1722	2	13	Transaction #222	2025-05-17	655.01	Auto-generated transaction entry #222	2025-06-15 08:46:52.126538
1723	2	13	Transaction #223	2025-05-27	994.89	Auto-generated transaction entry #223	2025-06-15 08:46:52.126538
1724	2	17	Transaction #224	2025-06-07	363.40	Auto-generated transaction entry #224	2025-06-15 08:46:52.126538
1725	2	16	Transaction #225	2025-06-13	191.88	Auto-generated transaction entry #225	2025-06-15 08:46:52.126538
1726	2	17	Transaction #226	2025-05-31	763.80	Auto-generated transaction entry #226	2025-06-15 08:46:52.126538
1727	2	14	Transaction #227	2025-06-12	354.28	Auto-generated transaction entry #227	2025-06-15 08:46:52.126538
1728	2	19	Transaction #228	2025-06-10	240.09	Auto-generated transaction entry #228	2025-06-15 08:46:52.126538
1729	2	13	Transaction #229	2025-06-10	850.75	Auto-generated transaction entry #229	2025-06-15 08:46:52.126538
1730	2	14	Transaction #230	2025-05-23	859.05	Auto-generated transaction entry #230	2025-06-15 08:46:52.126538
1731	2	18	Transaction #231	2025-05-24	416.07	Auto-generated transaction entry #231	2025-06-15 08:46:52.126538
1732	2	19	Transaction #232	2025-06-12	443.46	Auto-generated transaction entry #232	2025-06-15 08:46:52.126538
1733	2	14	Transaction #233	2025-05-16	584.62	Auto-generated transaction entry #233	2025-06-15 08:46:52.126538
1734	2	16	Transaction #234	2025-05-29	975.67	Auto-generated transaction entry #234	2025-06-15 08:46:52.126538
1735	2	17	Transaction #235	2025-05-23	828.93	Auto-generated transaction entry #235	2025-06-15 08:46:52.126538
1736	2	14	Transaction #236	2025-06-03	916.76	Auto-generated transaction entry #236	2025-06-15 08:46:52.126538
1737	2	13	Transaction #237	2025-05-25	909.69	Auto-generated transaction entry #237	2025-06-15 08:46:52.126538
1738	2	17	Transaction #238	2025-06-02	542.49	Auto-generated transaction entry #238	2025-06-15 08:46:52.126538
1739	2	13	Transaction #239	2025-06-10	81.68	Auto-generated transaction entry #239	2025-06-15 08:46:52.126538
1740	2	19	Transaction #240	2025-05-28	290.29	Auto-generated transaction entry #240	2025-06-15 08:46:52.126538
1741	2	15	Transaction #241	2025-05-22	769.49	Auto-generated transaction entry #241	2025-06-15 08:46:52.126538
1742	2	16	Transaction #242	2025-06-14	672.95	Auto-generated transaction entry #242	2025-06-15 08:46:52.126538
1743	2	20	Transaction #243	2025-05-28	401.67	Auto-generated transaction entry #243	2025-06-15 08:46:52.126538
1744	2	16	Transaction #244	2025-06-06	986.68	Auto-generated transaction entry #244	2025-06-15 08:46:52.126538
1745	2	19	Transaction #245	2025-05-25	593.17	Auto-generated transaction entry #245	2025-06-15 08:46:52.126538
1746	2	17	Transaction #246	2025-05-30	653.41	Auto-generated transaction entry #246	2025-06-15 08:46:52.126538
1747	2	17	Transaction #247	2025-06-03	463.19	Auto-generated transaction entry #247	2025-06-15 08:46:52.126538
1748	2	14	Transaction #248	2025-06-09	493.16	Auto-generated transaction entry #248	2025-06-15 08:46:52.126538
1749	2	14	Transaction #249	2025-05-27	963.86	Auto-generated transaction entry #249	2025-06-15 08:46:52.126538
1750	2	19	Transaction #250	2025-06-06	380.23	Auto-generated transaction entry #250	2025-06-15 08:46:52.126538
1751	2	14	Transaction #251	2025-05-29	145.89	Auto-generated transaction entry #251	2025-06-15 08:46:52.126538
1752	2	19	Transaction #252	2025-06-04	586.44	Auto-generated transaction entry #252	2025-06-15 08:46:52.126538
1753	2	15	Transaction #253	2025-05-19	904.09	Auto-generated transaction entry #253	2025-06-15 08:46:52.126538
1754	2	19	Transaction #254	2025-05-28	357.06	Auto-generated transaction entry #254	2025-06-15 08:46:52.126538
1755	2	16	Transaction #255	2025-05-25	815.34	Auto-generated transaction entry #255	2025-06-15 08:46:52.126538
1756	2	19	Transaction #256	2025-05-25	774.74	Auto-generated transaction entry #256	2025-06-15 08:46:52.126538
1757	2	13	Transaction #257	2025-06-06	561.92	Auto-generated transaction entry #257	2025-06-15 08:46:52.126538
1758	2	19	Transaction #258	2025-05-31	628.95	Auto-generated transaction entry #258	2025-06-15 08:46:52.126538
1759	2	13	Transaction #259	2025-05-29	484.62	Auto-generated transaction entry #259	2025-06-15 08:46:52.126538
1760	2	15	Transaction #260	2025-05-25	834.10	Auto-generated transaction entry #260	2025-06-15 08:46:52.126538
1761	2	15	Transaction #261	2025-05-23	774.44	Auto-generated transaction entry #261	2025-06-15 08:46:52.126538
1762	2	15	Transaction #262	2025-05-27	990.61	Auto-generated transaction entry #262	2025-06-15 08:46:52.126538
1763	2	15	Transaction #263	2025-05-19	137.18	Auto-generated transaction entry #263	2025-06-15 08:46:52.126538
1764	2	15	Transaction #264	2025-06-02	115.83	Auto-generated transaction entry #264	2025-06-15 08:46:52.126538
1765	2	17	Transaction #265	2025-05-29	951.19	Auto-generated transaction entry #265	2025-06-15 08:46:52.126538
1766	2	13	Transaction #266	2025-06-08	274.62	Auto-generated transaction entry #266	2025-06-15 08:46:52.126538
1767	2	19	Transaction #267	2025-05-24	906.21	Auto-generated transaction entry #267	2025-06-15 08:46:52.126538
1768	2	20	Transaction #268	2025-05-17	118.01	Auto-generated transaction entry #268	2025-06-15 08:46:52.126538
1769	2	20	Transaction #269	2025-05-30	779.92	Auto-generated transaction entry #269	2025-06-15 08:46:52.126538
1770	2	20	Transaction #270	2025-05-25	541.62	Auto-generated transaction entry #270	2025-06-15 08:46:52.126538
1771	2	16	Transaction #271	2025-05-28	398.77	Auto-generated transaction entry #271	2025-06-15 08:46:52.126538
1772	2	15	Transaction #272	2025-05-28	431.40	Auto-generated transaction entry #272	2025-06-15 08:46:52.126538
1773	2	16	Transaction #273	2025-05-19	379.91	Auto-generated transaction entry #273	2025-06-15 08:46:52.126538
1774	2	15	Transaction #274	2025-05-29	944.95	Auto-generated transaction entry #274	2025-06-15 08:46:52.126538
1775	2	15	Transaction #275	2025-05-24	567.57	Auto-generated transaction entry #275	2025-06-15 08:46:52.126538
1776	2	14	Transaction #276	2025-05-16	375.87	Auto-generated transaction entry #276	2025-06-15 08:46:52.126538
1777	2	19	Transaction #277	2025-05-23	825.05	Auto-generated transaction entry #277	2025-06-15 08:46:52.126538
1778	2	15	Transaction #278	2025-05-17	428.97	Auto-generated transaction entry #278	2025-06-15 08:46:52.126538
1779	2	17	Transaction #279	2025-06-02	979.32	Auto-generated transaction entry #279	2025-06-15 08:46:52.126538
1780	2	14	Transaction #280	2025-06-01	975.76	Auto-generated transaction entry #280	2025-06-15 08:46:52.126538
1781	2	14	Transaction #281	2025-06-12	628.81	Auto-generated transaction entry #281	2025-06-15 08:46:52.126538
1782	2	14	Transaction #282	2025-06-09	317.18	Auto-generated transaction entry #282	2025-06-15 08:46:52.126538
1783	2	16	Transaction #283	2025-05-24	532.87	Auto-generated transaction entry #283	2025-06-15 08:46:52.126538
1784	2	13	Transaction #284	2025-06-07	846.19	Auto-generated transaction entry #284	2025-06-15 08:46:52.126538
1785	2	19	Transaction #285	2025-05-17	811.76	Auto-generated transaction entry #285	2025-06-15 08:46:52.126538
1786	2	14	Transaction #286	2025-05-19	722.79	Auto-generated transaction entry #286	2025-06-15 08:46:52.126538
1787	2	13	Transaction #287	2025-05-25	712.96	Auto-generated transaction entry #287	2025-06-15 08:46:52.126538
1788	2	16	Transaction #288	2025-05-24	398.61	Auto-generated transaction entry #288	2025-06-15 08:46:52.126538
1789	2	13	Transaction #289	2025-06-09	871.03	Auto-generated transaction entry #289	2025-06-15 08:46:52.126538
1790	2	17	Transaction #290	2025-06-12	794.92	Auto-generated transaction entry #290	2025-06-15 08:46:52.126538
1791	2	15	Transaction #291	2025-05-31	419.46	Auto-generated transaction entry #291	2025-06-15 08:46:52.126538
1792	2	15	Transaction #292	2025-06-02	318.01	Auto-generated transaction entry #292	2025-06-15 08:46:52.126538
1793	2	20	Transaction #293	2025-05-31	366.37	Auto-generated transaction entry #293	2025-06-15 08:46:52.126538
1794	2	17	Transaction #294	2025-05-19	618.39	Auto-generated transaction entry #294	2025-06-15 08:46:52.126538
1795	2	20	Transaction #295	2025-05-20	641.54	Auto-generated transaction entry #295	2025-06-15 08:46:52.126538
1796	2	16	Transaction #296	2025-06-03	522.38	Auto-generated transaction entry #296	2025-06-15 08:46:52.126538
1797	2	20	Transaction #297	2025-05-29	435.65	Auto-generated transaction entry #297	2025-06-15 08:46:52.126538
1798	2	18	Transaction #298	2025-06-09	456.28	Auto-generated transaction entry #298	2025-06-15 08:46:52.126538
1799	2	14	Transaction #299	2025-05-20	550.93	Auto-generated transaction entry #299	2025-06-15 08:46:52.126538
1800	2	17	Transaction #300	2025-05-27	662.12	Auto-generated transaction entry #300	2025-06-15 08:46:52.126538
1801	2	15	Transaction #301	2025-05-29	800.22	Auto-generated transaction entry #301	2025-06-15 08:46:52.126538
1802	2	14	Transaction #302	2025-06-01	958.11	Auto-generated transaction entry #302	2025-06-15 08:46:52.126538
1803	2	20	Transaction #303	2025-06-05	811.07	Auto-generated transaction entry #303	2025-06-15 08:46:52.126538
1804	2	16	Transaction #304	2025-06-11	645.20	Auto-generated transaction entry #304	2025-06-15 08:46:52.126538
1805	2	15	Transaction #305	2025-06-14	100.68	Auto-generated transaction entry #305	2025-06-15 08:46:52.126538
1806	2	20	Transaction #306	2025-05-21	612.97	Auto-generated transaction entry #306	2025-06-15 08:46:52.126538
1807	2	20	Transaction #307	2025-06-12	324.50	Auto-generated transaction entry #307	2025-06-15 08:46:52.126538
1808	2	15	Transaction #308	2025-06-14	897.85	Auto-generated transaction entry #308	2025-06-15 08:46:52.126538
1809	2	16	Transaction #309	2025-05-24	837.16	Auto-generated transaction entry #309	2025-06-15 08:46:52.126538
1810	2	14	Transaction #310	2025-05-23	727.35	Auto-generated transaction entry #310	2025-06-15 08:46:52.126538
1811	2	13	Transaction #311	2025-06-09	725.96	Auto-generated transaction entry #311	2025-06-15 08:46:52.126538
1812	2	17	Transaction #312	2025-06-02	198.46	Auto-generated transaction entry #312	2025-06-15 08:46:52.126538
1813	2	15	Transaction #313	2025-05-29	479.48	Auto-generated transaction entry #313	2025-06-15 08:46:52.126538
1814	2	17	Transaction #314	2025-05-25	541.74	Auto-generated transaction entry #314	2025-06-15 08:46:52.126538
1815	2	15	Transaction #315	2025-05-30	284.23	Auto-generated transaction entry #315	2025-06-15 08:46:52.126538
1816	2	16	Transaction #316	2025-05-22	237.73	Auto-generated transaction entry #316	2025-06-15 08:46:52.126538
1817	2	13	Transaction #317	2025-05-31	62.21	Auto-generated transaction entry #317	2025-06-15 08:46:52.126538
1818	2	15	Transaction #318	2025-06-02	842.34	Auto-generated transaction entry #318	2025-06-15 08:46:52.126538
1819	2	14	Transaction #319	2025-05-25	968.22	Auto-generated transaction entry #319	2025-06-15 08:46:52.126538
1820	2	16	Transaction #320	2025-06-10	609.65	Auto-generated transaction entry #320	2025-06-15 08:46:52.126538
1821	2	16	Transaction #321	2025-06-04	772.23	Auto-generated transaction entry #321	2025-06-15 08:46:52.126538
1822	2	18	Transaction #322	2025-06-04	951.46	Auto-generated transaction entry #322	2025-06-15 08:46:52.126538
1823	2	19	Transaction #323	2025-05-23	439.33	Auto-generated transaction entry #323	2025-06-15 08:46:52.126538
1824	2	15	Transaction #324	2025-06-08	562.68	Auto-generated transaction entry #324	2025-06-15 08:46:52.126538
1825	2	20	Transaction #325	2025-06-08	593.41	Auto-generated transaction entry #325	2025-06-15 08:46:52.126538
1826	2	15	Transaction #326	2025-05-17	66.62	Auto-generated transaction entry #326	2025-06-15 08:46:52.126538
1827	2	13	Transaction #327	2025-06-04	925.94	Auto-generated transaction entry #327	2025-06-15 08:46:52.126538
1828	2	20	Transaction #328	2025-05-27	494.70	Auto-generated transaction entry #328	2025-06-15 08:46:52.126538
1829	2	20	Transaction #329	2025-05-18	977.94	Auto-generated transaction entry #329	2025-06-15 08:46:52.126538
1830	2	20	Transaction #330	2025-05-27	331.39	Auto-generated transaction entry #330	2025-06-15 08:46:52.126538
1831	2	15	Transaction #331	2025-06-04	663.10	Auto-generated transaction entry #331	2025-06-15 08:46:52.126538
1832	2	20	Transaction #332	2025-06-01	568.64	Auto-generated transaction entry #332	2025-06-15 08:46:52.126538
1833	2	16	Transaction #333	2025-05-26	95.91	Auto-generated transaction entry #333	2025-06-15 08:46:52.126538
1834	2	16	Transaction #334	2025-05-29	681.22	Auto-generated transaction entry #334	2025-06-15 08:46:52.126538
1835	2	20	Transaction #335	2025-05-24	445.07	Auto-generated transaction entry #335	2025-06-15 08:46:52.126538
1836	2	18	Transaction #336	2025-05-19	694.73	Auto-generated transaction entry #336	2025-06-15 08:46:52.126538
1837	2	13	Transaction #337	2025-06-04	179.77	Auto-generated transaction entry #337	2025-06-15 08:46:52.126538
1838	2	13	Transaction #338	2025-06-02	636.62	Auto-generated transaction entry #338	2025-06-15 08:46:52.126538
1839	2	15	Transaction #339	2025-05-28	648.52	Auto-generated transaction entry #339	2025-06-15 08:46:52.126538
1840	2	20	Transaction #340	2025-05-23	52.93	Auto-generated transaction entry #340	2025-06-15 08:46:52.126538
1841	2	17	Transaction #341	2025-05-23	958.76	Auto-generated transaction entry #341	2025-06-15 08:46:52.126538
1842	2	18	Transaction #342	2025-06-07	281.86	Auto-generated transaction entry #342	2025-06-15 08:46:52.126538
1843	2	14	Transaction #343	2025-05-17	70.89	Auto-generated transaction entry #343	2025-06-15 08:46:52.126538
1844	2	16	Transaction #344	2025-06-02	77.14	Auto-generated transaction entry #344	2025-06-15 08:46:52.126538
1845	2	14	Transaction #345	2025-06-13	76.96	Auto-generated transaction entry #345	2025-06-15 08:46:52.126538
1846	2	20	Transaction #346	2025-06-02	418.85	Auto-generated transaction entry #346	2025-06-15 08:46:52.126538
1847	2	18	Transaction #347	2025-05-30	125.12	Auto-generated transaction entry #347	2025-06-15 08:46:52.126538
1848	2	16	Transaction #348	2025-06-01	372.72	Auto-generated transaction entry #348	2025-06-15 08:46:52.126538
1849	2	18	Transaction #349	2025-05-26	901.02	Auto-generated transaction entry #349	2025-06-15 08:46:52.126538
1850	2	19	Transaction #350	2025-05-19	206.38	Auto-generated transaction entry #350	2025-06-15 08:46:52.126538
1851	2	18	Transaction #351	2025-06-03	858.24	Auto-generated transaction entry #351	2025-06-15 08:46:52.126538
1852	2	16	Transaction #352	2025-05-24	934.40	Auto-generated transaction entry #352	2025-06-15 08:46:52.126538
1853	2	19	Transaction #353	2025-05-29	594.53	Auto-generated transaction entry #353	2025-06-15 08:46:52.126538
1854	2	17	Transaction #354	2025-05-29	707.56	Auto-generated transaction entry #354	2025-06-15 08:46:52.126538
1855	2	17	Transaction #355	2025-06-15	444.51	Auto-generated transaction entry #355	2025-06-15 08:46:52.126538
1856	2	13	Transaction #356	2025-06-12	194.43	Auto-generated transaction entry #356	2025-06-15 08:46:52.126538
1857	2	16	Transaction #357	2025-05-29	630.07	Auto-generated transaction entry #357	2025-06-15 08:46:52.126538
1858	2	15	Transaction #358	2025-05-27	334.27	Auto-generated transaction entry #358	2025-06-15 08:46:52.126538
1859	2	20	Transaction #359	2025-05-24	393.65	Auto-generated transaction entry #359	2025-06-15 08:46:52.126538
1860	2	16	Transaction #360	2025-06-08	756.33	Auto-generated transaction entry #360	2025-06-15 08:46:52.126538
1861	2	17	Transaction #361	2025-06-10	185.44	Auto-generated transaction entry #361	2025-06-15 08:46:52.126538
1862	2	16	Transaction #362	2025-05-24	705.06	Auto-generated transaction entry #362	2025-06-15 08:46:52.126538
1863	2	20	Transaction #363	2025-05-26	67.55	Auto-generated transaction entry #363	2025-06-15 08:46:52.126538
1864	2	17	Transaction #364	2025-06-06	383.43	Auto-generated transaction entry #364	2025-06-15 08:46:52.126538
1865	2	20	Transaction #365	2025-05-19	935.62	Auto-generated transaction entry #365	2025-06-15 08:46:52.126538
1866	2	19	Transaction #366	2025-06-13	766.38	Auto-generated transaction entry #366	2025-06-15 08:46:52.126538
1867	2	13	Transaction #367	2025-05-28	304.00	Auto-generated transaction entry #367	2025-06-15 08:46:52.126538
1868	2	14	Transaction #368	2025-06-08	980.37	Auto-generated transaction entry #368	2025-06-15 08:46:52.126538
1869	2	13	Transaction #369	2025-05-21	265.53	Auto-generated transaction entry #369	2025-06-15 08:46:52.126538
1870	2	17	Transaction #370	2025-05-27	452.50	Auto-generated transaction entry #370	2025-06-15 08:46:52.126538
1871	2	15	Transaction #371	2025-06-13	505.78	Auto-generated transaction entry #371	2025-06-15 08:46:52.126538
1872	2	13	Transaction #372	2025-06-03	109.84	Auto-generated transaction entry #372	2025-06-15 08:46:52.126538
1873	2	19	Transaction #373	2025-05-17	487.02	Auto-generated transaction entry #373	2025-06-15 08:46:52.126538
1874	2	16	Transaction #374	2025-05-28	934.42	Auto-generated transaction entry #374	2025-06-15 08:46:52.126538
1875	2	17	Transaction #375	2025-06-08	294.53	Auto-generated transaction entry #375	2025-06-15 08:46:52.126538
1876	2	13	Transaction #376	2025-06-13	644.41	Auto-generated transaction entry #376	2025-06-15 08:46:52.126538
1877	2	18	Transaction #377	2025-06-04	102.40	Auto-generated transaction entry #377	2025-06-15 08:46:52.126538
1878	2	13	Transaction #378	2025-05-22	106.10	Auto-generated transaction entry #378	2025-06-15 08:46:52.126538
1879	2	15	Transaction #379	2025-05-21	166.00	Auto-generated transaction entry #379	2025-06-15 08:46:52.126538
1880	2	20	Transaction #380	2025-06-05	730.14	Auto-generated transaction entry #380	2025-06-15 08:46:52.126538
1881	2	13	Transaction #381	2025-05-21	68.42	Auto-generated transaction entry #381	2025-06-15 08:46:52.126538
1882	2	18	Transaction #382	2025-06-10	214.64	Auto-generated transaction entry #382	2025-06-15 08:46:52.126538
1883	2	20	Transaction #383	2025-05-25	828.28	Auto-generated transaction entry #383	2025-06-15 08:46:52.126538
1884	2	16	Transaction #384	2025-06-05	175.16	Auto-generated transaction entry #384	2025-06-15 08:46:52.126538
1885	2	14	Transaction #385	2025-05-25	281.72	Auto-generated transaction entry #385	2025-06-15 08:46:52.126538
1886	2	13	Transaction #386	2025-05-25	926.29	Auto-generated transaction entry #386	2025-06-15 08:46:52.126538
1887	2	14	Transaction #387	2025-05-25	589.93	Auto-generated transaction entry #387	2025-06-15 08:46:52.126538
1888	2	14	Transaction #388	2025-05-17	703.03	Auto-generated transaction entry #388	2025-06-15 08:46:52.126538
1889	2	13	Transaction #389	2025-05-22	372.01	Auto-generated transaction entry #389	2025-06-15 08:46:52.126538
1890	2	14	Transaction #390	2025-05-20	164.51	Auto-generated transaction entry #390	2025-06-15 08:46:52.126538
1891	2	19	Transaction #391	2025-05-19	81.21	Auto-generated transaction entry #391	2025-06-15 08:46:52.126538
1892	2	16	Transaction #392	2025-05-23	179.89	Auto-generated transaction entry #392	2025-06-15 08:46:52.126538
1893	2	16	Transaction #393	2025-06-09	710.76	Auto-generated transaction entry #393	2025-06-15 08:46:52.126538
1894	2	18	Transaction #394	2025-06-06	446.57	Auto-generated transaction entry #394	2025-06-15 08:46:52.126538
1895	2	20	Transaction #395	2025-06-07	701.94	Auto-generated transaction entry #395	2025-06-15 08:46:52.126538
1896	2	17	Transaction #396	2025-05-18	201.52	Auto-generated transaction entry #396	2025-06-15 08:46:52.126538
1897	2	17	Transaction #397	2025-05-29	718.41	Auto-generated transaction entry #397	2025-06-15 08:46:52.126538
1898	2	20	Transaction #398	2025-05-20	236.50	Auto-generated transaction entry #398	2025-06-15 08:46:52.126538
1899	2	20	Transaction #399	2025-06-06	852.40	Auto-generated transaction entry #399	2025-06-15 08:46:52.126538
1900	2	13	Transaction #400	2025-05-20	917.15	Auto-generated transaction entry #400	2025-06-15 08:46:52.126538
1901	2	15	Transaction #401	2025-05-23	994.04	Auto-generated transaction entry #401	2025-06-15 08:46:52.126538
1902	2	13	Transaction #402	2025-06-15	379.85	Auto-generated transaction entry #402	2025-06-15 08:46:52.126538
1903	2	17	Transaction #403	2025-06-12	712.80	Auto-generated transaction entry #403	2025-06-15 08:46:52.126538
1904	2	13	Transaction #404	2025-05-21	524.08	Auto-generated transaction entry #404	2025-06-15 08:46:52.126538
1905	2	13	Transaction #405	2025-05-18	393.75	Auto-generated transaction entry #405	2025-06-15 08:46:52.126538
1906	2	14	Transaction #406	2025-06-09	513.01	Auto-generated transaction entry #406	2025-06-15 08:46:52.126538
1907	2	19	Transaction #407	2025-06-08	381.01	Auto-generated transaction entry #407	2025-06-15 08:46:52.126538
1908	2	20	Transaction #408	2025-06-07	708.47	Auto-generated transaction entry #408	2025-06-15 08:46:52.126538
1909	2	14	Transaction #409	2025-06-05	210.77	Auto-generated transaction entry #409	2025-06-15 08:46:52.126538
1910	2	20	Transaction #410	2025-05-19	50.50	Auto-generated transaction entry #410	2025-06-15 08:46:52.126538
1911	2	20	Transaction #411	2025-06-13	690.27	Auto-generated transaction entry #411	2025-06-15 08:46:52.126538
1912	2	17	Transaction #412	2025-06-02	314.56	Auto-generated transaction entry #412	2025-06-15 08:46:52.126538
1913	2	19	Transaction #413	2025-05-31	217.99	Auto-generated transaction entry #413	2025-06-15 08:46:52.126538
1914	2	20	Transaction #414	2025-05-16	849.57	Auto-generated transaction entry #414	2025-06-15 08:46:52.126538
1915	2	20	Transaction #415	2025-06-01	358.11	Auto-generated transaction entry #415	2025-06-15 08:46:52.126538
1916	2	20	Transaction #416	2025-06-05	959.22	Auto-generated transaction entry #416	2025-06-15 08:46:52.126538
1917	2	18	Transaction #417	2025-06-01	565.98	Auto-generated transaction entry #417	2025-06-15 08:46:52.126538
1918	2	20	Transaction #418	2025-06-06	480.67	Auto-generated transaction entry #418	2025-06-15 08:46:52.126538
1919	2	15	Transaction #419	2025-05-17	799.90	Auto-generated transaction entry #419	2025-06-15 08:46:52.126538
1920	2	16	Transaction #420	2025-05-24	279.39	Auto-generated transaction entry #420	2025-06-15 08:46:52.126538
1921	2	16	Transaction #421	2025-06-08	827.18	Auto-generated transaction entry #421	2025-06-15 08:46:52.126538
1922	2	19	Transaction #422	2025-06-05	274.16	Auto-generated transaction entry #422	2025-06-15 08:46:52.126538
1923	2	15	Transaction #423	2025-06-02	411.77	Auto-generated transaction entry #423	2025-06-15 08:46:52.126538
1924	2	15	Transaction #424	2025-05-24	374.89	Auto-generated transaction entry #424	2025-06-15 08:46:52.126538
1925	2	13	Transaction #425	2025-06-14	550.72	Auto-generated transaction entry #425	2025-06-15 08:46:52.126538
1926	2	18	Transaction #426	2025-05-16	116.42	Auto-generated transaction entry #426	2025-06-15 08:46:52.126538
1927	2	15	Transaction #427	2025-05-28	242.13	Auto-generated transaction entry #427	2025-06-15 08:46:52.126538
1928	2	13	Transaction #428	2025-05-23	728.54	Auto-generated transaction entry #428	2025-06-15 08:46:52.126538
1929	2	13	Transaction #429	2025-05-30	68.81	Auto-generated transaction entry #429	2025-06-15 08:46:52.126538
1930	2	16	Transaction #430	2025-06-01	768.42	Auto-generated transaction entry #430	2025-06-15 08:46:52.126538
1931	2	13	Transaction #431	2025-06-10	445.40	Auto-generated transaction entry #431	2025-06-15 08:46:52.126538
1932	2	18	Transaction #432	2025-06-02	489.05	Auto-generated transaction entry #432	2025-06-15 08:46:52.126538
1933	2	13	Transaction #433	2025-05-25	310.02	Auto-generated transaction entry #433	2025-06-15 08:46:52.126538
1934	2	14	Transaction #434	2025-06-13	484.75	Auto-generated transaction entry #434	2025-06-15 08:46:52.126538
1935	2	16	Transaction #435	2025-06-10	231.06	Auto-generated transaction entry #435	2025-06-15 08:46:52.126538
1936	2	17	Transaction #436	2025-05-28	822.82	Auto-generated transaction entry #436	2025-06-15 08:46:52.126538
1937	2	17	Transaction #437	2025-05-27	397.53	Auto-generated transaction entry #437	2025-06-15 08:46:52.126538
1938	2	16	Transaction #438	2025-06-07	959.56	Auto-generated transaction entry #438	2025-06-15 08:46:52.126538
1939	2	19	Transaction #439	2025-05-19	305.95	Auto-generated transaction entry #439	2025-06-15 08:46:52.126538
1940	2	14	Transaction #440	2025-06-12	367.25	Auto-generated transaction entry #440	2025-06-15 08:46:52.126538
1941	2	19	Transaction #441	2025-05-20	667.14	Auto-generated transaction entry #441	2025-06-15 08:46:52.126538
1942	2	19	Transaction #442	2025-05-18	377.37	Auto-generated transaction entry #442	2025-06-15 08:46:52.126538
1943	2	15	Transaction #443	2025-05-18	616.48	Auto-generated transaction entry #443	2025-06-15 08:46:52.126538
1944	2	15	Transaction #444	2025-05-21	812.83	Auto-generated transaction entry #444	2025-06-15 08:46:52.126538
1945	2	17	Transaction #445	2025-05-17	621.29	Auto-generated transaction entry #445	2025-06-15 08:46:52.126538
1946	2	13	Transaction #446	2025-06-13	412.21	Auto-generated transaction entry #446	2025-06-15 08:46:52.126538
1947	2	19	Transaction #447	2025-05-19	616.10	Auto-generated transaction entry #447	2025-06-15 08:46:52.126538
1948	2	20	Transaction #448	2025-05-25	889.90	Auto-generated transaction entry #448	2025-06-15 08:46:52.126538
1949	2	15	Transaction #449	2025-05-22	85.68	Auto-generated transaction entry #449	2025-06-15 08:46:52.126538
1950	2	18	Transaction #450	2025-05-22	265.85	Auto-generated transaction entry #450	2025-06-15 08:46:52.126538
1951	2	18	Transaction #451	2025-06-14	921.31	Auto-generated transaction entry #451	2025-06-15 08:46:52.126538
1952	2	19	Transaction #452	2025-06-12	61.80	Auto-generated transaction entry #452	2025-06-15 08:46:52.126538
1953	2	20	Transaction #453	2025-06-15	537.34	Auto-generated transaction entry #453	2025-06-15 08:46:52.126538
1954	2	14	Transaction #454	2025-05-22	139.65	Auto-generated transaction entry #454	2025-06-15 08:46:52.126538
1955	2	15	Transaction #455	2025-06-05	715.64	Auto-generated transaction entry #455	2025-06-15 08:46:52.126538
1956	2	14	Transaction #456	2025-05-25	947.60	Auto-generated transaction entry #456	2025-06-15 08:46:52.126538
1957	2	14	Transaction #457	2025-05-20	733.05	Auto-generated transaction entry #457	2025-06-15 08:46:52.126538
1958	2	19	Transaction #458	2025-05-29	445.19	Auto-generated transaction entry #458	2025-06-15 08:46:52.126538
1959	2	15	Transaction #459	2025-05-18	987.60	Auto-generated transaction entry #459	2025-06-15 08:46:52.126538
1960	2	19	Transaction #460	2025-05-17	161.94	Auto-generated transaction entry #460	2025-06-15 08:46:52.126538
1961	2	16	Transaction #461	2025-06-01	916.05	Auto-generated transaction entry #461	2025-06-15 08:46:52.126538
1962	2	13	Transaction #462	2025-06-01	346.07	Auto-generated transaction entry #462	2025-06-15 08:46:52.126538
1963	2	18	Transaction #463	2025-06-07	409.34	Auto-generated transaction entry #463	2025-06-15 08:46:52.126538
1964	2	20	Transaction #464	2025-06-04	502.27	Auto-generated transaction entry #464	2025-06-15 08:46:52.126538
1965	2	16	Transaction #465	2025-05-23	715.39	Auto-generated transaction entry #465	2025-06-15 08:46:52.126538
1966	2	14	Transaction #466	2025-05-25	849.35	Auto-generated transaction entry #466	2025-06-15 08:46:52.126538
1967	2	19	Transaction #467	2025-05-21	159.59	Auto-generated transaction entry #467	2025-06-15 08:46:52.126538
1968	2	13	Transaction #468	2025-05-24	513.53	Auto-generated transaction entry #468	2025-06-15 08:46:52.126538
1969	2	15	Transaction #469	2025-05-30	516.56	Auto-generated transaction entry #469	2025-06-15 08:46:52.126538
1970	2	16	Transaction #470	2025-06-10	470.51	Auto-generated transaction entry #470	2025-06-15 08:46:52.126538
1971	2	18	Transaction #471	2025-05-27	203.63	Auto-generated transaction entry #471	2025-06-15 08:46:52.126538
1972	2	20	Transaction #472	2025-06-01	693.00	Auto-generated transaction entry #472	2025-06-15 08:46:52.126538
1973	2	20	Transaction #473	2025-06-01	366.41	Auto-generated transaction entry #473	2025-06-15 08:46:52.126538
1974	2	18	Transaction #474	2025-06-06	275.40	Auto-generated transaction entry #474	2025-06-15 08:46:52.126538
1975	2	18	Transaction #475	2025-06-10	512.70	Auto-generated transaction entry #475	2025-06-15 08:46:52.126538
1976	2	17	Transaction #476	2025-06-12	114.19	Auto-generated transaction entry #476	2025-06-15 08:46:52.126538
1977	2	19	Transaction #477	2025-06-02	443.90	Auto-generated transaction entry #477	2025-06-15 08:46:52.126538
1978	2	20	Transaction #478	2025-05-26	293.77	Auto-generated transaction entry #478	2025-06-15 08:46:52.126538
1979	2	16	Transaction #479	2025-05-19	291.16	Auto-generated transaction entry #479	2025-06-15 08:46:52.126538
1980	2	18	Transaction #480	2025-06-09	549.51	Auto-generated transaction entry #480	2025-06-15 08:46:52.126538
1981	2	16	Transaction #481	2025-05-27	341.12	Auto-generated transaction entry #481	2025-06-15 08:46:52.126538
1982	2	14	Transaction #482	2025-05-27	784.26	Auto-generated transaction entry #482	2025-06-15 08:46:52.126538
1983	2	17	Transaction #483	2025-06-07	656.66	Auto-generated transaction entry #483	2025-06-15 08:46:52.126538
1984	2	20	Transaction #484	2025-06-10	125.52	Auto-generated transaction entry #484	2025-06-15 08:46:52.126538
1985	2	16	Transaction #485	2025-05-27	305.84	Auto-generated transaction entry #485	2025-06-15 08:46:52.126538
1986	2	18	Transaction #486	2025-05-30	789.21	Auto-generated transaction entry #486	2025-06-15 08:46:52.126538
1987	2	20	Transaction #487	2025-05-25	713.24	Auto-generated transaction entry #487	2025-06-15 08:46:52.126538
1988	2	14	Transaction #488	2025-05-31	488.35	Auto-generated transaction entry #488	2025-06-15 08:46:52.126538
1989	2	15	Transaction #489	2025-06-03	205.59	Auto-generated transaction entry #489	2025-06-15 08:46:52.126538
1990	2	17	Transaction #490	2025-06-08	299.60	Auto-generated transaction entry #490	2025-06-15 08:46:52.126538
1991	2	14	Transaction #491	2025-06-05	135.23	Auto-generated transaction entry #491	2025-06-15 08:46:52.126538
1992	2	17	Transaction #492	2025-05-25	630.46	Auto-generated transaction entry #492	2025-06-15 08:46:52.126538
1993	2	17	Transaction #493	2025-05-22	910.02	Auto-generated transaction entry #493	2025-06-15 08:46:52.126538
1994	2	19	Transaction #494	2025-06-14	642.37	Auto-generated transaction entry #494	2025-06-15 08:46:52.126538
1995	2	18	Transaction #495	2025-05-21	71.70	Auto-generated transaction entry #495	2025-06-15 08:46:52.126538
1996	2	15	Transaction #496	2025-06-03	78.52	Auto-generated transaction entry #496	2025-06-15 08:46:52.126538
1997	2	18	Transaction #497	2025-06-07	315.83	Auto-generated transaction entry #497	2025-06-15 08:46:52.126538
1998	2	19	Transaction #498	2025-06-06	734.12	Auto-generated transaction entry #498	2025-06-15 08:46:52.126538
1999	2	16	Transaction #499	2025-05-21	539.52	Auto-generated transaction entry #499	2025-06-15 08:46:52.126538
2000	2	18	Transaction #500	2025-05-23	804.28	Auto-generated transaction entry #500	2025-06-15 08:46:52.126538
2001	3	27	Transaction #1	2025-05-24	560.91	Auto-generated transaction entry #1	2025-06-15 08:47:04.446339
2002	3	30	Transaction #2	2025-05-21	209.87	Auto-generated transaction entry #2	2025-06-15 08:47:04.446339
2003	3	29	Transaction #3	2025-06-14	383.28	Auto-generated transaction entry #3	2025-06-15 08:47:04.446339
2004	3	27	Transaction #4	2025-05-26	566.63	Auto-generated transaction entry #4	2025-06-15 08:47:04.446339
2005	3	29	Transaction #5	2025-06-02	535.99	Auto-generated transaction entry #5	2025-06-15 08:47:04.446339
2006	3	30	Transaction #6	2025-05-26	201.83	Auto-generated transaction entry #6	2025-06-15 08:47:04.446339
2007	3	29	Transaction #7	2025-06-02	245.67	Auto-generated transaction entry #7	2025-06-15 08:47:04.446339
2008	3	30	Transaction #8	2025-06-10	740.72	Auto-generated transaction entry #8	2025-06-15 08:47:04.446339
2009	3	29	Transaction #9	2025-05-31	695.53	Auto-generated transaction entry #9	2025-06-15 08:47:04.446339
2010	3	27	Transaction #10	2025-05-26	689.18	Auto-generated transaction entry #10	2025-06-15 08:47:04.446339
2011	3	28	Transaction #11	2025-06-04	306.68	Auto-generated transaction entry #11	2025-06-15 08:47:04.446339
2012	3	26	Transaction #12	2025-05-26	155.24	Auto-generated transaction entry #12	2025-06-15 08:47:04.446339
2013	3	29	Transaction #13	2025-06-13	609.54	Auto-generated transaction entry #13	2025-06-15 08:47:04.446339
2014	3	26	Transaction #14	2025-06-05	413.66	Auto-generated transaction entry #14	2025-06-15 08:47:04.446339
2015	3	28	Transaction #15	2025-05-25	441.06	Auto-generated transaction entry #15	2025-06-15 08:47:04.446339
2016	3	30	Transaction #16	2025-06-10	219.26	Auto-generated transaction entry #16	2025-06-15 08:47:04.446339
2017	3	27	Transaction #17	2025-06-07	851.70	Auto-generated transaction entry #17	2025-06-15 08:47:04.446339
2018	3	26	Transaction #18	2025-05-22	61.69	Auto-generated transaction entry #18	2025-06-15 08:47:04.446339
2019	3	29	Transaction #19	2025-05-19	568.30	Auto-generated transaction entry #19	2025-06-15 08:47:04.446339
2020	3	28	Transaction #20	2025-06-05	884.10	Auto-generated transaction entry #20	2025-06-15 08:47:04.446339
2021	3	27	Transaction #21	2025-06-11	762.36	Auto-generated transaction entry #21	2025-06-15 08:47:04.446339
2022	3	28	Transaction #22	2025-05-31	348.90	Auto-generated transaction entry #22	2025-06-15 08:47:04.446339
2023	3	29	Transaction #23	2025-06-05	580.81	Auto-generated transaction entry #23	2025-06-15 08:47:04.446339
2024	3	29	Transaction #24	2025-06-14	366.74	Auto-generated transaction entry #24	2025-06-15 08:47:04.446339
2025	3	29	Transaction #25	2025-05-24	645.28	Auto-generated transaction entry #25	2025-06-15 08:47:04.446339
2026	3	30	Transaction #26	2025-06-08	267.78	Auto-generated transaction entry #26	2025-06-15 08:47:04.446339
2027	3	30	Transaction #27	2025-05-21	774.87	Auto-generated transaction entry #27	2025-06-15 08:47:04.446339
2028	3	30	Transaction #28	2025-06-05	261.31	Auto-generated transaction entry #28	2025-06-15 08:47:04.446339
2029	3	29	Transaction #29	2025-05-25	603.61	Auto-generated transaction entry #29	2025-06-15 08:47:04.446339
2030	3	26	Transaction #30	2025-05-21	237.60	Auto-generated transaction entry #30	2025-06-15 08:47:04.446339
2031	3	26	Transaction #31	2025-05-27	217.59	Auto-generated transaction entry #31	2025-06-15 08:47:04.446339
2032	3	30	Transaction #32	2025-05-27	225.90	Auto-generated transaction entry #32	2025-06-15 08:47:04.446339
2033	3	28	Transaction #33	2025-06-11	183.00	Auto-generated transaction entry #33	2025-06-15 08:47:04.446339
2034	3	26	Transaction #34	2025-06-13	57.58	Auto-generated transaction entry #34	2025-06-15 08:47:04.446339
2035	3	30	Transaction #35	2025-06-04	710.17	Auto-generated transaction entry #35	2025-06-15 08:47:04.446339
2036	3	28	Transaction #36	2025-06-11	258.42	Auto-generated transaction entry #36	2025-06-15 08:47:04.446339
2037	3	29	Transaction #37	2025-05-31	363.31	Auto-generated transaction entry #37	2025-06-15 08:47:04.446339
2038	3	27	Transaction #38	2025-05-24	631.61	Auto-generated transaction entry #38	2025-06-15 08:47:04.446339
2039	3	29	Transaction #39	2025-05-28	863.21	Auto-generated transaction entry #39	2025-06-15 08:47:04.446339
2040	3	28	Transaction #40	2025-06-14	206.76	Auto-generated transaction entry #40	2025-06-15 08:47:04.446339
2041	3	28	Transaction #41	2025-06-02	331.28	Auto-generated transaction entry #41	2025-06-15 08:47:04.446339
2042	3	26	Transaction #42	2025-05-22	108.74	Auto-generated transaction entry #42	2025-06-15 08:47:04.446339
2043	3	30	Transaction #43	2025-05-24	259.68	Auto-generated transaction entry #43	2025-06-15 08:47:04.446339
2044	3	30	Transaction #44	2025-06-14	325.60	Auto-generated transaction entry #44	2025-06-15 08:47:04.446339
2045	3	27	Transaction #45	2025-06-10	962.86	Auto-generated transaction entry #45	2025-06-15 08:47:04.446339
2046	3	30	Transaction #46	2025-05-18	677.98	Auto-generated transaction entry #46	2025-06-15 08:47:04.446339
2047	3	26	Transaction #47	2025-05-17	486.17	Auto-generated transaction entry #47	2025-06-15 08:47:04.446339
2048	3	28	Transaction #48	2025-05-29	95.79	Auto-generated transaction entry #48	2025-06-15 08:47:04.446339
2049	3	28	Transaction #49	2025-05-21	290.51	Auto-generated transaction entry #49	2025-06-15 08:47:04.446339
2050	3	26	Transaction #50	2025-05-19	489.78	Auto-generated transaction entry #50	2025-06-15 08:47:04.446339
2051	3	30	Transaction #51	2025-06-12	675.48	Auto-generated transaction entry #51	2025-06-15 08:47:04.446339
2052	3	28	Transaction #52	2025-06-02	535.26	Auto-generated transaction entry #52	2025-06-15 08:47:04.446339
2053	3	30	Transaction #53	2025-06-15	989.12	Auto-generated transaction entry #53	2025-06-15 08:47:04.446339
2054	3	28	Transaction #54	2025-06-07	812.45	Auto-generated transaction entry #54	2025-06-15 08:47:04.446339
2055	3	29	Transaction #55	2025-06-03	123.25	Auto-generated transaction entry #55	2025-06-15 08:47:04.446339
2056	3	29	Transaction #56	2025-05-27	125.96	Auto-generated transaction entry #56	2025-06-15 08:47:04.446339
2057	3	27	Transaction #57	2025-05-29	935.90	Auto-generated transaction entry #57	2025-06-15 08:47:04.446339
2058	3	26	Transaction #58	2025-06-12	539.04	Auto-generated transaction entry #58	2025-06-15 08:47:04.446339
2059	3	26	Transaction #59	2025-05-30	946.34	Auto-generated transaction entry #59	2025-06-15 08:47:04.446339
2060	3	28	Transaction #60	2025-05-27	146.59	Auto-generated transaction entry #60	2025-06-15 08:47:04.446339
2061	3	26	Transaction #61	2025-06-08	745.71	Auto-generated transaction entry #61	2025-06-15 08:47:04.446339
2062	3	28	Transaction #62	2025-05-17	80.84	Auto-generated transaction entry #62	2025-06-15 08:47:04.446339
2063	3	26	Transaction #63	2025-06-01	518.85	Auto-generated transaction entry #63	2025-06-15 08:47:04.446339
2064	3	28	Transaction #64	2025-06-10	327.36	Auto-generated transaction entry #64	2025-06-15 08:47:04.446339
2065	3	28	Transaction #65	2025-06-03	701.14	Auto-generated transaction entry #65	2025-06-15 08:47:04.446339
2066	3	28	Transaction #66	2025-06-09	286.13	Auto-generated transaction entry #66	2025-06-15 08:47:04.446339
2067	3	30	Transaction #67	2025-06-14	924.45	Auto-generated transaction entry #67	2025-06-15 08:47:04.446339
2068	3	27	Transaction #68	2025-05-30	65.29	Auto-generated transaction entry #68	2025-06-15 08:47:04.446339
2069	3	30	Transaction #69	2025-06-04	396.49	Auto-generated transaction entry #69	2025-06-15 08:47:04.446339
2070	3	29	Transaction #70	2025-05-21	655.08	Auto-generated transaction entry #70	2025-06-15 08:47:04.446339
2071	3	30	Transaction #71	2025-05-20	551.40	Auto-generated transaction entry #71	2025-06-15 08:47:04.446339
2072	3	30	Transaction #72	2025-06-13	717.85	Auto-generated transaction entry #72	2025-06-15 08:47:04.446339
2073	3	27	Transaction #73	2025-06-11	226.03	Auto-generated transaction entry #73	2025-06-15 08:47:04.446339
2074	3	27	Transaction #74	2025-05-29	621.87	Auto-generated transaction entry #74	2025-06-15 08:47:04.446339
2075	3	26	Transaction #75	2025-06-03	142.28	Auto-generated transaction entry #75	2025-06-15 08:47:04.446339
2076	3	30	Transaction #76	2025-05-18	693.10	Auto-generated transaction entry #76	2025-06-15 08:47:04.446339
2077	3	27	Transaction #77	2025-06-12	859.82	Auto-generated transaction entry #77	2025-06-15 08:47:04.446339
2078	3	30	Transaction #78	2025-05-18	707.87	Auto-generated transaction entry #78	2025-06-15 08:47:04.446339
2079	3	26	Transaction #79	2025-06-02	127.17	Auto-generated transaction entry #79	2025-06-15 08:47:04.446339
2080	3	26	Transaction #80	2025-05-20	181.70	Auto-generated transaction entry #80	2025-06-15 08:47:04.446339
2081	3	28	Transaction #81	2025-06-03	889.08	Auto-generated transaction entry #81	2025-06-15 08:47:04.446339
2082	3	26	Transaction #82	2025-06-04	454.19	Auto-generated transaction entry #82	2025-06-15 08:47:04.446339
2083	3	30	Transaction #83	2025-05-17	774.34	Auto-generated transaction entry #83	2025-06-15 08:47:04.446339
2084	3	27	Transaction #84	2025-05-19	636.10	Auto-generated transaction entry #84	2025-06-15 08:47:04.446339
2085	3	29	Transaction #85	2025-05-30	73.97	Auto-generated transaction entry #85	2025-06-15 08:47:04.446339
2086	3	29	Transaction #86	2025-06-11	729.23	Auto-generated transaction entry #86	2025-06-15 08:47:04.446339
2087	3	29	Transaction #87	2025-05-17	725.44	Auto-generated transaction entry #87	2025-06-15 08:47:04.446339
2088	3	27	Transaction #88	2025-06-07	327.17	Auto-generated transaction entry #88	2025-06-15 08:47:04.446339
2089	3	28	Transaction #89	2025-05-29	916.23	Auto-generated transaction entry #89	2025-06-15 08:47:04.446339
2090	3	30	Transaction #90	2025-05-26	352.17	Auto-generated transaction entry #90	2025-06-15 08:47:04.446339
2091	3	26	Transaction #91	2025-05-27	232.22	Auto-generated transaction entry #91	2025-06-15 08:47:04.446339
2092	3	27	Transaction #92	2025-05-31	118.82	Auto-generated transaction entry #92	2025-06-15 08:47:04.446339
2093	3	30	Transaction #93	2025-06-14	351.06	Auto-generated transaction entry #93	2025-06-15 08:47:04.446339
2094	3	26	Transaction #94	2025-05-29	193.19	Auto-generated transaction entry #94	2025-06-15 08:47:04.446339
2095	3	30	Transaction #95	2025-05-17	71.50	Auto-generated transaction entry #95	2025-06-15 08:47:04.446339
2096	3	28	Transaction #96	2025-05-20	278.02	Auto-generated transaction entry #96	2025-06-15 08:47:04.446339
2097	3	27	Transaction #97	2025-05-19	112.97	Auto-generated transaction entry #97	2025-06-15 08:47:04.446339
2098	3	28	Transaction #98	2025-05-17	472.95	Auto-generated transaction entry #98	2025-06-15 08:47:04.446339
2099	3	29	Transaction #99	2025-05-19	304.93	Auto-generated transaction entry #99	2025-06-15 08:47:04.446339
2100	3	30	Transaction #100	2025-05-19	438.24	Auto-generated transaction entry #100	2025-06-15 08:47:04.446339
2101	3	30	Transaction #101	2025-06-10	724.75	Auto-generated transaction entry #101	2025-06-15 08:47:04.446339
2102	3	29	Transaction #102	2025-05-20	328.99	Auto-generated transaction entry #102	2025-06-15 08:47:04.446339
2103	3	26	Transaction #103	2025-05-22	495.32	Auto-generated transaction entry #103	2025-06-15 08:47:04.446339
2104	3	28	Transaction #104	2025-06-04	798.92	Auto-generated transaction entry #104	2025-06-15 08:47:04.446339
2105	3	26	Transaction #105	2025-06-13	770.77	Auto-generated transaction entry #105	2025-06-15 08:47:04.446339
2106	3	27	Transaction #106	2025-05-29	849.47	Auto-generated transaction entry #106	2025-06-15 08:47:04.446339
2107	3	26	Transaction #107	2025-05-16	814.49	Auto-generated transaction entry #107	2025-06-15 08:47:04.446339
2108	3	27	Transaction #108	2025-06-08	371.65	Auto-generated transaction entry #108	2025-06-15 08:47:04.446339
2109	3	30	Transaction #109	2025-05-26	561.54	Auto-generated transaction entry #109	2025-06-15 08:47:04.446339
2110	3	28	Transaction #110	2025-06-02	441.85	Auto-generated transaction entry #110	2025-06-15 08:47:04.446339
2111	3	28	Transaction #111	2025-05-23	601.03	Auto-generated transaction entry #111	2025-06-15 08:47:04.446339
2112	3	26	Transaction #112	2025-06-10	74.92	Auto-generated transaction entry #112	2025-06-15 08:47:04.446339
2113	3	27	Transaction #113	2025-06-13	519.60	Auto-generated transaction entry #113	2025-06-15 08:47:04.446339
2114	3	27	Transaction #114	2025-05-30	575.18	Auto-generated transaction entry #114	2025-06-15 08:47:04.446339
2115	3	29	Transaction #115	2025-05-19	486.61	Auto-generated transaction entry #115	2025-06-15 08:47:04.446339
2116	3	27	Transaction #116	2025-06-11	955.30	Auto-generated transaction entry #116	2025-06-15 08:47:04.446339
2117	3	26	Transaction #117	2025-05-22	153.82	Auto-generated transaction entry #117	2025-06-15 08:47:04.446339
2118	3	26	Transaction #118	2025-06-14	862.70	Auto-generated transaction entry #118	2025-06-15 08:47:04.446339
2119	3	30	Transaction #119	2025-06-02	923.99	Auto-generated transaction entry #119	2025-06-15 08:47:04.446339
2120	3	26	Transaction #120	2025-06-02	585.43	Auto-generated transaction entry #120	2025-06-15 08:47:04.446339
2121	3	26	Transaction #121	2025-06-08	881.48	Auto-generated transaction entry #121	2025-06-15 08:47:04.446339
2122	3	26	Transaction #122	2025-06-10	646.22	Auto-generated transaction entry #122	2025-06-15 08:47:04.446339
2123	3	27	Transaction #123	2025-05-26	710.34	Auto-generated transaction entry #123	2025-06-15 08:47:04.446339
2124	3	26	Transaction #124	2025-05-29	502.98	Auto-generated transaction entry #124	2025-06-15 08:47:04.446339
2125	3	27	Transaction #125	2025-05-21	833.34	Auto-generated transaction entry #125	2025-06-15 08:47:04.446339
2126	3	30	Transaction #126	2025-06-13	159.13	Auto-generated transaction entry #126	2025-06-15 08:47:04.446339
2127	3	29	Transaction #127	2025-06-06	953.71	Auto-generated transaction entry #127	2025-06-15 08:47:04.446339
2128	3	26	Transaction #128	2025-05-18	199.99	Auto-generated transaction entry #128	2025-06-15 08:47:04.446339
2129	3	30	Transaction #129	2025-06-14	353.98	Auto-generated transaction entry #129	2025-06-15 08:47:04.446339
2130	3	29	Transaction #130	2025-05-20	376.65	Auto-generated transaction entry #130	2025-06-15 08:47:04.446339
2131	3	26	Transaction #131	2025-06-10	209.93	Auto-generated transaction entry #131	2025-06-15 08:47:04.446339
2132	3	30	Transaction #132	2025-05-26	726.80	Auto-generated transaction entry #132	2025-06-15 08:47:04.446339
2133	3	29	Transaction #133	2025-05-21	827.37	Auto-generated transaction entry #133	2025-06-15 08:47:04.446339
2134	3	28	Transaction #134	2025-05-18	269.09	Auto-generated transaction entry #134	2025-06-15 08:47:04.446339
2135	3	28	Transaction #135	2025-05-20	668.31	Auto-generated transaction entry #135	2025-06-15 08:47:04.446339
2136	3	26	Transaction #136	2025-05-31	271.07	Auto-generated transaction entry #136	2025-06-15 08:47:04.446339
2137	3	28	Transaction #137	2025-06-08	223.88	Auto-generated transaction entry #137	2025-06-15 08:47:04.446339
2138	3	26	Transaction #138	2025-05-19	844.43	Auto-generated transaction entry #138	2025-06-15 08:47:04.446339
2139	3	29	Transaction #139	2025-05-26	893.43	Auto-generated transaction entry #139	2025-06-15 08:47:04.446339
2140	3	26	Transaction #140	2025-05-22	642.50	Auto-generated transaction entry #140	2025-06-15 08:47:04.446339
2141	3	27	Transaction #141	2025-06-05	375.04	Auto-generated transaction entry #141	2025-06-15 08:47:04.446339
2142	3	28	Transaction #142	2025-05-24	50.94	Auto-generated transaction entry #142	2025-06-15 08:47:04.446339
2143	3	27	Transaction #143	2025-05-23	390.77	Auto-generated transaction entry #143	2025-06-15 08:47:04.446339
2144	3	26	Transaction #144	2025-05-30	385.63	Auto-generated transaction entry #144	2025-06-15 08:47:04.446339
2145	3	30	Transaction #145	2025-06-12	716.92	Auto-generated transaction entry #145	2025-06-15 08:47:04.446339
2146	3	30	Transaction #146	2025-06-07	964.94	Auto-generated transaction entry #146	2025-06-15 08:47:04.446339
2147	3	27	Transaction #147	2025-05-24	159.13	Auto-generated transaction entry #147	2025-06-15 08:47:04.446339
2148	3	27	Transaction #148	2025-06-01	642.43	Auto-generated transaction entry #148	2025-06-15 08:47:04.446339
2149	3	26	Transaction #149	2025-05-30	588.93	Auto-generated transaction entry #149	2025-06-15 08:47:04.446339
2150	3	27	Transaction #150	2025-05-27	197.35	Auto-generated transaction entry #150	2025-06-15 08:47:04.446339
2151	3	26	Transaction #151	2025-06-15	508.82	Auto-generated transaction entry #151	2025-06-15 08:47:04.446339
2152	3	28	Transaction #152	2025-06-11	468.49	Auto-generated transaction entry #152	2025-06-15 08:47:04.446339
2153	3	30	Transaction #153	2025-05-30	216.06	Auto-generated transaction entry #153	2025-06-15 08:47:04.446339
2154	3	26	Transaction #154	2025-06-11	381.41	Auto-generated transaction entry #154	2025-06-15 08:47:04.446339
2155	3	29	Transaction #155	2025-06-05	972.01	Auto-generated transaction entry #155	2025-06-15 08:47:04.446339
2156	3	28	Transaction #156	2025-06-13	537.85	Auto-generated transaction entry #156	2025-06-15 08:47:04.446339
2157	3	30	Transaction #157	2025-06-11	183.19	Auto-generated transaction entry #157	2025-06-15 08:47:04.446339
2158	3	28	Transaction #158	2025-06-03	68.15	Auto-generated transaction entry #158	2025-06-15 08:47:04.446339
2159	3	27	Transaction #159	2025-05-17	182.97	Auto-generated transaction entry #159	2025-06-15 08:47:04.446339
2160	3	30	Transaction #160	2025-06-09	293.72	Auto-generated transaction entry #160	2025-06-15 08:47:04.446339
2161	3	28	Transaction #161	2025-06-01	879.35	Auto-generated transaction entry #161	2025-06-15 08:47:04.446339
2162	3	28	Transaction #162	2025-05-23	820.45	Auto-generated transaction entry #162	2025-06-15 08:47:04.446339
2163	3	28	Transaction #163	2025-05-22	219.16	Auto-generated transaction entry #163	2025-06-15 08:47:04.446339
2164	3	30	Transaction #164	2025-06-06	636.20	Auto-generated transaction entry #164	2025-06-15 08:47:04.446339
2165	3	28	Transaction #165	2025-06-05	872.42	Auto-generated transaction entry #165	2025-06-15 08:47:04.446339
2166	3	29	Transaction #166	2025-06-14	810.60	Auto-generated transaction entry #166	2025-06-15 08:47:04.446339
2167	3	30	Transaction #167	2025-06-15	968.59	Auto-generated transaction entry #167	2025-06-15 08:47:04.446339
2168	3	30	Transaction #168	2025-05-21	592.90	Auto-generated transaction entry #168	2025-06-15 08:47:04.446339
2169	3	29	Transaction #169	2025-06-07	84.89	Auto-generated transaction entry #169	2025-06-15 08:47:04.446339
2170	3	28	Transaction #170	2025-06-03	350.53	Auto-generated transaction entry #170	2025-06-15 08:47:04.446339
2171	3	30	Transaction #171	2025-06-05	634.28	Auto-generated transaction entry #171	2025-06-15 08:47:04.446339
2172	3	28	Transaction #172	2025-05-22	675.20	Auto-generated transaction entry #172	2025-06-15 08:47:04.446339
2173	3	27	Transaction #173	2025-05-16	302.91	Auto-generated transaction entry #173	2025-06-15 08:47:04.446339
2174	3	27	Transaction #174	2025-05-28	831.44	Auto-generated transaction entry #174	2025-06-15 08:47:04.446339
2175	3	29	Transaction #175	2025-06-08	651.09	Auto-generated transaction entry #175	2025-06-15 08:47:04.446339
2176	3	28	Transaction #176	2025-06-14	122.64	Auto-generated transaction entry #176	2025-06-15 08:47:04.446339
2177	3	30	Transaction #177	2025-05-27	952.00	Auto-generated transaction entry #177	2025-06-15 08:47:04.446339
2178	3	30	Transaction #178	2025-06-08	818.34	Auto-generated transaction entry #178	2025-06-15 08:47:04.446339
2179	3	29	Transaction #179	2025-06-12	592.83	Auto-generated transaction entry #179	2025-06-15 08:47:04.446339
2180	3	30	Transaction #180	2025-06-04	334.64	Auto-generated transaction entry #180	2025-06-15 08:47:04.446339
2181	3	29	Transaction #181	2025-05-22	902.56	Auto-generated transaction entry #181	2025-06-15 08:47:04.446339
2182	3	30	Transaction #182	2025-06-02	449.12	Auto-generated transaction entry #182	2025-06-15 08:47:04.446339
2183	3	29	Transaction #183	2025-05-23	878.31	Auto-generated transaction entry #183	2025-06-15 08:47:04.446339
2184	3	30	Transaction #184	2025-05-20	80.57	Auto-generated transaction entry #184	2025-06-15 08:47:04.446339
2185	3	26	Transaction #185	2025-05-21	873.45	Auto-generated transaction entry #185	2025-06-15 08:47:04.446339
2186	3	29	Transaction #186	2025-06-06	240.24	Auto-generated transaction entry #186	2025-06-15 08:47:04.446339
2187	3	29	Transaction #187	2025-06-02	481.24	Auto-generated transaction entry #187	2025-06-15 08:47:04.446339
2188	3	28	Transaction #188	2025-06-08	321.50	Auto-generated transaction entry #188	2025-06-15 08:47:04.446339
2189	3	27	Transaction #189	2025-05-24	516.10	Auto-generated transaction entry #189	2025-06-15 08:47:04.446339
2190	3	28	Transaction #190	2025-06-07	121.09	Auto-generated transaction entry #190	2025-06-15 08:47:04.446339
2191	3	30	Transaction #191	2025-06-04	123.55	Auto-generated transaction entry #191	2025-06-15 08:47:04.446339
2192	3	26	Transaction #192	2025-06-12	875.51	Auto-generated transaction entry #192	2025-06-15 08:47:04.446339
2193	3	30	Transaction #193	2025-05-29	386.63	Auto-generated transaction entry #193	2025-06-15 08:47:04.446339
2194	3	27	Transaction #194	2025-05-23	505.47	Auto-generated transaction entry #194	2025-06-15 08:47:04.446339
2195	3	30	Transaction #195	2025-05-19	328.35	Auto-generated transaction entry #195	2025-06-15 08:47:04.446339
2196	3	28	Transaction #196	2025-06-12	406.42	Auto-generated transaction entry #196	2025-06-15 08:47:04.446339
2197	3	28	Transaction #197	2025-06-10	779.75	Auto-generated transaction entry #197	2025-06-15 08:47:04.446339
2198	3	26	Transaction #198	2025-06-05	730.55	Auto-generated transaction entry #198	2025-06-15 08:47:04.446339
2199	3	26	Transaction #199	2025-05-29	862.07	Auto-generated transaction entry #199	2025-06-15 08:47:04.446339
2200	3	28	Transaction #200	2025-05-19	579.26	Auto-generated transaction entry #200	2025-06-15 08:47:04.446339
2201	3	28	Transaction #201	2025-05-20	435.10	Auto-generated transaction entry #201	2025-06-15 08:47:04.446339
2202	3	26	Transaction #202	2025-05-31	715.43	Auto-generated transaction entry #202	2025-06-15 08:47:04.446339
2203	3	30	Transaction #203	2025-06-08	312.31	Auto-generated transaction entry #203	2025-06-15 08:47:04.446339
2204	3	28	Transaction #204	2025-06-10	873.48	Auto-generated transaction entry #204	2025-06-15 08:47:04.446339
2205	3	26	Transaction #205	2025-06-04	759.02	Auto-generated transaction entry #205	2025-06-15 08:47:04.446339
2206	3	28	Transaction #206	2025-06-11	640.38	Auto-generated transaction entry #206	2025-06-15 08:47:04.446339
2207	3	27	Transaction #207	2025-05-22	112.47	Auto-generated transaction entry #207	2025-06-15 08:47:04.446339
2208	3	30	Transaction #208	2025-05-22	156.43	Auto-generated transaction entry #208	2025-06-15 08:47:04.446339
2209	3	29	Transaction #209	2025-06-10	63.50	Auto-generated transaction entry #209	2025-06-15 08:47:04.446339
2210	3	27	Transaction #210	2025-05-18	854.92	Auto-generated transaction entry #210	2025-06-15 08:47:04.446339
2211	3	29	Transaction #211	2025-05-17	450.48	Auto-generated transaction entry #211	2025-06-15 08:47:04.446339
2212	3	30	Transaction #212	2025-05-31	184.25	Auto-generated transaction entry #212	2025-06-15 08:47:04.446339
2213	3	26	Transaction #213	2025-06-07	507.69	Auto-generated transaction entry #213	2025-06-15 08:47:04.446339
2214	3	29	Transaction #214	2025-05-28	270.29	Auto-generated transaction entry #214	2025-06-15 08:47:04.446339
2215	3	26	Transaction #215	2025-05-29	668.87	Auto-generated transaction entry #215	2025-06-15 08:47:04.446339
2216	3	29	Transaction #216	2025-05-25	405.35	Auto-generated transaction entry #216	2025-06-15 08:47:04.446339
2217	3	28	Transaction #217	2025-05-20	441.47	Auto-generated transaction entry #217	2025-06-15 08:47:04.446339
2218	3	29	Transaction #218	2025-06-15	714.91	Auto-generated transaction entry #218	2025-06-15 08:47:04.446339
2219	3	26	Transaction #219	2025-05-19	82.62	Auto-generated transaction entry #219	2025-06-15 08:47:04.446339
2220	3	28	Transaction #220	2025-06-10	124.22	Auto-generated transaction entry #220	2025-06-15 08:47:04.446339
2221	3	26	Transaction #221	2025-05-17	695.31	Auto-generated transaction entry #221	2025-06-15 08:47:04.446339
2222	3	26	Transaction #222	2025-05-28	658.86	Auto-generated transaction entry #222	2025-06-15 08:47:04.446339
2223	3	26	Transaction #223	2025-05-25	631.70	Auto-generated transaction entry #223	2025-06-15 08:47:04.446339
2224	3	27	Transaction #224	2025-06-08	259.81	Auto-generated transaction entry #224	2025-06-15 08:47:04.446339
2225	3	30	Transaction #225	2025-06-07	560.46	Auto-generated transaction entry #225	2025-06-15 08:47:04.446339
2226	3	28	Transaction #226	2025-06-07	958.31	Auto-generated transaction entry #226	2025-06-15 08:47:04.446339
2227	3	27	Transaction #227	2025-05-20	846.59	Auto-generated transaction entry #227	2025-06-15 08:47:04.446339
2228	3	26	Transaction #228	2025-05-27	848.46	Auto-generated transaction entry #228	2025-06-15 08:47:04.446339
2229	3	26	Transaction #229	2025-05-31	471.64	Auto-generated transaction entry #229	2025-06-15 08:47:04.446339
2230	3	29	Transaction #230	2025-06-01	928.98	Auto-generated transaction entry #230	2025-06-15 08:47:04.446339
2231	3	30	Transaction #231	2025-05-30	113.95	Auto-generated transaction entry #231	2025-06-15 08:47:04.446339
2232	3	26	Transaction #232	2025-06-13	498.15	Auto-generated transaction entry #232	2025-06-15 08:47:04.446339
2233	3	30	Transaction #233	2025-05-21	866.13	Auto-generated transaction entry #233	2025-06-15 08:47:04.446339
2234	3	29	Transaction #234	2025-05-30	763.46	Auto-generated transaction entry #234	2025-06-15 08:47:04.446339
2235	3	29	Transaction #235	2025-05-18	988.35	Auto-generated transaction entry #235	2025-06-15 08:47:04.446339
2236	3	28	Transaction #236	2025-05-29	284.11	Auto-generated transaction entry #236	2025-06-15 08:47:04.446339
2237	3	27	Transaction #237	2025-06-09	436.81	Auto-generated transaction entry #237	2025-06-15 08:47:04.446339
2238	3	30	Transaction #238	2025-05-29	890.33	Auto-generated transaction entry #238	2025-06-15 08:47:04.446339
2239	3	28	Transaction #239	2025-05-28	467.91	Auto-generated transaction entry #239	2025-06-15 08:47:04.446339
2240	3	29	Transaction #240	2025-06-04	468.65	Auto-generated transaction entry #240	2025-06-15 08:47:04.446339
2241	3	28	Transaction #241	2025-05-19	617.11	Auto-generated transaction entry #241	2025-06-15 08:47:04.446339
2242	3	28	Transaction #242	2025-06-05	839.41	Auto-generated transaction entry #242	2025-06-15 08:47:04.446339
2243	3	29	Transaction #243	2025-06-04	76.40	Auto-generated transaction entry #243	2025-06-15 08:47:04.446339
2244	3	26	Transaction #244	2025-06-08	569.67	Auto-generated transaction entry #244	2025-06-15 08:47:04.446339
2245	3	27	Transaction #245	2025-06-14	705.05	Auto-generated transaction entry #245	2025-06-15 08:47:04.446339
2246	3	29	Transaction #246	2025-06-02	456.30	Auto-generated transaction entry #246	2025-06-15 08:47:04.446339
2247	3	30	Transaction #247	2025-05-17	995.30	Auto-generated transaction entry #247	2025-06-15 08:47:04.446339
2248	3	28	Transaction #248	2025-06-09	990.88	Auto-generated transaction entry #248	2025-06-15 08:47:04.446339
2249	3	26	Transaction #249	2025-06-02	427.82	Auto-generated transaction entry #249	2025-06-15 08:47:04.446339
2250	3	26	Transaction #250	2025-06-12	955.70	Auto-generated transaction entry #250	2025-06-15 08:47:04.446339
2251	3	28	Transaction #251	2025-05-29	914.95	Auto-generated transaction entry #251	2025-06-15 08:47:04.446339
2252	3	30	Transaction #252	2025-05-22	459.43	Auto-generated transaction entry #252	2025-06-15 08:47:04.446339
2253	3	29	Transaction #253	2025-06-13	531.28	Auto-generated transaction entry #253	2025-06-15 08:47:04.446339
2254	3	28	Transaction #254	2025-06-08	387.50	Auto-generated transaction entry #254	2025-06-15 08:47:04.446339
2255	3	29	Transaction #255	2025-06-01	505.93	Auto-generated transaction entry #255	2025-06-15 08:47:04.446339
2256	3	26	Transaction #256	2025-06-11	733.42	Auto-generated transaction entry #256	2025-06-15 08:47:04.446339
2257	3	27	Transaction #257	2025-06-02	110.75	Auto-generated transaction entry #257	2025-06-15 08:47:04.446339
2258	3	29	Transaction #258	2025-06-03	940.00	Auto-generated transaction entry #258	2025-06-15 08:47:04.446339
2259	3	29	Transaction #259	2025-05-30	978.31	Auto-generated transaction entry #259	2025-06-15 08:47:04.446339
2260	3	27	Transaction #260	2025-06-14	993.63	Auto-generated transaction entry #260	2025-06-15 08:47:04.446339
2261	3	29	Transaction #261	2025-05-29	496.83	Auto-generated transaction entry #261	2025-06-15 08:47:04.446339
2262	3	30	Transaction #262	2025-05-18	726.90	Auto-generated transaction entry #262	2025-06-15 08:47:04.446339
2263	3	28	Transaction #263	2025-05-29	684.68	Auto-generated transaction entry #263	2025-06-15 08:47:04.446339
2264	3	26	Transaction #264	2025-06-11	663.50	Auto-generated transaction entry #264	2025-06-15 08:47:04.446339
2265	3	26	Transaction #265	2025-05-26	281.84	Auto-generated transaction entry #265	2025-06-15 08:47:04.446339
2266	3	30	Transaction #266	2025-06-08	995.90	Auto-generated transaction entry #266	2025-06-15 08:47:04.446339
2267	3	28	Transaction #267	2025-05-16	363.30	Auto-generated transaction entry #267	2025-06-15 08:47:04.446339
2268	3	26	Transaction #268	2025-05-22	747.40	Auto-generated transaction entry #268	2025-06-15 08:47:04.446339
2269	3	30	Transaction #269	2025-05-21	967.99	Auto-generated transaction entry #269	2025-06-15 08:47:04.446339
2270	3	28	Transaction #270	2025-06-08	325.71	Auto-generated transaction entry #270	2025-06-15 08:47:04.446339
2271	3	28	Transaction #271	2025-05-24	917.95	Auto-generated transaction entry #271	2025-06-15 08:47:04.446339
2272	3	28	Transaction #272	2025-05-18	245.28	Auto-generated transaction entry #272	2025-06-15 08:47:04.446339
2273	3	30	Transaction #273	2025-06-02	646.28	Auto-generated transaction entry #273	2025-06-15 08:47:04.446339
2274	3	30	Transaction #274	2025-05-20	583.32	Auto-generated transaction entry #274	2025-06-15 08:47:04.446339
2275	3	27	Transaction #275	2025-06-05	450.35	Auto-generated transaction entry #275	2025-06-15 08:47:04.446339
2276	3	26	Transaction #276	2025-05-19	525.99	Auto-generated transaction entry #276	2025-06-15 08:47:04.446339
2277	3	27	Transaction #277	2025-06-07	260.98	Auto-generated transaction entry #277	2025-06-15 08:47:04.446339
2278	3	28	Transaction #278	2025-06-08	74.86	Auto-generated transaction entry #278	2025-06-15 08:47:04.446339
2279	3	26	Transaction #279	2025-05-31	911.35	Auto-generated transaction entry #279	2025-06-15 08:47:04.446339
2280	3	26	Transaction #280	2025-05-18	627.52	Auto-generated transaction entry #280	2025-06-15 08:47:04.446339
2281	3	27	Transaction #281	2025-06-06	573.57	Auto-generated transaction entry #281	2025-06-15 08:47:04.446339
2282	3	29	Transaction #282	2025-05-29	999.29	Auto-generated transaction entry #282	2025-06-15 08:47:04.446339
2283	3	28	Transaction #283	2025-06-13	632.12	Auto-generated transaction entry #283	2025-06-15 08:47:04.446339
2284	3	27	Transaction #284	2025-05-23	665.88	Auto-generated transaction entry #284	2025-06-15 08:47:04.446339
2285	3	30	Transaction #285	2025-06-11	741.98	Auto-generated transaction entry #285	2025-06-15 08:47:04.446339
2286	3	26	Transaction #286	2025-05-31	947.31	Auto-generated transaction entry #286	2025-06-15 08:47:04.446339
2287	3	29	Transaction #287	2025-05-16	897.16	Auto-generated transaction entry #287	2025-06-15 08:47:04.446339
2288	3	28	Transaction #288	2025-06-14	494.11	Auto-generated transaction entry #288	2025-06-15 08:47:04.446339
2289	3	30	Transaction #289	2025-06-13	606.05	Auto-generated transaction entry #289	2025-06-15 08:47:04.446339
2290	3	28	Transaction #290	2025-06-12	439.23	Auto-generated transaction entry #290	2025-06-15 08:47:04.446339
2291	3	29	Transaction #291	2025-05-24	926.81	Auto-generated transaction entry #291	2025-06-15 08:47:04.446339
2292	3	30	Transaction #292	2025-06-01	817.50	Auto-generated transaction entry #292	2025-06-15 08:47:04.446339
2293	3	29	Transaction #293	2025-06-04	610.05	Auto-generated transaction entry #293	2025-06-15 08:47:04.446339
2294	3	26	Transaction #294	2025-06-13	291.05	Auto-generated transaction entry #294	2025-06-15 08:47:04.446339
2295	3	29	Transaction #295	2025-05-17	422.07	Auto-generated transaction entry #295	2025-06-15 08:47:04.446339
2296	3	30	Transaction #296	2025-06-09	317.90	Auto-generated transaction entry #296	2025-06-15 08:47:04.446339
2297	3	29	Transaction #297	2025-05-27	557.27	Auto-generated transaction entry #297	2025-06-15 08:47:04.446339
2298	3	29	Transaction #298	2025-05-23	77.32	Auto-generated transaction entry #298	2025-06-15 08:47:04.446339
2299	3	28	Transaction #299	2025-06-04	974.48	Auto-generated transaction entry #299	2025-06-15 08:47:04.446339
2300	3	30	Transaction #300	2025-06-07	233.85	Auto-generated transaction entry #300	2025-06-15 08:47:04.446339
2301	3	27	Transaction #301	2025-05-27	589.29	Auto-generated transaction entry #301	2025-06-15 08:47:04.446339
2302	3	26	Transaction #302	2025-06-15	516.94	Auto-generated transaction entry #302	2025-06-15 08:47:04.446339
2303	3	30	Transaction #303	2025-06-02	180.14	Auto-generated transaction entry #303	2025-06-15 08:47:04.446339
2304	3	30	Transaction #304	2025-05-30	938.39	Auto-generated transaction entry #304	2025-06-15 08:47:04.446339
2305	3	29	Transaction #305	2025-06-03	436.28	Auto-generated transaction entry #305	2025-06-15 08:47:04.446339
2306	3	26	Transaction #306	2025-05-19	127.44	Auto-generated transaction entry #306	2025-06-15 08:47:04.446339
2307	3	26	Transaction #307	2025-05-18	327.83	Auto-generated transaction entry #307	2025-06-15 08:47:04.446339
2308	3	30	Transaction #308	2025-06-15	67.62	Auto-generated transaction entry #308	2025-06-15 08:47:04.446339
2309	3	26	Transaction #309	2025-05-20	545.13	Auto-generated transaction entry #309	2025-06-15 08:47:04.446339
2310	3	30	Transaction #310	2025-05-19	730.99	Auto-generated transaction entry #310	2025-06-15 08:47:04.446339
2311	3	26	Transaction #311	2025-05-21	308.25	Auto-generated transaction entry #311	2025-06-15 08:47:04.446339
2312	3	29	Transaction #312	2025-05-18	691.48	Auto-generated transaction entry #312	2025-06-15 08:47:04.446339
2313	3	29	Transaction #313	2025-06-09	235.82	Auto-generated transaction entry #313	2025-06-15 08:47:04.446339
2314	3	28	Transaction #314	2025-06-04	660.50	Auto-generated transaction entry #314	2025-06-15 08:47:04.446339
2315	3	29	Transaction #315	2025-05-18	148.25	Auto-generated transaction entry #315	2025-06-15 08:47:04.446339
2316	3	28	Transaction #316	2025-05-30	134.36	Auto-generated transaction entry #316	2025-06-15 08:47:04.446339
2317	3	28	Transaction #317	2025-05-22	294.66	Auto-generated transaction entry #317	2025-06-15 08:47:04.446339
2318	3	29	Transaction #318	2025-06-05	674.36	Auto-generated transaction entry #318	2025-06-15 08:47:04.446339
2319	3	26	Transaction #319	2025-05-17	658.89	Auto-generated transaction entry #319	2025-06-15 08:47:04.446339
2320	3	26	Transaction #320	2025-05-27	174.46	Auto-generated transaction entry #320	2025-06-15 08:47:04.446339
2321	3	26	Transaction #321	2025-05-16	693.56	Auto-generated transaction entry #321	2025-06-15 08:47:04.446339
2322	3	30	Transaction #322	2025-06-13	497.20	Auto-generated transaction entry #322	2025-06-15 08:47:04.446339
2323	3	28	Transaction #323	2025-05-20	437.62	Auto-generated transaction entry #323	2025-06-15 08:47:04.446339
2324	3	28	Transaction #324	2025-05-19	398.95	Auto-generated transaction entry #324	2025-06-15 08:47:04.446339
2325	3	26	Transaction #325	2025-06-01	905.91	Auto-generated transaction entry #325	2025-06-15 08:47:04.446339
2326	3	26	Transaction #326	2025-06-10	675.38	Auto-generated transaction entry #326	2025-06-15 08:47:04.446339
2327	3	27	Transaction #327	2025-05-25	887.38	Auto-generated transaction entry #327	2025-06-15 08:47:04.446339
2328	3	29	Transaction #328	2025-05-21	95.54	Auto-generated transaction entry #328	2025-06-15 08:47:04.446339
2329	3	26	Transaction #329	2025-06-10	155.69	Auto-generated transaction entry #329	2025-06-15 08:47:04.446339
2330	3	28	Transaction #330	2025-05-19	428.45	Auto-generated transaction entry #330	2025-06-15 08:47:04.446339
2331	3	29	Transaction #331	2025-06-10	732.89	Auto-generated transaction entry #331	2025-06-15 08:47:04.446339
2332	3	28	Transaction #332	2025-06-01	126.27	Auto-generated transaction entry #332	2025-06-15 08:47:04.446339
2333	3	27	Transaction #333	2025-06-07	920.24	Auto-generated transaction entry #333	2025-06-15 08:47:04.446339
2334	3	27	Transaction #334	2025-06-13	672.36	Auto-generated transaction entry #334	2025-06-15 08:47:04.446339
2335	3	29	Transaction #335	2025-06-11	203.97	Auto-generated transaction entry #335	2025-06-15 08:47:04.446339
2336	3	30	Transaction #336	2025-05-20	373.29	Auto-generated transaction entry #336	2025-06-15 08:47:04.446339
2337	3	30	Transaction #337	2025-06-05	436.21	Auto-generated transaction entry #337	2025-06-15 08:47:04.446339
2338	3	26	Transaction #338	2025-06-03	231.92	Auto-generated transaction entry #338	2025-06-15 08:47:04.446339
2339	3	27	Transaction #339	2025-05-19	136.62	Auto-generated transaction entry #339	2025-06-15 08:47:04.446339
2340	3	29	Transaction #340	2025-06-03	475.28	Auto-generated transaction entry #340	2025-06-15 08:47:04.446339
2341	3	29	Transaction #341	2025-06-08	328.84	Auto-generated transaction entry #341	2025-06-15 08:47:04.446339
2342	3	26	Transaction #342	2025-06-09	248.16	Auto-generated transaction entry #342	2025-06-15 08:47:04.446339
2343	3	27	Transaction #343	2025-06-09	297.24	Auto-generated transaction entry #343	2025-06-15 08:47:04.446339
2344	3	30	Transaction #344	2025-06-01	491.42	Auto-generated transaction entry #344	2025-06-15 08:47:04.446339
2345	3	28	Transaction #345	2025-06-06	89.31	Auto-generated transaction entry #345	2025-06-15 08:47:04.446339
2346	3	28	Transaction #346	2025-06-03	592.91	Auto-generated transaction entry #346	2025-06-15 08:47:04.446339
2347	3	28	Transaction #347	2025-05-28	921.94	Auto-generated transaction entry #347	2025-06-15 08:47:04.446339
2348	3	26	Transaction #348	2025-06-02	196.03	Auto-generated transaction entry #348	2025-06-15 08:47:04.446339
2349	3	30	Transaction #349	2025-05-30	814.43	Auto-generated transaction entry #349	2025-06-15 08:47:04.446339
2350	3	27	Transaction #350	2025-05-30	611.34	Auto-generated transaction entry #350	2025-06-15 08:47:04.446339
2351	3	28	Transaction #351	2025-06-11	666.60	Auto-generated transaction entry #351	2025-06-15 08:47:04.446339
2352	3	26	Transaction #352	2025-05-18	457.64	Auto-generated transaction entry #352	2025-06-15 08:47:04.446339
2353	3	27	Transaction #353	2025-05-24	360.40	Auto-generated transaction entry #353	2025-06-15 08:47:04.446339
2354	3	30	Transaction #354	2025-06-06	791.78	Auto-generated transaction entry #354	2025-06-15 08:47:04.446339
2355	3	26	Transaction #355	2025-06-14	808.16	Auto-generated transaction entry #355	2025-06-15 08:47:04.446339
2356	3	28	Transaction #356	2025-05-26	633.47	Auto-generated transaction entry #356	2025-06-15 08:47:04.446339
2357	3	26	Transaction #357	2025-06-10	506.45	Auto-generated transaction entry #357	2025-06-15 08:47:04.446339
2358	3	27	Transaction #358	2025-05-28	948.31	Auto-generated transaction entry #358	2025-06-15 08:47:04.446339
2359	3	26	Transaction #359	2025-06-08	590.38	Auto-generated transaction entry #359	2025-06-15 08:47:04.446339
2360	3	27	Transaction #360	2025-06-05	530.76	Auto-generated transaction entry #360	2025-06-15 08:47:04.446339
2361	3	30	Transaction #361	2025-06-08	558.45	Auto-generated transaction entry #361	2025-06-15 08:47:04.446339
2362	3	30	Transaction #362	2025-06-05	393.35	Auto-generated transaction entry #362	2025-06-15 08:47:04.446339
2363	3	27	Transaction #363	2025-06-02	265.85	Auto-generated transaction entry #363	2025-06-15 08:47:04.446339
2364	3	26	Transaction #364	2025-06-14	714.81	Auto-generated transaction entry #364	2025-06-15 08:47:04.446339
2365	3	27	Transaction #365	2025-06-01	244.18	Auto-generated transaction entry #365	2025-06-15 08:47:04.446339
2366	3	29	Transaction #366	2025-05-18	510.64	Auto-generated transaction entry #366	2025-06-15 08:47:04.446339
2367	3	28	Transaction #367	2025-05-30	285.22	Auto-generated transaction entry #367	2025-06-15 08:47:04.446339
2368	3	30	Transaction #368	2025-06-13	386.07	Auto-generated transaction entry #368	2025-06-15 08:47:04.446339
2369	3	30	Transaction #369	2025-06-04	207.31	Auto-generated transaction entry #369	2025-06-15 08:47:04.446339
2370	3	30	Transaction #370	2025-06-12	944.68	Auto-generated transaction entry #370	2025-06-15 08:47:04.446339
2371	3	27	Transaction #371	2025-05-19	409.51	Auto-generated transaction entry #371	2025-06-15 08:47:04.446339
2372	3	30	Transaction #372	2025-05-23	782.32	Auto-generated transaction entry #372	2025-06-15 08:47:04.446339
2373	3	27	Transaction #373	2025-05-20	450.35	Auto-generated transaction entry #373	2025-06-15 08:47:04.446339
2374	3	26	Transaction #374	2025-06-08	251.86	Auto-generated transaction entry #374	2025-06-15 08:47:04.446339
2375	3	29	Transaction #375	2025-06-05	777.23	Auto-generated transaction entry #375	2025-06-15 08:47:04.446339
2376	3	26	Transaction #376	2025-06-09	882.86	Auto-generated transaction entry #376	2025-06-15 08:47:04.446339
2377	3	29	Transaction #377	2025-05-19	909.14	Auto-generated transaction entry #377	2025-06-15 08:47:04.446339
2378	3	30	Transaction #378	2025-06-11	629.88	Auto-generated transaction entry #378	2025-06-15 08:47:04.446339
2379	3	28	Transaction #379	2025-05-31	877.47	Auto-generated transaction entry #379	2025-06-15 08:47:04.446339
2380	3	30	Transaction #380	2025-05-20	299.48	Auto-generated transaction entry #380	2025-06-15 08:47:04.446339
2381	3	27	Transaction #381	2025-06-15	799.32	Auto-generated transaction entry #381	2025-06-15 08:47:04.446339
2382	3	27	Transaction #382	2025-05-19	56.65	Auto-generated transaction entry #382	2025-06-15 08:47:04.446339
2383	3	27	Transaction #383	2025-05-25	895.43	Auto-generated transaction entry #383	2025-06-15 08:47:04.446339
2384	3	27	Transaction #384	2025-05-19	501.56	Auto-generated transaction entry #384	2025-06-15 08:47:04.446339
2385	3	28	Transaction #385	2025-05-25	931.46	Auto-generated transaction entry #385	2025-06-15 08:47:04.446339
2386	3	28	Transaction #386	2025-06-01	201.75	Auto-generated transaction entry #386	2025-06-15 08:47:04.446339
2387	3	28	Transaction #387	2025-06-05	80.95	Auto-generated transaction entry #387	2025-06-15 08:47:04.446339
2388	3	30	Transaction #388	2025-05-26	365.46	Auto-generated transaction entry #388	2025-06-15 08:47:04.446339
2389	3	26	Transaction #389	2025-06-02	972.65	Auto-generated transaction entry #389	2025-06-15 08:47:04.446339
2390	3	26	Transaction #390	2025-05-20	478.06	Auto-generated transaction entry #390	2025-06-15 08:47:04.446339
2391	3	28	Transaction #391	2025-05-26	631.02	Auto-generated transaction entry #391	2025-06-15 08:47:04.446339
2392	3	29	Transaction #392	2025-05-27	107.42	Auto-generated transaction entry #392	2025-06-15 08:47:04.446339
2393	3	27	Transaction #393	2025-05-23	868.95	Auto-generated transaction entry #393	2025-06-15 08:47:04.446339
2394	3	27	Transaction #394	2025-06-03	156.86	Auto-generated transaction entry #394	2025-06-15 08:47:04.446339
2395	3	30	Transaction #395	2025-06-14	926.01	Auto-generated transaction entry #395	2025-06-15 08:47:04.446339
2396	3	26	Transaction #396	2025-06-04	530.81	Auto-generated transaction entry #396	2025-06-15 08:47:04.446339
2397	3	27	Transaction #397	2025-06-08	523.84	Auto-generated transaction entry #397	2025-06-15 08:47:04.446339
2398	3	29	Transaction #398	2025-05-19	737.58	Auto-generated transaction entry #398	2025-06-15 08:47:04.446339
2399	3	29	Transaction #399	2025-05-30	408.86	Auto-generated transaction entry #399	2025-06-15 08:47:04.446339
2400	3	26	Transaction #400	2025-05-26	431.62	Auto-generated transaction entry #400	2025-06-15 08:47:04.446339
2401	3	26	Transaction #401	2025-06-02	850.95	Auto-generated transaction entry #401	2025-06-15 08:47:04.446339
2402	3	27	Transaction #402	2025-06-12	998.27	Auto-generated transaction entry #402	2025-06-15 08:47:04.446339
2403	3	28	Transaction #403	2025-05-27	220.53	Auto-generated transaction entry #403	2025-06-15 08:47:04.446339
2404	3	29	Transaction #404	2025-06-08	389.63	Auto-generated transaction entry #404	2025-06-15 08:47:04.446339
2405	3	28	Transaction #405	2025-06-14	688.97	Auto-generated transaction entry #405	2025-06-15 08:47:04.446339
2406	3	27	Transaction #406	2025-06-07	517.04	Auto-generated transaction entry #406	2025-06-15 08:47:04.446339
2407	3	26	Transaction #407	2025-05-22	240.00	Auto-generated transaction entry #407	2025-06-15 08:47:04.446339
2408	3	26	Transaction #408	2025-05-21	470.06	Auto-generated transaction entry #408	2025-06-15 08:47:04.446339
2409	3	27	Transaction #409	2025-05-26	698.32	Auto-generated transaction entry #409	2025-06-15 08:47:04.446339
2410	3	27	Transaction #410	2025-06-03	57.27	Auto-generated transaction entry #410	2025-06-15 08:47:04.446339
2411	3	30	Transaction #411	2025-06-07	575.93	Auto-generated transaction entry #411	2025-06-15 08:47:04.446339
2412	3	27	Transaction #412	2025-06-15	166.47	Auto-generated transaction entry #412	2025-06-15 08:47:04.446339
2413	3	27	Transaction #413	2025-06-12	953.12	Auto-generated transaction entry #413	2025-06-15 08:47:04.446339
2414	3	28	Transaction #414	2025-05-31	216.43	Auto-generated transaction entry #414	2025-06-15 08:47:04.446339
2415	3	29	Transaction #415	2025-06-12	986.92	Auto-generated transaction entry #415	2025-06-15 08:47:04.446339
2416	3	28	Transaction #416	2025-05-21	516.23	Auto-generated transaction entry #416	2025-06-15 08:47:04.446339
2417	3	27	Transaction #417	2025-05-25	606.60	Auto-generated transaction entry #417	2025-06-15 08:47:04.446339
2418	3	27	Transaction #418	2025-05-29	424.87	Auto-generated transaction entry #418	2025-06-15 08:47:04.446339
2419	3	27	Transaction #419	2025-06-04	919.49	Auto-generated transaction entry #419	2025-06-15 08:47:04.446339
2420	3	27	Transaction #420	2025-06-12	518.93	Auto-generated transaction entry #420	2025-06-15 08:47:04.446339
2421	3	26	Transaction #421	2025-05-24	144.65	Auto-generated transaction entry #421	2025-06-15 08:47:04.446339
2422	3	29	Transaction #422	2025-06-06	680.11	Auto-generated transaction entry #422	2025-06-15 08:47:04.446339
2423	3	27	Transaction #423	2025-05-22	788.75	Auto-generated transaction entry #423	2025-06-15 08:47:04.446339
2424	3	26	Transaction #424	2025-06-04	91.27	Auto-generated transaction entry #424	2025-06-15 08:47:04.446339
2425	3	29	Transaction #425	2025-06-02	340.40	Auto-generated transaction entry #425	2025-06-15 08:47:04.446339
2426	3	30	Transaction #426	2025-05-25	162.71	Auto-generated transaction entry #426	2025-06-15 08:47:04.446339
2427	3	28	Transaction #427	2025-05-27	584.22	Auto-generated transaction entry #427	2025-06-15 08:47:04.446339
2428	3	27	Transaction #428	2025-06-06	124.91	Auto-generated transaction entry #428	2025-06-15 08:47:04.446339
2429	3	28	Transaction #429	2025-06-14	544.83	Auto-generated transaction entry #429	2025-06-15 08:47:04.446339
2430	3	28	Transaction #430	2025-06-02	363.88	Auto-generated transaction entry #430	2025-06-15 08:47:04.446339
2431	3	27	Transaction #431	2025-06-08	801.09	Auto-generated transaction entry #431	2025-06-15 08:47:04.446339
2432	3	28	Transaction #432	2025-06-03	303.85	Auto-generated transaction entry #432	2025-06-15 08:47:04.446339
2433	3	29	Transaction #433	2025-05-26	203.68	Auto-generated transaction entry #433	2025-06-15 08:47:04.446339
2434	3	27	Transaction #434	2025-05-24	160.68	Auto-generated transaction entry #434	2025-06-15 08:47:04.446339
2435	3	30	Transaction #435	2025-05-24	961.23	Auto-generated transaction entry #435	2025-06-15 08:47:04.446339
2436	3	27	Transaction #436	2025-05-25	802.57	Auto-generated transaction entry #436	2025-06-15 08:47:04.446339
2437	3	27	Transaction #437	2025-05-23	314.67	Auto-generated transaction entry #437	2025-06-15 08:47:04.446339
2438	3	26	Transaction #438	2025-05-25	625.19	Auto-generated transaction entry #438	2025-06-15 08:47:04.446339
2439	3	28	Transaction #439	2025-06-10	650.91	Auto-generated transaction entry #439	2025-06-15 08:47:04.446339
2440	3	26	Transaction #440	2025-05-21	648.13	Auto-generated transaction entry #440	2025-06-15 08:47:04.446339
2441	3	28	Transaction #441	2025-06-04	744.82	Auto-generated transaction entry #441	2025-06-15 08:47:04.446339
2442	3	30	Transaction #442	2025-05-19	489.88	Auto-generated transaction entry #442	2025-06-15 08:47:04.446339
2443	3	30	Transaction #443	2025-05-26	457.95	Auto-generated transaction entry #443	2025-06-15 08:47:04.446339
2444	3	29	Transaction #444	2025-06-03	727.99	Auto-generated transaction entry #444	2025-06-15 08:47:04.446339
2445	3	30	Transaction #445	2025-05-19	799.44	Auto-generated transaction entry #445	2025-06-15 08:47:04.446339
2446	3	27	Transaction #446	2025-05-31	806.19	Auto-generated transaction entry #446	2025-06-15 08:47:04.446339
2447	3	27	Transaction #447	2025-06-15	417.79	Auto-generated transaction entry #447	2025-06-15 08:47:04.446339
2448	3	30	Transaction #448	2025-06-12	823.17	Auto-generated transaction entry #448	2025-06-15 08:47:04.446339
2449	3	26	Transaction #449	2025-05-16	514.36	Auto-generated transaction entry #449	2025-06-15 08:47:04.446339
2450	3	26	Transaction #450	2025-06-02	799.44	Auto-generated transaction entry #450	2025-06-15 08:47:04.446339
2451	3	26	Transaction #451	2025-05-25	587.90	Auto-generated transaction entry #451	2025-06-15 08:47:04.446339
2452	3	29	Transaction #452	2025-06-06	804.63	Auto-generated transaction entry #452	2025-06-15 08:47:04.446339
2453	3	29	Transaction #453	2025-05-27	919.57	Auto-generated transaction entry #453	2025-06-15 08:47:04.446339
2454	3	30	Transaction #454	2025-06-12	751.93	Auto-generated transaction entry #454	2025-06-15 08:47:04.446339
2455	3	27	Transaction #455	2025-05-27	633.34	Auto-generated transaction entry #455	2025-06-15 08:47:04.446339
2456	3	26	Transaction #456	2025-05-23	155.64	Auto-generated transaction entry #456	2025-06-15 08:47:04.446339
2457	3	26	Transaction #457	2025-06-10	68.52	Auto-generated transaction entry #457	2025-06-15 08:47:04.446339
2458	3	26	Transaction #458	2025-05-29	801.88	Auto-generated transaction entry #458	2025-06-15 08:47:04.446339
2459	3	27	Transaction #459	2025-06-07	959.68	Auto-generated transaction entry #459	2025-06-15 08:47:04.446339
2460	3	29	Transaction #460	2025-06-02	436.56	Auto-generated transaction entry #460	2025-06-15 08:47:04.446339
2461	3	28	Transaction #461	2025-05-28	109.20	Auto-generated transaction entry #461	2025-06-15 08:47:04.446339
2462	3	28	Transaction #462	2025-06-05	60.51	Auto-generated transaction entry #462	2025-06-15 08:47:04.446339
2463	3	29	Transaction #463	2025-06-07	370.10	Auto-generated transaction entry #463	2025-06-15 08:47:04.446339
2464	3	30	Transaction #464	2025-06-13	379.09	Auto-generated transaction entry #464	2025-06-15 08:47:04.446339
2465	3	30	Transaction #465	2025-06-07	330.91	Auto-generated transaction entry #465	2025-06-15 08:47:04.446339
2466	3	29	Transaction #466	2025-05-24	616.42	Auto-generated transaction entry #466	2025-06-15 08:47:04.446339
2467	3	26	Transaction #467	2025-06-13	776.64	Auto-generated transaction entry #467	2025-06-15 08:47:04.446339
2468	3	27	Transaction #468	2025-06-07	812.65	Auto-generated transaction entry #468	2025-06-15 08:47:04.446339
2469	3	30	Transaction #469	2025-05-23	103.39	Auto-generated transaction entry #469	2025-06-15 08:47:04.446339
2470	3	28	Transaction #470	2025-05-16	112.08	Auto-generated transaction entry #470	2025-06-15 08:47:04.446339
2471	3	27	Transaction #471	2025-06-15	564.10	Auto-generated transaction entry #471	2025-06-15 08:47:04.446339
2472	3	28	Transaction #472	2025-05-18	755.68	Auto-generated transaction entry #472	2025-06-15 08:47:04.446339
2473	3	26	Transaction #473	2025-06-07	441.94	Auto-generated transaction entry #473	2025-06-15 08:47:04.446339
2474	3	30	Transaction #474	2025-06-06	624.58	Auto-generated transaction entry #474	2025-06-15 08:47:04.446339
2475	3	29	Transaction #475	2025-06-02	93.65	Auto-generated transaction entry #475	2025-06-15 08:47:04.446339
2476	3	30	Transaction #476	2025-06-05	165.05	Auto-generated transaction entry #476	2025-06-15 08:47:04.446339
2477	3	28	Transaction #477	2025-06-04	632.18	Auto-generated transaction entry #477	2025-06-15 08:47:04.446339
2478	3	28	Transaction #478	2025-05-30	543.17	Auto-generated transaction entry #478	2025-06-15 08:47:04.446339
2479	3	28	Transaction #479	2025-06-05	334.96	Auto-generated transaction entry #479	2025-06-15 08:47:04.446339
2480	3	29	Transaction #480	2025-06-14	653.95	Auto-generated transaction entry #480	2025-06-15 08:47:04.446339
2481	3	28	Transaction #481	2025-05-18	685.34	Auto-generated transaction entry #481	2025-06-15 08:47:04.446339
2482	3	27	Transaction #482	2025-05-19	425.29	Auto-generated transaction entry #482	2025-06-15 08:47:04.446339
2483	3	29	Transaction #483	2025-05-28	98.50	Auto-generated transaction entry #483	2025-06-15 08:47:04.446339
2484	3	27	Transaction #484	2025-06-01	162.98	Auto-generated transaction entry #484	2025-06-15 08:47:04.446339
2485	3	28	Transaction #485	2025-05-23	869.93	Auto-generated transaction entry #485	2025-06-15 08:47:04.446339
2486	3	27	Transaction #486	2025-06-02	767.49	Auto-generated transaction entry #486	2025-06-15 08:47:04.446339
2487	3	28	Transaction #487	2025-06-09	495.11	Auto-generated transaction entry #487	2025-06-15 08:47:04.446339
2488	3	26	Transaction #488	2025-06-05	429.88	Auto-generated transaction entry #488	2025-06-15 08:47:04.446339
2489	3	27	Transaction #489	2025-06-05	698.96	Auto-generated transaction entry #489	2025-06-15 08:47:04.446339
2490	3	26	Transaction #490	2025-06-04	979.35	Auto-generated transaction entry #490	2025-06-15 08:47:04.446339
2491	3	26	Transaction #491	2025-05-25	982.88	Auto-generated transaction entry #491	2025-06-15 08:47:04.446339
2492	3	27	Transaction #492	2025-05-27	685.36	Auto-generated transaction entry #492	2025-06-15 08:47:04.446339
2493	3	29	Transaction #493	2025-05-28	780.23	Auto-generated transaction entry #493	2025-06-15 08:47:04.446339
2494	3	28	Transaction #494	2025-06-02	56.55	Auto-generated transaction entry #494	2025-06-15 08:47:04.446339
2495	3	30	Transaction #495	2025-05-17	716.82	Auto-generated transaction entry #495	2025-06-15 08:47:04.446339
2496	3	29	Transaction #496	2025-06-01	989.19	Auto-generated transaction entry #496	2025-06-15 08:47:04.446339
2497	3	30	Transaction #497	2025-06-15	53.05	Auto-generated transaction entry #497	2025-06-15 08:47:04.446339
2498	3	26	Transaction #498	2025-05-26	504.64	Auto-generated transaction entry #498	2025-06-15 08:47:04.446339
2499	3	27	Transaction #499	2025-05-22	302.03	Auto-generated transaction entry #499	2025-06-15 08:47:04.446339
2500	3	30	Transaction #500	2025-05-27	542.60	Auto-generated transaction entry #500	2025-06-15 08:47:04.446339
2501	3	22	Transaction #1	2025-06-01	861.05	Auto-generated transaction entry #1	2025-06-15 08:47:11.439519
2502	3	25	Transaction #2	2025-06-06	437.44	Auto-generated transaction entry #2	2025-06-15 08:47:11.439519
2503	3	21	Transaction #3	2025-05-22	918.42	Auto-generated transaction entry #3	2025-06-15 08:47:11.439519
2504	3	21	Transaction #4	2025-05-22	84.24	Auto-generated transaction entry #4	2025-06-15 08:47:11.439519
2505	3	22	Transaction #5	2025-06-14	208.95	Auto-generated transaction entry #5	2025-06-15 08:47:11.439519
2506	3	25	Transaction #6	2025-06-12	992.37	Auto-generated transaction entry #6	2025-06-15 08:47:11.439519
2507	3	25	Transaction #7	2025-05-18	247.27	Auto-generated transaction entry #7	2025-06-15 08:47:11.439519
2508	3	21	Transaction #8	2025-05-21	801.17	Auto-generated transaction entry #8	2025-06-15 08:47:11.439519
2509	3	23	Transaction #9	2025-05-18	356.15	Auto-generated transaction entry #9	2025-06-15 08:47:11.439519
2510	3	21	Transaction #10	2025-06-02	891.13	Auto-generated transaction entry #10	2025-06-15 08:47:11.439519
2511	3	22	Transaction #11	2025-05-21	973.14	Auto-generated transaction entry #11	2025-06-15 08:47:11.439519
2512	3	23	Transaction #12	2025-05-22	216.50	Auto-generated transaction entry #12	2025-06-15 08:47:11.439519
2513	3	21	Transaction #13	2025-05-16	567.16	Auto-generated transaction entry #13	2025-06-15 08:47:11.439519
2514	3	21	Transaction #14	2025-06-07	158.66	Auto-generated transaction entry #14	2025-06-15 08:47:11.439519
2515	3	21	Transaction #15	2025-06-10	106.98	Auto-generated transaction entry #15	2025-06-15 08:47:11.439519
2516	3	25	Transaction #16	2025-05-31	428.45	Auto-generated transaction entry #16	2025-06-15 08:47:11.439519
2517	3	24	Transaction #17	2025-06-07	667.19	Auto-generated transaction entry #17	2025-06-15 08:47:11.439519
2518	3	21	Transaction #18	2025-06-04	893.79	Auto-generated transaction entry #18	2025-06-15 08:47:11.439519
2519	3	25	Transaction #19	2025-05-23	790.63	Auto-generated transaction entry #19	2025-06-15 08:47:11.439519
2520	3	22	Transaction #20	2025-05-20	451.02	Auto-generated transaction entry #20	2025-06-15 08:47:11.439519
2521	3	24	Transaction #21	2025-05-17	560.65	Auto-generated transaction entry #21	2025-06-15 08:47:11.439519
2522	3	25	Transaction #22	2025-05-20	483.34	Auto-generated transaction entry #22	2025-06-15 08:47:11.439519
2523	3	22	Transaction #23	2025-06-05	100.48	Auto-generated transaction entry #23	2025-06-15 08:47:11.439519
2524	3	24	Transaction #24	2025-06-11	834.80	Auto-generated transaction entry #24	2025-06-15 08:47:11.439519
2525	3	25	Transaction #25	2025-06-08	906.44	Auto-generated transaction entry #25	2025-06-15 08:47:11.439519
2526	3	21	Transaction #26	2025-06-08	67.76	Auto-generated transaction entry #26	2025-06-15 08:47:11.439519
2527	3	21	Transaction #27	2025-05-29	159.96	Auto-generated transaction entry #27	2025-06-15 08:47:11.439519
2528	3	23	Transaction #28	2025-06-06	315.69	Auto-generated transaction entry #28	2025-06-15 08:47:11.439519
2529	3	23	Transaction #29	2025-06-03	845.79	Auto-generated transaction entry #29	2025-06-15 08:47:11.439519
2530	3	25	Transaction #30	2025-05-28	118.59	Auto-generated transaction entry #30	2025-06-15 08:47:11.439519
2531	3	22	Transaction #31	2025-06-11	565.96	Auto-generated transaction entry #31	2025-06-15 08:47:11.439519
2532	3	22	Transaction #32	2025-05-17	812.48	Auto-generated transaction entry #32	2025-06-15 08:47:11.439519
2533	3	24	Transaction #33	2025-05-27	672.54	Auto-generated transaction entry #33	2025-06-15 08:47:11.439519
2534	3	24	Transaction #34	2025-05-17	332.53	Auto-generated transaction entry #34	2025-06-15 08:47:11.439519
2535	3	22	Transaction #35	2025-05-26	895.41	Auto-generated transaction entry #35	2025-06-15 08:47:11.439519
2536	3	21	Transaction #36	2025-05-25	897.97	Auto-generated transaction entry #36	2025-06-15 08:47:11.439519
2537	3	25	Transaction #37	2025-05-28	147.24	Auto-generated transaction entry #37	2025-06-15 08:47:11.439519
2538	3	25	Transaction #38	2025-06-11	388.49	Auto-generated transaction entry #38	2025-06-15 08:47:11.439519
2539	3	22	Transaction #39	2025-05-17	659.79	Auto-generated transaction entry #39	2025-06-15 08:47:11.439519
2540	3	23	Transaction #40	2025-06-07	368.95	Auto-generated transaction entry #40	2025-06-15 08:47:11.439519
2541	3	24	Transaction #41	2025-05-24	85.74	Auto-generated transaction entry #41	2025-06-15 08:47:11.439519
2542	3	24	Transaction #42	2025-05-27	957.95	Auto-generated transaction entry #42	2025-06-15 08:47:11.439519
2543	3	25	Transaction #43	2025-05-20	611.11	Auto-generated transaction entry #43	2025-06-15 08:47:11.439519
2544	3	25	Transaction #44	2025-05-27	947.93	Auto-generated transaction entry #44	2025-06-15 08:47:11.439519
2545	3	22	Transaction #45	2025-05-19	379.58	Auto-generated transaction entry #45	2025-06-15 08:47:11.439519
2546	3	22	Transaction #46	2025-05-20	361.91	Auto-generated transaction entry #46	2025-06-15 08:47:11.439519
2547	3	24	Transaction #47	2025-06-02	739.94	Auto-generated transaction entry #47	2025-06-15 08:47:11.439519
2548	3	21	Transaction #48	2025-06-12	277.70	Auto-generated transaction entry #48	2025-06-15 08:47:11.439519
2549	3	23	Transaction #49	2025-05-30	227.53	Auto-generated transaction entry #49	2025-06-15 08:47:11.439519
2550	3	25	Transaction #50	2025-06-06	335.80	Auto-generated transaction entry #50	2025-06-15 08:47:11.439519
2551	3	21	Transaction #51	2025-06-03	368.46	Auto-generated transaction entry #51	2025-06-15 08:47:11.439519
2552	3	23	Transaction #52	2025-05-25	513.08	Auto-generated transaction entry #52	2025-06-15 08:47:11.439519
2553	3	22	Transaction #53	2025-05-17	65.18	Auto-generated transaction entry #53	2025-06-15 08:47:11.439519
2554	3	24	Transaction #54	2025-06-04	159.02	Auto-generated transaction entry #54	2025-06-15 08:47:11.439519
2555	3	21	Transaction #55	2025-06-06	943.22	Auto-generated transaction entry #55	2025-06-15 08:47:11.439519
2556	3	25	Transaction #56	2025-06-13	434.04	Auto-generated transaction entry #56	2025-06-15 08:47:11.439519
2557	3	24	Transaction #57	2025-06-04	344.36	Auto-generated transaction entry #57	2025-06-15 08:47:11.439519
2558	3	24	Transaction #58	2025-05-26	221.79	Auto-generated transaction entry #58	2025-06-15 08:47:11.439519
2559	3	21	Transaction #59	2025-05-28	324.71	Auto-generated transaction entry #59	2025-06-15 08:47:11.439519
2560	3	24	Transaction #60	2025-06-07	277.18	Auto-generated transaction entry #60	2025-06-15 08:47:11.439519
2561	3	24	Transaction #61	2025-05-17	70.55	Auto-generated transaction entry #61	2025-06-15 08:47:11.439519
2562	3	21	Transaction #62	2025-06-04	977.20	Auto-generated transaction entry #62	2025-06-15 08:47:11.439519
2563	3	22	Transaction #63	2025-05-29	782.09	Auto-generated transaction entry #63	2025-06-15 08:47:11.439519
2564	3	23	Transaction #64	2025-06-09	862.82	Auto-generated transaction entry #64	2025-06-15 08:47:11.439519
2565	3	24	Transaction #65	2025-06-01	774.91	Auto-generated transaction entry #65	2025-06-15 08:47:11.439519
2566	3	25	Transaction #66	2025-05-29	791.19	Auto-generated transaction entry #66	2025-06-15 08:47:11.439519
2567	3	22	Transaction #67	2025-06-03	151.26	Auto-generated transaction entry #67	2025-06-15 08:47:11.439519
2568	3	22	Transaction #68	2025-06-03	668.18	Auto-generated transaction entry #68	2025-06-15 08:47:11.439519
2569	3	23	Transaction #69	2025-05-29	293.68	Auto-generated transaction entry #69	2025-06-15 08:47:11.439519
2570	3	25	Transaction #70	2025-05-29	69.70	Auto-generated transaction entry #70	2025-06-15 08:47:11.439519
2571	3	22	Transaction #71	2025-05-19	843.19	Auto-generated transaction entry #71	2025-06-15 08:47:11.439519
2572	3	24	Transaction #72	2025-06-14	156.52	Auto-generated transaction entry #72	2025-06-15 08:47:11.439519
2573	3	21	Transaction #73	2025-05-17	891.35	Auto-generated transaction entry #73	2025-06-15 08:47:11.439519
2574	3	22	Transaction #74	2025-06-15	576.33	Auto-generated transaction entry #74	2025-06-15 08:47:11.439519
2575	3	23	Transaction #75	2025-05-24	872.94	Auto-generated transaction entry #75	2025-06-15 08:47:11.439519
2576	3	24	Transaction #76	2025-05-23	958.18	Auto-generated transaction entry #76	2025-06-15 08:47:11.439519
2577	3	21	Transaction #77	2025-05-31	735.43	Auto-generated transaction entry #77	2025-06-15 08:47:11.439519
2578	3	23	Transaction #78	2025-05-22	546.04	Auto-generated transaction entry #78	2025-06-15 08:47:11.439519
2579	3	21	Transaction #79	2025-06-02	341.45	Auto-generated transaction entry #79	2025-06-15 08:47:11.439519
2580	3	23	Transaction #80	2025-05-26	746.30	Auto-generated transaction entry #80	2025-06-15 08:47:11.439519
2581	3	23	Transaction #81	2025-05-19	116.04	Auto-generated transaction entry #81	2025-06-15 08:47:11.439519
2582	3	22	Transaction #82	2025-06-10	533.42	Auto-generated transaction entry #82	2025-06-15 08:47:11.439519
2583	3	23	Transaction #83	2025-05-29	115.49	Auto-generated transaction entry #83	2025-06-15 08:47:11.439519
2584	3	24	Transaction #84	2025-06-06	872.06	Auto-generated transaction entry #84	2025-06-15 08:47:11.439519
2585	3	23	Transaction #85	2025-06-06	325.23	Auto-generated transaction entry #85	2025-06-15 08:47:11.439519
2586	3	22	Transaction #86	2025-06-14	673.94	Auto-generated transaction entry #86	2025-06-15 08:47:11.439519
2587	3	22	Transaction #87	2025-06-11	749.24	Auto-generated transaction entry #87	2025-06-15 08:47:11.439519
2588	3	25	Transaction #88	2025-06-11	964.48	Auto-generated transaction entry #88	2025-06-15 08:47:11.439519
2589	3	22	Transaction #89	2025-06-03	88.20	Auto-generated transaction entry #89	2025-06-15 08:47:11.439519
2590	3	24	Transaction #90	2025-05-28	523.29	Auto-generated transaction entry #90	2025-06-15 08:47:11.439519
2591	3	22	Transaction #91	2025-05-27	242.28	Auto-generated transaction entry #91	2025-06-15 08:47:11.439519
2592	3	25	Transaction #92	2025-05-28	865.07	Auto-generated transaction entry #92	2025-06-15 08:47:11.439519
2593	3	25	Transaction #93	2025-06-08	715.06	Auto-generated transaction entry #93	2025-06-15 08:47:11.439519
2594	3	23	Transaction #94	2025-05-24	590.66	Auto-generated transaction entry #94	2025-06-15 08:47:11.439519
2595	3	21	Transaction #95	2025-05-25	204.02	Auto-generated transaction entry #95	2025-06-15 08:47:11.439519
2596	3	24	Transaction #96	2025-06-12	581.43	Auto-generated transaction entry #96	2025-06-15 08:47:11.439519
2597	3	21	Transaction #97	2025-06-03	542.43	Auto-generated transaction entry #97	2025-06-15 08:47:11.439519
2598	3	23	Transaction #98	2025-06-04	217.78	Auto-generated transaction entry #98	2025-06-15 08:47:11.439519
2599	3	24	Transaction #99	2025-05-23	705.83	Auto-generated transaction entry #99	2025-06-15 08:47:11.439519
2600	3	22	Transaction #100	2025-05-28	175.29	Auto-generated transaction entry #100	2025-06-15 08:47:11.439519
2601	3	24	Transaction #101	2025-05-28	82.95	Auto-generated transaction entry #101	2025-06-15 08:47:11.439519
2602	3	21	Transaction #102	2025-06-11	997.22	Auto-generated transaction entry #102	2025-06-15 08:47:11.439519
2603	3	25	Transaction #103	2025-05-29	949.28	Auto-generated transaction entry #103	2025-06-15 08:47:11.439519
2604	3	22	Transaction #104	2025-06-06	341.49	Auto-generated transaction entry #104	2025-06-15 08:47:11.439519
2605	3	22	Transaction #105	2025-05-21	749.78	Auto-generated transaction entry #105	2025-06-15 08:47:11.439519
2606	3	25	Transaction #106	2025-06-05	409.47	Auto-generated transaction entry #106	2025-06-15 08:47:11.439519
2607	3	22	Transaction #107	2025-06-02	116.71	Auto-generated transaction entry #107	2025-06-15 08:47:11.439519
2608	3	22	Transaction #108	2025-05-23	254.44	Auto-generated transaction entry #108	2025-06-15 08:47:11.439519
2609	3	24	Transaction #109	2025-06-12	813.48	Auto-generated transaction entry #109	2025-06-15 08:47:11.439519
2610	3	24	Transaction #110	2025-05-28	309.14	Auto-generated transaction entry #110	2025-06-15 08:47:11.439519
2611	3	25	Transaction #111	2025-06-09	376.24	Auto-generated transaction entry #111	2025-06-15 08:47:11.439519
2612	3	21	Transaction #112	2025-06-06	231.75	Auto-generated transaction entry #112	2025-06-15 08:47:11.439519
2613	3	22	Transaction #113	2025-05-20	911.27	Auto-generated transaction entry #113	2025-06-15 08:47:11.439519
2614	3	24	Transaction #114	2025-05-19	708.60	Auto-generated transaction entry #114	2025-06-15 08:47:11.439519
2615	3	25	Transaction #115	2025-06-10	844.47	Auto-generated transaction entry #115	2025-06-15 08:47:11.439519
2616	3	21	Transaction #116	2025-05-19	752.48	Auto-generated transaction entry #116	2025-06-15 08:47:11.439519
2617	3	21	Transaction #117	2025-05-19	514.60	Auto-generated transaction entry #117	2025-06-15 08:47:11.439519
2618	3	23	Transaction #118	2025-05-24	378.26	Auto-generated transaction entry #118	2025-06-15 08:47:11.439519
2619	3	23	Transaction #119	2025-06-07	769.18	Auto-generated transaction entry #119	2025-06-15 08:47:11.439519
2620	3	25	Transaction #120	2025-06-10	649.19	Auto-generated transaction entry #120	2025-06-15 08:47:11.439519
2621	3	21	Transaction #121	2025-06-14	731.39	Auto-generated transaction entry #121	2025-06-15 08:47:11.439519
2622	3	23	Transaction #122	2025-06-04	513.23	Auto-generated transaction entry #122	2025-06-15 08:47:11.439519
2623	3	23	Transaction #123	2025-06-06	67.03	Auto-generated transaction entry #123	2025-06-15 08:47:11.439519
2624	3	24	Transaction #124	2025-05-26	776.08	Auto-generated transaction entry #124	2025-06-15 08:47:11.439519
2625	3	23	Transaction #125	2025-06-08	629.51	Auto-generated transaction entry #125	2025-06-15 08:47:11.439519
2626	3	21	Transaction #126	2025-05-16	120.62	Auto-generated transaction entry #126	2025-06-15 08:47:11.439519
2627	3	22	Transaction #127	2025-06-15	127.72	Auto-generated transaction entry #127	2025-06-15 08:47:11.439519
2628	3	23	Transaction #128	2025-06-09	328.53	Auto-generated transaction entry #128	2025-06-15 08:47:11.439519
2629	3	22	Transaction #129	2025-06-07	800.35	Auto-generated transaction entry #129	2025-06-15 08:47:11.439519
2630	3	22	Transaction #130	2025-05-18	408.52	Auto-generated transaction entry #130	2025-06-15 08:47:11.439519
2631	3	22	Transaction #131	2025-05-26	468.43	Auto-generated transaction entry #131	2025-06-15 08:47:11.439519
2632	3	21	Transaction #132	2025-06-04	789.14	Auto-generated transaction entry #132	2025-06-15 08:47:11.439519
2633	3	25	Transaction #133	2025-06-02	358.54	Auto-generated transaction entry #133	2025-06-15 08:47:11.439519
2634	3	21	Transaction #134	2025-05-19	646.08	Auto-generated transaction entry #134	2025-06-15 08:47:11.439519
2635	3	21	Transaction #135	2025-06-07	947.45	Auto-generated transaction entry #135	2025-06-15 08:47:11.439519
2636	3	22	Transaction #136	2025-05-28	226.47	Auto-generated transaction entry #136	2025-06-15 08:47:11.439519
2637	3	25	Transaction #137	2025-05-29	651.73	Auto-generated transaction entry #137	2025-06-15 08:47:11.439519
2638	3	21	Transaction #138	2025-06-02	417.22	Auto-generated transaction entry #138	2025-06-15 08:47:11.439519
2639	3	23	Transaction #139	2025-06-07	421.24	Auto-generated transaction entry #139	2025-06-15 08:47:11.439519
2640	3	25	Transaction #140	2025-05-24	562.83	Auto-generated transaction entry #140	2025-06-15 08:47:11.439519
2641	3	21	Transaction #141	2025-06-01	486.08	Auto-generated transaction entry #141	2025-06-15 08:47:11.439519
2642	3	24	Transaction #142	2025-06-10	997.81	Auto-generated transaction entry #142	2025-06-15 08:47:11.439519
2643	3	21	Transaction #143	2025-06-04	725.16	Auto-generated transaction entry #143	2025-06-15 08:47:11.439519
2644	3	21	Transaction #144	2025-06-01	783.45	Auto-generated transaction entry #144	2025-06-15 08:47:11.439519
2645	3	25	Transaction #145	2025-05-19	130.90	Auto-generated transaction entry #145	2025-06-15 08:47:11.439519
2646	3	23	Transaction #146	2025-05-30	90.62	Auto-generated transaction entry #146	2025-06-15 08:47:11.439519
2647	3	25	Transaction #147	2025-06-10	735.85	Auto-generated transaction entry #147	2025-06-15 08:47:11.439519
2648	3	25	Transaction #148	2025-05-22	835.07	Auto-generated transaction entry #148	2025-06-15 08:47:11.439519
2649	3	21	Transaction #149	2025-05-31	594.54	Auto-generated transaction entry #149	2025-06-15 08:47:11.439519
2650	3	21	Transaction #150	2025-05-29	909.93	Auto-generated transaction entry #150	2025-06-15 08:47:11.439519
2651	3	23	Transaction #151	2025-05-26	427.59	Auto-generated transaction entry #151	2025-06-15 08:47:11.439519
2652	3	23	Transaction #152	2025-06-10	442.57	Auto-generated transaction entry #152	2025-06-15 08:47:11.439519
2653	3	24	Transaction #153	2025-06-11	90.40	Auto-generated transaction entry #153	2025-06-15 08:47:11.439519
2654	3	22	Transaction #154	2025-05-16	535.75	Auto-generated transaction entry #154	2025-06-15 08:47:11.439519
2655	3	22	Transaction #155	2025-05-31	754.98	Auto-generated transaction entry #155	2025-06-15 08:47:11.439519
2656	3	25	Transaction #156	2025-06-09	392.50	Auto-generated transaction entry #156	2025-06-15 08:47:11.439519
2657	3	21	Transaction #157	2025-05-17	449.23	Auto-generated transaction entry #157	2025-06-15 08:47:11.439519
2658	3	23	Transaction #158	2025-06-11	718.31	Auto-generated transaction entry #158	2025-06-15 08:47:11.439519
2659	3	25	Transaction #159	2025-05-27	414.57	Auto-generated transaction entry #159	2025-06-15 08:47:11.439519
2660	3	24	Transaction #160	2025-06-15	202.01	Auto-generated transaction entry #160	2025-06-15 08:47:11.439519
2661	3	24	Transaction #161	2025-05-27	788.03	Auto-generated transaction entry #161	2025-06-15 08:47:11.439519
2662	3	21	Transaction #162	2025-06-04	111.07	Auto-generated transaction entry #162	2025-06-15 08:47:11.439519
2663	3	24	Transaction #163	2025-05-20	271.14	Auto-generated transaction entry #163	2025-06-15 08:47:11.439519
2664	3	22	Transaction #164	2025-05-24	304.59	Auto-generated transaction entry #164	2025-06-15 08:47:11.439519
2665	3	21	Transaction #165	2025-05-22	320.27	Auto-generated transaction entry #165	2025-06-15 08:47:11.439519
2666	3	22	Transaction #166	2025-06-02	196.10	Auto-generated transaction entry #166	2025-06-15 08:47:11.439519
2667	3	24	Transaction #167	2025-05-21	983.11	Auto-generated transaction entry #167	2025-06-15 08:47:11.439519
2668	3	24	Transaction #168	2025-06-15	60.11	Auto-generated transaction entry #168	2025-06-15 08:47:11.439519
2669	3	23	Transaction #169	2025-05-26	344.53	Auto-generated transaction entry #169	2025-06-15 08:47:11.439519
2670	3	24	Transaction #170	2025-06-03	432.29	Auto-generated transaction entry #170	2025-06-15 08:47:11.439519
2671	3	25	Transaction #171	2025-06-10	365.34	Auto-generated transaction entry #171	2025-06-15 08:47:11.439519
2672	3	21	Transaction #172	2025-05-20	359.35	Auto-generated transaction entry #172	2025-06-15 08:47:11.439519
2673	3	25	Transaction #173	2025-06-01	819.15	Auto-generated transaction entry #173	2025-06-15 08:47:11.439519
2674	3	22	Transaction #174	2025-06-11	608.02	Auto-generated transaction entry #174	2025-06-15 08:47:11.439519
2675	3	22	Transaction #175	2025-05-17	684.89	Auto-generated transaction entry #175	2025-06-15 08:47:11.439519
2676	3	22	Transaction #176	2025-05-30	868.99	Auto-generated transaction entry #176	2025-06-15 08:47:11.439519
2677	3	25	Transaction #177	2025-06-03	676.99	Auto-generated transaction entry #177	2025-06-15 08:47:11.439519
2678	3	21	Transaction #178	2025-05-29	75.17	Auto-generated transaction entry #178	2025-06-15 08:47:11.439519
2679	3	24	Transaction #179	2025-06-08	699.07	Auto-generated transaction entry #179	2025-06-15 08:47:11.439519
2680	3	24	Transaction #180	2025-05-24	436.32	Auto-generated transaction entry #180	2025-06-15 08:47:11.439519
2681	3	21	Transaction #181	2025-05-25	92.82	Auto-generated transaction entry #181	2025-06-15 08:47:11.439519
2682	3	25	Transaction #182	2025-06-10	279.29	Auto-generated transaction entry #182	2025-06-15 08:47:11.439519
2683	3	22	Transaction #183	2025-06-10	524.15	Auto-generated transaction entry #183	2025-06-15 08:47:11.439519
2684	3	24	Transaction #184	2025-05-30	276.50	Auto-generated transaction entry #184	2025-06-15 08:47:11.439519
2685	3	22	Transaction #185	2025-05-18	130.65	Auto-generated transaction entry #185	2025-06-15 08:47:11.439519
2686	3	22	Transaction #186	2025-06-11	239.43	Auto-generated transaction entry #186	2025-06-15 08:47:11.439519
2687	3	25	Transaction #187	2025-05-23	123.29	Auto-generated transaction entry #187	2025-06-15 08:47:11.439519
2688	3	22	Transaction #188	2025-06-10	999.15	Auto-generated transaction entry #188	2025-06-15 08:47:11.439519
2689	3	23	Transaction #189	2025-06-05	343.01	Auto-generated transaction entry #189	2025-06-15 08:47:11.439519
2690	3	24	Transaction #190	2025-06-09	398.22	Auto-generated transaction entry #190	2025-06-15 08:47:11.439519
2691	3	25	Transaction #191	2025-06-11	711.65	Auto-generated transaction entry #191	2025-06-15 08:47:11.439519
2692	3	24	Transaction #192	2025-06-06	807.41	Auto-generated transaction entry #192	2025-06-15 08:47:11.439519
2693	3	25	Transaction #193	2025-06-11	875.58	Auto-generated transaction entry #193	2025-06-15 08:47:11.439519
2694	3	24	Transaction #194	2025-06-10	572.06	Auto-generated transaction entry #194	2025-06-15 08:47:11.439519
2695	3	22	Transaction #195	2025-05-28	760.85	Auto-generated transaction entry #195	2025-06-15 08:47:11.439519
2696	3	25	Transaction #196	2025-06-15	838.19	Auto-generated transaction entry #196	2025-06-15 08:47:11.439519
2697	3	23	Transaction #197	2025-05-21	666.02	Auto-generated transaction entry #197	2025-06-15 08:47:11.439519
2698	3	24	Transaction #198	2025-06-09	836.10	Auto-generated transaction entry #198	2025-06-15 08:47:11.439519
2699	3	25	Transaction #199	2025-05-23	471.25	Auto-generated transaction entry #199	2025-06-15 08:47:11.439519
2700	3	24	Transaction #200	2025-05-29	202.29	Auto-generated transaction entry #200	2025-06-15 08:47:11.439519
2701	3	23	Transaction #201	2025-05-18	576.43	Auto-generated transaction entry #201	2025-06-15 08:47:11.439519
2702	3	23	Transaction #202	2025-05-28	953.40	Auto-generated transaction entry #202	2025-06-15 08:47:11.439519
2703	3	24	Transaction #203	2025-05-25	182.56	Auto-generated transaction entry #203	2025-06-15 08:47:11.439519
2704	3	24	Transaction #204	2025-05-27	543.49	Auto-generated transaction entry #204	2025-06-15 08:47:11.439519
2705	3	24	Transaction #205	2025-05-31	761.25	Auto-generated transaction entry #205	2025-06-15 08:47:11.439519
2706	3	25	Transaction #206	2025-06-06	690.75	Auto-generated transaction entry #206	2025-06-15 08:47:11.439519
2707	3	24	Transaction #207	2025-06-01	703.05	Auto-generated transaction entry #207	2025-06-15 08:47:11.439519
2708	3	22	Transaction #208	2025-05-25	581.72	Auto-generated transaction entry #208	2025-06-15 08:47:11.439519
2709	3	23	Transaction #209	2025-06-09	308.50	Auto-generated transaction entry #209	2025-06-15 08:47:11.439519
2710	3	22	Transaction #210	2025-06-03	347.13	Auto-generated transaction entry #210	2025-06-15 08:47:11.439519
2711	3	21	Transaction #211	2025-05-21	635.61	Auto-generated transaction entry #211	2025-06-15 08:47:11.439519
2712	3	25	Transaction #212	2025-06-03	805.41	Auto-generated transaction entry #212	2025-06-15 08:47:11.439519
2713	3	22	Transaction #213	2025-06-09	202.16	Auto-generated transaction entry #213	2025-06-15 08:47:11.439519
2714	3	21	Transaction #214	2025-06-04	633.65	Auto-generated transaction entry #214	2025-06-15 08:47:11.439519
2715	3	21	Transaction #215	2025-06-02	218.74	Auto-generated transaction entry #215	2025-06-15 08:47:11.439519
2716	3	25	Transaction #216	2025-05-22	616.46	Auto-generated transaction entry #216	2025-06-15 08:47:11.439519
2717	3	23	Transaction #217	2025-05-22	199.89	Auto-generated transaction entry #217	2025-06-15 08:47:11.439519
2718	3	24	Transaction #218	2025-06-05	988.24	Auto-generated transaction entry #218	2025-06-15 08:47:11.439519
2719	3	22	Transaction #219	2025-06-08	260.39	Auto-generated transaction entry #219	2025-06-15 08:47:11.439519
2720	3	25	Transaction #220	2025-05-31	385.66	Auto-generated transaction entry #220	2025-06-15 08:47:11.439519
2721	3	24	Transaction #221	2025-06-13	955.14	Auto-generated transaction entry #221	2025-06-15 08:47:11.439519
2722	3	25	Transaction #222	2025-06-13	734.61	Auto-generated transaction entry #222	2025-06-15 08:47:11.439519
2723	3	25	Transaction #223	2025-05-29	494.81	Auto-generated transaction entry #223	2025-06-15 08:47:11.439519
2724	3	23	Transaction #224	2025-05-26	644.13	Auto-generated transaction entry #224	2025-06-15 08:47:11.439519
2725	3	25	Transaction #225	2025-05-26	216.48	Auto-generated transaction entry #225	2025-06-15 08:47:11.439519
2726	3	25	Transaction #226	2025-05-20	943.67	Auto-generated transaction entry #226	2025-06-15 08:47:11.439519
2727	3	25	Transaction #227	2025-06-03	782.23	Auto-generated transaction entry #227	2025-06-15 08:47:11.439519
2728	3	21	Transaction #228	2025-06-03	550.56	Auto-generated transaction entry #228	2025-06-15 08:47:11.439519
2729	3	25	Transaction #229	2025-06-07	307.09	Auto-generated transaction entry #229	2025-06-15 08:47:11.439519
2730	3	22	Transaction #230	2025-05-30	546.81	Auto-generated transaction entry #230	2025-06-15 08:47:11.439519
2731	3	25	Transaction #231	2025-05-25	768.11	Auto-generated transaction entry #231	2025-06-15 08:47:11.439519
2732	3	21	Transaction #232	2025-06-06	596.82	Auto-generated transaction entry #232	2025-06-15 08:47:11.439519
2733	3	22	Transaction #233	2025-05-25	970.17	Auto-generated transaction entry #233	2025-06-15 08:47:11.439519
2734	3	23	Transaction #234	2025-06-11	396.46	Auto-generated transaction entry #234	2025-06-15 08:47:11.439519
2735	3	25	Transaction #235	2025-05-20	286.39	Auto-generated transaction entry #235	2025-06-15 08:47:11.439519
2736	3	21	Transaction #236	2025-06-12	493.41	Auto-generated transaction entry #236	2025-06-15 08:47:11.439519
2737	3	23	Transaction #237	2025-06-02	772.17	Auto-generated transaction entry #237	2025-06-15 08:47:11.439519
2738	3	24	Transaction #238	2025-06-05	972.21	Auto-generated transaction entry #238	2025-06-15 08:47:11.439519
2739	3	22	Transaction #239	2025-05-22	212.00	Auto-generated transaction entry #239	2025-06-15 08:47:11.439519
2740	3	22	Transaction #240	2025-05-20	781.38	Auto-generated transaction entry #240	2025-06-15 08:47:11.439519
2741	3	21	Transaction #241	2025-06-11	179.72	Auto-generated transaction entry #241	2025-06-15 08:47:11.439519
2742	3	21	Transaction #242	2025-05-19	566.38	Auto-generated transaction entry #242	2025-06-15 08:47:11.439519
2743	3	24	Transaction #243	2025-06-14	924.60	Auto-generated transaction entry #243	2025-06-15 08:47:11.439519
2744	3	24	Transaction #244	2025-06-10	340.39	Auto-generated transaction entry #244	2025-06-15 08:47:11.439519
2745	3	22	Transaction #245	2025-06-08	741.97	Auto-generated transaction entry #245	2025-06-15 08:47:11.439519
2746	3	21	Transaction #246	2025-06-07	990.91	Auto-generated transaction entry #246	2025-06-15 08:47:11.439519
2747	3	24	Transaction #247	2025-05-28	656.59	Auto-generated transaction entry #247	2025-06-15 08:47:11.439519
2748	3	24	Transaction #248	2025-05-23	699.26	Auto-generated transaction entry #248	2025-06-15 08:47:11.439519
2749	3	21	Transaction #249	2025-05-22	924.19	Auto-generated transaction entry #249	2025-06-15 08:47:11.439519
2750	3	23	Transaction #250	2025-05-29	670.02	Auto-generated transaction entry #250	2025-06-15 08:47:11.439519
2751	3	24	Transaction #251	2025-06-09	919.93	Auto-generated transaction entry #251	2025-06-15 08:47:11.439519
2752	3	24	Transaction #252	2025-06-14	682.11	Auto-generated transaction entry #252	2025-06-15 08:47:11.439519
2753	3	23	Transaction #253	2025-06-08	651.54	Auto-generated transaction entry #253	2025-06-15 08:47:11.439519
2754	3	23	Transaction #254	2025-05-21	655.85	Auto-generated transaction entry #254	2025-06-15 08:47:11.439519
2755	3	24	Transaction #255	2025-05-23	596.04	Auto-generated transaction entry #255	2025-06-15 08:47:11.439519
2756	3	22	Transaction #256	2025-06-13	811.26	Auto-generated transaction entry #256	2025-06-15 08:47:11.439519
2757	3	24	Transaction #257	2025-05-26	684.06	Auto-generated transaction entry #257	2025-06-15 08:47:11.439519
2758	3	25	Transaction #258	2025-06-12	877.36	Auto-generated transaction entry #258	2025-06-15 08:47:11.439519
2759	3	24	Transaction #259	2025-06-08	325.40	Auto-generated transaction entry #259	2025-06-15 08:47:11.439519
2760	3	21	Transaction #260	2025-06-12	429.48	Auto-generated transaction entry #260	2025-06-15 08:47:11.439519
2761	3	23	Transaction #261	2025-05-23	602.84	Auto-generated transaction entry #261	2025-06-15 08:47:11.439519
2762	3	22	Transaction #262	2025-05-23	858.83	Auto-generated transaction entry #262	2025-06-15 08:47:11.439519
2763	3	24	Transaction #263	2025-06-11	236.54	Auto-generated transaction entry #263	2025-06-15 08:47:11.439519
2764	3	25	Transaction #264	2025-06-11	200.81	Auto-generated transaction entry #264	2025-06-15 08:47:11.439519
2765	3	22	Transaction #265	2025-06-09	482.83	Auto-generated transaction entry #265	2025-06-15 08:47:11.439519
2766	3	24	Transaction #266	2025-05-18	942.89	Auto-generated transaction entry #266	2025-06-15 08:47:11.439519
2767	3	25	Transaction #267	2025-06-06	747.39	Auto-generated transaction entry #267	2025-06-15 08:47:11.439519
2768	3	22	Transaction #268	2025-05-19	276.63	Auto-generated transaction entry #268	2025-06-15 08:47:11.439519
2769	3	21	Transaction #269	2025-05-30	671.54	Auto-generated transaction entry #269	2025-06-15 08:47:11.439519
2770	3	25	Transaction #270	2025-05-22	137.49	Auto-generated transaction entry #270	2025-06-15 08:47:11.439519
2771	3	25	Transaction #271	2025-05-18	680.40	Auto-generated transaction entry #271	2025-06-15 08:47:11.439519
2772	3	24	Transaction #272	2025-06-12	409.68	Auto-generated transaction entry #272	2025-06-15 08:47:11.439519
2773	3	25	Transaction #273	2025-05-30	199.94	Auto-generated transaction entry #273	2025-06-15 08:47:11.439519
2774	3	25	Transaction #274	2025-05-23	92.03	Auto-generated transaction entry #274	2025-06-15 08:47:11.439519
2775	3	25	Transaction #275	2025-05-24	995.09	Auto-generated transaction entry #275	2025-06-15 08:47:11.439519
2776	3	23	Transaction #276	2025-06-13	601.88	Auto-generated transaction entry #276	2025-06-15 08:47:11.439519
2777	3	25	Transaction #277	2025-05-26	855.86	Auto-generated transaction entry #277	2025-06-15 08:47:11.439519
2778	3	25	Transaction #278	2025-05-16	987.33	Auto-generated transaction entry #278	2025-06-15 08:47:11.439519
2779	3	22	Transaction #279	2025-05-30	863.80	Auto-generated transaction entry #279	2025-06-15 08:47:11.439519
2780	3	21	Transaction #280	2025-05-28	662.29	Auto-generated transaction entry #280	2025-06-15 08:47:11.439519
2781	3	21	Transaction #281	2025-05-31	177.26	Auto-generated transaction entry #281	2025-06-15 08:47:11.439519
2782	3	23	Transaction #282	2025-06-04	423.55	Auto-generated transaction entry #282	2025-06-15 08:47:11.439519
2783	3	21	Transaction #283	2025-05-19	828.12	Auto-generated transaction entry #283	2025-06-15 08:47:11.439519
2784	3	25	Transaction #284	2025-06-02	709.23	Auto-generated transaction entry #284	2025-06-15 08:47:11.439519
2785	3	25	Transaction #285	2025-05-30	993.57	Auto-generated transaction entry #285	2025-06-15 08:47:11.439519
2786	3	22	Transaction #286	2025-06-03	785.21	Auto-generated transaction entry #286	2025-06-15 08:47:11.439519
2787	3	25	Transaction #287	2025-05-23	932.01	Auto-generated transaction entry #287	2025-06-15 08:47:11.439519
2788	3	24	Transaction #288	2025-05-17	342.49	Auto-generated transaction entry #288	2025-06-15 08:47:11.439519
2789	3	25	Transaction #289	2025-06-08	639.22	Auto-generated transaction entry #289	2025-06-15 08:47:11.439519
2790	3	23	Transaction #290	2025-05-18	914.50	Auto-generated transaction entry #290	2025-06-15 08:47:11.439519
2791	3	25	Transaction #291	2025-06-03	851.03	Auto-generated transaction entry #291	2025-06-15 08:47:11.439519
2792	3	24	Transaction #292	2025-05-18	512.20	Auto-generated transaction entry #292	2025-06-15 08:47:11.439519
2793	3	25	Transaction #293	2025-05-18	158.36	Auto-generated transaction entry #293	2025-06-15 08:47:11.439519
2794	3	21	Transaction #294	2025-05-24	546.76	Auto-generated transaction entry #294	2025-06-15 08:47:11.439519
2795	3	21	Transaction #295	2025-06-01	470.42	Auto-generated transaction entry #295	2025-06-15 08:47:11.439519
2796	3	23	Transaction #296	2025-05-24	200.83	Auto-generated transaction entry #296	2025-06-15 08:47:11.439519
2797	3	23	Transaction #297	2025-05-20	654.78	Auto-generated transaction entry #297	2025-06-15 08:47:11.439519
2798	3	23	Transaction #298	2025-05-18	227.74	Auto-generated transaction entry #298	2025-06-15 08:47:11.439519
2799	3	25	Transaction #299	2025-05-23	282.59	Auto-generated transaction entry #299	2025-06-15 08:47:11.439519
2800	3	25	Transaction #300	2025-06-10	932.05	Auto-generated transaction entry #300	2025-06-15 08:47:11.439519
2801	3	25	Transaction #301	2025-06-13	387.15	Auto-generated transaction entry #301	2025-06-15 08:47:11.439519
2802	3	22	Transaction #302	2025-05-24	252.80	Auto-generated transaction entry #302	2025-06-15 08:47:11.439519
2803	3	21	Transaction #303	2025-05-29	277.99	Auto-generated transaction entry #303	2025-06-15 08:47:11.439519
2804	3	22	Transaction #304	2025-06-01	462.57	Auto-generated transaction entry #304	2025-06-15 08:47:11.439519
2805	3	25	Transaction #305	2025-06-07	683.49	Auto-generated transaction entry #305	2025-06-15 08:47:11.439519
2806	3	23	Transaction #306	2025-06-09	103.73	Auto-generated transaction entry #306	2025-06-15 08:47:11.439519
2807	3	25	Transaction #307	2025-05-26	68.47	Auto-generated transaction entry #307	2025-06-15 08:47:11.439519
2808	3	22	Transaction #308	2025-05-31	718.86	Auto-generated transaction entry #308	2025-06-15 08:47:11.439519
2809	3	22	Transaction #309	2025-06-04	264.68	Auto-generated transaction entry #309	2025-06-15 08:47:11.439519
2810	3	22	Transaction #310	2025-05-27	667.25	Auto-generated transaction entry #310	2025-06-15 08:47:11.439519
2811	3	22	Transaction #311	2025-05-17	557.21	Auto-generated transaction entry #311	2025-06-15 08:47:11.439519
2812	3	25	Transaction #312	2025-06-14	985.82	Auto-generated transaction entry #312	2025-06-15 08:47:11.439519
2813	3	23	Transaction #313	2025-05-23	627.52	Auto-generated transaction entry #313	2025-06-15 08:47:11.439519
2814	3	24	Transaction #314	2025-05-19	783.57	Auto-generated transaction entry #314	2025-06-15 08:47:11.439519
2815	3	23	Transaction #315	2025-05-25	456.11	Auto-generated transaction entry #315	2025-06-15 08:47:11.439519
2816	3	25	Transaction #316	2025-06-05	513.39	Auto-generated transaction entry #316	2025-06-15 08:47:11.439519
2817	3	24	Transaction #317	2025-05-24	793.65	Auto-generated transaction entry #317	2025-06-15 08:47:11.439519
2818	3	21	Transaction #318	2025-05-21	558.01	Auto-generated transaction entry #318	2025-06-15 08:47:11.439519
2819	3	21	Transaction #319	2025-06-03	903.93	Auto-generated transaction entry #319	2025-06-15 08:47:11.439519
2820	3	24	Transaction #320	2025-05-20	442.92	Auto-generated transaction entry #320	2025-06-15 08:47:11.439519
2821	3	23	Transaction #321	2025-05-30	310.08	Auto-generated transaction entry #321	2025-06-15 08:47:11.439519
2822	3	22	Transaction #322	2025-05-21	611.89	Auto-generated transaction entry #322	2025-06-15 08:47:11.439519
2823	3	24	Transaction #323	2025-05-17	267.30	Auto-generated transaction entry #323	2025-06-15 08:47:11.439519
2824	3	21	Transaction #324	2025-06-03	996.52	Auto-generated transaction entry #324	2025-06-15 08:47:11.439519
2825	3	24	Transaction #325	2025-05-28	217.89	Auto-generated transaction entry #325	2025-06-15 08:47:11.439519
2826	3	23	Transaction #326	2025-06-07	691.81	Auto-generated transaction entry #326	2025-06-15 08:47:11.439519
2827	3	21	Transaction #327	2025-06-02	175.77	Auto-generated transaction entry #327	2025-06-15 08:47:11.439519
2828	3	25	Transaction #328	2025-05-28	169.17	Auto-generated transaction entry #328	2025-06-15 08:47:11.439519
2829	3	22	Transaction #329	2025-05-18	706.05	Auto-generated transaction entry #329	2025-06-15 08:47:11.439519
2830	3	24	Transaction #330	2025-05-31	723.15	Auto-generated transaction entry #330	2025-06-15 08:47:11.439519
2831	3	21	Transaction #331	2025-05-24	845.80	Auto-generated transaction entry #331	2025-06-15 08:47:11.439519
2832	3	24	Transaction #332	2025-05-22	653.75	Auto-generated transaction entry #332	2025-06-15 08:47:11.439519
2833	3	24	Transaction #333	2025-05-29	114.43	Auto-generated transaction entry #333	2025-06-15 08:47:11.439519
2834	3	22	Transaction #334	2025-05-27	927.38	Auto-generated transaction entry #334	2025-06-15 08:47:11.439519
2835	3	25	Transaction #335	2025-05-20	901.12	Auto-generated transaction entry #335	2025-06-15 08:47:11.439519
2836	3	22	Transaction #336	2025-06-02	448.84	Auto-generated transaction entry #336	2025-06-15 08:47:11.439519
2837	3	25	Transaction #337	2025-05-27	903.36	Auto-generated transaction entry #337	2025-06-15 08:47:11.439519
2838	3	22	Transaction #338	2025-05-30	937.32	Auto-generated transaction entry #338	2025-06-15 08:47:11.439519
2839	3	22	Transaction #339	2025-06-02	416.29	Auto-generated transaction entry #339	2025-06-15 08:47:11.439519
2840	3	22	Transaction #340	2025-05-28	282.33	Auto-generated transaction entry #340	2025-06-15 08:47:11.439519
2841	3	23	Transaction #341	2025-06-12	786.02	Auto-generated transaction entry #341	2025-06-15 08:47:11.439519
2842	3	25	Transaction #342	2025-06-12	223.44	Auto-generated transaction entry #342	2025-06-15 08:47:11.439519
2843	3	24	Transaction #343	2025-06-10	218.20	Auto-generated transaction entry #343	2025-06-15 08:47:11.439519
2844	3	21	Transaction #344	2025-06-14	307.82	Auto-generated transaction entry #344	2025-06-15 08:47:11.439519
2845	3	23	Transaction #345	2025-06-01	172.49	Auto-generated transaction entry #345	2025-06-15 08:47:11.439519
2846	3	24	Transaction #346	2025-05-28	107.83	Auto-generated transaction entry #346	2025-06-15 08:47:11.439519
2847	3	21	Transaction #347	2025-06-12	649.01	Auto-generated transaction entry #347	2025-06-15 08:47:11.439519
2848	3	25	Transaction #348	2025-06-02	215.48	Auto-generated transaction entry #348	2025-06-15 08:47:11.439519
2849	3	23	Transaction #349	2025-05-26	397.07	Auto-generated transaction entry #349	2025-06-15 08:47:11.439519
2850	3	21	Transaction #350	2025-06-03	171.67	Auto-generated transaction entry #350	2025-06-15 08:47:11.439519
2851	3	23	Transaction #351	2025-06-11	494.92	Auto-generated transaction entry #351	2025-06-15 08:47:11.439519
2852	3	23	Transaction #352	2025-05-22	981.57	Auto-generated transaction entry #352	2025-06-15 08:47:11.439519
2853	3	21	Transaction #353	2025-06-10	503.17	Auto-generated transaction entry #353	2025-06-15 08:47:11.439519
2854	3	23	Transaction #354	2025-06-05	617.42	Auto-generated transaction entry #354	2025-06-15 08:47:11.439519
2855	3	23	Transaction #355	2025-05-30	577.80	Auto-generated transaction entry #355	2025-06-15 08:47:11.439519
2856	3	25	Transaction #356	2025-05-16	854.92	Auto-generated transaction entry #356	2025-06-15 08:47:11.439519
2857	3	22	Transaction #357	2025-05-28	918.13	Auto-generated transaction entry #357	2025-06-15 08:47:11.439519
2858	3	23	Transaction #358	2025-05-29	940.18	Auto-generated transaction entry #358	2025-06-15 08:47:11.439519
2859	3	21	Transaction #359	2025-06-05	364.76	Auto-generated transaction entry #359	2025-06-15 08:47:11.439519
2860	3	21	Transaction #360	2025-05-29	477.62	Auto-generated transaction entry #360	2025-06-15 08:47:11.439519
2861	3	21	Transaction #361	2025-05-20	200.78	Auto-generated transaction entry #361	2025-06-15 08:47:11.439519
2862	3	23	Transaction #362	2025-06-07	63.80	Auto-generated transaction entry #362	2025-06-15 08:47:11.439519
2863	3	25	Transaction #363	2025-05-27	85.69	Auto-generated transaction entry #363	2025-06-15 08:47:11.439519
2864	3	21	Transaction #364	2025-06-06	364.23	Auto-generated transaction entry #364	2025-06-15 08:47:11.439519
2865	3	25	Transaction #365	2025-05-28	783.20	Auto-generated transaction entry #365	2025-06-15 08:47:11.439519
2866	3	22	Transaction #366	2025-05-29	849.42	Auto-generated transaction entry #366	2025-06-15 08:47:11.439519
2867	3	22	Transaction #367	2025-05-23	483.69	Auto-generated transaction entry #367	2025-06-15 08:47:11.439519
2868	3	23	Transaction #368	2025-06-06	57.09	Auto-generated transaction entry #368	2025-06-15 08:47:11.439519
2869	3	24	Transaction #369	2025-05-29	554.12	Auto-generated transaction entry #369	2025-06-15 08:47:11.439519
2870	3	22	Transaction #370	2025-06-06	397.74	Auto-generated transaction entry #370	2025-06-15 08:47:11.439519
2871	3	25	Transaction #371	2025-05-28	234.90	Auto-generated transaction entry #371	2025-06-15 08:47:11.439519
2872	3	21	Transaction #372	2025-05-30	756.29	Auto-generated transaction entry #372	2025-06-15 08:47:11.439519
2873	3	23	Transaction #373	2025-06-09	956.72	Auto-generated transaction entry #373	2025-06-15 08:47:11.439519
2874	3	23	Transaction #374	2025-06-14	105.21	Auto-generated transaction entry #374	2025-06-15 08:47:11.439519
2875	3	24	Transaction #375	2025-06-01	247.47	Auto-generated transaction entry #375	2025-06-15 08:47:11.439519
2876	3	24	Transaction #376	2025-06-05	455.10	Auto-generated transaction entry #376	2025-06-15 08:47:11.439519
2877	3	21	Transaction #377	2025-06-11	284.98	Auto-generated transaction entry #377	2025-06-15 08:47:11.439519
2878	3	23	Transaction #378	2025-06-01	514.58	Auto-generated transaction entry #378	2025-06-15 08:47:11.439519
2879	3	21	Transaction #379	2025-06-14	560.43	Auto-generated transaction entry #379	2025-06-15 08:47:11.439519
2880	3	25	Transaction #380	2025-06-04	462.61	Auto-generated transaction entry #380	2025-06-15 08:47:11.439519
2881	3	21	Transaction #381	2025-06-01	677.30	Auto-generated transaction entry #381	2025-06-15 08:47:11.439519
2882	3	25	Transaction #382	2025-06-06	300.09	Auto-generated transaction entry #382	2025-06-15 08:47:11.439519
2883	3	24	Transaction #383	2025-05-24	114.71	Auto-generated transaction entry #383	2025-06-15 08:47:11.439519
2884	3	24	Transaction #384	2025-06-04	476.23	Auto-generated transaction entry #384	2025-06-15 08:47:11.439519
2885	3	25	Transaction #385	2025-05-30	221.18	Auto-generated transaction entry #385	2025-06-15 08:47:11.439519
2886	3	23	Transaction #386	2025-06-13	400.79	Auto-generated transaction entry #386	2025-06-15 08:47:11.439519
2887	3	21	Transaction #387	2025-06-02	830.59	Auto-generated transaction entry #387	2025-06-15 08:47:11.439519
2888	3	24	Transaction #388	2025-06-10	761.98	Auto-generated transaction entry #388	2025-06-15 08:47:11.439519
2889	3	23	Transaction #389	2025-06-10	345.49	Auto-generated transaction entry #389	2025-06-15 08:47:11.439519
2890	3	24	Transaction #390	2025-06-04	331.49	Auto-generated transaction entry #390	2025-06-15 08:47:11.439519
2891	3	25	Transaction #391	2025-05-26	845.51	Auto-generated transaction entry #391	2025-06-15 08:47:11.439519
2892	3	25	Transaction #392	2025-06-10	373.12	Auto-generated transaction entry #392	2025-06-15 08:47:11.439519
2893	3	22	Transaction #393	2025-06-06	572.35	Auto-generated transaction entry #393	2025-06-15 08:47:11.439519
2894	3	25	Transaction #394	2025-06-12	764.27	Auto-generated transaction entry #394	2025-06-15 08:47:11.439519
2895	3	23	Transaction #395	2025-05-19	891.07	Auto-generated transaction entry #395	2025-06-15 08:47:11.439519
2896	3	23	Transaction #396	2025-06-07	887.76	Auto-generated transaction entry #396	2025-06-15 08:47:11.439519
2897	3	22	Transaction #397	2025-06-04	217.50	Auto-generated transaction entry #397	2025-06-15 08:47:11.439519
2898	3	22	Transaction #398	2025-06-09	932.33	Auto-generated transaction entry #398	2025-06-15 08:47:11.439519
2899	3	21	Transaction #399	2025-05-23	632.21	Auto-generated transaction entry #399	2025-06-15 08:47:11.439519
2900	3	22	Transaction #400	2025-05-28	418.25	Auto-generated transaction entry #400	2025-06-15 08:47:11.439519
2901	3	24	Transaction #401	2025-05-29	869.48	Auto-generated transaction entry #401	2025-06-15 08:47:11.439519
2902	3	25	Transaction #402	2025-05-31	576.03	Auto-generated transaction entry #402	2025-06-15 08:47:11.439519
2903	3	21	Transaction #403	2025-05-19	701.06	Auto-generated transaction entry #403	2025-06-15 08:47:11.439519
2904	3	22	Transaction #404	2025-05-24	714.33	Auto-generated transaction entry #404	2025-06-15 08:47:11.439519
2905	3	23	Transaction #405	2025-06-14	404.88	Auto-generated transaction entry #405	2025-06-15 08:47:11.439519
2906	3	25	Transaction #406	2025-06-03	652.95	Auto-generated transaction entry #406	2025-06-15 08:47:11.439519
2907	3	21	Transaction #407	2025-05-29	605.28	Auto-generated transaction entry #407	2025-06-15 08:47:11.439519
2908	3	23	Transaction #408	2025-06-03	689.01	Auto-generated transaction entry #408	2025-06-15 08:47:11.439519
2909	3	24	Transaction #409	2025-06-11	863.49	Auto-generated transaction entry #409	2025-06-15 08:47:11.439519
2910	3	21	Transaction #410	2025-05-25	570.93	Auto-generated transaction entry #410	2025-06-15 08:47:11.439519
2911	3	22	Transaction #411	2025-05-29	273.47	Auto-generated transaction entry #411	2025-06-15 08:47:11.439519
2912	3	23	Transaction #412	2025-05-31	868.94	Auto-generated transaction entry #412	2025-06-15 08:47:11.439519
2913	3	23	Transaction #413	2025-05-30	888.21	Auto-generated transaction entry #413	2025-06-15 08:47:11.439519
2914	3	23	Transaction #414	2025-05-26	76.29	Auto-generated transaction entry #414	2025-06-15 08:47:11.439519
2915	3	24	Transaction #415	2025-05-17	947.63	Auto-generated transaction entry #415	2025-06-15 08:47:11.439519
2916	3	24	Transaction #416	2025-05-24	954.72	Auto-generated transaction entry #416	2025-06-15 08:47:11.439519
2917	3	25	Transaction #417	2025-05-24	151.03	Auto-generated transaction entry #417	2025-06-15 08:47:11.439519
2918	3	25	Transaction #418	2025-05-17	765.01	Auto-generated transaction entry #418	2025-06-15 08:47:11.439519
2919	3	24	Transaction #419	2025-05-20	928.59	Auto-generated transaction entry #419	2025-06-15 08:47:11.439519
2920	3	24	Transaction #420	2025-06-02	677.65	Auto-generated transaction entry #420	2025-06-15 08:47:11.439519
2921	3	24	Transaction #421	2025-05-25	630.55	Auto-generated transaction entry #421	2025-06-15 08:47:11.439519
2922	3	22	Transaction #422	2025-05-29	134.88	Auto-generated transaction entry #422	2025-06-15 08:47:11.439519
2923	3	21	Transaction #423	2025-06-13	508.84	Auto-generated transaction entry #423	2025-06-15 08:47:11.439519
2924	3	22	Transaction #424	2025-05-27	534.74	Auto-generated transaction entry #424	2025-06-15 08:47:11.439519
2925	3	21	Transaction #425	2025-05-17	852.98	Auto-generated transaction entry #425	2025-06-15 08:47:11.439519
2926	3	24	Transaction #426	2025-06-13	358.97	Auto-generated transaction entry #426	2025-06-15 08:47:11.439519
2927	3	24	Transaction #427	2025-05-24	440.71	Auto-generated transaction entry #427	2025-06-15 08:47:11.439519
2928	3	21	Transaction #428	2025-06-01	951.35	Auto-generated transaction entry #428	2025-06-15 08:47:11.439519
2929	3	22	Transaction #429	2025-06-07	735.81	Auto-generated transaction entry #429	2025-06-15 08:47:11.439519
2930	3	23	Transaction #430	2025-05-22	765.57	Auto-generated transaction entry #430	2025-06-15 08:47:11.439519
2931	3	23	Transaction #431	2025-05-23	555.64	Auto-generated transaction entry #431	2025-06-15 08:47:11.439519
2932	3	22	Transaction #432	2025-05-22	785.76	Auto-generated transaction entry #432	2025-06-15 08:47:11.439519
2933	3	25	Transaction #433	2025-05-31	160.84	Auto-generated transaction entry #433	2025-06-15 08:47:11.439519
2934	3	25	Transaction #434	2025-05-22	217.33	Auto-generated transaction entry #434	2025-06-15 08:47:11.439519
2935	3	25	Transaction #435	2025-05-19	537.63	Auto-generated transaction entry #435	2025-06-15 08:47:11.439519
2936	3	25	Transaction #436	2025-05-21	573.12	Auto-generated transaction entry #436	2025-06-15 08:47:11.439519
2937	3	21	Transaction #437	2025-05-24	945.76	Auto-generated transaction entry #437	2025-06-15 08:47:11.439519
2938	3	24	Transaction #438	2025-06-08	880.86	Auto-generated transaction entry #438	2025-06-15 08:47:11.439519
2939	3	23	Transaction #439	2025-06-04	977.85	Auto-generated transaction entry #439	2025-06-15 08:47:11.439519
2940	3	21	Transaction #440	2025-05-28	280.68	Auto-generated transaction entry #440	2025-06-15 08:47:11.439519
2941	3	24	Transaction #441	2025-05-26	730.41	Auto-generated transaction entry #441	2025-06-15 08:47:11.439519
2942	3	23	Transaction #442	2025-06-14	160.78	Auto-generated transaction entry #442	2025-06-15 08:47:11.439519
2943	3	24	Transaction #443	2025-05-17	531.66	Auto-generated transaction entry #443	2025-06-15 08:47:11.439519
2944	3	21	Transaction #444	2025-05-28	270.44	Auto-generated transaction entry #444	2025-06-15 08:47:11.439519
2945	3	22	Transaction #445	2025-06-01	887.10	Auto-generated transaction entry #445	2025-06-15 08:47:11.439519
2946	3	24	Transaction #446	2025-05-20	475.08	Auto-generated transaction entry #446	2025-06-15 08:47:11.439519
2947	3	21	Transaction #447	2025-05-29	525.50	Auto-generated transaction entry #447	2025-06-15 08:47:11.439519
2948	3	25	Transaction #448	2025-06-15	878.08	Auto-generated transaction entry #448	2025-06-15 08:47:11.439519
2949	3	25	Transaction #449	2025-05-24	818.45	Auto-generated transaction entry #449	2025-06-15 08:47:11.439519
2950	3	25	Transaction #450	2025-05-23	666.88	Auto-generated transaction entry #450	2025-06-15 08:47:11.439519
2951	3	25	Transaction #451	2025-06-04	420.65	Auto-generated transaction entry #451	2025-06-15 08:47:11.439519
2952	3	22	Transaction #452	2025-06-06	125.48	Auto-generated transaction entry #452	2025-06-15 08:47:11.439519
2953	3	22	Transaction #453	2025-05-29	83.55	Auto-generated transaction entry #453	2025-06-15 08:47:11.439519
2954	3	21	Transaction #454	2025-05-31	650.38	Auto-generated transaction entry #454	2025-06-15 08:47:11.439519
2955	3	24	Transaction #455	2025-05-28	549.66	Auto-generated transaction entry #455	2025-06-15 08:47:11.439519
2956	3	25	Transaction #456	2025-05-23	122.08	Auto-generated transaction entry #456	2025-06-15 08:47:11.439519
2957	3	22	Transaction #457	2025-06-07	607.82	Auto-generated transaction entry #457	2025-06-15 08:47:11.439519
2958	3	22	Transaction #458	2025-06-08	69.80	Auto-generated transaction entry #458	2025-06-15 08:47:11.439519
2959	3	25	Transaction #459	2025-05-23	593.79	Auto-generated transaction entry #459	2025-06-15 08:47:11.439519
2960	3	22	Transaction #460	2025-06-15	932.65	Auto-generated transaction entry #460	2025-06-15 08:47:11.439519
2961	3	21	Transaction #461	2025-06-13	452.08	Auto-generated transaction entry #461	2025-06-15 08:47:11.439519
2962	3	23	Transaction #462	2025-05-17	305.02	Auto-generated transaction entry #462	2025-06-15 08:47:11.439519
2963	3	22	Transaction #463	2025-06-12	808.95	Auto-generated transaction entry #463	2025-06-15 08:47:11.439519
2964	3	25	Transaction #464	2025-06-05	738.22	Auto-generated transaction entry #464	2025-06-15 08:47:11.439519
2965	3	21	Transaction #465	2025-05-25	811.86	Auto-generated transaction entry #465	2025-06-15 08:47:11.439519
2966	3	25	Transaction #466	2025-06-11	277.40	Auto-generated transaction entry #466	2025-06-15 08:47:11.439519
2967	3	25	Transaction #467	2025-05-30	976.99	Auto-generated transaction entry #467	2025-06-15 08:47:11.439519
2968	3	25	Transaction #468	2025-05-28	118.44	Auto-generated transaction entry #468	2025-06-15 08:47:11.439519
2969	3	23	Transaction #469	2025-06-09	295.36	Auto-generated transaction entry #469	2025-06-15 08:47:11.439519
2970	3	24	Transaction #470	2025-06-02	725.85	Auto-generated transaction entry #470	2025-06-15 08:47:11.439519
2971	3	22	Transaction #471	2025-06-07	744.30	Auto-generated transaction entry #471	2025-06-15 08:47:11.439519
2972	3	25	Transaction #472	2025-06-06	804.28	Auto-generated transaction entry #472	2025-06-15 08:47:11.439519
2973	3	24	Transaction #473	2025-05-25	417.38	Auto-generated transaction entry #473	2025-06-15 08:47:11.439519
2974	3	25	Transaction #474	2025-06-09	637.56	Auto-generated transaction entry #474	2025-06-15 08:47:11.439519
2975	3	21	Transaction #475	2025-05-25	851.65	Auto-generated transaction entry #475	2025-06-15 08:47:11.439519
2976	3	22	Transaction #476	2025-05-28	465.81	Auto-generated transaction entry #476	2025-06-15 08:47:11.439519
2977	3	25	Transaction #477	2025-06-10	480.07	Auto-generated transaction entry #477	2025-06-15 08:47:11.439519
2978	3	23	Transaction #478	2025-05-24	825.16	Auto-generated transaction entry #478	2025-06-15 08:47:11.439519
2979	3	21	Transaction #479	2025-06-06	750.87	Auto-generated transaction entry #479	2025-06-15 08:47:11.439519
2980	3	22	Transaction #480	2025-06-14	550.86	Auto-generated transaction entry #480	2025-06-15 08:47:11.439519
2981	3	24	Transaction #481	2025-05-29	857.36	Auto-generated transaction entry #481	2025-06-15 08:47:11.439519
2982	3	25	Transaction #482	2025-05-22	317.36	Auto-generated transaction entry #482	2025-06-15 08:47:11.439519
2983	3	22	Transaction #483	2025-05-24	831.95	Auto-generated transaction entry #483	2025-06-15 08:47:11.439519
2984	3	22	Transaction #484	2025-05-19	257.77	Auto-generated transaction entry #484	2025-06-15 08:47:11.439519
2985	3	25	Transaction #485	2025-06-13	639.16	Auto-generated transaction entry #485	2025-06-15 08:47:11.439519
2986	3	22	Transaction #486	2025-06-10	558.81	Auto-generated transaction entry #486	2025-06-15 08:47:11.439519
2987	3	25	Transaction #487	2025-06-14	711.13	Auto-generated transaction entry #487	2025-06-15 08:47:11.439519
2988	3	23	Transaction #488	2025-06-11	673.52	Auto-generated transaction entry #488	2025-06-15 08:47:11.439519
2989	3	25	Transaction #489	2025-06-08	949.85	Auto-generated transaction entry #489	2025-06-15 08:47:11.439519
2990	3	22	Transaction #490	2025-06-06	241.36	Auto-generated transaction entry #490	2025-06-15 08:47:11.439519
2991	3	22	Transaction #491	2025-06-13	482.36	Auto-generated transaction entry #491	2025-06-15 08:47:11.439519
2992	3	24	Transaction #492	2025-05-20	501.68	Auto-generated transaction entry #492	2025-06-15 08:47:11.439519
2993	3	23	Transaction #493	2025-05-27	200.80	Auto-generated transaction entry #493	2025-06-15 08:47:11.439519
2994	3	22	Transaction #494	2025-05-20	266.89	Auto-generated transaction entry #494	2025-06-15 08:47:11.439519
2995	3	25	Transaction #495	2025-05-16	938.78	Auto-generated transaction entry #495	2025-06-15 08:47:11.439519
2996	3	25	Transaction #496	2025-05-27	307.27	Auto-generated transaction entry #496	2025-06-15 08:47:11.439519
2997	3	22	Transaction #497	2025-06-10	323.19	Auto-generated transaction entry #497	2025-06-15 08:47:11.439519
2998	3	23	Transaction #498	2025-05-27	593.51	Auto-generated transaction entry #498	2025-06-15 08:47:11.439519
2999	3	23	Transaction #499	2025-06-13	274.63	Auto-generated transaction entry #499	2025-06-15 08:47:11.439519
3000	3	24	Transaction #500	2025-05-30	365.80	Auto-generated transaction entry #500	2025-06-15 08:47:11.439519
3001	4	35	Transaction #1	2025-05-17	536.46	Auto-generated transaction entry #1	2025-06-15 08:47:19.061659
3002	4	33	Transaction #2	2025-06-14	128.47	Auto-generated transaction entry #2	2025-06-15 08:47:19.061659
3003	4	35	Transaction #3	2025-06-11	62.45	Auto-generated transaction entry #3	2025-06-15 08:47:19.061659
3004	4	34	Transaction #4	2025-06-10	850.60	Auto-generated transaction entry #4	2025-06-15 08:47:19.061659
3005	4	33	Transaction #5	2025-06-02	698.54	Auto-generated transaction entry #5	2025-06-15 08:47:19.061659
3006	4	31	Transaction #6	2025-06-09	196.36	Auto-generated transaction entry #6	2025-06-15 08:47:19.061659
3007	4	33	Transaction #7	2025-05-24	892.44	Auto-generated transaction entry #7	2025-06-15 08:47:19.061659
3008	4	35	Transaction #8	2025-06-02	389.57	Auto-generated transaction entry #8	2025-06-15 08:47:19.061659
3009	4	34	Transaction #9	2025-06-07	326.58	Auto-generated transaction entry #9	2025-06-15 08:47:19.061659
3010	4	31	Transaction #10	2025-05-20	355.57	Auto-generated transaction entry #10	2025-06-15 08:47:19.061659
3011	4	34	Transaction #11	2025-06-08	945.39	Auto-generated transaction entry #11	2025-06-15 08:47:19.061659
3012	4	33	Transaction #12	2025-05-30	281.05	Auto-generated transaction entry #12	2025-06-15 08:47:19.061659
3013	4	34	Transaction #13	2025-06-12	127.51	Auto-generated transaction entry #13	2025-06-15 08:47:19.061659
3014	4	35	Transaction #14	2025-05-25	362.02	Auto-generated transaction entry #14	2025-06-15 08:47:19.061659
3015	4	34	Transaction #15	2025-05-17	587.42	Auto-generated transaction entry #15	2025-06-15 08:47:19.061659
3016	4	31	Transaction #16	2025-05-29	578.94	Auto-generated transaction entry #16	2025-06-15 08:47:19.061659
3017	4	35	Transaction #17	2025-05-19	881.58	Auto-generated transaction entry #17	2025-06-15 08:47:19.061659
3018	4	33	Transaction #18	2025-06-15	453.85	Auto-generated transaction entry #18	2025-06-15 08:47:19.061659
3019	4	34	Transaction #19	2025-05-21	558.08	Auto-generated transaction entry #19	2025-06-15 08:47:19.061659
3020	4	34	Transaction #20	2025-05-24	620.09	Auto-generated transaction entry #20	2025-06-15 08:47:19.061659
3021	4	33	Transaction #21	2025-06-06	845.58	Auto-generated transaction entry #21	2025-06-15 08:47:19.061659
3022	4	32	Transaction #22	2025-06-01	878.73	Auto-generated transaction entry #22	2025-06-15 08:47:19.061659
3023	4	35	Transaction #23	2025-06-09	423.69	Auto-generated transaction entry #23	2025-06-15 08:47:19.061659
3024	4	33	Transaction #24	2025-05-31	59.38	Auto-generated transaction entry #24	2025-06-15 08:47:19.061659
3025	4	33	Transaction #25	2025-06-01	339.35	Auto-generated transaction entry #25	2025-06-15 08:47:19.061659
3026	4	32	Transaction #26	2025-05-19	645.66	Auto-generated transaction entry #26	2025-06-15 08:47:19.061659
3027	4	33	Transaction #27	2025-06-14	701.32	Auto-generated transaction entry #27	2025-06-15 08:47:19.061659
3028	4	33	Transaction #28	2025-05-20	990.48	Auto-generated transaction entry #28	2025-06-15 08:47:19.061659
3029	4	34	Transaction #29	2025-05-28	708.49	Auto-generated transaction entry #29	2025-06-15 08:47:19.061659
3030	4	31	Transaction #30	2025-06-15	539.88	Auto-generated transaction entry #30	2025-06-15 08:47:19.061659
3031	4	34	Transaction #31	2025-06-08	550.36	Auto-generated transaction entry #31	2025-06-15 08:47:19.061659
3032	4	33	Transaction #32	2025-05-17	451.32	Auto-generated transaction entry #32	2025-06-15 08:47:19.061659
3033	4	32	Transaction #33	2025-06-06	324.71	Auto-generated transaction entry #33	2025-06-15 08:47:19.061659
3034	4	32	Transaction #34	2025-06-07	894.68	Auto-generated transaction entry #34	2025-06-15 08:47:19.061659
3035	4	32	Transaction #35	2025-06-05	424.81	Auto-generated transaction entry #35	2025-06-15 08:47:19.061659
3036	4	35	Transaction #36	2025-06-12	582.72	Auto-generated transaction entry #36	2025-06-15 08:47:19.061659
3037	4	33	Transaction #37	2025-06-12	112.48	Auto-generated transaction entry #37	2025-06-15 08:47:19.061659
3038	4	33	Transaction #38	2025-06-14	698.54	Auto-generated transaction entry #38	2025-06-15 08:47:19.061659
3039	4	31	Transaction #39	2025-06-03	996.42	Auto-generated transaction entry #39	2025-06-15 08:47:19.061659
3040	4	35	Transaction #40	2025-05-29	686.62	Auto-generated transaction entry #40	2025-06-15 08:47:19.061659
3041	4	33	Transaction #41	2025-05-20	630.48	Auto-generated transaction entry #41	2025-06-15 08:47:19.061659
3042	4	32	Transaction #42	2025-06-03	644.56	Auto-generated transaction entry #42	2025-06-15 08:47:19.061659
3043	4	35	Transaction #43	2025-06-09	536.93	Auto-generated transaction entry #43	2025-06-15 08:47:19.061659
3044	4	31	Transaction #44	2025-05-20	215.22	Auto-generated transaction entry #44	2025-06-15 08:47:19.061659
3045	4	31	Transaction #45	2025-06-05	816.10	Auto-generated transaction entry #45	2025-06-15 08:47:19.061659
3046	4	32	Transaction #46	2025-06-09	356.26	Auto-generated transaction entry #46	2025-06-15 08:47:19.061659
3047	4	35	Transaction #47	2025-06-10	745.22	Auto-generated transaction entry #47	2025-06-15 08:47:19.061659
3048	4	31	Transaction #48	2025-05-23	685.44	Auto-generated transaction entry #48	2025-06-15 08:47:19.061659
3049	4	34	Transaction #49	2025-05-19	281.29	Auto-generated transaction entry #49	2025-06-15 08:47:19.061659
3050	4	34	Transaction #50	2025-05-17	707.49	Auto-generated transaction entry #50	2025-06-15 08:47:19.061659
3051	4	31	Transaction #51	2025-06-12	776.80	Auto-generated transaction entry #51	2025-06-15 08:47:19.061659
3052	4	31	Transaction #52	2025-05-22	232.82	Auto-generated transaction entry #52	2025-06-15 08:47:19.061659
3053	4	33	Transaction #53	2025-06-05	783.65	Auto-generated transaction entry #53	2025-06-15 08:47:19.061659
3054	4	34	Transaction #54	2025-06-04	854.82	Auto-generated transaction entry #54	2025-06-15 08:47:19.061659
3055	4	35	Transaction #55	2025-05-26	707.48	Auto-generated transaction entry #55	2025-06-15 08:47:19.061659
3056	4	35	Transaction #56	2025-06-15	882.05	Auto-generated transaction entry #56	2025-06-15 08:47:19.061659
3057	4	34	Transaction #57	2025-06-07	291.39	Auto-generated transaction entry #57	2025-06-15 08:47:19.061659
3058	4	31	Transaction #58	2025-05-31	277.60	Auto-generated transaction entry #58	2025-06-15 08:47:19.061659
3059	4	33	Transaction #59	2025-06-06	843.34	Auto-generated transaction entry #59	2025-06-15 08:47:19.061659
3060	4	35	Transaction #60	2025-06-09	965.43	Auto-generated transaction entry #60	2025-06-15 08:47:19.061659
3061	4	32	Transaction #61	2025-05-21	249.18	Auto-generated transaction entry #61	2025-06-15 08:47:19.061659
3062	4	33	Transaction #62	2025-05-29	478.85	Auto-generated transaction entry #62	2025-06-15 08:47:19.061659
3063	4	35	Transaction #63	2025-05-22	524.64	Auto-generated transaction entry #63	2025-06-15 08:47:19.061659
3064	4	34	Transaction #64	2025-06-01	880.26	Auto-generated transaction entry #64	2025-06-15 08:47:19.061659
3065	4	31	Transaction #65	2025-06-15	164.40	Auto-generated transaction entry #65	2025-06-15 08:47:19.061659
3066	4	33	Transaction #66	2025-06-10	473.54	Auto-generated transaction entry #66	2025-06-15 08:47:19.061659
3067	4	33	Transaction #67	2025-05-28	326.49	Auto-generated transaction entry #67	2025-06-15 08:47:19.061659
3068	4	35	Transaction #68	2025-05-20	154.78	Auto-generated transaction entry #68	2025-06-15 08:47:19.061659
3069	4	31	Transaction #69	2025-06-11	215.70	Auto-generated transaction entry #69	2025-06-15 08:47:19.061659
3070	4	33	Transaction #70	2025-05-23	296.24	Auto-generated transaction entry #70	2025-06-15 08:47:19.061659
3071	4	32	Transaction #71	2025-05-17	711.34	Auto-generated transaction entry #71	2025-06-15 08:47:19.061659
3072	4	34	Transaction #72	2025-05-25	145.95	Auto-generated transaction entry #72	2025-06-15 08:47:19.061659
3073	4	34	Transaction #73	2025-05-26	791.16	Auto-generated transaction entry #73	2025-06-15 08:47:19.061659
3074	4	34	Transaction #74	2025-06-14	123.09	Auto-generated transaction entry #74	2025-06-15 08:47:19.061659
3075	4	31	Transaction #75	2025-05-26	723.22	Auto-generated transaction entry #75	2025-06-15 08:47:19.061659
3076	4	35	Transaction #76	2025-06-08	205.18	Auto-generated transaction entry #76	2025-06-15 08:47:19.061659
3077	4	35	Transaction #77	2025-06-07	945.68	Auto-generated transaction entry #77	2025-06-15 08:47:19.061659
3078	4	32	Transaction #78	2025-05-21	718.33	Auto-generated transaction entry #78	2025-06-15 08:47:19.061659
3079	4	35	Transaction #79	2025-05-18	680.49	Auto-generated transaction entry #79	2025-06-15 08:47:19.061659
3080	4	32	Transaction #80	2025-06-12	73.04	Auto-generated transaction entry #80	2025-06-15 08:47:19.061659
3081	4	34	Transaction #81	2025-06-07	248.90	Auto-generated transaction entry #81	2025-06-15 08:47:19.061659
3082	4	35	Transaction #82	2025-05-20	798.00	Auto-generated transaction entry #82	2025-06-15 08:47:19.061659
3083	4	35	Transaction #83	2025-06-01	525.20	Auto-generated transaction entry #83	2025-06-15 08:47:19.061659
3084	4	33	Transaction #84	2025-06-02	897.44	Auto-generated transaction entry #84	2025-06-15 08:47:19.061659
3085	4	35	Transaction #85	2025-05-18	698.82	Auto-generated transaction entry #85	2025-06-15 08:47:19.061659
3086	4	32	Transaction #86	2025-06-09	151.15	Auto-generated transaction entry #86	2025-06-15 08:47:19.061659
3087	4	34	Transaction #87	2025-05-20	309.03	Auto-generated transaction entry #87	2025-06-15 08:47:19.061659
3088	4	35	Transaction #88	2025-05-17	735.52	Auto-generated transaction entry #88	2025-06-15 08:47:19.061659
3089	4	33	Transaction #89	2025-06-09	393.66	Auto-generated transaction entry #89	2025-06-15 08:47:19.061659
3090	4	33	Transaction #90	2025-05-21	917.45	Auto-generated transaction entry #90	2025-06-15 08:47:19.061659
3091	4	34	Transaction #91	2025-06-10	418.41	Auto-generated transaction entry #91	2025-06-15 08:47:19.061659
3092	4	31	Transaction #92	2025-05-30	901.26	Auto-generated transaction entry #92	2025-06-15 08:47:19.061659
3093	4	31	Transaction #93	2025-06-09	253.83	Auto-generated transaction entry #93	2025-06-15 08:47:19.061659
3094	4	35	Transaction #94	2025-05-23	931.21	Auto-generated transaction entry #94	2025-06-15 08:47:19.061659
3095	4	31	Transaction #95	2025-05-17	784.21	Auto-generated transaction entry #95	2025-06-15 08:47:19.061659
3096	4	35	Transaction #96	2025-05-30	808.11	Auto-generated transaction entry #96	2025-06-15 08:47:19.061659
3097	4	33	Transaction #97	2025-06-13	713.55	Auto-generated transaction entry #97	2025-06-15 08:47:19.061659
3098	4	33	Transaction #98	2025-05-29	468.35	Auto-generated transaction entry #98	2025-06-15 08:47:19.061659
3099	4	34	Transaction #99	2025-05-31	94.16	Auto-generated transaction entry #99	2025-06-15 08:47:19.061659
3100	4	35	Transaction #100	2025-05-20	813.61	Auto-generated transaction entry #100	2025-06-15 08:47:19.061659
3101	4	33	Transaction #101	2025-06-04	136.50	Auto-generated transaction entry #101	2025-06-15 08:47:19.061659
3102	4	33	Transaction #102	2025-06-12	640.73	Auto-generated transaction entry #102	2025-06-15 08:47:19.061659
3103	4	34	Transaction #103	2025-06-06	610.26	Auto-generated transaction entry #103	2025-06-15 08:47:19.061659
3104	4	35	Transaction #104	2025-06-09	818.94	Auto-generated transaction entry #104	2025-06-15 08:47:19.061659
3105	4	33	Transaction #105	2025-06-04	696.14	Auto-generated transaction entry #105	2025-06-15 08:47:19.061659
3106	4	33	Transaction #106	2025-05-25	897.36	Auto-generated transaction entry #106	2025-06-15 08:47:19.061659
3107	4	33	Transaction #107	2025-05-27	828.07	Auto-generated transaction entry #107	2025-06-15 08:47:19.061659
3108	4	32	Transaction #108	2025-06-02	241.85	Auto-generated transaction entry #108	2025-06-15 08:47:19.061659
3109	4	32	Transaction #109	2025-05-21	436.36	Auto-generated transaction entry #109	2025-06-15 08:47:19.061659
3110	4	34	Transaction #110	2025-06-07	63.76	Auto-generated transaction entry #110	2025-06-15 08:47:19.061659
3111	4	31	Transaction #111	2025-06-06	892.94	Auto-generated transaction entry #111	2025-06-15 08:47:19.061659
3112	4	32	Transaction #112	2025-06-15	241.18	Auto-generated transaction entry #112	2025-06-15 08:47:19.061659
3113	4	32	Transaction #113	2025-05-26	408.88	Auto-generated transaction entry #113	2025-06-15 08:47:19.061659
3114	4	35	Transaction #114	2025-06-13	855.27	Auto-generated transaction entry #114	2025-06-15 08:47:19.061659
3115	4	35	Transaction #115	2025-05-30	158.70	Auto-generated transaction entry #115	2025-06-15 08:47:19.061659
3116	4	32	Transaction #116	2025-05-31	521.45	Auto-generated transaction entry #116	2025-06-15 08:47:19.061659
3117	4	35	Transaction #117	2025-06-08	455.58	Auto-generated transaction entry #117	2025-06-15 08:47:19.061659
3118	4	34	Transaction #118	2025-06-13	439.38	Auto-generated transaction entry #118	2025-06-15 08:47:19.061659
3119	4	33	Transaction #119	2025-06-08	914.41	Auto-generated transaction entry #119	2025-06-15 08:47:19.061659
3120	4	34	Transaction #120	2025-05-27	751.97	Auto-generated transaction entry #120	2025-06-15 08:47:19.061659
3121	4	35	Transaction #121	2025-06-04	73.83	Auto-generated transaction entry #121	2025-06-15 08:47:19.061659
3122	4	33	Transaction #122	2025-06-07	963.74	Auto-generated transaction entry #122	2025-06-15 08:47:19.061659
3123	4	33	Transaction #123	2025-06-05	413.03	Auto-generated transaction entry #123	2025-06-15 08:47:19.061659
3124	4	33	Transaction #124	2025-05-25	536.49	Auto-generated transaction entry #124	2025-06-15 08:47:19.061659
3125	4	35	Transaction #125	2025-06-04	100.05	Auto-generated transaction entry #125	2025-06-15 08:47:19.061659
3126	4	32	Transaction #126	2025-05-30	495.77	Auto-generated transaction entry #126	2025-06-15 08:47:19.061659
3127	4	32	Transaction #127	2025-05-26	385.25	Auto-generated transaction entry #127	2025-06-15 08:47:19.061659
3128	4	35	Transaction #128	2025-05-19	450.69	Auto-generated transaction entry #128	2025-06-15 08:47:19.061659
3129	4	33	Transaction #129	2025-06-10	75.96	Auto-generated transaction entry #129	2025-06-15 08:47:19.061659
3130	4	32	Transaction #130	2025-05-20	143.50	Auto-generated transaction entry #130	2025-06-15 08:47:19.061659
3131	4	34	Transaction #131	2025-06-06	706.09	Auto-generated transaction entry #131	2025-06-15 08:47:19.061659
3132	4	31	Transaction #132	2025-06-09	715.16	Auto-generated transaction entry #132	2025-06-15 08:47:19.061659
3133	4	31	Transaction #133	2025-05-31	881.27	Auto-generated transaction entry #133	2025-06-15 08:47:19.061659
3134	4	34	Transaction #134	2025-06-01	260.92	Auto-generated transaction entry #134	2025-06-15 08:47:19.061659
3135	4	33	Transaction #135	2025-05-23	677.67	Auto-generated transaction entry #135	2025-06-15 08:47:19.061659
3136	4	32	Transaction #136	2025-06-10	258.30	Auto-generated transaction entry #136	2025-06-15 08:47:19.061659
3137	4	32	Transaction #137	2025-06-14	374.61	Auto-generated transaction entry #137	2025-06-15 08:47:19.061659
3138	4	31	Transaction #138	2025-06-14	914.40	Auto-generated transaction entry #138	2025-06-15 08:47:19.061659
3139	4	31	Transaction #139	2025-06-11	409.98	Auto-generated transaction entry #139	2025-06-15 08:47:19.061659
3140	4	32	Transaction #140	2025-05-20	469.14	Auto-generated transaction entry #140	2025-06-15 08:47:19.061659
3141	4	32	Transaction #141	2025-05-21	95.71	Auto-generated transaction entry #141	2025-06-15 08:47:19.061659
3142	4	33	Transaction #142	2025-06-05	903.58	Auto-generated transaction entry #142	2025-06-15 08:47:19.061659
3143	4	32	Transaction #143	2025-06-14	735.15	Auto-generated transaction entry #143	2025-06-15 08:47:19.061659
3144	4	35	Transaction #144	2025-06-06	812.69	Auto-generated transaction entry #144	2025-06-15 08:47:19.061659
3145	4	35	Transaction #145	2025-06-06	829.37	Auto-generated transaction entry #145	2025-06-15 08:47:19.061659
3146	4	35	Transaction #146	2025-06-10	443.75	Auto-generated transaction entry #146	2025-06-15 08:47:19.061659
3147	4	32	Transaction #147	2025-06-03	383.91	Auto-generated transaction entry #147	2025-06-15 08:47:19.061659
3148	4	33	Transaction #148	2025-05-27	225.49	Auto-generated transaction entry #148	2025-06-15 08:47:19.061659
3149	4	33	Transaction #149	2025-06-11	282.24	Auto-generated transaction entry #149	2025-06-15 08:47:19.061659
3150	4	33	Transaction #150	2025-05-27	97.19	Auto-generated transaction entry #150	2025-06-15 08:47:19.061659
3151	4	32	Transaction #151	2025-05-25	879.15	Auto-generated transaction entry #151	2025-06-15 08:47:19.061659
3152	4	34	Transaction #152	2025-05-23	175.33	Auto-generated transaction entry #152	2025-06-15 08:47:19.061659
3153	4	32	Transaction #153	2025-05-17	722.14	Auto-generated transaction entry #153	2025-06-15 08:47:19.061659
3154	4	34	Transaction #154	2025-05-22	347.30	Auto-generated transaction entry #154	2025-06-15 08:47:19.061659
3155	4	35	Transaction #155	2025-06-01	301.71	Auto-generated transaction entry #155	2025-06-15 08:47:19.061659
3156	4	32	Transaction #156	2025-06-03	398.78	Auto-generated transaction entry #156	2025-06-15 08:47:19.061659
3157	4	31	Transaction #157	2025-05-21	188.92	Auto-generated transaction entry #157	2025-06-15 08:47:19.061659
3158	4	33	Transaction #158	2025-06-08	801.21	Auto-generated transaction entry #158	2025-06-15 08:47:19.061659
3159	4	32	Transaction #159	2025-05-25	441.28	Auto-generated transaction entry #159	2025-06-15 08:47:19.061659
3160	4	35	Transaction #160	2025-06-05	424.65	Auto-generated transaction entry #160	2025-06-15 08:47:19.061659
3161	4	33	Transaction #161	2025-05-22	229.47	Auto-generated transaction entry #161	2025-06-15 08:47:19.061659
3162	4	31	Transaction #162	2025-06-10	864.90	Auto-generated transaction entry #162	2025-06-15 08:47:19.061659
3163	4	32	Transaction #163	2025-05-28	486.92	Auto-generated transaction entry #163	2025-06-15 08:47:19.061659
3164	4	34	Transaction #164	2025-06-13	240.72	Auto-generated transaction entry #164	2025-06-15 08:47:19.061659
3165	4	34	Transaction #165	2025-05-19	516.98	Auto-generated transaction entry #165	2025-06-15 08:47:19.061659
3166	4	35	Transaction #166	2025-05-23	537.23	Auto-generated transaction entry #166	2025-06-15 08:47:19.061659
3167	4	31	Transaction #167	2025-06-13	519.35	Auto-generated transaction entry #167	2025-06-15 08:47:19.061659
3168	4	32	Transaction #168	2025-05-24	755.60	Auto-generated transaction entry #168	2025-06-15 08:47:19.061659
3169	4	33	Transaction #169	2025-05-29	578.83	Auto-generated transaction entry #169	2025-06-15 08:47:19.061659
3170	4	34	Transaction #170	2025-05-17	697.88	Auto-generated transaction entry #170	2025-06-15 08:47:19.061659
3171	4	33	Transaction #171	2025-06-08	782.88	Auto-generated transaction entry #171	2025-06-15 08:47:19.061659
3172	4	34	Transaction #172	2025-05-29	435.57	Auto-generated transaction entry #172	2025-06-15 08:47:19.061659
3173	4	33	Transaction #173	2025-06-10	307.88	Auto-generated transaction entry #173	2025-06-15 08:47:19.061659
3174	4	32	Transaction #174	2025-05-16	982.40	Auto-generated transaction entry #174	2025-06-15 08:47:19.061659
3175	4	34	Transaction #175	2025-06-11	241.23	Auto-generated transaction entry #175	2025-06-15 08:47:19.061659
3176	4	31	Transaction #176	2025-06-02	164.22	Auto-generated transaction entry #176	2025-06-15 08:47:19.061659
3177	4	31	Transaction #177	2025-05-27	412.20	Auto-generated transaction entry #177	2025-06-15 08:47:19.061659
3178	4	33	Transaction #178	2025-06-08	452.36	Auto-generated transaction entry #178	2025-06-15 08:47:19.061659
3179	4	33	Transaction #179	2025-05-24	603.19	Auto-generated transaction entry #179	2025-06-15 08:47:19.061659
3180	4	35	Transaction #180	2025-05-26	375.92	Auto-generated transaction entry #180	2025-06-15 08:47:19.061659
3181	4	34	Transaction #181	2025-05-29	716.29	Auto-generated transaction entry #181	2025-06-15 08:47:19.061659
3182	4	35	Transaction #182	2025-06-14	965.29	Auto-generated transaction entry #182	2025-06-15 08:47:19.061659
3183	4	33	Transaction #183	2025-05-25	763.05	Auto-generated transaction entry #183	2025-06-15 08:47:19.061659
3184	4	34	Transaction #184	2025-05-31	346.13	Auto-generated transaction entry #184	2025-06-15 08:47:19.061659
3185	4	34	Transaction #185	2025-05-25	485.81	Auto-generated transaction entry #185	2025-06-15 08:47:19.061659
3186	4	35	Transaction #186	2025-06-08	764.05	Auto-generated transaction entry #186	2025-06-15 08:47:19.061659
3187	4	35	Transaction #187	2025-06-07	735.79	Auto-generated transaction entry #187	2025-06-15 08:47:19.061659
3188	4	35	Transaction #188	2025-05-24	970.75	Auto-generated transaction entry #188	2025-06-15 08:47:19.061659
3189	4	35	Transaction #189	2025-06-14	890.12	Auto-generated transaction entry #189	2025-06-15 08:47:19.061659
3190	4	34	Transaction #190	2025-06-12	625.17	Auto-generated transaction entry #190	2025-06-15 08:47:19.061659
3191	4	34	Transaction #191	2025-05-21	138.50	Auto-generated transaction entry #191	2025-06-15 08:47:19.061659
3192	4	35	Transaction #192	2025-05-16	591.80	Auto-generated transaction entry #192	2025-06-15 08:47:19.061659
3193	4	34	Transaction #193	2025-06-06	920.83	Auto-generated transaction entry #193	2025-06-15 08:47:19.061659
3194	4	33	Transaction #194	2025-05-21	184.33	Auto-generated transaction entry #194	2025-06-15 08:47:19.061659
3195	4	31	Transaction #195	2025-05-26	942.11	Auto-generated transaction entry #195	2025-06-15 08:47:19.061659
3196	4	31	Transaction #196	2025-05-30	888.25	Auto-generated transaction entry #196	2025-06-15 08:47:19.061659
3197	4	33	Transaction #197	2025-05-19	712.75	Auto-generated transaction entry #197	2025-06-15 08:47:19.061659
3198	4	34	Transaction #198	2025-06-01	218.40	Auto-generated transaction entry #198	2025-06-15 08:47:19.061659
3199	4	31	Transaction #199	2025-05-26	695.15	Auto-generated transaction entry #199	2025-06-15 08:47:19.061659
3200	4	32	Transaction #200	2025-06-15	482.44	Auto-generated transaction entry #200	2025-06-15 08:47:19.061659
3201	4	34	Transaction #201	2025-06-07	135.16	Auto-generated transaction entry #201	2025-06-15 08:47:19.061659
3202	4	31	Transaction #202	2025-06-03	649.21	Auto-generated transaction entry #202	2025-06-15 08:47:19.061659
3203	4	33	Transaction #203	2025-06-04	409.27	Auto-generated transaction entry #203	2025-06-15 08:47:19.061659
3204	4	34	Transaction #204	2025-06-03	544.94	Auto-generated transaction entry #204	2025-06-15 08:47:19.061659
3205	4	32	Transaction #205	2025-06-11	446.63	Auto-generated transaction entry #205	2025-06-15 08:47:19.061659
3206	4	35	Transaction #206	2025-05-16	498.20	Auto-generated transaction entry #206	2025-06-15 08:47:19.061659
3207	4	33	Transaction #207	2025-05-27	288.12	Auto-generated transaction entry #207	2025-06-15 08:47:19.061659
3208	4	35	Transaction #208	2025-05-17	768.76	Auto-generated transaction entry #208	2025-06-15 08:47:19.061659
3209	4	34	Transaction #209	2025-05-21	554.88	Auto-generated transaction entry #209	2025-06-15 08:47:19.061659
3210	4	33	Transaction #210	2025-06-14	831.94	Auto-generated transaction entry #210	2025-06-15 08:47:19.061659
3211	4	34	Transaction #211	2025-06-14	680.36	Auto-generated transaction entry #211	2025-06-15 08:47:19.061659
3212	4	31	Transaction #212	2025-05-25	724.49	Auto-generated transaction entry #212	2025-06-15 08:47:19.061659
3213	4	32	Transaction #213	2025-06-08	685.56	Auto-generated transaction entry #213	2025-06-15 08:47:19.061659
3214	4	35	Transaction #214	2025-06-01	396.14	Auto-generated transaction entry #214	2025-06-15 08:47:19.061659
3215	4	33	Transaction #215	2025-05-20	965.67	Auto-generated transaction entry #215	2025-06-15 08:47:19.061659
3216	4	32	Transaction #216	2025-05-22	852.87	Auto-generated transaction entry #216	2025-06-15 08:47:19.061659
3217	4	32	Transaction #217	2025-05-31	548.51	Auto-generated transaction entry #217	2025-06-15 08:47:19.061659
3218	4	34	Transaction #218	2025-05-21	146.27	Auto-generated transaction entry #218	2025-06-15 08:47:19.061659
3219	4	34	Transaction #219	2025-06-10	294.76	Auto-generated transaction entry #219	2025-06-15 08:47:19.061659
3220	4	34	Transaction #220	2025-05-22	948.61	Auto-generated transaction entry #220	2025-06-15 08:47:19.061659
3221	4	35	Transaction #221	2025-06-03	98.35	Auto-generated transaction entry #221	2025-06-15 08:47:19.061659
3222	4	33	Transaction #222	2025-06-01	911.08	Auto-generated transaction entry #222	2025-06-15 08:47:19.061659
3223	4	32	Transaction #223	2025-05-23	790.26	Auto-generated transaction entry #223	2025-06-15 08:47:19.061659
3224	4	34	Transaction #224	2025-06-07	614.20	Auto-generated transaction entry #224	2025-06-15 08:47:19.061659
3225	4	33	Transaction #225	2025-05-22	385.71	Auto-generated transaction entry #225	2025-06-15 08:47:19.061659
3226	4	34	Transaction #226	2025-05-30	240.89	Auto-generated transaction entry #226	2025-06-15 08:47:19.061659
3227	4	32	Transaction #227	2025-06-11	503.42	Auto-generated transaction entry #227	2025-06-15 08:47:19.061659
3228	4	34	Transaction #228	2025-06-13	834.33	Auto-generated transaction entry #228	2025-06-15 08:47:19.061659
3229	4	32	Transaction #229	2025-06-04	200.17	Auto-generated transaction entry #229	2025-06-15 08:47:19.061659
3230	4	35	Transaction #230	2025-05-31	867.67	Auto-generated transaction entry #230	2025-06-15 08:47:19.061659
3231	4	35	Transaction #231	2025-06-08	290.28	Auto-generated transaction entry #231	2025-06-15 08:47:19.061659
3232	4	31	Transaction #232	2025-06-02	317.01	Auto-generated transaction entry #232	2025-06-15 08:47:19.061659
3233	4	31	Transaction #233	2025-06-04	77.79	Auto-generated transaction entry #233	2025-06-15 08:47:19.061659
3234	4	31	Transaction #234	2025-06-02	504.71	Auto-generated transaction entry #234	2025-06-15 08:47:19.061659
3235	4	31	Transaction #235	2025-06-07	680.52	Auto-generated transaction entry #235	2025-06-15 08:47:19.061659
3236	4	32	Transaction #236	2025-05-26	995.75	Auto-generated transaction entry #236	2025-06-15 08:47:19.061659
3237	4	32	Transaction #237	2025-05-20	800.43	Auto-generated transaction entry #237	2025-06-15 08:47:19.061659
3238	4	34	Transaction #238	2025-06-11	300.05	Auto-generated transaction entry #238	2025-06-15 08:47:19.061659
3239	4	34	Transaction #239	2025-06-06	677.59	Auto-generated transaction entry #239	2025-06-15 08:47:19.061659
3240	4	31	Transaction #240	2025-06-10	611.92	Auto-generated transaction entry #240	2025-06-15 08:47:19.061659
3241	4	35	Transaction #241	2025-05-21	788.12	Auto-generated transaction entry #241	2025-06-15 08:47:19.061659
3242	4	32	Transaction #242	2025-06-12	376.70	Auto-generated transaction entry #242	2025-06-15 08:47:19.061659
3243	4	35	Transaction #243	2025-05-29	339.61	Auto-generated transaction entry #243	2025-06-15 08:47:19.061659
3244	4	34	Transaction #244	2025-05-31	82.62	Auto-generated transaction entry #244	2025-06-15 08:47:19.061659
3245	4	35	Transaction #245	2025-06-06	241.93	Auto-generated transaction entry #245	2025-06-15 08:47:19.061659
3246	4	33	Transaction #246	2025-05-27	158.22	Auto-generated transaction entry #246	2025-06-15 08:47:19.061659
3247	4	32	Transaction #247	2025-05-30	609.39	Auto-generated transaction entry #247	2025-06-15 08:47:19.061659
3248	4	34	Transaction #248	2025-05-16	547.52	Auto-generated transaction entry #248	2025-06-15 08:47:19.061659
3249	4	33	Transaction #249	2025-06-07	985.39	Auto-generated transaction entry #249	2025-06-15 08:47:19.061659
3250	4	32	Transaction #250	2025-06-11	532.48	Auto-generated transaction entry #250	2025-06-15 08:47:19.061659
3251	4	33	Transaction #251	2025-05-19	826.09	Auto-generated transaction entry #251	2025-06-15 08:47:19.061659
3252	4	31	Transaction #252	2025-06-09	122.19	Auto-generated transaction entry #252	2025-06-15 08:47:19.061659
3253	4	35	Transaction #253	2025-06-13	532.68	Auto-generated transaction entry #253	2025-06-15 08:47:19.061659
3254	4	35	Transaction #254	2025-05-25	502.82	Auto-generated transaction entry #254	2025-06-15 08:47:19.061659
3255	4	31	Transaction #255	2025-06-05	643.09	Auto-generated transaction entry #255	2025-06-15 08:47:19.061659
3256	4	32	Transaction #256	2025-06-10	874.14	Auto-generated transaction entry #256	2025-06-15 08:47:19.061659
3257	4	35	Transaction #257	2025-05-27	814.64	Auto-generated transaction entry #257	2025-06-15 08:47:19.061659
3258	4	32	Transaction #258	2025-06-06	900.49	Auto-generated transaction entry #258	2025-06-15 08:47:19.061659
3259	4	32	Transaction #259	2025-05-23	896.10	Auto-generated transaction entry #259	2025-06-15 08:47:19.061659
3260	4	33	Transaction #260	2025-06-02	735.87	Auto-generated transaction entry #260	2025-06-15 08:47:19.061659
3261	4	33	Transaction #261	2025-05-24	254.61	Auto-generated transaction entry #261	2025-06-15 08:47:19.061659
3262	4	31	Transaction #262	2025-06-10	627.27	Auto-generated transaction entry #262	2025-06-15 08:47:19.061659
3263	4	33	Transaction #263	2025-05-21	574.82	Auto-generated transaction entry #263	2025-06-15 08:47:19.061659
3264	4	31	Transaction #264	2025-06-03	675.88	Auto-generated transaction entry #264	2025-06-15 08:47:19.061659
3265	4	32	Transaction #265	2025-06-03	587.09	Auto-generated transaction entry #265	2025-06-15 08:47:19.061659
3266	4	32	Transaction #266	2025-06-07	51.45	Auto-generated transaction entry #266	2025-06-15 08:47:19.061659
3267	4	33	Transaction #267	2025-05-23	719.98	Auto-generated transaction entry #267	2025-06-15 08:47:19.061659
3268	4	33	Transaction #268	2025-06-15	642.51	Auto-generated transaction entry #268	2025-06-15 08:47:19.061659
3269	4	31	Transaction #269	2025-05-31	270.65	Auto-generated transaction entry #269	2025-06-15 08:47:19.061659
3270	4	34	Transaction #270	2025-05-23	80.76	Auto-generated transaction entry #270	2025-06-15 08:47:19.061659
3271	4	35	Transaction #271	2025-06-14	897.78	Auto-generated transaction entry #271	2025-06-15 08:47:19.061659
3272	4	35	Transaction #272	2025-06-01	973.27	Auto-generated transaction entry #272	2025-06-15 08:47:19.061659
3273	4	32	Transaction #273	2025-05-22	891.48	Auto-generated transaction entry #273	2025-06-15 08:47:19.061659
3274	4	33	Transaction #274	2025-06-01	384.86	Auto-generated transaction entry #274	2025-06-15 08:47:19.061659
3275	4	33	Transaction #275	2025-06-14	822.41	Auto-generated transaction entry #275	2025-06-15 08:47:19.061659
3276	4	33	Transaction #276	2025-05-28	367.20	Auto-generated transaction entry #276	2025-06-15 08:47:19.061659
3277	4	31	Transaction #277	2025-06-07	290.48	Auto-generated transaction entry #277	2025-06-15 08:47:19.061659
3278	4	35	Transaction #278	2025-06-11	373.11	Auto-generated transaction entry #278	2025-06-15 08:47:19.061659
3279	4	35	Transaction #279	2025-05-16	684.24	Auto-generated transaction entry #279	2025-06-15 08:47:19.061659
3280	4	33	Transaction #280	2025-05-21	671.78	Auto-generated transaction entry #280	2025-06-15 08:47:19.061659
3281	4	33	Transaction #281	2025-05-28	109.62	Auto-generated transaction entry #281	2025-06-15 08:47:19.061659
3282	4	33	Transaction #282	2025-05-27	821.75	Auto-generated transaction entry #282	2025-06-15 08:47:19.061659
3283	4	35	Transaction #283	2025-06-08	718.60	Auto-generated transaction entry #283	2025-06-15 08:47:19.061659
3284	4	32	Transaction #284	2025-06-06	66.71	Auto-generated transaction entry #284	2025-06-15 08:47:19.061659
3285	4	34	Transaction #285	2025-05-19	470.51	Auto-generated transaction entry #285	2025-06-15 08:47:19.061659
3286	4	32	Transaction #286	2025-06-08	881.15	Auto-generated transaction entry #286	2025-06-15 08:47:19.061659
3287	4	34	Transaction #287	2025-05-29	603.86	Auto-generated transaction entry #287	2025-06-15 08:47:19.061659
3288	4	34	Transaction #288	2025-05-27	700.78	Auto-generated transaction entry #288	2025-06-15 08:47:19.061659
3289	4	34	Transaction #289	2025-06-11	781.47	Auto-generated transaction entry #289	2025-06-15 08:47:19.061659
3290	4	31	Transaction #290	2025-06-03	679.01	Auto-generated transaction entry #290	2025-06-15 08:47:19.061659
3291	4	34	Transaction #291	2025-06-10	160.28	Auto-generated transaction entry #291	2025-06-15 08:47:19.061659
3292	4	33	Transaction #292	2025-06-11	470.54	Auto-generated transaction entry #292	2025-06-15 08:47:19.061659
3293	4	35	Transaction #293	2025-05-17	901.27	Auto-generated transaction entry #293	2025-06-15 08:47:19.061659
3294	4	35	Transaction #294	2025-05-29	682.99	Auto-generated transaction entry #294	2025-06-15 08:47:19.061659
3295	4	34	Transaction #295	2025-06-05	169.48	Auto-generated transaction entry #295	2025-06-15 08:47:19.061659
3296	4	31	Transaction #296	2025-06-09	94.14	Auto-generated transaction entry #296	2025-06-15 08:47:19.061659
3297	4	34	Transaction #297	2025-06-08	689.16	Auto-generated transaction entry #297	2025-06-15 08:47:19.061659
3298	4	31	Transaction #298	2025-05-19	924.38	Auto-generated transaction entry #298	2025-06-15 08:47:19.061659
3299	4	33	Transaction #299	2025-05-19	146.43	Auto-generated transaction entry #299	2025-06-15 08:47:19.061659
3300	4	32	Transaction #300	2025-05-18	276.89	Auto-generated transaction entry #300	2025-06-15 08:47:19.061659
3301	4	31	Transaction #301	2025-05-28	250.60	Auto-generated transaction entry #301	2025-06-15 08:47:19.061659
3302	4	31	Transaction #302	2025-06-09	833.49	Auto-generated transaction entry #302	2025-06-15 08:47:19.061659
3303	4	34	Transaction #303	2025-06-08	956.34	Auto-generated transaction entry #303	2025-06-15 08:47:19.061659
3304	4	31	Transaction #304	2025-05-19	156.44	Auto-generated transaction entry #304	2025-06-15 08:47:19.061659
3305	4	33	Transaction #305	2025-06-06	856.75	Auto-generated transaction entry #305	2025-06-15 08:47:19.061659
3306	4	32	Transaction #306	2025-06-03	559.70	Auto-generated transaction entry #306	2025-06-15 08:47:19.061659
3307	4	32	Transaction #307	2025-06-12	351.01	Auto-generated transaction entry #307	2025-06-15 08:47:19.061659
3308	4	32	Transaction #308	2025-05-19	61.42	Auto-generated transaction entry #308	2025-06-15 08:47:19.061659
3309	4	34	Transaction #309	2025-05-23	175.68	Auto-generated transaction entry #309	2025-06-15 08:47:19.061659
3310	4	33	Transaction #310	2025-06-06	226.93	Auto-generated transaction entry #310	2025-06-15 08:47:19.061659
3311	4	34	Transaction #311	2025-05-16	294.56	Auto-generated transaction entry #311	2025-06-15 08:47:19.061659
3312	4	34	Transaction #312	2025-05-26	992.50	Auto-generated transaction entry #312	2025-06-15 08:47:19.061659
3313	4	32	Transaction #313	2025-05-18	762.06	Auto-generated transaction entry #313	2025-06-15 08:47:19.061659
3314	4	31	Transaction #314	2025-06-11	513.87	Auto-generated transaction entry #314	2025-06-15 08:47:19.061659
3315	4	34	Transaction #315	2025-06-09	678.09	Auto-generated transaction entry #315	2025-06-15 08:47:19.061659
3316	4	34	Transaction #316	2025-05-28	226.80	Auto-generated transaction entry #316	2025-06-15 08:47:19.061659
3317	4	31	Transaction #317	2025-06-10	752.45	Auto-generated transaction entry #317	2025-06-15 08:47:19.061659
3318	4	32	Transaction #318	2025-05-30	56.72	Auto-generated transaction entry #318	2025-06-15 08:47:19.061659
3319	4	34	Transaction #319	2025-06-02	568.28	Auto-generated transaction entry #319	2025-06-15 08:47:19.061659
3320	4	31	Transaction #320	2025-06-02	656.08	Auto-generated transaction entry #320	2025-06-15 08:47:19.061659
3321	4	31	Transaction #321	2025-06-03	198.57	Auto-generated transaction entry #321	2025-06-15 08:47:19.061659
3322	4	32	Transaction #322	2025-06-09	612.89	Auto-generated transaction entry #322	2025-06-15 08:47:19.061659
3323	4	35	Transaction #323	2025-05-26	449.99	Auto-generated transaction entry #323	2025-06-15 08:47:19.061659
3324	4	33	Transaction #324	2025-06-04	790.10	Auto-generated transaction entry #324	2025-06-15 08:47:19.061659
3325	4	35	Transaction #325	2025-06-03	186.99	Auto-generated transaction entry #325	2025-06-15 08:47:19.061659
3326	4	34	Transaction #326	2025-05-31	121.35	Auto-generated transaction entry #326	2025-06-15 08:47:19.061659
3327	4	31	Transaction #327	2025-06-13	335.09	Auto-generated transaction entry #327	2025-06-15 08:47:19.061659
3328	4	35	Transaction #328	2025-05-17	814.80	Auto-generated transaction entry #328	2025-06-15 08:47:19.061659
3329	4	33	Transaction #329	2025-05-30	258.67	Auto-generated transaction entry #329	2025-06-15 08:47:19.061659
3330	4	32	Transaction #330	2025-05-31	352.77	Auto-generated transaction entry #330	2025-06-15 08:47:19.061659
3331	4	33	Transaction #331	2025-05-27	980.50	Auto-generated transaction entry #331	2025-06-15 08:47:19.061659
3332	4	34	Transaction #332	2025-05-30	563.19	Auto-generated transaction entry #332	2025-06-15 08:47:19.061659
3333	4	34	Transaction #333	2025-05-21	887.58	Auto-generated transaction entry #333	2025-06-15 08:47:19.061659
3334	4	34	Transaction #334	2025-06-13	828.44	Auto-generated transaction entry #334	2025-06-15 08:47:19.061659
3335	4	35	Transaction #335	2025-06-07	338.20	Auto-generated transaction entry #335	2025-06-15 08:47:19.061659
3336	4	33	Transaction #336	2025-05-25	95.94	Auto-generated transaction entry #336	2025-06-15 08:47:19.061659
3337	4	31	Transaction #337	2025-05-19	599.57	Auto-generated transaction entry #337	2025-06-15 08:47:19.061659
3338	4	34	Transaction #338	2025-06-07	363.22	Auto-generated transaction entry #338	2025-06-15 08:47:19.061659
3339	4	31	Transaction #339	2025-06-09	806.91	Auto-generated transaction entry #339	2025-06-15 08:47:19.061659
3340	4	33	Transaction #340	2025-06-06	718.04	Auto-generated transaction entry #340	2025-06-15 08:47:19.061659
3341	4	31	Transaction #341	2025-05-27	471.71	Auto-generated transaction entry #341	2025-06-15 08:47:19.061659
3342	4	33	Transaction #342	2025-06-15	687.62	Auto-generated transaction entry #342	2025-06-15 08:47:19.061659
3343	4	33	Transaction #343	2025-05-24	141.89	Auto-generated transaction entry #343	2025-06-15 08:47:19.061659
3344	4	31	Transaction #344	2025-05-19	333.98	Auto-generated transaction entry #344	2025-06-15 08:47:19.061659
3345	4	33	Transaction #345	2025-06-04	896.02	Auto-generated transaction entry #345	2025-06-15 08:47:19.061659
3346	4	33	Transaction #346	2025-05-23	595.04	Auto-generated transaction entry #346	2025-06-15 08:47:19.061659
3347	4	31	Transaction #347	2025-06-04	316.48	Auto-generated transaction entry #347	2025-06-15 08:47:19.061659
3348	4	33	Transaction #348	2025-06-12	509.80	Auto-generated transaction entry #348	2025-06-15 08:47:19.061659
3349	4	33	Transaction #349	2025-06-01	232.76	Auto-generated transaction entry #349	2025-06-15 08:47:19.061659
3350	4	31	Transaction #350	2025-05-23	504.67	Auto-generated transaction entry #350	2025-06-15 08:47:19.061659
3351	4	34	Transaction #351	2025-06-11	882.88	Auto-generated transaction entry #351	2025-06-15 08:47:19.061659
3352	4	32	Transaction #352	2025-05-17	546.36	Auto-generated transaction entry #352	2025-06-15 08:47:19.061659
3353	4	35	Transaction #353	2025-06-07	613.70	Auto-generated transaction entry #353	2025-06-15 08:47:19.061659
3354	4	31	Transaction #354	2025-05-31	128.46	Auto-generated transaction entry #354	2025-06-15 08:47:19.061659
3355	4	34	Transaction #355	2025-05-18	889.25	Auto-generated transaction entry #355	2025-06-15 08:47:19.061659
3356	4	32	Transaction #356	2025-05-31	264.84	Auto-generated transaction entry #356	2025-06-15 08:47:19.061659
3357	4	35	Transaction #357	2025-06-06	861.42	Auto-generated transaction entry #357	2025-06-15 08:47:19.061659
3358	4	35	Transaction #358	2025-06-01	865.18	Auto-generated transaction entry #358	2025-06-15 08:47:19.061659
3359	4	35	Transaction #359	2025-06-12	572.80	Auto-generated transaction entry #359	2025-06-15 08:47:19.061659
3360	4	32	Transaction #360	2025-06-06	393.08	Auto-generated transaction entry #360	2025-06-15 08:47:19.061659
3361	4	31	Transaction #361	2025-05-28	145.21	Auto-generated transaction entry #361	2025-06-15 08:47:19.061659
3362	4	35	Transaction #362	2025-05-21	858.37	Auto-generated transaction entry #362	2025-06-15 08:47:19.061659
3363	4	32	Transaction #363	2025-05-19	76.74	Auto-generated transaction entry #363	2025-06-15 08:47:19.061659
3364	4	32	Transaction #364	2025-06-01	924.87	Auto-generated transaction entry #364	2025-06-15 08:47:19.061659
3365	4	32	Transaction #365	2025-05-18	79.30	Auto-generated transaction entry #365	2025-06-15 08:47:19.061659
3366	4	34	Transaction #366	2025-05-24	507.12	Auto-generated transaction entry #366	2025-06-15 08:47:19.061659
3367	4	32	Transaction #367	2025-06-14	59.61	Auto-generated transaction entry #367	2025-06-15 08:47:19.061659
3368	4	33	Transaction #368	2025-06-03	597.29	Auto-generated transaction entry #368	2025-06-15 08:47:19.061659
3369	4	31	Transaction #369	2025-05-31	792.49	Auto-generated transaction entry #369	2025-06-15 08:47:19.061659
3370	4	31	Transaction #370	2025-06-08	416.41	Auto-generated transaction entry #370	2025-06-15 08:47:19.061659
3371	4	31	Transaction #371	2025-05-24	178.04	Auto-generated transaction entry #371	2025-06-15 08:47:19.061659
3372	4	34	Transaction #372	2025-05-24	301.00	Auto-generated transaction entry #372	2025-06-15 08:47:19.061659
3373	4	35	Transaction #373	2025-05-31	696.70	Auto-generated transaction entry #373	2025-06-15 08:47:19.061659
3374	4	33	Transaction #374	2025-06-01	899.92	Auto-generated transaction entry #374	2025-06-15 08:47:19.061659
3375	4	33	Transaction #375	2025-06-13	333.69	Auto-generated transaction entry #375	2025-06-15 08:47:19.061659
3376	4	35	Transaction #376	2025-05-29	656.69	Auto-generated transaction entry #376	2025-06-15 08:47:19.061659
3377	4	34	Transaction #377	2025-06-11	677.45	Auto-generated transaction entry #377	2025-06-15 08:47:19.061659
3378	4	34	Transaction #378	2025-05-27	197.39	Auto-generated transaction entry #378	2025-06-15 08:47:19.061659
3379	4	35	Transaction #379	2025-06-12	457.69	Auto-generated transaction entry #379	2025-06-15 08:47:19.061659
3380	4	33	Transaction #380	2025-05-19	173.15	Auto-generated transaction entry #380	2025-06-15 08:47:19.061659
3381	4	31	Transaction #381	2025-06-12	727.11	Auto-generated transaction entry #381	2025-06-15 08:47:19.061659
3382	4	32	Transaction #382	2025-06-07	669.45	Auto-generated transaction entry #382	2025-06-15 08:47:19.061659
3383	4	33	Transaction #383	2025-05-23	79.73	Auto-generated transaction entry #383	2025-06-15 08:47:19.061659
3384	4	31	Transaction #384	2025-05-20	594.68	Auto-generated transaction entry #384	2025-06-15 08:47:19.061659
3385	4	33	Transaction #385	2025-06-04	522.31	Auto-generated transaction entry #385	2025-06-15 08:47:19.061659
3386	4	31	Transaction #386	2025-05-18	342.13	Auto-generated transaction entry #386	2025-06-15 08:47:19.061659
3387	4	31	Transaction #387	2025-05-27	328.59	Auto-generated transaction entry #387	2025-06-15 08:47:19.061659
3388	4	34	Transaction #388	2025-06-01	229.89	Auto-generated transaction entry #388	2025-06-15 08:47:19.061659
3389	4	32	Transaction #389	2025-06-05	435.71	Auto-generated transaction entry #389	2025-06-15 08:47:19.061659
3390	4	32	Transaction #390	2025-06-13	429.34	Auto-generated transaction entry #390	2025-06-15 08:47:19.061659
3391	4	31	Transaction #391	2025-05-23	419.72	Auto-generated transaction entry #391	2025-06-15 08:47:19.061659
3392	4	33	Transaction #392	2025-06-06	864.65	Auto-generated transaction entry #392	2025-06-15 08:47:19.061659
3393	4	32	Transaction #393	2025-05-28	634.84	Auto-generated transaction entry #393	2025-06-15 08:47:19.061659
3394	4	35	Transaction #394	2025-05-22	306.73	Auto-generated transaction entry #394	2025-06-15 08:47:19.061659
3395	4	35	Transaction #395	2025-06-06	300.19	Auto-generated transaction entry #395	2025-06-15 08:47:19.061659
3396	4	33	Transaction #396	2025-05-21	202.59	Auto-generated transaction entry #396	2025-06-15 08:47:19.061659
3397	4	33	Transaction #397	2025-06-01	719.12	Auto-generated transaction entry #397	2025-06-15 08:47:19.061659
3398	4	31	Transaction #398	2025-05-19	712.96	Auto-generated transaction entry #398	2025-06-15 08:47:19.061659
3399	4	34	Transaction #399	2025-06-09	633.32	Auto-generated transaction entry #399	2025-06-15 08:47:19.061659
3400	4	34	Transaction #400	2025-06-10	861.01	Auto-generated transaction entry #400	2025-06-15 08:47:19.061659
3401	4	35	Transaction #401	2025-05-20	760.54	Auto-generated transaction entry #401	2025-06-15 08:47:19.061659
3402	4	32	Transaction #402	2025-06-05	105.25	Auto-generated transaction entry #402	2025-06-15 08:47:19.061659
3403	4	31	Transaction #403	2025-06-10	743.73	Auto-generated transaction entry #403	2025-06-15 08:47:19.061659
3404	4	33	Transaction #404	2025-05-21	906.37	Auto-generated transaction entry #404	2025-06-15 08:47:19.061659
3405	4	33	Transaction #405	2025-05-18	202.32	Auto-generated transaction entry #405	2025-06-15 08:47:19.061659
3406	4	35	Transaction #406	2025-05-30	196.27	Auto-generated transaction entry #406	2025-06-15 08:47:19.061659
3407	4	32	Transaction #407	2025-06-13	291.26	Auto-generated transaction entry #407	2025-06-15 08:47:19.061659
3408	4	32	Transaction #408	2025-06-09	358.76	Auto-generated transaction entry #408	2025-06-15 08:47:19.061659
3409	4	33	Transaction #409	2025-06-06	821.29	Auto-generated transaction entry #409	2025-06-15 08:47:19.061659
3410	4	34	Transaction #410	2025-05-29	105.43	Auto-generated transaction entry #410	2025-06-15 08:47:19.061659
3411	4	32	Transaction #411	2025-05-19	906.57	Auto-generated transaction entry #411	2025-06-15 08:47:19.061659
3412	4	35	Transaction #412	2025-06-05	847.28	Auto-generated transaction entry #412	2025-06-15 08:47:19.061659
3413	4	33	Transaction #413	2025-06-04	914.35	Auto-generated transaction entry #413	2025-06-15 08:47:19.061659
3414	4	31	Transaction #414	2025-05-27	476.93	Auto-generated transaction entry #414	2025-06-15 08:47:19.061659
3415	4	35	Transaction #415	2025-06-03	723.97	Auto-generated transaction entry #415	2025-06-15 08:47:19.061659
3416	4	33	Transaction #416	2025-05-29	716.03	Auto-generated transaction entry #416	2025-06-15 08:47:19.061659
3417	4	33	Transaction #417	2025-06-14	838.06	Auto-generated transaction entry #417	2025-06-15 08:47:19.061659
3418	4	32	Transaction #418	2025-06-02	539.41	Auto-generated transaction entry #418	2025-06-15 08:47:19.061659
3419	4	33	Transaction #419	2025-06-06	166.67	Auto-generated transaction entry #419	2025-06-15 08:47:19.061659
3420	4	33	Transaction #420	2025-05-29	417.95	Auto-generated transaction entry #420	2025-06-15 08:47:19.061659
3421	4	34	Transaction #421	2025-05-18	663.50	Auto-generated transaction entry #421	2025-06-15 08:47:19.061659
3422	4	33	Transaction #422	2025-06-12	234.20	Auto-generated transaction entry #422	2025-06-15 08:47:19.061659
3423	4	34	Transaction #423	2025-05-27	846.20	Auto-generated transaction entry #423	2025-06-15 08:47:19.061659
3424	4	33	Transaction #424	2025-06-02	573.01	Auto-generated transaction entry #424	2025-06-15 08:47:19.061659
3425	4	34	Transaction #425	2025-06-10	946.44	Auto-generated transaction entry #425	2025-06-15 08:47:19.061659
3426	4	34	Transaction #426	2025-06-03	858.49	Auto-generated transaction entry #426	2025-06-15 08:47:19.061659
3427	4	34	Transaction #427	2025-05-21	972.96	Auto-generated transaction entry #427	2025-06-15 08:47:19.061659
3428	4	31	Transaction #428	2025-06-02	280.62	Auto-generated transaction entry #428	2025-06-15 08:47:19.061659
3429	4	32	Transaction #429	2025-05-22	945.75	Auto-generated transaction entry #429	2025-06-15 08:47:19.061659
3430	4	35	Transaction #430	2025-06-03	995.14	Auto-generated transaction entry #430	2025-06-15 08:47:19.061659
3431	4	35	Transaction #431	2025-06-11	161.77	Auto-generated transaction entry #431	2025-06-15 08:47:19.061659
3432	4	34	Transaction #432	2025-06-06	92.63	Auto-generated transaction entry #432	2025-06-15 08:47:19.061659
3433	4	34	Transaction #433	2025-06-01	407.12	Auto-generated transaction entry #433	2025-06-15 08:47:19.061659
3434	4	33	Transaction #434	2025-06-12	815.74	Auto-generated transaction entry #434	2025-06-15 08:47:19.061659
3435	4	34	Transaction #435	2025-05-18	386.78	Auto-generated transaction entry #435	2025-06-15 08:47:19.061659
3436	4	34	Transaction #436	2025-06-14	916.40	Auto-generated transaction entry #436	2025-06-15 08:47:19.061659
3437	4	31	Transaction #437	2025-05-21	842.51	Auto-generated transaction entry #437	2025-06-15 08:47:19.061659
3438	4	35	Transaction #438	2025-06-06	116.13	Auto-generated transaction entry #438	2025-06-15 08:47:19.061659
3439	4	33	Transaction #439	2025-06-04	266.05	Auto-generated transaction entry #439	2025-06-15 08:47:19.061659
3440	4	31	Transaction #440	2025-06-09	738.07	Auto-generated transaction entry #440	2025-06-15 08:47:19.061659
3441	4	33	Transaction #441	2025-05-27	672.33	Auto-generated transaction entry #441	2025-06-15 08:47:19.061659
3442	4	33	Transaction #442	2025-06-11	482.35	Auto-generated transaction entry #442	2025-06-15 08:47:19.061659
3443	4	31	Transaction #443	2025-06-06	114.51	Auto-generated transaction entry #443	2025-06-15 08:47:19.061659
3444	4	31	Transaction #444	2025-06-09	927.81	Auto-generated transaction entry #444	2025-06-15 08:47:19.061659
3445	4	34	Transaction #445	2025-06-03	341.56	Auto-generated transaction entry #445	2025-06-15 08:47:19.061659
3446	4	34	Transaction #446	2025-05-19	666.22	Auto-generated transaction entry #446	2025-06-15 08:47:19.061659
3447	4	32	Transaction #447	2025-05-27	725.25	Auto-generated transaction entry #447	2025-06-15 08:47:19.061659
3448	4	35	Transaction #448	2025-06-12	148.69	Auto-generated transaction entry #448	2025-06-15 08:47:19.061659
3449	4	32	Transaction #449	2025-05-26	652.87	Auto-generated transaction entry #449	2025-06-15 08:47:19.061659
3450	4	31	Transaction #450	2025-06-10	801.22	Auto-generated transaction entry #450	2025-06-15 08:47:19.061659
3451	4	35	Transaction #451	2025-05-31	930.35	Auto-generated transaction entry #451	2025-06-15 08:47:19.061659
3452	4	33	Transaction #452	2025-06-14	526.65	Auto-generated transaction entry #452	2025-06-15 08:47:19.061659
3453	4	31	Transaction #453	2025-06-02	192.88	Auto-generated transaction entry #453	2025-06-15 08:47:19.061659
3454	4	33	Transaction #454	2025-06-02	886.91	Auto-generated transaction entry #454	2025-06-15 08:47:19.061659
3455	4	31	Transaction #455	2025-06-13	320.90	Auto-generated transaction entry #455	2025-06-15 08:47:19.061659
3456	4	35	Transaction #456	2025-06-03	918.08	Auto-generated transaction entry #456	2025-06-15 08:47:19.061659
3457	4	31	Transaction #457	2025-05-22	822.64	Auto-generated transaction entry #457	2025-06-15 08:47:19.061659
3458	4	34	Transaction #458	2025-06-02	986.61	Auto-generated transaction entry #458	2025-06-15 08:47:19.061659
3459	4	31	Transaction #459	2025-06-12	72.24	Auto-generated transaction entry #459	2025-06-15 08:47:19.061659
3460	4	32	Transaction #460	2025-05-31	142.78	Auto-generated transaction entry #460	2025-06-15 08:47:19.061659
3461	4	34	Transaction #461	2025-05-16	102.81	Auto-generated transaction entry #461	2025-06-15 08:47:19.061659
3462	4	32	Transaction #462	2025-06-02	516.07	Auto-generated transaction entry #462	2025-06-15 08:47:19.061659
3463	4	32	Transaction #463	2025-05-23	877.87	Auto-generated transaction entry #463	2025-06-15 08:47:19.061659
3464	4	34	Transaction #464	2025-06-04	256.51	Auto-generated transaction entry #464	2025-06-15 08:47:19.061659
3465	4	35	Transaction #465	2025-05-22	687.69	Auto-generated transaction entry #465	2025-06-15 08:47:19.061659
3466	4	35	Transaction #466	2025-06-07	581.64	Auto-generated transaction entry #466	2025-06-15 08:47:19.061659
3467	4	35	Transaction #467	2025-05-24	579.90	Auto-generated transaction entry #467	2025-06-15 08:47:19.061659
3468	4	33	Transaction #468	2025-06-03	114.76	Auto-generated transaction entry #468	2025-06-15 08:47:19.061659
3469	4	32	Transaction #469	2025-05-23	940.26	Auto-generated transaction entry #469	2025-06-15 08:47:19.061659
3470	4	33	Transaction #470	2025-05-21	247.74	Auto-generated transaction entry #470	2025-06-15 08:47:19.061659
3471	4	33	Transaction #471	2025-06-11	567.89	Auto-generated transaction entry #471	2025-06-15 08:47:19.061659
3472	4	32	Transaction #472	2025-05-30	441.87	Auto-generated transaction entry #472	2025-06-15 08:47:19.061659
3473	4	35	Transaction #473	2025-06-13	290.94	Auto-generated transaction entry #473	2025-06-15 08:47:19.061659
3474	4	35	Transaction #474	2025-05-26	50.88	Auto-generated transaction entry #474	2025-06-15 08:47:19.061659
3475	4	34	Transaction #475	2025-05-29	376.51	Auto-generated transaction entry #475	2025-06-15 08:47:19.061659
3476	4	32	Transaction #476	2025-06-07	512.47	Auto-generated transaction entry #476	2025-06-15 08:47:19.061659
3477	4	34	Transaction #477	2025-05-18	698.37	Auto-generated transaction entry #477	2025-06-15 08:47:19.061659
3478	4	34	Transaction #478	2025-06-14	351.37	Auto-generated transaction entry #478	2025-06-15 08:47:19.061659
3479	4	35	Transaction #479	2025-05-23	741.35	Auto-generated transaction entry #479	2025-06-15 08:47:19.061659
3480	4	33	Transaction #480	2025-05-23	174.89	Auto-generated transaction entry #480	2025-06-15 08:47:19.061659
3481	4	35	Transaction #481	2025-06-13	194.18	Auto-generated transaction entry #481	2025-06-15 08:47:19.061659
3482	4	31	Transaction #482	2025-06-11	878.72	Auto-generated transaction entry #482	2025-06-15 08:47:19.061659
3483	4	35	Transaction #483	2025-05-26	80.98	Auto-generated transaction entry #483	2025-06-15 08:47:19.061659
3484	4	32	Transaction #484	2025-05-23	92.41	Auto-generated transaction entry #484	2025-06-15 08:47:19.061659
3485	4	34	Transaction #485	2025-05-23	367.83	Auto-generated transaction entry #485	2025-06-15 08:47:19.061659
3486	4	31	Transaction #486	2025-05-20	629.00	Auto-generated transaction entry #486	2025-06-15 08:47:19.061659
3487	4	33	Transaction #487	2025-06-14	886.65	Auto-generated transaction entry #487	2025-06-15 08:47:19.061659
3488	4	32	Transaction #488	2025-05-31	877.37	Auto-generated transaction entry #488	2025-06-15 08:47:19.061659
3489	4	34	Transaction #489	2025-05-26	770.39	Auto-generated transaction entry #489	2025-06-15 08:47:19.061659
3490	4	31	Transaction #490	2025-06-07	508.26	Auto-generated transaction entry #490	2025-06-15 08:47:19.061659
3491	4	34	Transaction #491	2025-06-04	208.21	Auto-generated transaction entry #491	2025-06-15 08:47:19.061659
3492	4	34	Transaction #492	2025-05-21	409.46	Auto-generated transaction entry #492	2025-06-15 08:47:19.061659
3493	4	31	Transaction #493	2025-05-27	600.80	Auto-generated transaction entry #493	2025-06-15 08:47:19.061659
3494	4	34	Transaction #494	2025-06-08	431.94	Auto-generated transaction entry #494	2025-06-15 08:47:19.061659
3495	4	32	Transaction #495	2025-05-27	769.51	Auto-generated transaction entry #495	2025-06-15 08:47:19.061659
3496	4	34	Transaction #496	2025-05-27	419.99	Auto-generated transaction entry #496	2025-06-15 08:47:19.061659
3497	4	35	Transaction #497	2025-05-29	139.16	Auto-generated transaction entry #497	2025-06-15 08:47:19.061659
3498	4	31	Transaction #498	2025-06-01	843.55	Auto-generated transaction entry #498	2025-06-15 08:47:19.061659
3499	4	31	Transaction #499	2025-05-25	834.24	Auto-generated transaction entry #499	2025-06-15 08:47:19.061659
3500	4	32	Transaction #500	2025-06-05	265.04	Auto-generated transaction entry #500	2025-06-15 08:47:19.061659
3501	4	42	Transaction #1	2025-06-05	833.97	Auto-generated transaction entry #1	2025-06-15 08:47:25.78371
3502	4	42	Transaction #2	2025-05-19	647.34	Auto-generated transaction entry #2	2025-06-15 08:47:25.78371
3503	4	41	Transaction #3	2025-06-12	590.72	Auto-generated transaction entry #3	2025-06-15 08:47:25.78371
3504	4	43	Transaction #4	2025-05-31	187.52	Auto-generated transaction entry #4	2025-06-15 08:47:25.78371
3505	4	43	Transaction #5	2025-06-07	700.82	Auto-generated transaction entry #5	2025-06-15 08:47:25.78371
3506	4	37	Transaction #6	2025-05-21	520.00	Auto-generated transaction entry #6	2025-06-15 08:47:25.78371
3507	4	42	Transaction #7	2025-05-22	744.71	Auto-generated transaction entry #7	2025-06-15 08:47:25.78371
3508	4	38	Transaction #8	2025-05-21	552.40	Auto-generated transaction entry #8	2025-06-15 08:47:25.78371
3509	4	39	Transaction #9	2025-05-18	710.32	Auto-generated transaction entry #9	2025-06-15 08:47:25.78371
3510	4	37	Transaction #10	2025-05-17	594.08	Auto-generated transaction entry #10	2025-06-15 08:47:25.78371
3511	4	36	Transaction #11	2025-06-09	858.61	Auto-generated transaction entry #11	2025-06-15 08:47:25.78371
3512	4	39	Transaction #12	2025-05-26	610.14	Auto-generated transaction entry #12	2025-06-15 08:47:25.78371
3513	4	38	Transaction #13	2025-05-20	691.52	Auto-generated transaction entry #13	2025-06-15 08:47:25.78371
3514	4	39	Transaction #14	2025-06-10	743.29	Auto-generated transaction entry #14	2025-06-15 08:47:25.78371
3515	4	43	Transaction #15	2025-06-01	509.02	Auto-generated transaction entry #15	2025-06-15 08:47:25.78371
3516	4	37	Transaction #16	2025-05-27	123.81	Auto-generated transaction entry #16	2025-06-15 08:47:25.78371
3517	4	42	Transaction #17	2025-05-17	569.24	Auto-generated transaction entry #17	2025-06-15 08:47:25.78371
3518	4	39	Transaction #18	2025-05-19	304.98	Auto-generated transaction entry #18	2025-06-15 08:47:25.78371
3519	4	36	Transaction #19	2025-05-24	268.97	Auto-generated transaction entry #19	2025-06-15 08:47:25.78371
3520	4	36	Transaction #20	2025-06-13	147.42	Auto-generated transaction entry #20	2025-06-15 08:47:25.78371
3521	4	36	Transaction #21	2025-05-22	907.45	Auto-generated transaction entry #21	2025-06-15 08:47:25.78371
3522	4	36	Transaction #22	2025-05-23	530.53	Auto-generated transaction entry #22	2025-06-15 08:47:25.78371
3523	4	41	Transaction #23	2025-06-06	156.43	Auto-generated transaction entry #23	2025-06-15 08:47:25.78371
3524	4	40	Transaction #24	2025-06-03	977.82	Auto-generated transaction entry #24	2025-06-15 08:47:25.78371
3525	4	39	Transaction #25	2025-05-19	374.71	Auto-generated transaction entry #25	2025-06-15 08:47:25.78371
3526	4	36	Transaction #26	2025-05-17	987.04	Auto-generated transaction entry #26	2025-06-15 08:47:25.78371
3527	4	40	Transaction #27	2025-05-19	980.18	Auto-generated transaction entry #27	2025-06-15 08:47:25.78371
3528	4	38	Transaction #28	2025-06-15	760.27	Auto-generated transaction entry #28	2025-06-15 08:47:25.78371
3529	4	36	Transaction #29	2025-06-13	615.49	Auto-generated transaction entry #29	2025-06-15 08:47:25.78371
3530	4	41	Transaction #30	2025-05-25	562.53	Auto-generated transaction entry #30	2025-06-15 08:47:25.78371
3531	4	36	Transaction #31	2025-06-11	451.15	Auto-generated transaction entry #31	2025-06-15 08:47:25.78371
3532	4	39	Transaction #32	2025-05-16	152.44	Auto-generated transaction entry #32	2025-06-15 08:47:25.78371
3533	4	38	Transaction #33	2025-06-15	60.68	Auto-generated transaction entry #33	2025-06-15 08:47:25.78371
3534	4	40	Transaction #34	2025-06-07	506.30	Auto-generated transaction entry #34	2025-06-15 08:47:25.78371
3535	4	43	Transaction #35	2025-05-17	822.31	Auto-generated transaction entry #35	2025-06-15 08:47:25.78371
3536	4	39	Transaction #36	2025-06-04	336.14	Auto-generated transaction entry #36	2025-06-15 08:47:25.78371
3537	4	40	Transaction #37	2025-05-27	871.34	Auto-generated transaction entry #37	2025-06-15 08:47:25.78371
3538	4	42	Transaction #38	2025-06-12	537.62	Auto-generated transaction entry #38	2025-06-15 08:47:25.78371
3539	4	37	Transaction #39	2025-06-02	576.26	Auto-generated transaction entry #39	2025-06-15 08:47:25.78371
3540	4	43	Transaction #40	2025-05-28	747.62	Auto-generated transaction entry #40	2025-06-15 08:47:25.78371
3541	4	41	Transaction #41	2025-05-24	121.18	Auto-generated transaction entry #41	2025-06-15 08:47:25.78371
3542	4	43	Transaction #42	2025-06-09	385.95	Auto-generated transaction entry #42	2025-06-15 08:47:25.78371
3543	4	36	Transaction #43	2025-06-02	969.72	Auto-generated transaction entry #43	2025-06-15 08:47:25.78371
3544	4	39	Transaction #44	2025-05-27	790.36	Auto-generated transaction entry #44	2025-06-15 08:47:25.78371
3545	4	39	Transaction #45	2025-05-22	788.59	Auto-generated transaction entry #45	2025-06-15 08:47:25.78371
3546	4	39	Transaction #46	2025-05-28	712.59	Auto-generated transaction entry #46	2025-06-15 08:47:25.78371
3547	4	37	Transaction #47	2025-05-20	206.64	Auto-generated transaction entry #47	2025-06-15 08:47:25.78371
3548	4	43	Transaction #48	2025-06-03	314.48	Auto-generated transaction entry #48	2025-06-15 08:47:25.78371
3549	4	41	Transaction #49	2025-05-26	62.96	Auto-generated transaction entry #49	2025-06-15 08:47:25.78371
3550	4	40	Transaction #50	2025-05-23	740.82	Auto-generated transaction entry #50	2025-06-15 08:47:25.78371
3551	4	40	Transaction #51	2025-05-26	990.10	Auto-generated transaction entry #51	2025-06-15 08:47:25.78371
3552	4	43	Transaction #52	2025-06-07	304.65	Auto-generated transaction entry #52	2025-06-15 08:47:25.78371
3553	4	40	Transaction #53	2025-05-30	571.39	Auto-generated transaction entry #53	2025-06-15 08:47:25.78371
3554	4	43	Transaction #54	2025-06-09	534.94	Auto-generated transaction entry #54	2025-06-15 08:47:25.78371
3555	4	36	Transaction #55	2025-06-01	334.34	Auto-generated transaction entry #55	2025-06-15 08:47:25.78371
3556	4	36	Transaction #56	2025-06-01	771.25	Auto-generated transaction entry #56	2025-06-15 08:47:25.78371
3557	4	41	Transaction #57	2025-05-29	104.11	Auto-generated transaction entry #57	2025-06-15 08:47:25.78371
3558	4	38	Transaction #58	2025-05-24	165.23	Auto-generated transaction entry #58	2025-06-15 08:47:25.78371
3559	4	37	Transaction #59	2025-05-23	404.57	Auto-generated transaction entry #59	2025-06-15 08:47:25.78371
3560	4	37	Transaction #60	2025-05-21	307.54	Auto-generated transaction entry #60	2025-06-15 08:47:25.78371
3561	4	40	Transaction #61	2025-05-17	148.15	Auto-generated transaction entry #61	2025-06-15 08:47:25.78371
3562	4	40	Transaction #62	2025-06-09	157.42	Auto-generated transaction entry #62	2025-06-15 08:47:25.78371
3563	4	36	Transaction #63	2025-05-20	691.23	Auto-generated transaction entry #63	2025-06-15 08:47:25.78371
3564	4	43	Transaction #64	2025-05-28	970.59	Auto-generated transaction entry #64	2025-06-15 08:47:25.78371
3565	4	41	Transaction #65	2025-06-11	196.05	Auto-generated transaction entry #65	2025-06-15 08:47:25.78371
3566	4	42	Transaction #66	2025-06-15	918.70	Auto-generated transaction entry #66	2025-06-15 08:47:25.78371
3567	4	39	Transaction #67	2025-05-19	624.63	Auto-generated transaction entry #67	2025-06-15 08:47:25.78371
3568	4	43	Transaction #68	2025-06-10	371.66	Auto-generated transaction entry #68	2025-06-15 08:47:25.78371
3569	4	40	Transaction #69	2025-06-03	803.21	Auto-generated transaction entry #69	2025-06-15 08:47:25.78371
3570	4	41	Transaction #70	2025-05-26	885.38	Auto-generated transaction entry #70	2025-06-15 08:47:25.78371
3571	4	42	Transaction #71	2025-06-13	818.79	Auto-generated transaction entry #71	2025-06-15 08:47:25.78371
3572	4	37	Transaction #72	2025-05-21	802.97	Auto-generated transaction entry #72	2025-06-15 08:47:25.78371
3573	4	40	Transaction #73	2025-06-10	649.71	Auto-generated transaction entry #73	2025-06-15 08:47:25.78371
3574	4	37	Transaction #74	2025-05-26	725.67	Auto-generated transaction entry #74	2025-06-15 08:47:25.78371
3575	4	42	Transaction #75	2025-06-11	766.62	Auto-generated transaction entry #75	2025-06-15 08:47:25.78371
3576	4	39	Transaction #76	2025-05-30	977.78	Auto-generated transaction entry #76	2025-06-15 08:47:25.78371
3577	4	37	Transaction #77	2025-05-16	991.33	Auto-generated transaction entry #77	2025-06-15 08:47:25.78371
3578	4	41	Transaction #78	2025-06-05	434.11	Auto-generated transaction entry #78	2025-06-15 08:47:25.78371
3579	4	39	Transaction #79	2025-05-27	856.89	Auto-generated transaction entry #79	2025-06-15 08:47:25.78371
3580	4	36	Transaction #80	2025-06-07	867.65	Auto-generated transaction entry #80	2025-06-15 08:47:25.78371
3581	4	41	Transaction #81	2025-05-25	956.93	Auto-generated transaction entry #81	2025-06-15 08:47:25.78371
3582	4	37	Transaction #82	2025-05-23	454.85	Auto-generated transaction entry #82	2025-06-15 08:47:25.78371
3583	4	39	Transaction #83	2025-05-29	801.93	Auto-generated transaction entry #83	2025-06-15 08:47:25.78371
3584	4	37	Transaction #84	2025-05-24	891.19	Auto-generated transaction entry #84	2025-06-15 08:47:25.78371
3585	4	37	Transaction #85	2025-06-11	749.71	Auto-generated transaction entry #85	2025-06-15 08:47:25.78371
3586	4	42	Transaction #86	2025-06-06	256.70	Auto-generated transaction entry #86	2025-06-15 08:47:25.78371
3587	4	42	Transaction #87	2025-05-16	707.40	Auto-generated transaction entry #87	2025-06-15 08:47:25.78371
3588	4	42	Transaction #88	2025-05-22	854.17	Auto-generated transaction entry #88	2025-06-15 08:47:25.78371
3589	4	40	Transaction #89	2025-06-14	958.09	Auto-generated transaction entry #89	2025-06-15 08:47:25.78371
3590	4	38	Transaction #90	2025-06-13	792.32	Auto-generated transaction entry #90	2025-06-15 08:47:25.78371
3591	4	42	Transaction #91	2025-05-23	960.21	Auto-generated transaction entry #91	2025-06-15 08:47:25.78371
3592	4	43	Transaction #92	2025-05-23	248.13	Auto-generated transaction entry #92	2025-06-15 08:47:25.78371
3593	4	40	Transaction #93	2025-06-08	779.51	Auto-generated transaction entry #93	2025-06-15 08:47:25.78371
3594	4	36	Transaction #94	2025-05-21	392.09	Auto-generated transaction entry #94	2025-06-15 08:47:25.78371
3595	4	41	Transaction #95	2025-06-12	460.65	Auto-generated transaction entry #95	2025-06-15 08:47:25.78371
3596	4	42	Transaction #96	2025-05-20	697.12	Auto-generated transaction entry #96	2025-06-15 08:47:25.78371
3597	4	38	Transaction #97	2025-06-05	643.32	Auto-generated transaction entry #97	2025-06-15 08:47:25.78371
3598	4	37	Transaction #98	2025-06-14	296.08	Auto-generated transaction entry #98	2025-06-15 08:47:25.78371
3599	4	39	Transaction #99	2025-06-08	50.18	Auto-generated transaction entry #99	2025-06-15 08:47:25.78371
3600	4	40	Transaction #100	2025-06-02	675.18	Auto-generated transaction entry #100	2025-06-15 08:47:25.78371
3601	4	41	Transaction #101	2025-05-22	335.39	Auto-generated transaction entry #101	2025-06-15 08:47:25.78371
3602	4	38	Transaction #102	2025-06-12	922.83	Auto-generated transaction entry #102	2025-06-15 08:47:25.78371
3603	4	43	Transaction #103	2025-05-29	718.40	Auto-generated transaction entry #103	2025-06-15 08:47:25.78371
3604	4	42	Transaction #104	2025-06-06	789.12	Auto-generated transaction entry #104	2025-06-15 08:47:25.78371
3605	4	42	Transaction #105	2025-06-03	538.53	Auto-generated transaction entry #105	2025-06-15 08:47:25.78371
3606	4	39	Transaction #106	2025-05-19	238.10	Auto-generated transaction entry #106	2025-06-15 08:47:25.78371
3607	4	40	Transaction #107	2025-06-05	859.02	Auto-generated transaction entry #107	2025-06-15 08:47:25.78371
3608	4	43	Transaction #108	2025-06-08	547.37	Auto-generated transaction entry #108	2025-06-15 08:47:25.78371
3609	4	39	Transaction #109	2025-05-21	713.03	Auto-generated transaction entry #109	2025-06-15 08:47:25.78371
3610	4	42	Transaction #110	2025-05-25	960.45	Auto-generated transaction entry #110	2025-06-15 08:47:25.78371
3611	4	42	Transaction #111	2025-06-15	469.42	Auto-generated transaction entry #111	2025-06-15 08:47:25.78371
3612	4	43	Transaction #112	2025-05-25	117.38	Auto-generated transaction entry #112	2025-06-15 08:47:25.78371
3613	4	40	Transaction #113	2025-05-21	407.44	Auto-generated transaction entry #113	2025-06-15 08:47:25.78371
3614	4	42	Transaction #114	2025-06-03	877.81	Auto-generated transaction entry #114	2025-06-15 08:47:25.78371
3615	4	40	Transaction #115	2025-05-27	185.23	Auto-generated transaction entry #115	2025-06-15 08:47:25.78371
3616	4	43	Transaction #116	2025-05-29	444.43	Auto-generated transaction entry #116	2025-06-15 08:47:25.78371
3617	4	39	Transaction #117	2025-06-08	272.33	Auto-generated transaction entry #117	2025-06-15 08:47:25.78371
3618	4	42	Transaction #118	2025-06-14	514.92	Auto-generated transaction entry #118	2025-06-15 08:47:25.78371
3619	4	40	Transaction #119	2025-05-26	167.03	Auto-generated transaction entry #119	2025-06-15 08:47:25.78371
3620	4	38	Transaction #120	2025-05-28	712.37	Auto-generated transaction entry #120	2025-06-15 08:47:25.78371
3621	4	40	Transaction #121	2025-05-19	505.61	Auto-generated transaction entry #121	2025-06-15 08:47:25.78371
3622	4	39	Transaction #122	2025-05-24	110.65	Auto-generated transaction entry #122	2025-06-15 08:47:25.78371
3623	4	38	Transaction #123	2025-06-11	141.43	Auto-generated transaction entry #123	2025-06-15 08:47:25.78371
3624	4	41	Transaction #124	2025-06-03	864.74	Auto-generated transaction entry #124	2025-06-15 08:47:25.78371
3625	4	39	Transaction #125	2025-05-19	959.11	Auto-generated transaction entry #125	2025-06-15 08:47:25.78371
3626	4	41	Transaction #126	2025-06-07	122.40	Auto-generated transaction entry #126	2025-06-15 08:47:25.78371
3627	4	39	Transaction #127	2025-05-30	685.42	Auto-generated transaction entry #127	2025-06-15 08:47:25.78371
3628	4	42	Transaction #128	2025-05-21	278.77	Auto-generated transaction entry #128	2025-06-15 08:47:25.78371
3629	4	43	Transaction #129	2025-05-25	138.13	Auto-generated transaction entry #129	2025-06-15 08:47:25.78371
3630	4	42	Transaction #130	2025-05-20	364.67	Auto-generated transaction entry #130	2025-06-15 08:47:25.78371
3631	4	40	Transaction #131	2025-05-26	991.75	Auto-generated transaction entry #131	2025-06-15 08:47:25.78371
3632	4	39	Transaction #132	2025-06-01	875.47	Auto-generated transaction entry #132	2025-06-15 08:47:25.78371
3633	4	38	Transaction #133	2025-06-02	638.16	Auto-generated transaction entry #133	2025-06-15 08:47:25.78371
3634	4	38	Transaction #134	2025-05-31	464.27	Auto-generated transaction entry #134	2025-06-15 08:47:25.78371
3635	4	36	Transaction #135	2025-05-29	811.06	Auto-generated transaction entry #135	2025-06-15 08:47:25.78371
3636	4	38	Transaction #136	2025-06-03	388.20	Auto-generated transaction entry #136	2025-06-15 08:47:25.78371
3637	4	36	Transaction #137	2025-05-27	858.43	Auto-generated transaction entry #137	2025-06-15 08:47:25.78371
3638	4	40	Transaction #138	2025-06-09	710.65	Auto-generated transaction entry #138	2025-06-15 08:47:25.78371
3639	4	38	Transaction #139	2025-05-17	482.05	Auto-generated transaction entry #139	2025-06-15 08:47:25.78371
3640	4	43	Transaction #140	2025-05-27	898.56	Auto-generated transaction entry #140	2025-06-15 08:47:25.78371
3641	4	39	Transaction #141	2025-06-09	764.52	Auto-generated transaction entry #141	2025-06-15 08:47:25.78371
3642	4	42	Transaction #142	2025-05-24	225.84	Auto-generated transaction entry #142	2025-06-15 08:47:25.78371
3643	4	43	Transaction #143	2025-06-07	922.76	Auto-generated transaction entry #143	2025-06-15 08:47:25.78371
3644	4	41	Transaction #144	2025-05-23	464.83	Auto-generated transaction entry #144	2025-06-15 08:47:25.78371
3645	4	38	Transaction #145	2025-06-07	407.03	Auto-generated transaction entry #145	2025-06-15 08:47:25.78371
3646	4	40	Transaction #146	2025-05-21	805.92	Auto-generated transaction entry #146	2025-06-15 08:47:25.78371
3647	4	37	Transaction #147	2025-06-01	750.72	Auto-generated transaction entry #147	2025-06-15 08:47:25.78371
3648	4	40	Transaction #148	2025-06-10	361.27	Auto-generated transaction entry #148	2025-06-15 08:47:25.78371
3649	4	36	Transaction #149	2025-05-22	565.70	Auto-generated transaction entry #149	2025-06-15 08:47:25.78371
3650	4	38	Transaction #150	2025-05-16	575.45	Auto-generated transaction entry #150	2025-06-15 08:47:25.78371
3651	4	40	Transaction #151	2025-05-31	147.16	Auto-generated transaction entry #151	2025-06-15 08:47:25.78371
3652	4	38	Transaction #152	2025-05-23	163.55	Auto-generated transaction entry #152	2025-06-15 08:47:25.78371
3653	4	41	Transaction #153	2025-05-22	547.60	Auto-generated transaction entry #153	2025-06-15 08:47:25.78371
3654	4	40	Transaction #154	2025-06-07	115.45	Auto-generated transaction entry #154	2025-06-15 08:47:25.78371
3655	4	36	Transaction #155	2025-06-02	718.20	Auto-generated transaction entry #155	2025-06-15 08:47:25.78371
3656	4	42	Transaction #156	2025-05-19	641.40	Auto-generated transaction entry #156	2025-06-15 08:47:25.78371
3657	4	37	Transaction #157	2025-06-06	249.42	Auto-generated transaction entry #157	2025-06-15 08:47:25.78371
3658	4	36	Transaction #158	2025-06-13	426.34	Auto-generated transaction entry #158	2025-06-15 08:47:25.78371
3659	4	37	Transaction #159	2025-06-05	276.35	Auto-generated transaction entry #159	2025-06-15 08:47:25.78371
3660	4	39	Transaction #160	2025-06-14	354.42	Auto-generated transaction entry #160	2025-06-15 08:47:25.78371
3661	4	37	Transaction #161	2025-05-17	60.28	Auto-generated transaction entry #161	2025-06-15 08:47:25.78371
3662	4	43	Transaction #162	2025-06-13	390.39	Auto-generated transaction entry #162	2025-06-15 08:47:25.78371
3663	4	37	Transaction #163	2025-06-11	432.96	Auto-generated transaction entry #163	2025-06-15 08:47:25.78371
3664	4	38	Transaction #164	2025-06-03	795.74	Auto-generated transaction entry #164	2025-06-15 08:47:25.78371
3665	4	39	Transaction #165	2025-06-06	313.26	Auto-generated transaction entry #165	2025-06-15 08:47:25.78371
3666	4	38	Transaction #166	2025-05-26	298.69	Auto-generated transaction entry #166	2025-06-15 08:47:25.78371
3667	4	41	Transaction #167	2025-06-09	324.92	Auto-generated transaction entry #167	2025-06-15 08:47:25.78371
3668	4	42	Transaction #168	2025-06-08	262.94	Auto-generated transaction entry #168	2025-06-15 08:47:25.78371
3669	4	36	Transaction #169	2025-06-13	677.30	Auto-generated transaction entry #169	2025-06-15 08:47:25.78371
3670	4	40	Transaction #170	2025-06-10	641.42	Auto-generated transaction entry #170	2025-06-15 08:47:25.78371
3671	4	41	Transaction #171	2025-06-02	394.75	Auto-generated transaction entry #171	2025-06-15 08:47:25.78371
3672	4	38	Transaction #172	2025-06-06	986.09	Auto-generated transaction entry #172	2025-06-15 08:47:25.78371
3673	4	36	Transaction #173	2025-05-30	403.65	Auto-generated transaction entry #173	2025-06-15 08:47:25.78371
3674	4	37	Transaction #174	2025-06-07	211.07	Auto-generated transaction entry #174	2025-06-15 08:47:25.78371
3675	4	40	Transaction #175	2025-06-06	269.07	Auto-generated transaction entry #175	2025-06-15 08:47:25.78371
3676	4	43	Transaction #176	2025-06-13	556.33	Auto-generated transaction entry #176	2025-06-15 08:47:25.78371
3677	4	39	Transaction #177	2025-05-21	84.12	Auto-generated transaction entry #177	2025-06-15 08:47:25.78371
3678	4	39	Transaction #178	2025-06-09	492.21	Auto-generated transaction entry #178	2025-06-15 08:47:25.78371
3679	4	42	Transaction #179	2025-05-20	416.81	Auto-generated transaction entry #179	2025-06-15 08:47:25.78371
3680	4	40	Transaction #180	2025-06-07	274.58	Auto-generated transaction entry #180	2025-06-15 08:47:25.78371
3681	4	41	Transaction #181	2025-05-29	883.51	Auto-generated transaction entry #181	2025-06-15 08:47:25.78371
3682	4	39	Transaction #182	2025-06-08	774.41	Auto-generated transaction entry #182	2025-06-15 08:47:25.78371
3683	4	43	Transaction #183	2025-05-27	212.60	Auto-generated transaction entry #183	2025-06-15 08:47:25.78371
3684	4	40	Transaction #184	2025-05-24	185.07	Auto-generated transaction entry #184	2025-06-15 08:47:25.78371
3685	4	38	Transaction #185	2025-06-15	50.19	Auto-generated transaction entry #185	2025-06-15 08:47:25.78371
3686	4	41	Transaction #186	2025-05-21	658.56	Auto-generated transaction entry #186	2025-06-15 08:47:25.78371
3687	4	36	Transaction #187	2025-05-26	943.96	Auto-generated transaction entry #187	2025-06-15 08:47:25.78371
3688	4	43	Transaction #188	2025-05-24	125.82	Auto-generated transaction entry #188	2025-06-15 08:47:25.78371
3689	4	36	Transaction #189	2025-05-19	772.24	Auto-generated transaction entry #189	2025-06-15 08:47:25.78371
3690	4	41	Transaction #190	2025-05-20	71.06	Auto-generated transaction entry #190	2025-06-15 08:47:25.78371
3691	4	42	Transaction #191	2025-05-19	833.82	Auto-generated transaction entry #191	2025-06-15 08:47:25.78371
3692	4	39	Transaction #192	2025-06-12	940.80	Auto-generated transaction entry #192	2025-06-15 08:47:25.78371
3693	4	37	Transaction #193	2025-05-22	747.27	Auto-generated transaction entry #193	2025-06-15 08:47:25.78371
3694	4	39	Transaction #194	2025-05-28	397.33	Auto-generated transaction entry #194	2025-06-15 08:47:25.78371
3695	4	41	Transaction #195	2025-05-24	576.37	Auto-generated transaction entry #195	2025-06-15 08:47:25.78371
3696	4	38	Transaction #196	2025-06-14	733.75	Auto-generated transaction entry #196	2025-06-15 08:47:25.78371
3697	4	38	Transaction #197	2025-05-19	638.37	Auto-generated transaction entry #197	2025-06-15 08:47:25.78371
3698	4	41	Transaction #198	2025-05-31	912.08	Auto-generated transaction entry #198	2025-06-15 08:47:25.78371
3699	4	36	Transaction #199	2025-06-01	55.47	Auto-generated transaction entry #199	2025-06-15 08:47:25.78371
3700	4	37	Transaction #200	2025-05-27	913.73	Auto-generated transaction entry #200	2025-06-15 08:47:25.78371
3701	4	36	Transaction #201	2025-06-03	859.47	Auto-generated transaction entry #201	2025-06-15 08:47:25.78371
3702	4	43	Transaction #202	2025-05-28	298.00	Auto-generated transaction entry #202	2025-06-15 08:47:25.78371
3703	4	40	Transaction #203	2025-06-04	213.61	Auto-generated transaction entry #203	2025-06-15 08:47:25.78371
3704	4	42	Transaction #204	2025-05-29	978.68	Auto-generated transaction entry #204	2025-06-15 08:47:25.78371
3705	4	42	Transaction #205	2025-05-30	175.73	Auto-generated transaction entry #205	2025-06-15 08:47:25.78371
3706	4	42	Transaction #206	2025-06-05	837.61	Auto-generated transaction entry #206	2025-06-15 08:47:25.78371
3707	4	43	Transaction #207	2025-06-10	165.31	Auto-generated transaction entry #207	2025-06-15 08:47:25.78371
3708	4	38	Transaction #208	2025-05-22	614.67	Auto-generated transaction entry #208	2025-06-15 08:47:25.78371
3709	4	43	Transaction #209	2025-05-24	916.73	Auto-generated transaction entry #209	2025-06-15 08:47:25.78371
3710	4	40	Transaction #210	2025-06-13	883.15	Auto-generated transaction entry #210	2025-06-15 08:47:25.78371
3711	4	40	Transaction #211	2025-05-17	716.75	Auto-generated transaction entry #211	2025-06-15 08:47:25.78371
3712	4	38	Transaction #212	2025-06-05	202.45	Auto-generated transaction entry #212	2025-06-15 08:47:25.78371
3713	4	42	Transaction #213	2025-05-28	317.87	Auto-generated transaction entry #213	2025-06-15 08:47:25.78371
3714	4	37	Transaction #214	2025-06-13	98.35	Auto-generated transaction entry #214	2025-06-15 08:47:25.78371
3715	4	40	Transaction #215	2025-05-18	480.52	Auto-generated transaction entry #215	2025-06-15 08:47:25.78371
3716	4	42	Transaction #216	2025-06-03	671.18	Auto-generated transaction entry #216	2025-06-15 08:47:25.78371
3717	4	37	Transaction #217	2025-05-20	992.94	Auto-generated transaction entry #217	2025-06-15 08:47:25.78371
3718	4	38	Transaction #218	2025-06-05	246.37	Auto-generated transaction entry #218	2025-06-15 08:47:25.78371
3719	4	43	Transaction #219	2025-06-11	516.69	Auto-generated transaction entry #219	2025-06-15 08:47:25.78371
3720	4	36	Transaction #220	2025-05-18	134.40	Auto-generated transaction entry #220	2025-06-15 08:47:25.78371
3721	4	36	Transaction #221	2025-06-04	388.16	Auto-generated transaction entry #221	2025-06-15 08:47:25.78371
3722	4	43	Transaction #222	2025-05-24	729.25	Auto-generated transaction entry #222	2025-06-15 08:47:25.78371
3723	4	36	Transaction #223	2025-06-14	301.05	Auto-generated transaction entry #223	2025-06-15 08:47:25.78371
3724	4	36	Transaction #224	2025-05-21	338.39	Auto-generated transaction entry #224	2025-06-15 08:47:25.78371
3725	4	43	Transaction #225	2025-06-11	369.00	Auto-generated transaction entry #225	2025-06-15 08:47:25.78371
3726	4	39	Transaction #226	2025-05-26	140.36	Auto-generated transaction entry #226	2025-06-15 08:47:25.78371
3727	4	39	Transaction #227	2025-05-24	137.39	Auto-generated transaction entry #227	2025-06-15 08:47:25.78371
3728	4	43	Transaction #228	2025-06-09	405.44	Auto-generated transaction entry #228	2025-06-15 08:47:25.78371
3729	4	42	Transaction #229	2025-06-02	409.31	Auto-generated transaction entry #229	2025-06-15 08:47:25.78371
3730	4	39	Transaction #230	2025-06-07	94.00	Auto-generated transaction entry #230	2025-06-15 08:47:25.78371
3731	4	38	Transaction #231	2025-05-31	376.12	Auto-generated transaction entry #231	2025-06-15 08:47:25.78371
3732	4	37	Transaction #232	2025-05-18	70.99	Auto-generated transaction entry #232	2025-06-15 08:47:25.78371
3733	4	36	Transaction #233	2025-05-26	237.00	Auto-generated transaction entry #233	2025-06-15 08:47:25.78371
3734	4	38	Transaction #234	2025-06-13	992.59	Auto-generated transaction entry #234	2025-06-15 08:47:25.78371
3735	4	36	Transaction #235	2025-05-19	331.85	Auto-generated transaction entry #235	2025-06-15 08:47:25.78371
3736	4	38	Transaction #236	2025-06-15	213.96	Auto-generated transaction entry #236	2025-06-15 08:47:25.78371
3737	4	43	Transaction #237	2025-06-04	678.81	Auto-generated transaction entry #237	2025-06-15 08:47:25.78371
3738	4	39	Transaction #238	2025-06-09	595.04	Auto-generated transaction entry #238	2025-06-15 08:47:25.78371
3739	4	42	Transaction #239	2025-06-12	584.10	Auto-generated transaction entry #239	2025-06-15 08:47:25.78371
3740	4	42	Transaction #240	2025-05-31	284.83	Auto-generated transaction entry #240	2025-06-15 08:47:25.78371
3741	4	36	Transaction #241	2025-06-12	334.35	Auto-generated transaction entry #241	2025-06-15 08:47:25.78371
3742	4	40	Transaction #242	2025-06-15	485.48	Auto-generated transaction entry #242	2025-06-15 08:47:25.78371
3743	4	39	Transaction #243	2025-06-05	234.11	Auto-generated transaction entry #243	2025-06-15 08:47:25.78371
3744	4	36	Transaction #244	2025-05-30	560.42	Auto-generated transaction entry #244	2025-06-15 08:47:25.78371
3745	4	43	Transaction #245	2025-06-04	619.72	Auto-generated transaction entry #245	2025-06-15 08:47:25.78371
3746	4	41	Transaction #246	2025-05-17	343.16	Auto-generated transaction entry #246	2025-06-15 08:47:25.78371
3747	4	42	Transaction #247	2025-06-06	63.43	Auto-generated transaction entry #247	2025-06-15 08:47:25.78371
3748	4	40	Transaction #248	2025-05-27	872.32	Auto-generated transaction entry #248	2025-06-15 08:47:25.78371
3749	4	36	Transaction #249	2025-06-10	932.36	Auto-generated transaction entry #249	2025-06-15 08:47:25.78371
3750	4	42	Transaction #250	2025-06-14	462.63	Auto-generated transaction entry #250	2025-06-15 08:47:25.78371
3751	4	36	Transaction #251	2025-05-27	74.59	Auto-generated transaction entry #251	2025-06-15 08:47:25.78371
3752	4	40	Transaction #252	2025-05-31	734.08	Auto-generated transaction entry #252	2025-06-15 08:47:25.78371
3753	4	37	Transaction #253	2025-06-01	564.47	Auto-generated transaction entry #253	2025-06-15 08:47:25.78371
3754	4	40	Transaction #254	2025-06-14	640.62	Auto-generated transaction entry #254	2025-06-15 08:47:25.78371
3755	4	43	Transaction #255	2025-05-25	769.30	Auto-generated transaction entry #255	2025-06-15 08:47:25.78371
3756	4	41	Transaction #256	2025-05-18	128.83	Auto-generated transaction entry #256	2025-06-15 08:47:25.78371
3757	4	36	Transaction #257	2025-06-02	937.52	Auto-generated transaction entry #257	2025-06-15 08:47:25.78371
3758	4	38	Transaction #258	2025-06-03	210.36	Auto-generated transaction entry #258	2025-06-15 08:47:25.78371
3759	4	37	Transaction #259	2025-06-08	964.92	Auto-generated transaction entry #259	2025-06-15 08:47:25.78371
3760	4	37	Transaction #260	2025-06-04	448.87	Auto-generated transaction entry #260	2025-06-15 08:47:25.78371
3761	4	43	Transaction #261	2025-06-11	567.33	Auto-generated transaction entry #261	2025-06-15 08:47:25.78371
3762	4	42	Transaction #262	2025-05-17	814.28	Auto-generated transaction entry #262	2025-06-15 08:47:25.78371
3763	4	42	Transaction #263	2025-06-02	63.77	Auto-generated transaction entry #263	2025-06-15 08:47:25.78371
3764	4	41	Transaction #264	2025-06-02	607.55	Auto-generated transaction entry #264	2025-06-15 08:47:25.78371
3765	4	38	Transaction #265	2025-05-30	53.47	Auto-generated transaction entry #265	2025-06-15 08:47:25.78371
3766	4	36	Transaction #266	2025-06-06	939.74	Auto-generated transaction entry #266	2025-06-15 08:47:25.78371
3767	4	40	Transaction #267	2025-06-13	379.18	Auto-generated transaction entry #267	2025-06-15 08:47:25.78371
3768	4	41	Transaction #268	2025-05-22	933.01	Auto-generated transaction entry #268	2025-06-15 08:47:25.78371
3769	4	40	Transaction #269	2025-05-18	272.69	Auto-generated transaction entry #269	2025-06-15 08:47:25.78371
3770	4	42	Transaction #270	2025-05-20	217.63	Auto-generated transaction entry #270	2025-06-15 08:47:25.78371
3771	4	42	Transaction #271	2025-05-22	711.46	Auto-generated transaction entry #271	2025-06-15 08:47:25.78371
3772	4	42	Transaction #272	2025-06-12	392.35	Auto-generated transaction entry #272	2025-06-15 08:47:25.78371
3773	4	37	Transaction #273	2025-06-11	266.64	Auto-generated transaction entry #273	2025-06-15 08:47:25.78371
3774	4	40	Transaction #274	2025-06-11	204.77	Auto-generated transaction entry #274	2025-06-15 08:47:25.78371
3775	4	36	Transaction #275	2025-06-12	914.68	Auto-generated transaction entry #275	2025-06-15 08:47:25.78371
3776	4	39	Transaction #276	2025-06-08	633.44	Auto-generated transaction entry #276	2025-06-15 08:47:25.78371
3777	4	37	Transaction #277	2025-06-02	684.88	Auto-generated transaction entry #277	2025-06-15 08:47:25.78371
3778	4	42	Transaction #278	2025-06-13	85.80	Auto-generated transaction entry #278	2025-06-15 08:47:25.78371
3779	4	42	Transaction #279	2025-06-10	183.84	Auto-generated transaction entry #279	2025-06-15 08:47:25.78371
3780	4	41	Transaction #280	2025-05-26	500.73	Auto-generated transaction entry #280	2025-06-15 08:47:25.78371
3781	4	37	Transaction #281	2025-06-10	59.52	Auto-generated transaction entry #281	2025-06-15 08:47:25.78371
3782	4	37	Transaction #282	2025-05-31	719.13	Auto-generated transaction entry #282	2025-06-15 08:47:25.78371
3783	4	40	Transaction #283	2025-05-21	468.67	Auto-generated transaction entry #283	2025-06-15 08:47:25.78371
3784	4	40	Transaction #284	2025-05-20	873.53	Auto-generated transaction entry #284	2025-06-15 08:47:25.78371
3785	4	36	Transaction #285	2025-05-17	628.90	Auto-generated transaction entry #285	2025-06-15 08:47:25.78371
3786	4	37	Transaction #286	2025-05-26	126.71	Auto-generated transaction entry #286	2025-06-15 08:47:25.78371
3787	4	37	Transaction #287	2025-05-18	611.47	Auto-generated transaction entry #287	2025-06-15 08:47:25.78371
3788	4	38	Transaction #288	2025-05-29	442.43	Auto-generated transaction entry #288	2025-06-15 08:47:25.78371
3789	4	37	Transaction #289	2025-05-19	519.38	Auto-generated transaction entry #289	2025-06-15 08:47:25.78371
3790	4	37	Transaction #290	2025-05-31	524.22	Auto-generated transaction entry #290	2025-06-15 08:47:25.78371
3791	4	39	Transaction #291	2025-05-20	231.98	Auto-generated transaction entry #291	2025-06-15 08:47:25.78371
3792	4	39	Transaction #292	2025-05-20	195.88	Auto-generated transaction entry #292	2025-06-15 08:47:25.78371
3793	4	40	Transaction #293	2025-06-13	603.24	Auto-generated transaction entry #293	2025-06-15 08:47:25.78371
3794	4	37	Transaction #294	2025-06-05	552.50	Auto-generated transaction entry #294	2025-06-15 08:47:25.78371
3795	4	41	Transaction #295	2025-06-15	505.45	Auto-generated transaction entry #295	2025-06-15 08:47:25.78371
3796	4	43	Transaction #296	2025-06-12	120.87	Auto-generated transaction entry #296	2025-06-15 08:47:25.78371
3797	4	42	Transaction #297	2025-06-07	256.63	Auto-generated transaction entry #297	2025-06-15 08:47:25.78371
3798	4	43	Transaction #298	2025-05-23	989.31	Auto-generated transaction entry #298	2025-06-15 08:47:25.78371
3799	4	36	Transaction #299	2025-05-31	612.51	Auto-generated transaction entry #299	2025-06-15 08:47:25.78371
3800	4	38	Transaction #300	2025-06-07	980.35	Auto-generated transaction entry #300	2025-06-15 08:47:25.78371
3801	4	41	Transaction #301	2025-05-29	405.79	Auto-generated transaction entry #301	2025-06-15 08:47:25.78371
3802	4	41	Transaction #302	2025-06-14	186.38	Auto-generated transaction entry #302	2025-06-15 08:47:25.78371
3803	4	43	Transaction #303	2025-05-25	813.72	Auto-generated transaction entry #303	2025-06-15 08:47:25.78371
3804	4	36	Transaction #304	2025-05-31	881.90	Auto-generated transaction entry #304	2025-06-15 08:47:25.78371
3805	4	40	Transaction #305	2025-05-20	570.26	Auto-generated transaction entry #305	2025-06-15 08:47:25.78371
3806	4	36	Transaction #306	2025-06-06	555.42	Auto-generated transaction entry #306	2025-06-15 08:47:25.78371
3807	4	39	Transaction #307	2025-05-23	69.65	Auto-generated transaction entry #307	2025-06-15 08:47:25.78371
3808	4	43	Transaction #308	2025-06-01	97.72	Auto-generated transaction entry #308	2025-06-15 08:47:25.78371
3809	4	37	Transaction #309	2025-06-09	487.43	Auto-generated transaction entry #309	2025-06-15 08:47:25.78371
3810	4	36	Transaction #310	2025-05-29	156.99	Auto-generated transaction entry #310	2025-06-15 08:47:25.78371
3811	4	38	Transaction #311	2025-06-13	678.64	Auto-generated transaction entry #311	2025-06-15 08:47:25.78371
3812	4	38	Transaction #312	2025-05-30	90.64	Auto-generated transaction entry #312	2025-06-15 08:47:25.78371
3813	4	42	Transaction #313	2025-05-28	372.87	Auto-generated transaction entry #313	2025-06-15 08:47:25.78371
3814	4	40	Transaction #314	2025-05-19	110.21	Auto-generated transaction entry #314	2025-06-15 08:47:25.78371
3815	4	43	Transaction #315	2025-06-14	382.42	Auto-generated transaction entry #315	2025-06-15 08:47:25.78371
3816	4	40	Transaction #316	2025-05-23	229.16	Auto-generated transaction entry #316	2025-06-15 08:47:25.78371
3817	4	43	Transaction #317	2025-05-19	267.04	Auto-generated transaction entry #317	2025-06-15 08:47:25.78371
3818	4	40	Transaction #318	2025-06-07	288.32	Auto-generated transaction entry #318	2025-06-15 08:47:25.78371
3819	4	38	Transaction #319	2025-05-19	117.72	Auto-generated transaction entry #319	2025-06-15 08:47:25.78371
3820	4	39	Transaction #320	2025-05-28	889.97	Auto-generated transaction entry #320	2025-06-15 08:47:25.78371
3821	4	38	Transaction #321	2025-05-20	245.83	Auto-generated transaction entry #321	2025-06-15 08:47:25.78371
3822	4	37	Transaction #322	2025-05-18	415.16	Auto-generated transaction entry #322	2025-06-15 08:47:25.78371
3823	4	42	Transaction #323	2025-05-17	100.92	Auto-generated transaction entry #323	2025-06-15 08:47:25.78371
3824	4	37	Transaction #324	2025-05-29	132.31	Auto-generated transaction entry #324	2025-06-15 08:47:25.78371
3825	4	38	Transaction #325	2025-06-09	837.11	Auto-generated transaction entry #325	2025-06-15 08:47:25.78371
3826	4	38	Transaction #326	2025-05-27	820.76	Auto-generated transaction entry #326	2025-06-15 08:47:25.78371
3827	4	43	Transaction #327	2025-05-18	339.08	Auto-generated transaction entry #327	2025-06-15 08:47:25.78371
3828	4	42	Transaction #328	2025-05-17	314.80	Auto-generated transaction entry #328	2025-06-15 08:47:25.78371
3829	4	37	Transaction #329	2025-05-30	71.06	Auto-generated transaction entry #329	2025-06-15 08:47:25.78371
3830	4	39	Transaction #330	2025-06-07	102.13	Auto-generated transaction entry #330	2025-06-15 08:47:25.78371
3831	4	43	Transaction #331	2025-05-17	588.01	Auto-generated transaction entry #331	2025-06-15 08:47:25.78371
3832	4	39	Transaction #332	2025-06-03	513.60	Auto-generated transaction entry #332	2025-06-15 08:47:25.78371
3833	4	39	Transaction #333	2025-05-26	288.48	Auto-generated transaction entry #333	2025-06-15 08:47:25.78371
3834	4	36	Transaction #334	2025-05-19	850.81	Auto-generated transaction entry #334	2025-06-15 08:47:25.78371
3835	4	36	Transaction #335	2025-06-08	641.19	Auto-generated transaction entry #335	2025-06-15 08:47:25.78371
3836	4	36	Transaction #336	2025-05-25	626.03	Auto-generated transaction entry #336	2025-06-15 08:47:25.78371
3837	4	42	Transaction #337	2025-05-22	825.87	Auto-generated transaction entry #337	2025-06-15 08:47:25.78371
3838	4	37	Transaction #338	2025-06-07	872.38	Auto-generated transaction entry #338	2025-06-15 08:47:25.78371
3839	4	43	Transaction #339	2025-06-01	588.27	Auto-generated transaction entry #339	2025-06-15 08:47:25.78371
3840	4	41	Transaction #340	2025-06-01	358.49	Auto-generated transaction entry #340	2025-06-15 08:47:25.78371
3841	4	37	Transaction #341	2025-06-07	594.08	Auto-generated transaction entry #341	2025-06-15 08:47:25.78371
3842	4	36	Transaction #342	2025-05-27	759.99	Auto-generated transaction entry #342	2025-06-15 08:47:25.78371
3843	4	39	Transaction #343	2025-05-27	152.82	Auto-generated transaction entry #343	2025-06-15 08:47:25.78371
3844	4	40	Transaction #344	2025-06-06	677.77	Auto-generated transaction entry #344	2025-06-15 08:47:25.78371
3845	4	40	Transaction #345	2025-06-15	63.24	Auto-generated transaction entry #345	2025-06-15 08:47:25.78371
3846	4	42	Transaction #346	2025-06-12	852.51	Auto-generated transaction entry #346	2025-06-15 08:47:25.78371
3847	4	43	Transaction #347	2025-06-12	667.48	Auto-generated transaction entry #347	2025-06-15 08:47:25.78371
3848	4	40	Transaction #348	2025-05-23	211.83	Auto-generated transaction entry #348	2025-06-15 08:47:25.78371
3849	4	38	Transaction #349	2025-06-15	652.77	Auto-generated transaction entry #349	2025-06-15 08:47:25.78371
3850	4	39	Transaction #350	2025-05-29	374.56	Auto-generated transaction entry #350	2025-06-15 08:47:25.78371
3851	4	39	Transaction #351	2025-05-31	655.30	Auto-generated transaction entry #351	2025-06-15 08:47:25.78371
3852	4	43	Transaction #352	2025-06-14	227.34	Auto-generated transaction entry #352	2025-06-15 08:47:25.78371
3853	4	43	Transaction #353	2025-05-23	998.80	Auto-generated transaction entry #353	2025-06-15 08:47:25.78371
3854	4	36	Transaction #354	2025-06-10	976.09	Auto-generated transaction entry #354	2025-06-15 08:47:25.78371
3855	4	37	Transaction #355	2025-06-09	957.44	Auto-generated transaction entry #355	2025-06-15 08:47:25.78371
3856	4	41	Transaction #356	2025-05-31	593.20	Auto-generated transaction entry #356	2025-06-15 08:47:25.78371
3857	4	43	Transaction #357	2025-05-30	461.62	Auto-generated transaction entry #357	2025-06-15 08:47:25.78371
3858	4	41	Transaction #358	2025-05-22	471.07	Auto-generated transaction entry #358	2025-06-15 08:47:25.78371
3859	4	42	Transaction #359	2025-05-27	485.19	Auto-generated transaction entry #359	2025-06-15 08:47:25.78371
3860	4	37	Transaction #360	2025-05-20	472.93	Auto-generated transaction entry #360	2025-06-15 08:47:25.78371
3861	4	36	Transaction #361	2025-05-28	823.94	Auto-generated transaction entry #361	2025-06-15 08:47:25.78371
3862	4	37	Transaction #362	2025-06-01	575.62	Auto-generated transaction entry #362	2025-06-15 08:47:25.78371
3863	4	41	Transaction #363	2025-05-19	478.73	Auto-generated transaction entry #363	2025-06-15 08:47:25.78371
3864	4	39	Transaction #364	2025-06-07	910.03	Auto-generated transaction entry #364	2025-06-15 08:47:25.78371
3865	4	39	Transaction #365	2025-06-03	364.36	Auto-generated transaction entry #365	2025-06-15 08:47:25.78371
3866	4	43	Transaction #366	2025-05-23	261.06	Auto-generated transaction entry #366	2025-06-15 08:47:25.78371
3867	4	43	Transaction #367	2025-05-20	516.68	Auto-generated transaction entry #367	2025-06-15 08:47:25.78371
3868	4	41	Transaction #368	2025-05-22	431.93	Auto-generated transaction entry #368	2025-06-15 08:47:25.78371
3869	4	37	Transaction #369	2025-06-04	235.70	Auto-generated transaction entry #369	2025-06-15 08:47:25.78371
3870	4	37	Transaction #370	2025-05-22	153.37	Auto-generated transaction entry #370	2025-06-15 08:47:25.78371
3871	4	36	Transaction #371	2025-06-14	956.21	Auto-generated transaction entry #371	2025-06-15 08:47:25.78371
3872	4	41	Transaction #372	2025-05-22	892.42	Auto-generated transaction entry #372	2025-06-15 08:47:25.78371
3873	4	39	Transaction #373	2025-05-23	186.40	Auto-generated transaction entry #373	2025-06-15 08:47:25.78371
3874	4	41	Transaction #374	2025-06-03	469.47	Auto-generated transaction entry #374	2025-06-15 08:47:25.78371
3875	4	37	Transaction #375	2025-06-03	516.81	Auto-generated transaction entry #375	2025-06-15 08:47:25.78371
3876	4	42	Transaction #376	2025-05-25	361.85	Auto-generated transaction entry #376	2025-06-15 08:47:25.78371
3877	4	38	Transaction #377	2025-05-22	631.40	Auto-generated transaction entry #377	2025-06-15 08:47:25.78371
3878	4	40	Transaction #378	2025-06-13	151.27	Auto-generated transaction entry #378	2025-06-15 08:47:25.78371
3879	4	41	Transaction #379	2025-06-09	736.03	Auto-generated transaction entry #379	2025-06-15 08:47:25.78371
3880	4	42	Transaction #380	2025-06-05	430.93	Auto-generated transaction entry #380	2025-06-15 08:47:25.78371
3881	4	36	Transaction #381	2025-06-09	723.08	Auto-generated transaction entry #381	2025-06-15 08:47:25.78371
3882	4	36	Transaction #382	2025-06-05	886.80	Auto-generated transaction entry #382	2025-06-15 08:47:25.78371
3883	4	39	Transaction #383	2025-05-22	930.19	Auto-generated transaction entry #383	2025-06-15 08:47:25.78371
3884	4	43	Transaction #384	2025-06-15	416.85	Auto-generated transaction entry #384	2025-06-15 08:47:25.78371
3885	4	36	Transaction #385	2025-06-09	502.83	Auto-generated transaction entry #385	2025-06-15 08:47:25.78371
3886	4	36	Transaction #386	2025-05-25	200.22	Auto-generated transaction entry #386	2025-06-15 08:47:25.78371
3887	4	36	Transaction #387	2025-06-09	62.07	Auto-generated transaction entry #387	2025-06-15 08:47:25.78371
3888	4	37	Transaction #388	2025-05-21	261.41	Auto-generated transaction entry #388	2025-06-15 08:47:25.78371
3889	4	41	Transaction #389	2025-05-17	956.07	Auto-generated transaction entry #389	2025-06-15 08:47:25.78371
3890	4	40	Transaction #390	2025-06-09	759.29	Auto-generated transaction entry #390	2025-06-15 08:47:25.78371
3891	4	40	Transaction #391	2025-05-20	912.01	Auto-generated transaction entry #391	2025-06-15 08:47:25.78371
3892	4	39	Transaction #392	2025-05-20	60.60	Auto-generated transaction entry #392	2025-06-15 08:47:25.78371
3893	4	40	Transaction #393	2025-05-16	316.44	Auto-generated transaction entry #393	2025-06-15 08:47:25.78371
3894	4	43	Transaction #394	2025-05-25	994.26	Auto-generated transaction entry #394	2025-06-15 08:47:25.78371
3895	4	38	Transaction #395	2025-06-14	496.63	Auto-generated transaction entry #395	2025-06-15 08:47:25.78371
3896	4	43	Transaction #396	2025-06-07	53.20	Auto-generated transaction entry #396	2025-06-15 08:47:25.78371
3897	4	40	Transaction #397	2025-05-24	913.21	Auto-generated transaction entry #397	2025-06-15 08:47:25.78371
3898	4	40	Transaction #398	2025-06-04	548.17	Auto-generated transaction entry #398	2025-06-15 08:47:25.78371
3899	4	38	Transaction #399	2025-06-02	288.52	Auto-generated transaction entry #399	2025-06-15 08:47:25.78371
3900	4	40	Transaction #400	2025-06-11	341.21	Auto-generated transaction entry #400	2025-06-15 08:47:25.78371
3901	4	41	Transaction #401	2025-05-18	217.00	Auto-generated transaction entry #401	2025-06-15 08:47:25.78371
3902	4	43	Transaction #402	2025-05-18	996.86	Auto-generated transaction entry #402	2025-06-15 08:47:25.78371
3903	4	37	Transaction #403	2025-05-30	436.60	Auto-generated transaction entry #403	2025-06-15 08:47:25.78371
3904	4	36	Transaction #404	2025-05-20	439.88	Auto-generated transaction entry #404	2025-06-15 08:47:25.78371
3905	4	37	Transaction #405	2025-05-26	286.68	Auto-generated transaction entry #405	2025-06-15 08:47:25.78371
3906	4	41	Transaction #406	2025-05-17	381.61	Auto-generated transaction entry #406	2025-06-15 08:47:25.78371
3907	4	40	Transaction #407	2025-06-02	887.36	Auto-generated transaction entry #407	2025-06-15 08:47:25.78371
3908	4	40	Transaction #408	2025-06-11	937.36	Auto-generated transaction entry #408	2025-06-15 08:47:25.78371
3909	4	43	Transaction #409	2025-06-03	499.40	Auto-generated transaction entry #409	2025-06-15 08:47:25.78371
3910	4	37	Transaction #410	2025-05-30	808.75	Auto-generated transaction entry #410	2025-06-15 08:47:25.78371
3911	4	36	Transaction #411	2025-05-29	60.09	Auto-generated transaction entry #411	2025-06-15 08:47:25.78371
3912	4	37	Transaction #412	2025-06-06	425.36	Auto-generated transaction entry #412	2025-06-15 08:47:25.78371
3913	4	40	Transaction #413	2025-06-13	986.85	Auto-generated transaction entry #413	2025-06-15 08:47:25.78371
3914	4	41	Transaction #414	2025-06-02	868.88	Auto-generated transaction entry #414	2025-06-15 08:47:25.78371
3915	4	42	Transaction #415	2025-05-31	653.50	Auto-generated transaction entry #415	2025-06-15 08:47:25.78371
3916	4	43	Transaction #416	2025-05-19	835.47	Auto-generated transaction entry #416	2025-06-15 08:47:25.78371
3917	4	42	Transaction #417	2025-06-02	351.37	Auto-generated transaction entry #417	2025-06-15 08:47:25.78371
3918	4	42	Transaction #418	2025-06-03	670.98	Auto-generated transaction entry #418	2025-06-15 08:47:25.78371
3919	4	41	Transaction #419	2025-06-11	123.72	Auto-generated transaction entry #419	2025-06-15 08:47:25.78371
3920	4	39	Transaction #420	2025-06-03	524.80	Auto-generated transaction entry #420	2025-06-15 08:47:25.78371
3921	4	38	Transaction #421	2025-06-02	836.26	Auto-generated transaction entry #421	2025-06-15 08:47:25.78371
3922	4	40	Transaction #422	2025-06-02	829.54	Auto-generated transaction entry #422	2025-06-15 08:47:25.78371
3923	4	38	Transaction #423	2025-05-19	896.13	Auto-generated transaction entry #423	2025-06-15 08:47:25.78371
3924	4	41	Transaction #424	2025-06-09	231.50	Auto-generated transaction entry #424	2025-06-15 08:47:25.78371
3925	4	41	Transaction #425	2025-06-07	763.68	Auto-generated transaction entry #425	2025-06-15 08:47:25.78371
3926	4	38	Transaction #426	2025-05-22	257.54	Auto-generated transaction entry #426	2025-06-15 08:47:25.78371
3927	4	41	Transaction #427	2025-06-11	609.97	Auto-generated transaction entry #427	2025-06-15 08:47:25.78371
3928	4	40	Transaction #428	2025-06-14	450.89	Auto-generated transaction entry #428	2025-06-15 08:47:25.78371
3929	4	37	Transaction #429	2025-06-02	629.54	Auto-generated transaction entry #429	2025-06-15 08:47:25.78371
3930	4	42	Transaction #430	2025-06-05	144.21	Auto-generated transaction entry #430	2025-06-15 08:47:25.78371
3931	4	42	Transaction #431	2025-05-26	588.18	Auto-generated transaction entry #431	2025-06-15 08:47:25.78371
3932	4	41	Transaction #432	2025-05-25	189.79	Auto-generated transaction entry #432	2025-06-15 08:47:25.78371
3933	4	42	Transaction #433	2025-06-05	414.70	Auto-generated transaction entry #433	2025-06-15 08:47:25.78371
3934	4	37	Transaction #434	2025-05-18	498.01	Auto-generated transaction entry #434	2025-06-15 08:47:25.78371
3935	4	37	Transaction #435	2025-06-05	837.90	Auto-generated transaction entry #435	2025-06-15 08:47:25.78371
3936	4	40	Transaction #436	2025-05-23	162.46	Auto-generated transaction entry #436	2025-06-15 08:47:25.78371
3937	4	41	Transaction #437	2025-05-17	516.00	Auto-generated transaction entry #437	2025-06-15 08:47:25.78371
3938	4	42	Transaction #438	2025-06-08	430.59	Auto-generated transaction entry #438	2025-06-15 08:47:25.78371
3939	4	43	Transaction #439	2025-05-29	202.71	Auto-generated transaction entry #439	2025-06-15 08:47:25.78371
3940	4	37	Transaction #440	2025-05-31	944.86	Auto-generated transaction entry #440	2025-06-15 08:47:25.78371
3941	4	37	Transaction #441	2025-05-29	597.28	Auto-generated transaction entry #441	2025-06-15 08:47:25.78371
3942	4	37	Transaction #442	2025-06-12	965.45	Auto-generated transaction entry #442	2025-06-15 08:47:25.78371
3943	4	37	Transaction #443	2025-05-24	178.60	Auto-generated transaction entry #443	2025-06-15 08:47:25.78371
3944	4	40	Transaction #444	2025-05-30	669.90	Auto-generated transaction entry #444	2025-06-15 08:47:25.78371
3945	4	36	Transaction #445	2025-05-22	152.42	Auto-generated transaction entry #445	2025-06-15 08:47:25.78371
3946	4	40	Transaction #446	2025-05-19	954.05	Auto-generated transaction entry #446	2025-06-15 08:47:25.78371
3947	4	41	Transaction #447	2025-05-20	285.40	Auto-generated transaction entry #447	2025-06-15 08:47:25.78371
3948	4	38	Transaction #448	2025-06-03	828.79	Auto-generated transaction entry #448	2025-06-15 08:47:25.78371
3949	4	39	Transaction #449	2025-05-28	613.47	Auto-generated transaction entry #449	2025-06-15 08:47:25.78371
3950	4	36	Transaction #450	2025-05-20	479.67	Auto-generated transaction entry #450	2025-06-15 08:47:25.78371
3951	4	38	Transaction #451	2025-05-19	803.88	Auto-generated transaction entry #451	2025-06-15 08:47:25.78371
3952	4	38	Transaction #452	2025-06-13	221.99	Auto-generated transaction entry #452	2025-06-15 08:47:25.78371
3953	4	38	Transaction #453	2025-06-07	699.73	Auto-generated transaction entry #453	2025-06-15 08:47:25.78371
3954	4	39	Transaction #454	2025-05-28	966.59	Auto-generated transaction entry #454	2025-06-15 08:47:25.78371
3955	4	43	Transaction #455	2025-06-09	634.60	Auto-generated transaction entry #455	2025-06-15 08:47:25.78371
3956	4	43	Transaction #456	2025-06-13	183.64	Auto-generated transaction entry #456	2025-06-15 08:47:25.78371
3957	4	40	Transaction #457	2025-05-27	480.42	Auto-generated transaction entry #457	2025-06-15 08:47:25.78371
3958	4	39	Transaction #458	2025-05-23	660.00	Auto-generated transaction entry #458	2025-06-15 08:47:25.78371
3959	4	43	Transaction #459	2025-05-30	632.27	Auto-generated transaction entry #459	2025-06-15 08:47:25.78371
3960	4	43	Transaction #460	2025-06-09	162.32	Auto-generated transaction entry #460	2025-06-15 08:47:25.78371
3961	4	38	Transaction #461	2025-05-29	624.63	Auto-generated transaction entry #461	2025-06-15 08:47:25.78371
3962	4	39	Transaction #462	2025-05-31	359.12	Auto-generated transaction entry #462	2025-06-15 08:47:25.78371
3963	4	40	Transaction #463	2025-06-07	476.75	Auto-generated transaction entry #463	2025-06-15 08:47:25.78371
3964	4	37	Transaction #464	2025-05-30	545.54	Auto-generated transaction entry #464	2025-06-15 08:47:25.78371
3965	4	41	Transaction #465	2025-05-16	950.70	Auto-generated transaction entry #465	2025-06-15 08:47:25.78371
3966	4	41	Transaction #466	2025-05-24	801.30	Auto-generated transaction entry #466	2025-06-15 08:47:25.78371
3967	4	37	Transaction #467	2025-06-06	105.87	Auto-generated transaction entry #467	2025-06-15 08:47:25.78371
3968	4	39	Transaction #468	2025-05-22	601.63	Auto-generated transaction entry #468	2025-06-15 08:47:25.78371
3969	4	39	Transaction #469	2025-05-31	607.87	Auto-generated transaction entry #469	2025-06-15 08:47:25.78371
3970	4	42	Transaction #470	2025-05-19	108.36	Auto-generated transaction entry #470	2025-06-15 08:47:25.78371
3971	4	38	Transaction #471	2025-06-08	909.96	Auto-generated transaction entry #471	2025-06-15 08:47:25.78371
3972	4	36	Transaction #472	2025-05-29	636.35	Auto-generated transaction entry #472	2025-06-15 08:47:25.78371
3973	4	41	Transaction #473	2025-05-29	191.68	Auto-generated transaction entry #473	2025-06-15 08:47:25.78371
3974	4	36	Transaction #474	2025-06-09	654.67	Auto-generated transaction entry #474	2025-06-15 08:47:25.78371
3975	4	39	Transaction #475	2025-05-20	546.78	Auto-generated transaction entry #475	2025-06-15 08:47:25.78371
3976	4	39	Transaction #476	2025-05-26	624.29	Auto-generated transaction entry #476	2025-06-15 08:47:25.78371
3977	4	39	Transaction #477	2025-06-15	837.74	Auto-generated transaction entry #477	2025-06-15 08:47:25.78371
3978	4	42	Transaction #478	2025-05-30	282.37	Auto-generated transaction entry #478	2025-06-15 08:47:25.78371
3979	4	39	Transaction #479	2025-06-10	674.75	Auto-generated transaction entry #479	2025-06-15 08:47:25.78371
3980	4	38	Transaction #480	2025-05-29	295.68	Auto-generated transaction entry #480	2025-06-15 08:47:25.78371
3981	4	43	Transaction #481	2025-06-05	579.14	Auto-generated transaction entry #481	2025-06-15 08:47:25.78371
3982	4	39	Transaction #482	2025-05-26	106.08	Auto-generated transaction entry #482	2025-06-15 08:47:25.78371
3983	4	41	Transaction #483	2025-06-14	459.95	Auto-generated transaction entry #483	2025-06-15 08:47:25.78371
3984	4	38	Transaction #484	2025-05-18	827.51	Auto-generated transaction entry #484	2025-06-15 08:47:25.78371
3985	4	38	Transaction #485	2025-05-21	583.21	Auto-generated transaction entry #485	2025-06-15 08:47:25.78371
3986	4	38	Transaction #486	2025-05-21	152.62	Auto-generated transaction entry #486	2025-06-15 08:47:25.78371
3987	4	38	Transaction #487	2025-06-10	591.80	Auto-generated transaction entry #487	2025-06-15 08:47:25.78371
3988	4	43	Transaction #488	2025-06-09	131.40	Auto-generated transaction entry #488	2025-06-15 08:47:25.78371
3989	4	39	Transaction #489	2025-06-03	175.46	Auto-generated transaction entry #489	2025-06-15 08:47:25.78371
3990	4	40	Transaction #490	2025-05-18	382.53	Auto-generated transaction entry #490	2025-06-15 08:47:25.78371
3991	4	37	Transaction #491	2025-05-27	444.82	Auto-generated transaction entry #491	2025-06-15 08:47:25.78371
3992	4	37	Transaction #492	2025-05-30	626.15	Auto-generated transaction entry #492	2025-06-15 08:47:25.78371
3993	4	38	Transaction #493	2025-06-07	761.41	Auto-generated transaction entry #493	2025-06-15 08:47:25.78371
3994	4	41	Transaction #494	2025-05-31	596.85	Auto-generated transaction entry #494	2025-06-15 08:47:25.78371
3995	4	38	Transaction #495	2025-06-08	103.20	Auto-generated transaction entry #495	2025-06-15 08:47:25.78371
3996	4	42	Transaction #496	2025-06-09	862.01	Auto-generated transaction entry #496	2025-06-15 08:47:25.78371
3997	4	43	Transaction #497	2025-05-27	865.44	Auto-generated transaction entry #497	2025-06-15 08:47:25.78371
3998	4	38	Transaction #498	2025-06-08	599.34	Auto-generated transaction entry #498	2025-06-15 08:47:25.78371
3999	4	40	Transaction #499	2025-05-18	768.45	Auto-generated transaction entry #499	2025-06-15 08:47:25.78371
4000	4	39	Transaction #500	2025-05-27	53.30	Auto-generated transaction entry #500	2025-06-15 08:47:25.78371
4001	5	49	Transaction #1	2025-05-31	832.41	Auto-generated transaction entry #1	2025-06-15 08:47:38.007345
4002	5	53	Transaction #2	2025-05-29	189.45	Auto-generated transaction entry #2	2025-06-15 08:47:38.007345
4003	5	54	Transaction #3	2025-05-21	901.34	Auto-generated transaction entry #3	2025-06-15 08:47:38.007345
4004	5	55	Transaction #4	2025-06-11	995.20	Auto-generated transaction entry #4	2025-06-15 08:47:38.007345
4005	5	52	Transaction #5	2025-05-25	671.47	Auto-generated transaction entry #5	2025-06-15 08:47:38.007345
4006	5	54	Transaction #6	2025-05-19	607.27	Auto-generated transaction entry #6	2025-06-15 08:47:38.007345
4007	5	52	Transaction #7	2025-05-21	763.91	Auto-generated transaction entry #7	2025-06-15 08:47:38.007345
4008	5	55	Transaction #8	2025-05-19	113.48	Auto-generated transaction entry #8	2025-06-15 08:47:38.007345
4009	5	53	Transaction #9	2025-05-18	541.08	Auto-generated transaction entry #9	2025-06-15 08:47:38.007345
4010	5	55	Transaction #10	2025-05-26	999.81	Auto-generated transaction entry #10	2025-06-15 08:47:38.007345
4011	5	54	Transaction #11	2025-05-24	528.88	Auto-generated transaction entry #11	2025-06-15 08:47:38.007345
4012	5	49	Transaction #12	2025-06-09	488.26	Auto-generated transaction entry #12	2025-06-15 08:47:38.007345
4013	5	53	Transaction #13	2025-06-04	907.68	Auto-generated transaction entry #13	2025-06-15 08:47:38.007345
4014	5	50	Transaction #14	2025-06-13	477.50	Auto-generated transaction entry #14	2025-06-15 08:47:38.007345
4015	5	49	Transaction #15	2025-06-11	59.51	Auto-generated transaction entry #15	2025-06-15 08:47:38.007345
4016	5	52	Transaction #16	2025-06-05	731.72	Auto-generated transaction entry #16	2025-06-15 08:47:38.007345
4017	5	51	Transaction #17	2025-06-09	111.37	Auto-generated transaction entry #17	2025-06-15 08:47:38.007345
4018	5	55	Transaction #18	2025-06-06	73.11	Auto-generated transaction entry #18	2025-06-15 08:47:38.007345
4019	5	54	Transaction #19	2025-06-09	248.24	Auto-generated transaction entry #19	2025-06-15 08:47:38.007345
4020	5	49	Transaction #20	2025-06-01	646.70	Auto-generated transaction entry #20	2025-06-15 08:47:38.007345
4021	5	55	Transaction #21	2025-05-22	734.15	Auto-generated transaction entry #21	2025-06-15 08:47:38.007345
4022	5	55	Transaction #22	2025-05-23	226.76	Auto-generated transaction entry #22	2025-06-15 08:47:38.007345
4023	5	51	Transaction #23	2025-05-27	931.04	Auto-generated transaction entry #23	2025-06-15 08:47:38.007345
4024	5	52	Transaction #24	2025-06-06	495.21	Auto-generated transaction entry #24	2025-06-15 08:47:38.007345
4025	5	54	Transaction #25	2025-06-14	901.48	Auto-generated transaction entry #25	2025-06-15 08:47:38.007345
4026	5	50	Transaction #26	2025-05-29	499.61	Auto-generated transaction entry #26	2025-06-15 08:47:38.007345
4027	5	49	Transaction #27	2025-06-02	581.34	Auto-generated transaction entry #27	2025-06-15 08:47:38.007345
4028	5	49	Transaction #28	2025-05-18	395.90	Auto-generated transaction entry #28	2025-06-15 08:47:38.007345
4029	5	51	Transaction #29	2025-06-02	672.95	Auto-generated transaction entry #29	2025-06-15 08:47:38.007345
4030	5	55	Transaction #30	2025-06-05	180.30	Auto-generated transaction entry #30	2025-06-15 08:47:38.007345
4031	5	54	Transaction #31	2025-06-07	732.99	Auto-generated transaction entry #31	2025-06-15 08:47:38.007345
4032	5	49	Transaction #32	2025-05-28	524.62	Auto-generated transaction entry #32	2025-06-15 08:47:38.007345
4033	5	50	Transaction #33	2025-06-11	421.96	Auto-generated transaction entry #33	2025-06-15 08:47:38.007345
4034	5	49	Transaction #34	2025-05-28	195.56	Auto-generated transaction entry #34	2025-06-15 08:47:38.007345
4035	5	49	Transaction #35	2025-06-01	118.73	Auto-generated transaction entry #35	2025-06-15 08:47:38.007345
4036	5	50	Transaction #36	2025-06-05	192.38	Auto-generated transaction entry #36	2025-06-15 08:47:38.007345
4037	5	49	Transaction #37	2025-06-02	146.22	Auto-generated transaction entry #37	2025-06-15 08:47:38.007345
4038	5	53	Transaction #38	2025-06-14	764.87	Auto-generated transaction entry #38	2025-06-15 08:47:38.007345
4039	5	54	Transaction #39	2025-05-25	905.28	Auto-generated transaction entry #39	2025-06-15 08:47:38.007345
4040	5	51	Transaction #40	2025-06-15	226.83	Auto-generated transaction entry #40	2025-06-15 08:47:38.007345
4041	5	50	Transaction #41	2025-05-22	333.76	Auto-generated transaction entry #41	2025-06-15 08:47:38.007345
4042	5	49	Transaction #42	2025-06-13	618.76	Auto-generated transaction entry #42	2025-06-15 08:47:38.007345
4043	5	53	Transaction #43	2025-05-29	195.57	Auto-generated transaction entry #43	2025-06-15 08:47:38.007345
4044	5	52	Transaction #44	2025-05-29	270.70	Auto-generated transaction entry #44	2025-06-15 08:47:38.007345
4045	5	50	Transaction #45	2025-06-13	396.91	Auto-generated transaction entry #45	2025-06-15 08:47:38.007345
4046	5	55	Transaction #46	2025-06-07	228.53	Auto-generated transaction entry #46	2025-06-15 08:47:38.007345
4047	5	50	Transaction #47	2025-05-31	737.86	Auto-generated transaction entry #47	2025-06-15 08:47:38.007345
4048	5	51	Transaction #48	2025-05-24	897.13	Auto-generated transaction entry #48	2025-06-15 08:47:38.007345
4049	5	53	Transaction #49	2025-05-23	176.30	Auto-generated transaction entry #49	2025-06-15 08:47:38.007345
4050	5	52	Transaction #50	2025-05-24	283.94	Auto-generated transaction entry #50	2025-06-15 08:47:38.007345
4051	5	49	Transaction #51	2025-06-06	92.14	Auto-generated transaction entry #51	2025-06-15 08:47:38.007345
4052	5	54	Transaction #52	2025-05-29	735.50	Auto-generated transaction entry #52	2025-06-15 08:47:38.007345
4053	5	51	Transaction #53	2025-05-29	75.11	Auto-generated transaction entry #53	2025-06-15 08:47:38.007345
4054	5	51	Transaction #54	2025-05-29	918.89	Auto-generated transaction entry #54	2025-06-15 08:47:38.007345
4055	5	52	Transaction #55	2025-06-05	731.02	Auto-generated transaction entry #55	2025-06-15 08:47:38.007345
4056	5	49	Transaction #56	2025-05-19	874.82	Auto-generated transaction entry #56	2025-06-15 08:47:38.007345
4057	5	53	Transaction #57	2025-06-10	567.05	Auto-generated transaction entry #57	2025-06-15 08:47:38.007345
4058	5	51	Transaction #58	2025-06-09	191.97	Auto-generated transaction entry #58	2025-06-15 08:47:38.007345
4059	5	55	Transaction #59	2025-05-31	280.42	Auto-generated transaction entry #59	2025-06-15 08:47:38.007345
4060	5	51	Transaction #60	2025-06-02	91.02	Auto-generated transaction entry #60	2025-06-15 08:47:38.007345
4061	5	55	Transaction #61	2025-06-13	835.22	Auto-generated transaction entry #61	2025-06-15 08:47:38.007345
4062	5	55	Transaction #62	2025-05-18	249.24	Auto-generated transaction entry #62	2025-06-15 08:47:38.007345
4063	5	53	Transaction #63	2025-06-14	650.43	Auto-generated transaction entry #63	2025-06-15 08:47:38.007345
4064	5	53	Transaction #64	2025-05-27	968.52	Auto-generated transaction entry #64	2025-06-15 08:47:38.007345
4065	5	52	Transaction #65	2025-06-09	477.74	Auto-generated transaction entry #65	2025-06-15 08:47:38.007345
4066	5	51	Transaction #66	2025-05-27	137.50	Auto-generated transaction entry #66	2025-06-15 08:47:38.007345
4067	5	49	Transaction #67	2025-06-08	779.21	Auto-generated transaction entry #67	2025-06-15 08:47:38.007345
4068	5	49	Transaction #68	2025-06-09	483.71	Auto-generated transaction entry #68	2025-06-15 08:47:38.007345
4069	5	54	Transaction #69	2025-05-30	437.14	Auto-generated transaction entry #69	2025-06-15 08:47:38.007345
4070	5	50	Transaction #70	2025-06-01	117.36	Auto-generated transaction entry #70	2025-06-15 08:47:38.007345
4071	5	54	Transaction #71	2025-06-03	293.55	Auto-generated transaction entry #71	2025-06-15 08:47:38.007345
4072	5	53	Transaction #72	2025-05-20	796.89	Auto-generated transaction entry #72	2025-06-15 08:47:38.007345
4073	5	55	Transaction #73	2025-05-31	335.26	Auto-generated transaction entry #73	2025-06-15 08:47:38.007345
4074	5	55	Transaction #74	2025-05-23	830.56	Auto-generated transaction entry #74	2025-06-15 08:47:38.007345
4075	5	52	Transaction #75	2025-06-02	709.16	Auto-generated transaction entry #75	2025-06-15 08:47:38.007345
4076	5	49	Transaction #76	2025-05-22	639.26	Auto-generated transaction entry #76	2025-06-15 08:47:38.007345
4077	5	52	Transaction #77	2025-05-22	603.14	Auto-generated transaction entry #77	2025-06-15 08:47:38.007345
4078	5	51	Transaction #78	2025-05-27	435.74	Auto-generated transaction entry #78	2025-06-15 08:47:38.007345
4079	5	53	Transaction #79	2025-06-04	422.44	Auto-generated transaction entry #79	2025-06-15 08:47:38.007345
4080	5	50	Transaction #80	2025-06-12	552.22	Auto-generated transaction entry #80	2025-06-15 08:47:38.007345
4081	5	55	Transaction #81	2025-05-25	254.12	Auto-generated transaction entry #81	2025-06-15 08:47:38.007345
4082	5	49	Transaction #82	2025-06-11	606.98	Auto-generated transaction entry #82	2025-06-15 08:47:38.007345
4083	5	53	Transaction #83	2025-05-25	670.79	Auto-generated transaction entry #83	2025-06-15 08:47:38.007345
4084	5	51	Transaction #84	2025-06-08	496.60	Auto-generated transaction entry #84	2025-06-15 08:47:38.007345
4085	5	51	Transaction #85	2025-06-04	471.79	Auto-generated transaction entry #85	2025-06-15 08:47:38.007345
4086	5	55	Transaction #86	2025-06-06	171.05	Auto-generated transaction entry #86	2025-06-15 08:47:38.007345
4087	5	49	Transaction #87	2025-06-11	101.24	Auto-generated transaction entry #87	2025-06-15 08:47:38.007345
4088	5	52	Transaction #88	2025-05-30	858.91	Auto-generated transaction entry #88	2025-06-15 08:47:38.007345
4089	5	50	Transaction #89	2025-05-22	747.84	Auto-generated transaction entry #89	2025-06-15 08:47:38.007345
4090	5	53	Transaction #90	2025-05-31	528.19	Auto-generated transaction entry #90	2025-06-15 08:47:38.007345
4091	5	50	Transaction #91	2025-05-20	798.68	Auto-generated transaction entry #91	2025-06-15 08:47:38.007345
4092	5	52	Transaction #92	2025-06-06	476.12	Auto-generated transaction entry #92	2025-06-15 08:47:38.007345
4093	5	51	Transaction #93	2025-05-25	382.82	Auto-generated transaction entry #93	2025-06-15 08:47:38.007345
4094	5	55	Transaction #94	2025-05-25	435.65	Auto-generated transaction entry #94	2025-06-15 08:47:38.007345
4095	5	54	Transaction #95	2025-06-04	720.81	Auto-generated transaction entry #95	2025-06-15 08:47:38.007345
4096	5	49	Transaction #96	2025-05-24	368.22	Auto-generated transaction entry #96	2025-06-15 08:47:38.007345
4097	5	50	Transaction #97	2025-06-06	802.91	Auto-generated transaction entry #97	2025-06-15 08:47:38.007345
4098	5	54	Transaction #98	2025-06-06	941.31	Auto-generated transaction entry #98	2025-06-15 08:47:38.007345
4099	5	51	Transaction #99	2025-05-21	899.98	Auto-generated transaction entry #99	2025-06-15 08:47:38.007345
4100	5	50	Transaction #100	2025-05-17	553.70	Auto-generated transaction entry #100	2025-06-15 08:47:38.007345
4101	5	55	Transaction #101	2025-06-08	123.08	Auto-generated transaction entry #101	2025-06-15 08:47:38.007345
4102	5	52	Transaction #102	2025-05-28	287.62	Auto-generated transaction entry #102	2025-06-15 08:47:38.007345
4103	5	54	Transaction #103	2025-05-19	529.34	Auto-generated transaction entry #103	2025-06-15 08:47:38.007345
4104	5	52	Transaction #104	2025-05-27	701.91	Auto-generated transaction entry #104	2025-06-15 08:47:38.007345
4105	5	53	Transaction #105	2025-06-05	183.70	Auto-generated transaction entry #105	2025-06-15 08:47:38.007345
4106	5	50	Transaction #106	2025-06-13	206.55	Auto-generated transaction entry #106	2025-06-15 08:47:38.007345
4107	5	52	Transaction #107	2025-05-27	106.50	Auto-generated transaction entry #107	2025-06-15 08:47:38.007345
4108	5	50	Transaction #108	2025-06-06	436.61	Auto-generated transaction entry #108	2025-06-15 08:47:38.007345
4109	5	49	Transaction #109	2025-06-03	794.41	Auto-generated transaction entry #109	2025-06-15 08:47:38.007345
4110	5	49	Transaction #110	2025-05-21	440.24	Auto-generated transaction entry #110	2025-06-15 08:47:38.007345
4111	5	55	Transaction #111	2025-05-21	441.90	Auto-generated transaction entry #111	2025-06-15 08:47:38.007345
4112	5	55	Transaction #112	2025-05-31	838.14	Auto-generated transaction entry #112	2025-06-15 08:47:38.007345
4113	5	50	Transaction #113	2025-06-02	398.92	Auto-generated transaction entry #113	2025-06-15 08:47:38.007345
4114	5	49	Transaction #114	2025-05-21	712.46	Auto-generated transaction entry #114	2025-06-15 08:47:38.007345
4115	5	54	Transaction #115	2025-06-10	451.90	Auto-generated transaction entry #115	2025-06-15 08:47:38.007345
4116	5	51	Transaction #116	2025-05-22	740.11	Auto-generated transaction entry #116	2025-06-15 08:47:38.007345
4117	5	53	Transaction #117	2025-06-11	669.04	Auto-generated transaction entry #117	2025-06-15 08:47:38.007345
4118	5	49	Transaction #118	2025-05-20	124.58	Auto-generated transaction entry #118	2025-06-15 08:47:38.007345
4119	5	50	Transaction #119	2025-06-10	470.15	Auto-generated transaction entry #119	2025-06-15 08:47:38.007345
4120	5	53	Transaction #120	2025-06-13	315.31	Auto-generated transaction entry #120	2025-06-15 08:47:38.007345
4121	5	54	Transaction #121	2025-05-30	630.42	Auto-generated transaction entry #121	2025-06-15 08:47:38.007345
4122	5	55	Transaction #122	2025-05-27	139.91	Auto-generated transaction entry #122	2025-06-15 08:47:38.007345
4123	5	52	Transaction #123	2025-06-03	690.58	Auto-generated transaction entry #123	2025-06-15 08:47:38.007345
4124	5	51	Transaction #124	2025-06-10	84.12	Auto-generated transaction entry #124	2025-06-15 08:47:38.007345
4125	5	50	Transaction #125	2025-06-08	463.37	Auto-generated transaction entry #125	2025-06-15 08:47:38.007345
4126	5	53	Transaction #126	2025-05-22	682.82	Auto-generated transaction entry #126	2025-06-15 08:47:38.007345
4127	5	50	Transaction #127	2025-06-11	504.68	Auto-generated transaction entry #127	2025-06-15 08:47:38.007345
4128	5	53	Transaction #128	2025-06-04	239.95	Auto-generated transaction entry #128	2025-06-15 08:47:38.007345
4129	5	55	Transaction #129	2025-06-04	315.69	Auto-generated transaction entry #129	2025-06-15 08:47:38.007345
4130	5	49	Transaction #130	2025-06-13	666.25	Auto-generated transaction entry #130	2025-06-15 08:47:38.007345
4131	5	54	Transaction #131	2025-06-11	457.76	Auto-generated transaction entry #131	2025-06-15 08:47:38.007345
4132	5	53	Transaction #132	2025-05-28	692.21	Auto-generated transaction entry #132	2025-06-15 08:47:38.007345
4133	5	50	Transaction #133	2025-05-21	537.25	Auto-generated transaction entry #133	2025-06-15 08:47:38.007345
4134	5	52	Transaction #134	2025-05-24	782.94	Auto-generated transaction entry #134	2025-06-15 08:47:38.007345
4135	5	55	Transaction #135	2025-06-15	801.65	Auto-generated transaction entry #135	2025-06-15 08:47:38.007345
4136	5	49	Transaction #136	2025-06-03	286.37	Auto-generated transaction entry #136	2025-06-15 08:47:38.007345
4137	5	52	Transaction #137	2025-05-26	274.17	Auto-generated transaction entry #137	2025-06-15 08:47:38.007345
4138	5	51	Transaction #138	2025-06-07	893.41	Auto-generated transaction entry #138	2025-06-15 08:47:38.007345
4139	5	49	Transaction #139	2025-06-07	472.90	Auto-generated transaction entry #139	2025-06-15 08:47:38.007345
4140	5	54	Transaction #140	2025-05-24	134.28	Auto-generated transaction entry #140	2025-06-15 08:47:38.007345
4141	5	55	Transaction #141	2025-05-27	509.91	Auto-generated transaction entry #141	2025-06-15 08:47:38.007345
4142	5	55	Transaction #142	2025-05-17	499.29	Auto-generated transaction entry #142	2025-06-15 08:47:38.007345
4143	5	53	Transaction #143	2025-06-12	766.91	Auto-generated transaction entry #143	2025-06-15 08:47:38.007345
4144	5	49	Transaction #144	2025-05-27	396.30	Auto-generated transaction entry #144	2025-06-15 08:47:38.007345
4145	5	53	Transaction #145	2025-06-08	757.32	Auto-generated transaction entry #145	2025-06-15 08:47:38.007345
4146	5	54	Transaction #146	2025-06-01	646.63	Auto-generated transaction entry #146	2025-06-15 08:47:38.007345
4147	5	55	Transaction #147	2025-06-05	926.69	Auto-generated transaction entry #147	2025-06-15 08:47:38.007345
4148	5	49	Transaction #148	2025-05-20	244.22	Auto-generated transaction entry #148	2025-06-15 08:47:38.007345
4149	5	53	Transaction #149	2025-05-19	947.72	Auto-generated transaction entry #149	2025-06-15 08:47:38.007345
4150	5	51	Transaction #150	2025-06-02	235.11	Auto-generated transaction entry #150	2025-06-15 08:47:38.007345
4151	5	52	Transaction #151	2025-06-01	798.00	Auto-generated transaction entry #151	2025-06-15 08:47:38.007345
4152	5	53	Transaction #152	2025-05-31	342.85	Auto-generated transaction entry #152	2025-06-15 08:47:38.007345
4153	5	53	Transaction #153	2025-05-19	850.50	Auto-generated transaction entry #153	2025-06-15 08:47:38.007345
4154	5	55	Transaction #154	2025-05-26	360.59	Auto-generated transaction entry #154	2025-06-15 08:47:38.007345
4155	5	50	Transaction #155	2025-06-11	132.05	Auto-generated transaction entry #155	2025-06-15 08:47:38.007345
4156	5	49	Transaction #156	2025-06-08	104.00	Auto-generated transaction entry #156	2025-06-15 08:47:38.007345
4157	5	50	Transaction #157	2025-05-17	198.23	Auto-generated transaction entry #157	2025-06-15 08:47:38.007345
4158	5	50	Transaction #158	2025-05-29	554.16	Auto-generated transaction entry #158	2025-06-15 08:47:38.007345
4159	5	51	Transaction #159	2025-05-26	263.12	Auto-generated transaction entry #159	2025-06-15 08:47:38.007345
4160	5	54	Transaction #160	2025-05-23	172.22	Auto-generated transaction entry #160	2025-06-15 08:47:38.007345
4161	5	55	Transaction #161	2025-06-03	502.93	Auto-generated transaction entry #161	2025-06-15 08:47:38.007345
4162	5	50	Transaction #162	2025-05-30	58.43	Auto-generated transaction entry #162	2025-06-15 08:47:38.007345
4163	5	55	Transaction #163	2025-06-08	435.90	Auto-generated transaction entry #163	2025-06-15 08:47:38.007345
4164	5	50	Transaction #164	2025-05-27	920.17	Auto-generated transaction entry #164	2025-06-15 08:47:38.007345
4165	5	49	Transaction #165	2025-06-05	368.56	Auto-generated transaction entry #165	2025-06-15 08:47:38.007345
4166	5	51	Transaction #166	2025-06-12	247.27	Auto-generated transaction entry #166	2025-06-15 08:47:38.007345
4167	5	52	Transaction #167	2025-06-01	839.03	Auto-generated transaction entry #167	2025-06-15 08:47:38.007345
4168	5	49	Transaction #168	2025-05-30	984.41	Auto-generated transaction entry #168	2025-06-15 08:47:38.007345
4169	5	53	Transaction #169	2025-06-06	189.88	Auto-generated transaction entry #169	2025-06-15 08:47:38.007345
4170	5	52	Transaction #170	2025-06-09	452.43	Auto-generated transaction entry #170	2025-06-15 08:47:38.007345
4171	5	52	Transaction #171	2025-06-07	734.96	Auto-generated transaction entry #171	2025-06-15 08:47:38.007345
4172	5	53	Transaction #172	2025-05-22	187.02	Auto-generated transaction entry #172	2025-06-15 08:47:38.007345
4173	5	54	Transaction #173	2025-05-19	294.28	Auto-generated transaction entry #173	2025-06-15 08:47:38.007345
4174	5	52	Transaction #174	2025-06-04	675.14	Auto-generated transaction entry #174	2025-06-15 08:47:38.007345
4175	5	50	Transaction #175	2025-06-12	899.65	Auto-generated transaction entry #175	2025-06-15 08:47:38.007345
4176	5	51	Transaction #176	2025-06-05	467.66	Auto-generated transaction entry #176	2025-06-15 08:47:38.007345
4177	5	55	Transaction #177	2025-06-10	157.94	Auto-generated transaction entry #177	2025-06-15 08:47:38.007345
4178	5	53	Transaction #178	2025-06-12	515.23	Auto-generated transaction entry #178	2025-06-15 08:47:38.007345
4179	5	49	Transaction #179	2025-06-10	932.97	Auto-generated transaction entry #179	2025-06-15 08:47:38.007345
4180	5	52	Transaction #180	2025-06-12	276.12	Auto-generated transaction entry #180	2025-06-15 08:47:38.007345
4181	5	55	Transaction #181	2025-06-14	543.95	Auto-generated transaction entry #181	2025-06-15 08:47:38.007345
4182	5	55	Transaction #182	2025-05-17	235.10	Auto-generated transaction entry #182	2025-06-15 08:47:38.007345
4183	5	49	Transaction #183	2025-05-27	334.61	Auto-generated transaction entry #183	2025-06-15 08:47:38.007345
4184	5	52	Transaction #184	2025-06-03	870.64	Auto-generated transaction entry #184	2025-06-15 08:47:38.007345
4185	5	52	Transaction #185	2025-05-21	300.03	Auto-generated transaction entry #185	2025-06-15 08:47:38.007345
4186	5	50	Transaction #186	2025-06-09	597.39	Auto-generated transaction entry #186	2025-06-15 08:47:38.007345
4187	5	49	Transaction #187	2025-05-30	394.79	Auto-generated transaction entry #187	2025-06-15 08:47:38.007345
4188	5	52	Transaction #188	2025-06-08	355.12	Auto-generated transaction entry #188	2025-06-15 08:47:38.007345
4189	5	53	Transaction #189	2025-05-20	892.88	Auto-generated transaction entry #189	2025-06-15 08:47:38.007345
4190	5	51	Transaction #190	2025-06-12	812.64	Auto-generated transaction entry #190	2025-06-15 08:47:38.007345
4191	5	52	Transaction #191	2025-06-09	686.54	Auto-generated transaction entry #191	2025-06-15 08:47:38.007345
4192	5	55	Transaction #192	2025-05-16	695.76	Auto-generated transaction entry #192	2025-06-15 08:47:38.007345
4193	5	53	Transaction #193	2025-06-10	687.89	Auto-generated transaction entry #193	2025-06-15 08:47:38.007345
4194	5	51	Transaction #194	2025-06-13	959.94	Auto-generated transaction entry #194	2025-06-15 08:47:38.007345
4195	5	52	Transaction #195	2025-05-30	486.86	Auto-generated transaction entry #195	2025-06-15 08:47:38.007345
4196	5	50	Transaction #196	2025-06-04	332.60	Auto-generated transaction entry #196	2025-06-15 08:47:38.007345
4197	5	50	Transaction #197	2025-06-11	428.05	Auto-generated transaction entry #197	2025-06-15 08:47:38.007345
4198	5	54	Transaction #198	2025-05-21	671.26	Auto-generated transaction entry #198	2025-06-15 08:47:38.007345
4199	5	49	Transaction #199	2025-05-27	850.78	Auto-generated transaction entry #199	2025-06-15 08:47:38.007345
4200	5	54	Transaction #200	2025-05-31	971.73	Auto-generated transaction entry #200	2025-06-15 08:47:38.007345
4201	5	53	Transaction #201	2025-06-02	837.83	Auto-generated transaction entry #201	2025-06-15 08:47:38.007345
4202	5	50	Transaction #202	2025-06-05	325.03	Auto-generated transaction entry #202	2025-06-15 08:47:38.007345
4203	5	55	Transaction #203	2025-06-05	492.79	Auto-generated transaction entry #203	2025-06-15 08:47:38.007345
4204	5	51	Transaction #204	2025-05-30	349.84	Auto-generated transaction entry #204	2025-06-15 08:47:38.007345
4205	5	55	Transaction #205	2025-06-04	269.70	Auto-generated transaction entry #205	2025-06-15 08:47:38.007345
4206	5	52	Transaction #206	2025-06-11	885.21	Auto-generated transaction entry #206	2025-06-15 08:47:38.007345
4207	5	53	Transaction #207	2025-05-18	245.06	Auto-generated transaction entry #207	2025-06-15 08:47:38.007345
4208	5	51	Transaction #208	2025-05-22	863.67	Auto-generated transaction entry #208	2025-06-15 08:47:38.007345
4209	5	54	Transaction #209	2025-06-13	737.46	Auto-generated transaction entry #209	2025-06-15 08:47:38.007345
4210	5	51	Transaction #210	2025-06-06	577.94	Auto-generated transaction entry #210	2025-06-15 08:47:38.007345
4211	5	53	Transaction #211	2025-05-18	393.76	Auto-generated transaction entry #211	2025-06-15 08:47:38.007345
4212	5	51	Transaction #212	2025-05-18	912.02	Auto-generated transaction entry #212	2025-06-15 08:47:38.007345
4213	5	51	Transaction #213	2025-05-16	372.54	Auto-generated transaction entry #213	2025-06-15 08:47:38.007345
4214	5	52	Transaction #214	2025-05-21	818.24	Auto-generated transaction entry #214	2025-06-15 08:47:38.007345
4215	5	50	Transaction #215	2025-05-27	787.47	Auto-generated transaction entry #215	2025-06-15 08:47:38.007345
4216	5	54	Transaction #216	2025-05-24	52.77	Auto-generated transaction entry #216	2025-06-15 08:47:38.007345
4217	5	49	Transaction #217	2025-06-14	152.87	Auto-generated transaction entry #217	2025-06-15 08:47:38.007345
4218	5	53	Transaction #218	2025-06-07	706.05	Auto-generated transaction entry #218	2025-06-15 08:47:38.007345
4219	5	53	Transaction #219	2025-05-23	139.81	Auto-generated transaction entry #219	2025-06-15 08:47:38.007345
4220	5	50	Transaction #220	2025-06-06	738.92	Auto-generated transaction entry #220	2025-06-15 08:47:38.007345
4221	5	51	Transaction #221	2025-05-28	798.32	Auto-generated transaction entry #221	2025-06-15 08:47:38.007345
4222	5	55	Transaction #222	2025-05-18	164.30	Auto-generated transaction entry #222	2025-06-15 08:47:38.007345
4223	5	49	Transaction #223	2025-05-22	667.40	Auto-generated transaction entry #223	2025-06-15 08:47:38.007345
4224	5	49	Transaction #224	2025-06-04	437.07	Auto-generated transaction entry #224	2025-06-15 08:47:38.007345
4225	5	51	Transaction #225	2025-05-28	944.86	Auto-generated transaction entry #225	2025-06-15 08:47:38.007345
4226	5	52	Transaction #226	2025-06-11	977.12	Auto-generated transaction entry #226	2025-06-15 08:47:38.007345
4227	5	54	Transaction #227	2025-05-23	474.55	Auto-generated transaction entry #227	2025-06-15 08:47:38.007345
4228	5	52	Transaction #228	2025-06-07	380.59	Auto-generated transaction entry #228	2025-06-15 08:47:38.007345
4229	5	52	Transaction #229	2025-05-20	80.69	Auto-generated transaction entry #229	2025-06-15 08:47:38.007345
4230	5	49	Transaction #230	2025-05-16	568.79	Auto-generated transaction entry #230	2025-06-15 08:47:38.007345
4231	5	49	Transaction #231	2025-06-01	749.07	Auto-generated transaction entry #231	2025-06-15 08:47:38.007345
4232	5	54	Transaction #232	2025-05-20	583.14	Auto-generated transaction entry #232	2025-06-15 08:47:38.007345
4233	5	51	Transaction #233	2025-05-20	134.76	Auto-generated transaction entry #233	2025-06-15 08:47:38.007345
4234	5	54	Transaction #234	2025-06-04	351.09	Auto-generated transaction entry #234	2025-06-15 08:47:38.007345
4235	5	51	Transaction #235	2025-05-28	945.39	Auto-generated transaction entry #235	2025-06-15 08:47:38.007345
4236	5	53	Transaction #236	2025-05-23	949.79	Auto-generated transaction entry #236	2025-06-15 08:47:38.007345
4237	5	51	Transaction #237	2025-06-13	792.43	Auto-generated transaction entry #237	2025-06-15 08:47:38.007345
4238	5	49	Transaction #238	2025-05-23	314.06	Auto-generated transaction entry #238	2025-06-15 08:47:38.007345
4239	5	54	Transaction #239	2025-05-28	750.13	Auto-generated transaction entry #239	2025-06-15 08:47:38.007345
4240	5	49	Transaction #240	2025-06-06	875.32	Auto-generated transaction entry #240	2025-06-15 08:47:38.007345
4241	5	51	Transaction #241	2025-05-18	360.75	Auto-generated transaction entry #241	2025-06-15 08:47:38.007345
4242	5	53	Transaction #242	2025-06-12	950.02	Auto-generated transaction entry #242	2025-06-15 08:47:38.007345
4243	5	53	Transaction #243	2025-06-08	524.75	Auto-generated transaction entry #243	2025-06-15 08:47:38.007345
4244	5	51	Transaction #244	2025-06-10	997.97	Auto-generated transaction entry #244	2025-06-15 08:47:38.007345
4245	5	51	Transaction #245	2025-06-13	879.18	Auto-generated transaction entry #245	2025-06-15 08:47:38.007345
4246	5	50	Transaction #246	2025-05-24	260.01	Auto-generated transaction entry #246	2025-06-15 08:47:38.007345
4247	5	55	Transaction #247	2025-06-13	318.90	Auto-generated transaction entry #247	2025-06-15 08:47:38.007345
4248	5	53	Transaction #248	2025-06-04	350.80	Auto-generated transaction entry #248	2025-06-15 08:47:38.007345
4249	5	54	Transaction #249	2025-06-14	362.71	Auto-generated transaction entry #249	2025-06-15 08:47:38.007345
4250	5	49	Transaction #250	2025-06-11	701.58	Auto-generated transaction entry #250	2025-06-15 08:47:38.007345
4251	5	54	Transaction #251	2025-05-24	746.11	Auto-generated transaction entry #251	2025-06-15 08:47:38.007345
4252	5	51	Transaction #252	2025-05-23	556.15	Auto-generated transaction entry #252	2025-06-15 08:47:38.007345
4253	5	51	Transaction #253	2025-06-14	461.42	Auto-generated transaction entry #253	2025-06-15 08:47:38.007345
4254	5	52	Transaction #254	2025-06-09	432.52	Auto-generated transaction entry #254	2025-06-15 08:47:38.007345
4255	5	54	Transaction #255	2025-05-20	620.55	Auto-generated transaction entry #255	2025-06-15 08:47:38.007345
4256	5	54	Transaction #256	2025-05-21	320.70	Auto-generated transaction entry #256	2025-06-15 08:47:38.007345
4257	5	52	Transaction #257	2025-06-14	710.71	Auto-generated transaction entry #257	2025-06-15 08:47:38.007345
4258	5	54	Transaction #258	2025-05-16	507.18	Auto-generated transaction entry #258	2025-06-15 08:47:38.007345
4259	5	54	Transaction #259	2025-05-19	553.54	Auto-generated transaction entry #259	2025-06-15 08:47:38.007345
4260	5	50	Transaction #260	2025-05-18	629.44	Auto-generated transaction entry #260	2025-06-15 08:47:38.007345
4261	5	55	Transaction #261	2025-06-03	581.85	Auto-generated transaction entry #261	2025-06-15 08:47:38.007345
4262	5	55	Transaction #262	2025-05-20	109.33	Auto-generated transaction entry #262	2025-06-15 08:47:38.007345
4263	5	49	Transaction #263	2025-06-06	404.52	Auto-generated transaction entry #263	2025-06-15 08:47:38.007345
4264	5	53	Transaction #264	2025-05-19	472.65	Auto-generated transaction entry #264	2025-06-15 08:47:38.007345
4265	5	54	Transaction #265	2025-06-11	662.62	Auto-generated transaction entry #265	2025-06-15 08:47:38.007345
4266	5	52	Transaction #266	2025-06-11	365.43	Auto-generated transaction entry #266	2025-06-15 08:47:38.007345
4267	5	53	Transaction #267	2025-05-16	950.09	Auto-generated transaction entry #267	2025-06-15 08:47:38.007345
4268	5	55	Transaction #268	2025-05-30	811.25	Auto-generated transaction entry #268	2025-06-15 08:47:38.007345
4269	5	49	Transaction #269	2025-05-24	131.36	Auto-generated transaction entry #269	2025-06-15 08:47:38.007345
4270	5	51	Transaction #270	2025-06-07	348.87	Auto-generated transaction entry #270	2025-06-15 08:47:38.007345
4271	5	55	Transaction #271	2025-06-12	666.56	Auto-generated transaction entry #271	2025-06-15 08:47:38.007345
4272	5	51	Transaction #272	2025-05-26	888.20	Auto-generated transaction entry #272	2025-06-15 08:47:38.007345
4273	5	53	Transaction #273	2025-05-23	171.66	Auto-generated transaction entry #273	2025-06-15 08:47:38.007345
4274	5	49	Transaction #274	2025-05-22	983.03	Auto-generated transaction entry #274	2025-06-15 08:47:38.007345
4275	5	50	Transaction #275	2025-05-23	233.14	Auto-generated transaction entry #275	2025-06-15 08:47:38.007345
4276	5	49	Transaction #276	2025-06-06	560.65	Auto-generated transaction entry #276	2025-06-15 08:47:38.007345
4277	5	51	Transaction #277	2025-06-07	894.21	Auto-generated transaction entry #277	2025-06-15 08:47:38.007345
4278	5	51	Transaction #278	2025-06-06	214.81	Auto-generated transaction entry #278	2025-06-15 08:47:38.007345
4279	5	49	Transaction #279	2025-05-25	833.70	Auto-generated transaction entry #279	2025-06-15 08:47:38.007345
4280	5	55	Transaction #280	2025-05-29	384.65	Auto-generated transaction entry #280	2025-06-15 08:47:38.007345
4281	5	54	Transaction #281	2025-05-16	933.13	Auto-generated transaction entry #281	2025-06-15 08:47:38.007345
4282	5	52	Transaction #282	2025-06-13	680.04	Auto-generated transaction entry #282	2025-06-15 08:47:38.007345
4283	5	49	Transaction #283	2025-05-25	446.97	Auto-generated transaction entry #283	2025-06-15 08:47:38.007345
4284	5	51	Transaction #284	2025-05-19	718.64	Auto-generated transaction entry #284	2025-06-15 08:47:38.007345
4285	5	54	Transaction #285	2025-06-13	649.45	Auto-generated transaction entry #285	2025-06-15 08:47:38.007345
4286	5	53	Transaction #286	2025-05-30	859.03	Auto-generated transaction entry #286	2025-06-15 08:47:38.007345
4287	5	49	Transaction #287	2025-06-14	84.47	Auto-generated transaction entry #287	2025-06-15 08:47:38.007345
4288	5	55	Transaction #288	2025-05-28	510.93	Auto-generated transaction entry #288	2025-06-15 08:47:38.007345
4289	5	53	Transaction #289	2025-06-02	160.94	Auto-generated transaction entry #289	2025-06-15 08:47:38.007345
4290	5	49	Transaction #290	2025-05-20	109.13	Auto-generated transaction entry #290	2025-06-15 08:47:38.007345
4291	5	50	Transaction #291	2025-06-13	522.37	Auto-generated transaction entry #291	2025-06-15 08:47:38.007345
4292	5	52	Transaction #292	2025-05-19	174.26	Auto-generated transaction entry #292	2025-06-15 08:47:38.007345
4293	5	54	Transaction #293	2025-06-14	543.42	Auto-generated transaction entry #293	2025-06-15 08:47:38.007345
4294	5	49	Transaction #294	2025-05-28	809.76	Auto-generated transaction entry #294	2025-06-15 08:47:38.007345
4295	5	49	Transaction #295	2025-05-18	390.28	Auto-generated transaction entry #295	2025-06-15 08:47:38.007345
4296	5	55	Transaction #296	2025-06-03	440.13	Auto-generated transaction entry #296	2025-06-15 08:47:38.007345
4297	5	49	Transaction #297	2025-06-11	919.08	Auto-generated transaction entry #297	2025-06-15 08:47:38.007345
4298	5	51	Transaction #298	2025-05-28	737.49	Auto-generated transaction entry #298	2025-06-15 08:47:38.007345
4299	5	54	Transaction #299	2025-05-28	444.19	Auto-generated transaction entry #299	2025-06-15 08:47:38.007345
4300	5	50	Transaction #300	2025-05-27	959.28	Auto-generated transaction entry #300	2025-06-15 08:47:38.007345
4301	5	54	Transaction #301	2025-05-23	700.65	Auto-generated transaction entry #301	2025-06-15 08:47:38.007345
4302	5	50	Transaction #302	2025-06-10	938.09	Auto-generated transaction entry #302	2025-06-15 08:47:38.007345
4303	5	51	Transaction #303	2025-06-03	966.32	Auto-generated transaction entry #303	2025-06-15 08:47:38.007345
4304	5	49	Transaction #304	2025-06-02	268.73	Auto-generated transaction entry #304	2025-06-15 08:47:38.007345
4305	5	52	Transaction #305	2025-06-11	929.58	Auto-generated transaction entry #305	2025-06-15 08:47:38.007345
4306	5	50	Transaction #306	2025-05-21	883.35	Auto-generated transaction entry #306	2025-06-15 08:47:38.007345
4307	5	53	Transaction #307	2025-06-03	430.69	Auto-generated transaction entry #307	2025-06-15 08:47:38.007345
4308	5	50	Transaction #308	2025-05-16	482.08	Auto-generated transaction entry #308	2025-06-15 08:47:38.007345
4309	5	51	Transaction #309	2025-06-12	591.77	Auto-generated transaction entry #309	2025-06-15 08:47:38.007345
4310	5	50	Transaction #310	2025-05-16	683.75	Auto-generated transaction entry #310	2025-06-15 08:47:38.007345
4311	5	54	Transaction #311	2025-06-13	251.62	Auto-generated transaction entry #311	2025-06-15 08:47:38.007345
4312	5	52	Transaction #312	2025-05-23	812.14	Auto-generated transaction entry #312	2025-06-15 08:47:38.007345
4313	5	49	Transaction #313	2025-06-11	107.98	Auto-generated transaction entry #313	2025-06-15 08:47:38.007345
4314	5	50	Transaction #314	2025-05-22	689.19	Auto-generated transaction entry #314	2025-06-15 08:47:38.007345
4315	5	50	Transaction #315	2025-06-09	273.72	Auto-generated transaction entry #315	2025-06-15 08:47:38.007345
4316	5	50	Transaction #316	2025-06-04	317.61	Auto-generated transaction entry #316	2025-06-15 08:47:38.007345
4317	5	53	Transaction #317	2025-06-04	973.13	Auto-generated transaction entry #317	2025-06-15 08:47:38.007345
4318	5	50	Transaction #318	2025-06-01	404.38	Auto-generated transaction entry #318	2025-06-15 08:47:38.007345
4319	5	55	Transaction #319	2025-05-28	465.24	Auto-generated transaction entry #319	2025-06-15 08:47:38.007345
4320	5	53	Transaction #320	2025-05-19	550.87	Auto-generated transaction entry #320	2025-06-15 08:47:38.007345
4321	5	51	Transaction #321	2025-06-06	466.70	Auto-generated transaction entry #321	2025-06-15 08:47:38.007345
4322	5	51	Transaction #322	2025-05-28	857.82	Auto-generated transaction entry #322	2025-06-15 08:47:38.007345
4323	5	50	Transaction #323	2025-06-07	936.22	Auto-generated transaction entry #323	2025-06-15 08:47:38.007345
4324	5	55	Transaction #324	2025-05-23	214.91	Auto-generated transaction entry #324	2025-06-15 08:47:38.007345
4325	5	51	Transaction #325	2025-06-11	970.58	Auto-generated transaction entry #325	2025-06-15 08:47:38.007345
4326	5	49	Transaction #326	2025-06-10	296.93	Auto-generated transaction entry #326	2025-06-15 08:47:38.007345
4327	5	53	Transaction #327	2025-06-08	183.63	Auto-generated transaction entry #327	2025-06-15 08:47:38.007345
4328	5	52	Transaction #328	2025-06-11	301.86	Auto-generated transaction entry #328	2025-06-15 08:47:38.007345
4329	5	50	Transaction #329	2025-06-01	632.30	Auto-generated transaction entry #329	2025-06-15 08:47:38.007345
4330	5	55	Transaction #330	2025-05-25	571.12	Auto-generated transaction entry #330	2025-06-15 08:47:38.007345
4331	5	50	Transaction #331	2025-05-25	910.24	Auto-generated transaction entry #331	2025-06-15 08:47:38.007345
4332	5	55	Transaction #332	2025-05-21	280.01	Auto-generated transaction entry #332	2025-06-15 08:47:38.007345
4333	5	49	Transaction #333	2025-06-13	260.35	Auto-generated transaction entry #333	2025-06-15 08:47:38.007345
4334	5	50	Transaction #334	2025-06-07	512.94	Auto-generated transaction entry #334	2025-06-15 08:47:38.007345
4335	5	51	Transaction #335	2025-06-01	403.46	Auto-generated transaction entry #335	2025-06-15 08:47:38.007345
4336	5	55	Transaction #336	2025-06-05	580.26	Auto-generated transaction entry #336	2025-06-15 08:47:38.007345
4337	5	51	Transaction #337	2025-05-28	551.62	Auto-generated transaction entry #337	2025-06-15 08:47:38.007345
4338	5	53	Transaction #338	2025-06-13	400.35	Auto-generated transaction entry #338	2025-06-15 08:47:38.007345
4339	5	49	Transaction #339	2025-05-17	601.35	Auto-generated transaction entry #339	2025-06-15 08:47:38.007345
4340	5	54	Transaction #340	2025-05-27	751.58	Auto-generated transaction entry #340	2025-06-15 08:47:38.007345
4341	5	51	Transaction #341	2025-05-19	203.00	Auto-generated transaction entry #341	2025-06-15 08:47:38.007345
4342	5	50	Transaction #342	2025-05-23	240.10	Auto-generated transaction entry #342	2025-06-15 08:47:38.007345
4343	5	53	Transaction #343	2025-05-17	318.96	Auto-generated transaction entry #343	2025-06-15 08:47:38.007345
4344	5	51	Transaction #344	2025-06-12	580.56	Auto-generated transaction entry #344	2025-06-15 08:47:38.007345
4345	5	49	Transaction #345	2025-05-17	609.42	Auto-generated transaction entry #345	2025-06-15 08:47:38.007345
4346	5	53	Transaction #346	2025-05-24	626.62	Auto-generated transaction entry #346	2025-06-15 08:47:38.007345
4347	5	51	Transaction #347	2025-06-01	194.94	Auto-generated transaction entry #347	2025-06-15 08:47:38.007345
4348	5	54	Transaction #348	2025-06-02	783.82	Auto-generated transaction entry #348	2025-06-15 08:47:38.007345
4349	5	50	Transaction #349	2025-05-27	942.46	Auto-generated transaction entry #349	2025-06-15 08:47:38.007345
4350	5	50	Transaction #350	2025-05-29	124.88	Auto-generated transaction entry #350	2025-06-15 08:47:38.007345
4351	5	55	Transaction #351	2025-06-02	87.06	Auto-generated transaction entry #351	2025-06-15 08:47:38.007345
4352	5	52	Transaction #352	2025-06-05	748.03	Auto-generated transaction entry #352	2025-06-15 08:47:38.007345
4353	5	49	Transaction #353	2025-05-24	126.11	Auto-generated transaction entry #353	2025-06-15 08:47:38.007345
4354	5	55	Transaction #354	2025-06-09	848.92	Auto-generated transaction entry #354	2025-06-15 08:47:38.007345
4355	5	54	Transaction #355	2025-06-03	489.08	Auto-generated transaction entry #355	2025-06-15 08:47:38.007345
4356	5	51	Transaction #356	2025-06-06	428.05	Auto-generated transaction entry #356	2025-06-15 08:47:38.007345
4357	5	55	Transaction #357	2025-05-28	524.31	Auto-generated transaction entry #357	2025-06-15 08:47:38.007345
4358	5	50	Transaction #358	2025-06-14	964.67	Auto-generated transaction entry #358	2025-06-15 08:47:38.007345
4359	5	53	Transaction #359	2025-06-13	481.29	Auto-generated transaction entry #359	2025-06-15 08:47:38.007345
4360	5	49	Transaction #360	2025-06-05	962.04	Auto-generated transaction entry #360	2025-06-15 08:47:38.007345
4361	5	54	Transaction #361	2025-06-07	153.08	Auto-generated transaction entry #361	2025-06-15 08:47:38.007345
4362	5	55	Transaction #362	2025-06-09	519.93	Auto-generated transaction entry #362	2025-06-15 08:47:38.007345
4363	5	55	Transaction #363	2025-05-27	894.61	Auto-generated transaction entry #363	2025-06-15 08:47:38.007345
4364	5	50	Transaction #364	2025-05-17	938.90	Auto-generated transaction entry #364	2025-06-15 08:47:38.007345
4365	5	50	Transaction #365	2025-06-03	124.37	Auto-generated transaction entry #365	2025-06-15 08:47:38.007345
4366	5	54	Transaction #366	2025-06-04	529.03	Auto-generated transaction entry #366	2025-06-15 08:47:38.007345
4367	5	53	Transaction #367	2025-05-27	209.63	Auto-generated transaction entry #367	2025-06-15 08:47:38.007345
4368	5	54	Transaction #368	2025-05-17	787.90	Auto-generated transaction entry #368	2025-06-15 08:47:38.007345
4369	5	54	Transaction #369	2025-06-14	869.01	Auto-generated transaction entry #369	2025-06-15 08:47:38.007345
4370	5	55	Transaction #370	2025-05-23	113.53	Auto-generated transaction entry #370	2025-06-15 08:47:38.007345
4371	5	52	Transaction #371	2025-05-28	620.93	Auto-generated transaction entry #371	2025-06-15 08:47:38.007345
4372	5	53	Transaction #372	2025-06-14	678.90	Auto-generated transaction entry #372	2025-06-15 08:47:38.007345
4373	5	53	Transaction #373	2025-05-30	622.02	Auto-generated transaction entry #373	2025-06-15 08:47:38.007345
4374	5	53	Transaction #374	2025-05-17	888.12	Auto-generated transaction entry #374	2025-06-15 08:47:38.007345
4375	5	49	Transaction #375	2025-06-12	710.26	Auto-generated transaction entry #375	2025-06-15 08:47:38.007345
4376	5	50	Transaction #376	2025-06-14	662.34	Auto-generated transaction entry #376	2025-06-15 08:47:38.007345
4377	5	49	Transaction #377	2025-06-03	330.89	Auto-generated transaction entry #377	2025-06-15 08:47:38.007345
4378	5	50	Transaction #378	2025-06-06	776.04	Auto-generated transaction entry #378	2025-06-15 08:47:38.007345
4379	5	54	Transaction #379	2025-05-25	708.01	Auto-generated transaction entry #379	2025-06-15 08:47:38.007345
4380	5	54	Transaction #380	2025-05-29	291.05	Auto-generated transaction entry #380	2025-06-15 08:47:38.007345
4381	5	52	Transaction #381	2025-05-17	389.81	Auto-generated transaction entry #381	2025-06-15 08:47:38.007345
4382	5	52	Transaction #382	2025-06-12	545.44	Auto-generated transaction entry #382	2025-06-15 08:47:38.007345
4383	5	53	Transaction #383	2025-05-18	224.06	Auto-generated transaction entry #383	2025-06-15 08:47:38.007345
4384	5	54	Transaction #384	2025-06-07	276.47	Auto-generated transaction entry #384	2025-06-15 08:47:38.007345
4385	5	50	Transaction #385	2025-05-17	328.33	Auto-generated transaction entry #385	2025-06-15 08:47:38.007345
4386	5	55	Transaction #386	2025-05-27	194.34	Auto-generated transaction entry #386	2025-06-15 08:47:38.007345
4387	5	55	Transaction #387	2025-06-13	138.28	Auto-generated transaction entry #387	2025-06-15 08:47:38.007345
4388	5	50	Transaction #388	2025-06-05	917.15	Auto-generated transaction entry #388	2025-06-15 08:47:38.007345
4389	5	53	Transaction #389	2025-05-16	140.99	Auto-generated transaction entry #389	2025-06-15 08:47:38.007345
4390	5	55	Transaction #390	2025-06-03	907.22	Auto-generated transaction entry #390	2025-06-15 08:47:38.007345
4391	5	51	Transaction #391	2025-05-23	942.98	Auto-generated transaction entry #391	2025-06-15 08:47:38.007345
4392	5	53	Transaction #392	2025-05-26	442.92	Auto-generated transaction entry #392	2025-06-15 08:47:38.007345
4393	5	51	Transaction #393	2025-06-01	395.58	Auto-generated transaction entry #393	2025-06-15 08:47:38.007345
4394	5	55	Transaction #394	2025-06-13	104.95	Auto-generated transaction entry #394	2025-06-15 08:47:38.007345
4395	5	53	Transaction #395	2025-05-16	162.68	Auto-generated transaction entry #395	2025-06-15 08:47:38.007345
4396	5	53	Transaction #396	2025-06-05	554.17	Auto-generated transaction entry #396	2025-06-15 08:47:38.007345
4397	5	54	Transaction #397	2025-05-23	363.66	Auto-generated transaction entry #397	2025-06-15 08:47:38.007345
4398	5	51	Transaction #398	2025-05-27	370.71	Auto-generated transaction entry #398	2025-06-15 08:47:38.007345
4399	5	55	Transaction #399	2025-05-26	116.00	Auto-generated transaction entry #399	2025-06-15 08:47:38.007345
4400	5	53	Transaction #400	2025-05-26	70.58	Auto-generated transaction entry #400	2025-06-15 08:47:38.007345
4401	5	52	Transaction #401	2025-06-04	976.33	Auto-generated transaction entry #401	2025-06-15 08:47:38.007345
4402	5	51	Transaction #402	2025-05-29	438.29	Auto-generated transaction entry #402	2025-06-15 08:47:38.007345
4403	5	49	Transaction #403	2025-06-02	776.45	Auto-generated transaction entry #403	2025-06-15 08:47:38.007345
4404	5	54	Transaction #404	2025-05-31	844.04	Auto-generated transaction entry #404	2025-06-15 08:47:38.007345
4405	5	55	Transaction #405	2025-06-13	880.19	Auto-generated transaction entry #405	2025-06-15 08:47:38.007345
4406	5	49	Transaction #406	2025-05-24	548.08	Auto-generated transaction entry #406	2025-06-15 08:47:38.007345
4407	5	49	Transaction #407	2025-06-09	862.39	Auto-generated transaction entry #407	2025-06-15 08:47:38.007345
4408	5	49	Transaction #408	2025-05-17	103.41	Auto-generated transaction entry #408	2025-06-15 08:47:38.007345
4409	5	55	Transaction #409	2025-05-28	519.03	Auto-generated transaction entry #409	2025-06-15 08:47:38.007345
4410	5	49	Transaction #410	2025-05-31	132.38	Auto-generated transaction entry #410	2025-06-15 08:47:38.007345
4411	5	50	Transaction #411	2025-06-14	165.71	Auto-generated transaction entry #411	2025-06-15 08:47:38.007345
4412	5	50	Transaction #412	2025-06-02	334.24	Auto-generated transaction entry #412	2025-06-15 08:47:38.007345
4413	5	50	Transaction #413	2025-05-24	962.02	Auto-generated transaction entry #413	2025-06-15 08:47:38.007345
4414	5	50	Transaction #414	2025-06-05	429.86	Auto-generated transaction entry #414	2025-06-15 08:47:38.007345
4415	5	52	Transaction #415	2025-06-05	170.35	Auto-generated transaction entry #415	2025-06-15 08:47:38.007345
4416	5	50	Transaction #416	2025-06-03	634.02	Auto-generated transaction entry #416	2025-06-15 08:47:38.007345
4417	5	50	Transaction #417	2025-06-02	836.89	Auto-generated transaction entry #417	2025-06-15 08:47:38.007345
4418	5	50	Transaction #418	2025-06-14	698.73	Auto-generated transaction entry #418	2025-06-15 08:47:38.007345
4419	5	54	Transaction #419	2025-05-18	879.53	Auto-generated transaction entry #419	2025-06-15 08:47:38.007345
4420	5	55	Transaction #420	2025-06-06	366.83	Auto-generated transaction entry #420	2025-06-15 08:47:38.007345
4421	5	50	Transaction #421	2025-05-26	695.96	Auto-generated transaction entry #421	2025-06-15 08:47:38.007345
4422	5	54	Transaction #422	2025-05-19	601.77	Auto-generated transaction entry #422	2025-06-15 08:47:38.007345
4423	5	53	Transaction #423	2025-06-11	654.13	Auto-generated transaction entry #423	2025-06-15 08:47:38.007345
4424	5	53	Transaction #424	2025-06-11	536.19	Auto-generated transaction entry #424	2025-06-15 08:47:38.007345
4425	5	52	Transaction #425	2025-05-30	810.45	Auto-generated transaction entry #425	2025-06-15 08:47:38.007345
4426	5	52	Transaction #426	2025-06-03	409.47	Auto-generated transaction entry #426	2025-06-15 08:47:38.007345
4427	5	49	Transaction #427	2025-05-19	396.86	Auto-generated transaction entry #427	2025-06-15 08:47:38.007345
4428	5	53	Transaction #428	2025-06-10	954.67	Auto-generated transaction entry #428	2025-06-15 08:47:38.007345
4429	5	51	Transaction #429	2025-06-04	211.77	Auto-generated transaction entry #429	2025-06-15 08:47:38.007345
4430	5	50	Transaction #430	2025-05-19	147.20	Auto-generated transaction entry #430	2025-06-15 08:47:38.007345
4431	5	50	Transaction #431	2025-06-12	415.98	Auto-generated transaction entry #431	2025-06-15 08:47:38.007345
4432	5	52	Transaction #432	2025-05-25	153.74	Auto-generated transaction entry #432	2025-06-15 08:47:38.007345
4433	5	49	Transaction #433	2025-05-25	289.28	Auto-generated transaction entry #433	2025-06-15 08:47:38.007345
4434	5	50	Transaction #434	2025-05-23	763.08	Auto-generated transaction entry #434	2025-06-15 08:47:38.007345
4435	5	51	Transaction #435	2025-05-17	52.22	Auto-generated transaction entry #435	2025-06-15 08:47:38.007345
4436	5	50	Transaction #436	2025-05-21	496.21	Auto-generated transaction entry #436	2025-06-15 08:47:38.007345
4437	5	50	Transaction #437	2025-05-31	656.76	Auto-generated transaction entry #437	2025-06-15 08:47:38.007345
4438	5	53	Transaction #438	2025-06-10	128.85	Auto-generated transaction entry #438	2025-06-15 08:47:38.007345
4439	5	52	Transaction #439	2025-06-09	676.71	Auto-generated transaction entry #439	2025-06-15 08:47:38.007345
4440	5	49	Transaction #440	2025-06-01	110.35	Auto-generated transaction entry #440	2025-06-15 08:47:38.007345
4441	5	52	Transaction #441	2025-05-23	222.25	Auto-generated transaction entry #441	2025-06-15 08:47:38.007345
4442	5	51	Transaction #442	2025-05-25	809.15	Auto-generated transaction entry #442	2025-06-15 08:47:38.007345
4443	5	55	Transaction #443	2025-05-29	301.02	Auto-generated transaction entry #443	2025-06-15 08:47:38.007345
4444	5	55	Transaction #444	2025-05-18	492.65	Auto-generated transaction entry #444	2025-06-15 08:47:38.007345
4445	5	55	Transaction #445	2025-05-24	269.73	Auto-generated transaction entry #445	2025-06-15 08:47:38.007345
4446	5	53	Transaction #446	2025-05-30	856.11	Auto-generated transaction entry #446	2025-06-15 08:47:38.007345
4447	5	53	Transaction #447	2025-06-13	371.32	Auto-generated transaction entry #447	2025-06-15 08:47:38.007345
4448	5	49	Transaction #448	2025-05-19	188.60	Auto-generated transaction entry #448	2025-06-15 08:47:38.007345
4449	5	52	Transaction #449	2025-06-13	525.24	Auto-generated transaction entry #449	2025-06-15 08:47:38.007345
4450	5	55	Transaction #450	2025-05-30	869.24	Auto-generated transaction entry #450	2025-06-15 08:47:38.007345
4451	5	55	Transaction #451	2025-06-03	430.06	Auto-generated transaction entry #451	2025-06-15 08:47:38.007345
4452	5	51	Transaction #452	2025-06-01	358.46	Auto-generated transaction entry #452	2025-06-15 08:47:38.007345
4453	5	52	Transaction #453	2025-06-13	58.42	Auto-generated transaction entry #453	2025-06-15 08:47:38.007345
4454	5	54	Transaction #454	2025-05-17	711.53	Auto-generated transaction entry #454	2025-06-15 08:47:38.007345
4455	5	54	Transaction #455	2025-05-17	452.52	Auto-generated transaction entry #455	2025-06-15 08:47:38.007345
4456	5	55	Transaction #456	2025-05-22	66.89	Auto-generated transaction entry #456	2025-06-15 08:47:38.007345
4457	5	50	Transaction #457	2025-05-27	725.99	Auto-generated transaction entry #457	2025-06-15 08:47:38.007345
4458	5	52	Transaction #458	2025-05-29	249.09	Auto-generated transaction entry #458	2025-06-15 08:47:38.007345
4459	5	54	Transaction #459	2025-05-29	502.42	Auto-generated transaction entry #459	2025-06-15 08:47:38.007345
4460	5	52	Transaction #460	2025-05-17	251.54	Auto-generated transaction entry #460	2025-06-15 08:47:38.007345
4461	5	55	Transaction #461	2025-06-07	346.80	Auto-generated transaction entry #461	2025-06-15 08:47:38.007345
4462	5	55	Transaction #462	2025-05-23	474.82	Auto-generated transaction entry #462	2025-06-15 08:47:38.007345
4463	5	49	Transaction #463	2025-06-14	435.58	Auto-generated transaction entry #463	2025-06-15 08:47:38.007345
4464	5	52	Transaction #464	2025-06-03	326.10	Auto-generated transaction entry #464	2025-06-15 08:47:38.007345
4465	5	55	Transaction #465	2025-06-06	825.80	Auto-generated transaction entry #465	2025-06-15 08:47:38.007345
4466	5	53	Transaction #466	2025-05-23	484.13	Auto-generated transaction entry #466	2025-06-15 08:47:38.007345
4467	5	54	Transaction #467	2025-06-01	743.07	Auto-generated transaction entry #467	2025-06-15 08:47:38.007345
4468	5	52	Transaction #468	2025-05-22	284.22	Auto-generated transaction entry #468	2025-06-15 08:47:38.007345
4469	5	51	Transaction #469	2025-06-07	165.98	Auto-generated transaction entry #469	2025-06-15 08:47:38.007345
4470	5	50	Transaction #470	2025-05-30	400.64	Auto-generated transaction entry #470	2025-06-15 08:47:38.007345
4471	5	50	Transaction #471	2025-06-06	748.18	Auto-generated transaction entry #471	2025-06-15 08:47:38.007345
4472	5	50	Transaction #472	2025-05-26	803.41	Auto-generated transaction entry #472	2025-06-15 08:47:38.007345
4473	5	54	Transaction #473	2025-05-27	603.59	Auto-generated transaction entry #473	2025-06-15 08:47:38.007345
4474	5	50	Transaction #474	2025-05-29	555.67	Auto-generated transaction entry #474	2025-06-15 08:47:38.007345
4475	5	49	Transaction #475	2025-06-04	976.24	Auto-generated transaction entry #475	2025-06-15 08:47:38.007345
4476	5	49	Transaction #476	2025-06-13	675.45	Auto-generated transaction entry #476	2025-06-15 08:47:38.007345
4477	5	55	Transaction #477	2025-05-17	258.00	Auto-generated transaction entry #477	2025-06-15 08:47:38.007345
4478	5	51	Transaction #478	2025-06-03	131.12	Auto-generated transaction entry #478	2025-06-15 08:47:38.007345
4479	5	49	Transaction #479	2025-05-24	132.40	Auto-generated transaction entry #479	2025-06-15 08:47:38.007345
4480	5	53	Transaction #480	2025-06-04	297.68	Auto-generated transaction entry #480	2025-06-15 08:47:38.007345
4481	5	52	Transaction #481	2025-05-22	679.92	Auto-generated transaction entry #481	2025-06-15 08:47:38.007345
4482	5	53	Transaction #482	2025-06-07	921.74	Auto-generated transaction entry #482	2025-06-15 08:47:38.007345
4483	5	53	Transaction #483	2025-06-05	88.33	Auto-generated transaction entry #483	2025-06-15 08:47:38.007345
4484	5	54	Transaction #484	2025-06-08	476.49	Auto-generated transaction entry #484	2025-06-15 08:47:38.007345
4485	5	51	Transaction #485	2025-05-31	92.72	Auto-generated transaction entry #485	2025-06-15 08:47:38.007345
4486	5	52	Transaction #486	2025-06-03	516.03	Auto-generated transaction entry #486	2025-06-15 08:47:38.007345
4487	5	51	Transaction #487	2025-06-12	643.45	Auto-generated transaction entry #487	2025-06-15 08:47:38.007345
4488	5	52	Transaction #488	2025-06-01	575.76	Auto-generated transaction entry #488	2025-06-15 08:47:38.007345
4489	5	54	Transaction #489	2025-05-18	264.34	Auto-generated transaction entry #489	2025-06-15 08:47:38.007345
4490	5	54	Transaction #490	2025-06-08	406.93	Auto-generated transaction entry #490	2025-06-15 08:47:38.007345
4491	5	49	Transaction #491	2025-05-19	648.75	Auto-generated transaction entry #491	2025-06-15 08:47:38.007345
4492	5	50	Transaction #492	2025-06-07	180.20	Auto-generated transaction entry #492	2025-06-15 08:47:38.007345
4493	5	51	Transaction #493	2025-06-13	373.71	Auto-generated transaction entry #493	2025-06-15 08:47:38.007345
4494	5	55	Transaction #494	2025-05-24	169.57	Auto-generated transaction entry #494	2025-06-15 08:47:38.007345
4495	5	53	Transaction #495	2025-05-19	269.42	Auto-generated transaction entry #495	2025-06-15 08:47:38.007345
4496	5	50	Transaction #496	2025-06-15	601.10	Auto-generated transaction entry #496	2025-06-15 08:47:38.007345
4497	5	52	Transaction #497	2025-05-16	578.18	Auto-generated transaction entry #497	2025-06-15 08:47:38.007345
4498	5	50	Transaction #498	2025-05-21	760.68	Auto-generated transaction entry #498	2025-06-15 08:47:38.007345
4499	5	53	Transaction #499	2025-06-06	361.01	Auto-generated transaction entry #499	2025-06-15 08:47:38.007345
4500	5	49	Transaction #500	2025-05-28	861.02	Auto-generated transaction entry #500	2025-06-15 08:47:38.007345
4501	5	45	Transaction #1	2025-05-22	237.94	Auto-generated transaction entry #1	2025-06-15 08:47:46.054219
4502	5	46	Transaction #2	2025-06-10	952.13	Auto-generated transaction entry #2	2025-06-15 08:47:46.054219
4503	5	48	Transaction #3	2025-06-12	969.01	Auto-generated transaction entry #3	2025-06-15 08:47:46.054219
4504	5	46	Transaction #4	2025-06-09	150.56	Auto-generated transaction entry #4	2025-06-15 08:47:46.054219
4505	5	44	Transaction #5	2025-05-24	875.51	Auto-generated transaction entry #5	2025-06-15 08:47:46.054219
4506	5	46	Transaction #6	2025-06-05	594.09	Auto-generated transaction entry #6	2025-06-15 08:47:46.054219
4507	5	45	Transaction #7	2025-06-01	970.90	Auto-generated transaction entry #7	2025-06-15 08:47:46.054219
4508	5	47	Transaction #8	2025-05-30	671.68	Auto-generated transaction entry #8	2025-06-15 08:47:46.054219
4509	5	46	Transaction #9	2025-06-12	745.29	Auto-generated transaction entry #9	2025-06-15 08:47:46.054219
4510	5	47	Transaction #10	2025-05-30	798.23	Auto-generated transaction entry #10	2025-06-15 08:47:46.054219
4511	5	47	Transaction #11	2025-06-08	440.58	Auto-generated transaction entry #11	2025-06-15 08:47:46.054219
4512	5	47	Transaction #12	2025-05-21	940.71	Auto-generated transaction entry #12	2025-06-15 08:47:46.054219
4513	5	47	Transaction #13	2025-05-26	420.36	Auto-generated transaction entry #13	2025-06-15 08:47:46.054219
4514	5	45	Transaction #14	2025-06-02	914.96	Auto-generated transaction entry #14	2025-06-15 08:47:46.054219
4515	5	48	Transaction #15	2025-06-15	788.28	Auto-generated transaction entry #15	2025-06-15 08:47:46.054219
4516	5	48	Transaction #16	2025-05-17	63.91	Auto-generated transaction entry #16	2025-06-15 08:47:46.054219
4517	5	47	Transaction #17	2025-05-28	155.80	Auto-generated transaction entry #17	2025-06-15 08:47:46.054219
4518	5	48	Transaction #18	2025-06-07	311.90	Auto-generated transaction entry #18	2025-06-15 08:47:46.054219
4519	5	47	Transaction #19	2025-05-28	726.70	Auto-generated transaction entry #19	2025-06-15 08:47:46.054219
4520	5	46	Transaction #20	2025-05-24	189.05	Auto-generated transaction entry #20	2025-06-15 08:47:46.054219
4521	5	47	Transaction #21	2025-06-14	724.57	Auto-generated transaction entry #21	2025-06-15 08:47:46.054219
4522	5	47	Transaction #22	2025-06-13	583.39	Auto-generated transaction entry #22	2025-06-15 08:47:46.054219
4523	5	44	Transaction #23	2025-05-23	687.80	Auto-generated transaction entry #23	2025-06-15 08:47:46.054219
4524	5	48	Transaction #24	2025-06-04	994.37	Auto-generated transaction entry #24	2025-06-15 08:47:46.054219
4525	5	47	Transaction #25	2025-06-09	295.19	Auto-generated transaction entry #25	2025-06-15 08:47:46.054219
4526	5	47	Transaction #26	2025-06-10	894.73	Auto-generated transaction entry #26	2025-06-15 08:47:46.054219
4527	5	44	Transaction #27	2025-06-08	172.54	Auto-generated transaction entry #27	2025-06-15 08:47:46.054219
4528	5	47	Transaction #28	2025-05-30	435.18	Auto-generated transaction entry #28	2025-06-15 08:47:46.054219
4529	5	46	Transaction #29	2025-05-16	699.53	Auto-generated transaction entry #29	2025-06-15 08:47:46.054219
4530	5	47	Transaction #30	2025-06-11	763.46	Auto-generated transaction entry #30	2025-06-15 08:47:46.054219
4531	5	47	Transaction #31	2025-05-29	844.74	Auto-generated transaction entry #31	2025-06-15 08:47:46.054219
4532	5	47	Transaction #32	2025-05-31	741.52	Auto-generated transaction entry #32	2025-06-15 08:47:46.054219
4533	5	48	Transaction #33	2025-06-14	120.51	Auto-generated transaction entry #33	2025-06-15 08:47:46.054219
4534	5	44	Transaction #34	2025-06-12	655.10	Auto-generated transaction entry #34	2025-06-15 08:47:46.054219
4535	5	44	Transaction #35	2025-06-12	315.13	Auto-generated transaction entry #35	2025-06-15 08:47:46.054219
4536	5	47	Transaction #36	2025-06-08	394.75	Auto-generated transaction entry #36	2025-06-15 08:47:46.054219
4537	5	46	Transaction #37	2025-05-27	502.54	Auto-generated transaction entry #37	2025-06-15 08:47:46.054219
4538	5	45	Transaction #38	2025-06-04	308.74	Auto-generated transaction entry #38	2025-06-15 08:47:46.054219
4539	5	45	Transaction #39	2025-05-22	896.77	Auto-generated transaction entry #39	2025-06-15 08:47:46.054219
4540	5	48	Transaction #40	2025-06-03	215.46	Auto-generated transaction entry #40	2025-06-15 08:47:46.054219
4541	5	48	Transaction #41	2025-06-11	812.15	Auto-generated transaction entry #41	2025-06-15 08:47:46.054219
4542	5	47	Transaction #42	2025-05-25	267.36	Auto-generated transaction entry #42	2025-06-15 08:47:46.054219
4543	5	48	Transaction #43	2025-06-03	380.93	Auto-generated transaction entry #43	2025-06-15 08:47:46.054219
4544	5	47	Transaction #44	2025-05-24	499.41	Auto-generated transaction entry #44	2025-06-15 08:47:46.054219
4545	5	47	Transaction #45	2025-06-06	145.66	Auto-generated transaction entry #45	2025-06-15 08:47:46.054219
4546	5	47	Transaction #46	2025-05-28	599.16	Auto-generated transaction entry #46	2025-06-15 08:47:46.054219
4547	5	48	Transaction #47	2025-05-31	369.56	Auto-generated transaction entry #47	2025-06-15 08:47:46.054219
4548	5	44	Transaction #48	2025-05-21	56.69	Auto-generated transaction entry #48	2025-06-15 08:47:46.054219
4549	5	46	Transaction #49	2025-05-24	563.49	Auto-generated transaction entry #49	2025-06-15 08:47:46.054219
4550	5	47	Transaction #50	2025-06-01	941.74	Auto-generated transaction entry #50	2025-06-15 08:47:46.054219
4551	5	45	Transaction #51	2025-05-16	167.53	Auto-generated transaction entry #51	2025-06-15 08:47:46.054219
4552	5	45	Transaction #52	2025-06-12	923.77	Auto-generated transaction entry #52	2025-06-15 08:47:46.054219
4553	5	45	Transaction #53	2025-05-22	321.66	Auto-generated transaction entry #53	2025-06-15 08:47:46.054219
4554	5	48	Transaction #54	2025-06-03	159.12	Auto-generated transaction entry #54	2025-06-15 08:47:46.054219
4555	5	47	Transaction #55	2025-05-27	355.71	Auto-generated transaction entry #55	2025-06-15 08:47:46.054219
4556	5	45	Transaction #56	2025-05-25	475.54	Auto-generated transaction entry #56	2025-06-15 08:47:46.054219
4557	5	44	Transaction #57	2025-06-09	588.10	Auto-generated transaction entry #57	2025-06-15 08:47:46.054219
4558	5	45	Transaction #58	2025-06-04	636.69	Auto-generated transaction entry #58	2025-06-15 08:47:46.054219
4559	5	47	Transaction #59	2025-06-15	314.04	Auto-generated transaction entry #59	2025-06-15 08:47:46.054219
4560	5	44	Transaction #60	2025-05-19	755.16	Auto-generated transaction entry #60	2025-06-15 08:47:46.054219
4561	5	47	Transaction #61	2025-05-30	883.78	Auto-generated transaction entry #61	2025-06-15 08:47:46.054219
4562	5	44	Transaction #62	2025-06-02	785.62	Auto-generated transaction entry #62	2025-06-15 08:47:46.054219
4563	5	47	Transaction #63	2025-06-10	953.50	Auto-generated transaction entry #63	2025-06-15 08:47:46.054219
4564	5	44	Transaction #64	2025-05-18	70.64	Auto-generated transaction entry #64	2025-06-15 08:47:46.054219
4565	5	44	Transaction #65	2025-06-12	206.25	Auto-generated transaction entry #65	2025-06-15 08:47:46.054219
4566	5	48	Transaction #66	2025-05-18	508.44	Auto-generated transaction entry #66	2025-06-15 08:47:46.054219
4567	5	44	Transaction #67	2025-05-29	387.47	Auto-generated transaction entry #67	2025-06-15 08:47:46.054219
4568	5	45	Transaction #68	2025-05-31	294.02	Auto-generated transaction entry #68	2025-06-15 08:47:46.054219
4569	5	48	Transaction #69	2025-05-20	964.92	Auto-generated transaction entry #69	2025-06-15 08:47:46.054219
4570	5	46	Transaction #70	2025-06-09	105.95	Auto-generated transaction entry #70	2025-06-15 08:47:46.054219
4571	5	46	Transaction #71	2025-05-31	755.50	Auto-generated transaction entry #71	2025-06-15 08:47:46.054219
4572	5	46	Transaction #72	2025-05-19	234.07	Auto-generated transaction entry #72	2025-06-15 08:47:46.054219
4573	5	46	Transaction #73	2025-05-28	738.10	Auto-generated transaction entry #73	2025-06-15 08:47:46.054219
4574	5	47	Transaction #74	2025-05-20	770.03	Auto-generated transaction entry #74	2025-06-15 08:47:46.054219
4575	5	44	Transaction #75	2025-05-28	653.88	Auto-generated transaction entry #75	2025-06-15 08:47:46.054219
4576	5	48	Transaction #76	2025-05-23	855.54	Auto-generated transaction entry #76	2025-06-15 08:47:46.054219
4577	5	46	Transaction #77	2025-05-30	838.76	Auto-generated transaction entry #77	2025-06-15 08:47:46.054219
4578	5	45	Transaction #78	2025-06-10	435.22	Auto-generated transaction entry #78	2025-06-15 08:47:46.054219
4579	5	48	Transaction #79	2025-06-06	931.28	Auto-generated transaction entry #79	2025-06-15 08:47:46.054219
4580	5	47	Transaction #80	2025-05-30	983.79	Auto-generated transaction entry #80	2025-06-15 08:47:46.054219
4581	5	48	Transaction #81	2025-06-12	100.94	Auto-generated transaction entry #81	2025-06-15 08:47:46.054219
4582	5	48	Transaction #82	2025-06-02	647.65	Auto-generated transaction entry #82	2025-06-15 08:47:46.054219
4583	5	44	Transaction #83	2025-06-11	671.42	Auto-generated transaction entry #83	2025-06-15 08:47:46.054219
4584	5	47	Transaction #84	2025-06-04	856.38	Auto-generated transaction entry #84	2025-06-15 08:47:46.054219
4585	5	46	Transaction #85	2025-05-19	264.10	Auto-generated transaction entry #85	2025-06-15 08:47:46.054219
4586	5	46	Transaction #86	2025-06-09	315.47	Auto-generated transaction entry #86	2025-06-15 08:47:46.054219
4587	5	48	Transaction #87	2025-06-13	854.99	Auto-generated transaction entry #87	2025-06-15 08:47:46.054219
4588	5	46	Transaction #88	2025-06-12	979.00	Auto-generated transaction entry #88	2025-06-15 08:47:46.054219
4589	5	44	Transaction #89	2025-05-25	211.56	Auto-generated transaction entry #89	2025-06-15 08:47:46.054219
4590	5	46	Transaction #90	2025-06-05	664.04	Auto-generated transaction entry #90	2025-06-15 08:47:46.054219
4591	5	48	Transaction #91	2025-05-30	456.94	Auto-generated transaction entry #91	2025-06-15 08:47:46.054219
4592	5	48	Transaction #92	2025-05-21	942.87	Auto-generated transaction entry #92	2025-06-15 08:47:46.054219
4593	5	46	Transaction #93	2025-05-22	709.99	Auto-generated transaction entry #93	2025-06-15 08:47:46.054219
4594	5	45	Transaction #94	2025-05-22	864.37	Auto-generated transaction entry #94	2025-06-15 08:47:46.054219
4595	5	47	Transaction #95	2025-06-10	79.21	Auto-generated transaction entry #95	2025-06-15 08:47:46.054219
4596	5	45	Transaction #96	2025-06-11	99.04	Auto-generated transaction entry #96	2025-06-15 08:47:46.054219
4597	5	45	Transaction #97	2025-05-20	987.33	Auto-generated transaction entry #97	2025-06-15 08:47:46.054219
4598	5	48	Transaction #98	2025-05-29	126.25	Auto-generated transaction entry #98	2025-06-15 08:47:46.054219
4599	5	45	Transaction #99	2025-06-05	760.58	Auto-generated transaction entry #99	2025-06-15 08:47:46.054219
4600	5	48	Transaction #100	2025-06-14	457.25	Auto-generated transaction entry #100	2025-06-15 08:47:46.054219
4601	5	44	Transaction #101	2025-06-08	634.60	Auto-generated transaction entry #101	2025-06-15 08:47:46.054219
4602	5	44	Transaction #102	2025-06-11	51.72	Auto-generated transaction entry #102	2025-06-15 08:47:46.054219
4603	5	48	Transaction #103	2025-05-20	281.38	Auto-generated transaction entry #103	2025-06-15 08:47:46.054219
4604	5	44	Transaction #104	2025-06-02	120.57	Auto-generated transaction entry #104	2025-06-15 08:47:46.054219
4605	5	46	Transaction #105	2025-05-28	559.40	Auto-generated transaction entry #105	2025-06-15 08:47:46.054219
4606	5	47	Transaction #106	2025-05-28	496.58	Auto-generated transaction entry #106	2025-06-15 08:47:46.054219
4607	5	47	Transaction #107	2025-05-21	169.11	Auto-generated transaction entry #107	2025-06-15 08:47:46.054219
4608	5	44	Transaction #108	2025-05-23	960.80	Auto-generated transaction entry #108	2025-06-15 08:47:46.054219
4609	5	46	Transaction #109	2025-05-20	387.25	Auto-generated transaction entry #109	2025-06-15 08:47:46.054219
4610	5	45	Transaction #110	2025-06-01	409.98	Auto-generated transaction entry #110	2025-06-15 08:47:46.054219
4611	5	46	Transaction #111	2025-06-14	834.94	Auto-generated transaction entry #111	2025-06-15 08:47:46.054219
4612	5	48	Transaction #112	2025-06-12	642.08	Auto-generated transaction entry #112	2025-06-15 08:47:46.054219
4613	5	47	Transaction #113	2025-06-05	428.29	Auto-generated transaction entry #113	2025-06-15 08:47:46.054219
4614	5	48	Transaction #114	2025-06-06	188.56	Auto-generated transaction entry #114	2025-06-15 08:47:46.054219
4615	5	46	Transaction #115	2025-06-02	473.07	Auto-generated transaction entry #115	2025-06-15 08:47:46.054219
4616	5	44	Transaction #116	2025-06-08	410.21	Auto-generated transaction entry #116	2025-06-15 08:47:46.054219
4617	5	46	Transaction #117	2025-06-04	717.14	Auto-generated transaction entry #117	2025-06-15 08:47:46.054219
4618	5	46	Transaction #118	2025-06-11	895.84	Auto-generated transaction entry #118	2025-06-15 08:47:46.054219
4619	5	44	Transaction #119	2025-06-08	157.77	Auto-generated transaction entry #119	2025-06-15 08:47:46.054219
4620	5	45	Transaction #120	2025-06-13	325.86	Auto-generated transaction entry #120	2025-06-15 08:47:46.054219
4621	5	48	Transaction #121	2025-06-15	127.59	Auto-generated transaction entry #121	2025-06-15 08:47:46.054219
4622	5	45	Transaction #122	2025-05-23	170.37	Auto-generated transaction entry #122	2025-06-15 08:47:46.054219
4623	5	48	Transaction #123	2025-06-05	161.27	Auto-generated transaction entry #123	2025-06-15 08:47:46.054219
4624	5	45	Transaction #124	2025-05-25	239.77	Auto-generated transaction entry #124	2025-06-15 08:47:46.054219
4625	5	44	Transaction #125	2025-06-11	261.60	Auto-generated transaction entry #125	2025-06-15 08:47:46.054219
4626	5	45	Transaction #126	2025-05-26	550.52	Auto-generated transaction entry #126	2025-06-15 08:47:46.054219
4627	5	47	Transaction #127	2025-06-02	196.55	Auto-generated transaction entry #127	2025-06-15 08:47:46.054219
4628	5	47	Transaction #128	2025-05-31	887.55	Auto-generated transaction entry #128	2025-06-15 08:47:46.054219
4629	5	46	Transaction #129	2025-05-24	940.05	Auto-generated transaction entry #129	2025-06-15 08:47:46.054219
4630	5	47	Transaction #130	2025-06-14	448.92	Auto-generated transaction entry #130	2025-06-15 08:47:46.054219
4631	5	46	Transaction #131	2025-05-24	445.39	Auto-generated transaction entry #131	2025-06-15 08:47:46.054219
4632	5	45	Transaction #132	2025-06-09	940.28	Auto-generated transaction entry #132	2025-06-15 08:47:46.054219
4633	5	46	Transaction #133	2025-06-11	348.43	Auto-generated transaction entry #133	2025-06-15 08:47:46.054219
4634	5	47	Transaction #134	2025-05-26	886.09	Auto-generated transaction entry #134	2025-06-15 08:47:46.054219
4635	5	47	Transaction #135	2025-05-25	288.29	Auto-generated transaction entry #135	2025-06-15 08:47:46.054219
4636	5	44	Transaction #136	2025-06-03	537.72	Auto-generated transaction entry #136	2025-06-15 08:47:46.054219
4637	5	45	Transaction #137	2025-05-20	551.54	Auto-generated transaction entry #137	2025-06-15 08:47:46.054219
4638	5	45	Transaction #138	2025-06-10	301.88	Auto-generated transaction entry #138	2025-06-15 08:47:46.054219
4639	5	45	Transaction #139	2025-05-28	747.82	Auto-generated transaction entry #139	2025-06-15 08:47:46.054219
4640	5	45	Transaction #140	2025-05-17	412.73	Auto-generated transaction entry #140	2025-06-15 08:47:46.054219
4641	5	46	Transaction #141	2025-05-27	502.28	Auto-generated transaction entry #141	2025-06-15 08:47:46.054219
4642	5	47	Transaction #142	2025-05-28	183.60	Auto-generated transaction entry #142	2025-06-15 08:47:46.054219
4643	5	47	Transaction #143	2025-06-04	486.80	Auto-generated transaction entry #143	2025-06-15 08:47:46.054219
4644	5	47	Transaction #144	2025-05-26	778.50	Auto-generated transaction entry #144	2025-06-15 08:47:46.054219
4645	5	47	Transaction #145	2025-05-26	217.15	Auto-generated transaction entry #145	2025-06-15 08:47:46.054219
4646	5	48	Transaction #146	2025-06-03	297.16	Auto-generated transaction entry #146	2025-06-15 08:47:46.054219
4647	5	46	Transaction #147	2025-06-01	604.41	Auto-generated transaction entry #147	2025-06-15 08:47:46.054219
4648	5	44	Transaction #148	2025-05-30	359.51	Auto-generated transaction entry #148	2025-06-15 08:47:46.054219
4649	5	47	Transaction #149	2025-05-18	290.38	Auto-generated transaction entry #149	2025-06-15 08:47:46.054219
4650	5	44	Transaction #150	2025-06-04	475.36	Auto-generated transaction entry #150	2025-06-15 08:47:46.054219
4651	5	48	Transaction #151	2025-05-20	418.26	Auto-generated transaction entry #151	2025-06-15 08:47:46.054219
4652	5	47	Transaction #152	2025-06-07	375.98	Auto-generated transaction entry #152	2025-06-15 08:47:46.054219
4653	5	47	Transaction #153	2025-06-03	726.38	Auto-generated transaction entry #153	2025-06-15 08:47:46.054219
4654	5	44	Transaction #154	2025-05-21	267.94	Auto-generated transaction entry #154	2025-06-15 08:47:46.054219
4655	5	46	Transaction #155	2025-05-22	907.81	Auto-generated transaction entry #155	2025-06-15 08:47:46.054219
4656	5	48	Transaction #156	2025-06-13	279.59	Auto-generated transaction entry #156	2025-06-15 08:47:46.054219
4657	5	44	Transaction #157	2025-05-27	812.41	Auto-generated transaction entry #157	2025-06-15 08:47:46.054219
4658	5	47	Transaction #158	2025-05-23	689.57	Auto-generated transaction entry #158	2025-06-15 08:47:46.054219
4659	5	47	Transaction #159	2025-06-02	660.50	Auto-generated transaction entry #159	2025-06-15 08:47:46.054219
4660	5	44	Transaction #160	2025-06-05	785.35	Auto-generated transaction entry #160	2025-06-15 08:47:46.054219
4661	5	47	Transaction #161	2025-05-29	453.12	Auto-generated transaction entry #161	2025-06-15 08:47:46.054219
4662	5	44	Transaction #162	2025-06-06	603.61	Auto-generated transaction entry #162	2025-06-15 08:47:46.054219
4663	5	46	Transaction #163	2025-06-03	914.65	Auto-generated transaction entry #163	2025-06-15 08:47:46.054219
4664	5	47	Transaction #164	2025-05-30	147.39	Auto-generated transaction entry #164	2025-06-15 08:47:46.054219
4665	5	44	Transaction #165	2025-06-13	629.92	Auto-generated transaction entry #165	2025-06-15 08:47:46.054219
4666	5	46	Transaction #166	2025-05-30	367.07	Auto-generated transaction entry #166	2025-06-15 08:47:46.054219
4667	5	45	Transaction #167	2025-06-06	237.76	Auto-generated transaction entry #167	2025-06-15 08:47:46.054219
4668	5	45	Transaction #168	2025-06-03	358.00	Auto-generated transaction entry #168	2025-06-15 08:47:46.054219
4669	5	46	Transaction #169	2025-06-13	665.86	Auto-generated transaction entry #169	2025-06-15 08:47:46.054219
4670	5	44	Transaction #170	2025-05-24	952.43	Auto-generated transaction entry #170	2025-06-15 08:47:46.054219
4671	5	46	Transaction #171	2025-06-10	528.75	Auto-generated transaction entry #171	2025-06-15 08:47:46.054219
4672	5	48	Transaction #172	2025-06-09	816.55	Auto-generated transaction entry #172	2025-06-15 08:47:46.054219
4673	5	44	Transaction #173	2025-05-25	920.02	Auto-generated transaction entry #173	2025-06-15 08:47:46.054219
4674	5	46	Transaction #174	2025-05-31	371.10	Auto-generated transaction entry #174	2025-06-15 08:47:46.054219
4675	5	45	Transaction #175	2025-06-06	661.90	Auto-generated transaction entry #175	2025-06-15 08:47:46.054219
4676	5	48	Transaction #176	2025-06-08	219.60	Auto-generated transaction entry #176	2025-06-15 08:47:46.054219
4677	5	48	Transaction #177	2025-06-12	170.99	Auto-generated transaction entry #177	2025-06-15 08:47:46.054219
4678	5	46	Transaction #178	2025-06-04	215.76	Auto-generated transaction entry #178	2025-06-15 08:47:46.054219
4679	5	46	Transaction #179	2025-06-02	560.93	Auto-generated transaction entry #179	2025-06-15 08:47:46.054219
4680	5	46	Transaction #180	2025-06-07	238.38	Auto-generated transaction entry #180	2025-06-15 08:47:46.054219
4681	5	44	Transaction #181	2025-06-08	864.30	Auto-generated transaction entry #181	2025-06-15 08:47:46.054219
4682	5	45	Transaction #182	2025-06-13	348.99	Auto-generated transaction entry #182	2025-06-15 08:47:46.054219
4683	5	48	Transaction #183	2025-05-18	761.39	Auto-generated transaction entry #183	2025-06-15 08:47:46.054219
4684	5	45	Transaction #184	2025-05-25	338.42	Auto-generated transaction entry #184	2025-06-15 08:47:46.054219
4685	5	47	Transaction #185	2025-05-19	288.70	Auto-generated transaction entry #185	2025-06-15 08:47:46.054219
4686	5	44	Transaction #186	2025-06-13	852.86	Auto-generated transaction entry #186	2025-06-15 08:47:46.054219
4687	5	48	Transaction #187	2025-06-08	178.57	Auto-generated transaction entry #187	2025-06-15 08:47:46.054219
4688	5	47	Transaction #188	2025-05-21	407.32	Auto-generated transaction entry #188	2025-06-15 08:47:46.054219
4689	5	46	Transaction #189	2025-05-16	618.75	Auto-generated transaction entry #189	2025-06-15 08:47:46.054219
4690	5	47	Transaction #190	2025-06-08	763.82	Auto-generated transaction entry #190	2025-06-15 08:47:46.054219
4691	5	46	Transaction #191	2025-05-25	139.76	Auto-generated transaction entry #191	2025-06-15 08:47:46.054219
4692	5	46	Transaction #192	2025-06-04	470.69	Auto-generated transaction entry #192	2025-06-15 08:47:46.054219
4693	5	47	Transaction #193	2025-06-01	146.91	Auto-generated transaction entry #193	2025-06-15 08:47:46.054219
4694	5	48	Transaction #194	2025-05-30	215.37	Auto-generated transaction entry #194	2025-06-15 08:47:46.054219
4695	5	46	Transaction #195	2025-06-01	199.06	Auto-generated transaction entry #195	2025-06-15 08:47:46.054219
4696	5	47	Transaction #196	2025-05-23	81.94	Auto-generated transaction entry #196	2025-06-15 08:47:46.054219
4697	5	46	Transaction #197	2025-06-03	573.78	Auto-generated transaction entry #197	2025-06-15 08:47:46.054219
4698	5	45	Transaction #198	2025-06-05	675.13	Auto-generated transaction entry #198	2025-06-15 08:47:46.054219
4699	5	44	Transaction #199	2025-06-12	320.02	Auto-generated transaction entry #199	2025-06-15 08:47:46.054219
4700	5	45	Transaction #200	2025-05-22	638.67	Auto-generated transaction entry #200	2025-06-15 08:47:46.054219
4701	5	46	Transaction #201	2025-05-20	359.72	Auto-generated transaction entry #201	2025-06-15 08:47:46.054219
4702	5	45	Transaction #202	2025-06-10	531.01	Auto-generated transaction entry #202	2025-06-15 08:47:46.054219
4703	5	46	Transaction #203	2025-05-26	433.18	Auto-generated transaction entry #203	2025-06-15 08:47:46.054219
4704	5	47	Transaction #204	2025-05-25	599.96	Auto-generated transaction entry #204	2025-06-15 08:47:46.054219
4705	5	45	Transaction #205	2025-05-16	705.47	Auto-generated transaction entry #205	2025-06-15 08:47:46.054219
4706	5	47	Transaction #206	2025-06-14	128.66	Auto-generated transaction entry #206	2025-06-15 08:47:46.054219
4707	5	48	Transaction #207	2025-05-18	130.00	Auto-generated transaction entry #207	2025-06-15 08:47:46.054219
4708	5	45	Transaction #208	2025-05-22	722.01	Auto-generated transaction entry #208	2025-06-15 08:47:46.054219
4709	5	48	Transaction #209	2025-06-09	660.22	Auto-generated transaction entry #209	2025-06-15 08:47:46.054219
4710	5	46	Transaction #210	2025-06-14	221.66	Auto-generated transaction entry #210	2025-06-15 08:47:46.054219
4711	5	45	Transaction #211	2025-05-17	167.20	Auto-generated transaction entry #211	2025-06-15 08:47:46.054219
4712	5	48	Transaction #212	2025-06-10	517.39	Auto-generated transaction entry #212	2025-06-15 08:47:46.054219
4713	5	48	Transaction #213	2025-05-20	303.05	Auto-generated transaction entry #213	2025-06-15 08:47:46.054219
4714	5	46	Transaction #214	2025-05-29	593.49	Auto-generated transaction entry #214	2025-06-15 08:47:46.054219
4715	5	44	Transaction #215	2025-05-21	173.10	Auto-generated transaction entry #215	2025-06-15 08:47:46.054219
4716	5	45	Transaction #216	2025-06-04	679.08	Auto-generated transaction entry #216	2025-06-15 08:47:46.054219
4717	5	45	Transaction #217	2025-06-05	170.05	Auto-generated transaction entry #217	2025-06-15 08:47:46.054219
4718	5	48	Transaction #218	2025-06-12	764.11	Auto-generated transaction entry #218	2025-06-15 08:47:46.054219
4719	5	45	Transaction #219	2025-06-07	249.92	Auto-generated transaction entry #219	2025-06-15 08:47:46.054219
4720	5	45	Transaction #220	2025-06-08	960.53	Auto-generated transaction entry #220	2025-06-15 08:47:46.054219
4721	5	47	Transaction #221	2025-05-24	292.84	Auto-generated transaction entry #221	2025-06-15 08:47:46.054219
4722	5	45	Transaction #222	2025-06-03	125.40	Auto-generated transaction entry #222	2025-06-15 08:47:46.054219
4723	5	45	Transaction #223	2025-05-19	258.08	Auto-generated transaction entry #223	2025-06-15 08:47:46.054219
4724	5	48	Transaction #224	2025-06-02	883.73	Auto-generated transaction entry #224	2025-06-15 08:47:46.054219
4725	5	48	Transaction #225	2025-06-07	311.16	Auto-generated transaction entry #225	2025-06-15 08:47:46.054219
4726	5	45	Transaction #226	2025-05-16	436.54	Auto-generated transaction entry #226	2025-06-15 08:47:46.054219
4727	5	44	Transaction #227	2025-06-09	168.99	Auto-generated transaction entry #227	2025-06-15 08:47:46.054219
4728	5	44	Transaction #228	2025-06-04	498.44	Auto-generated transaction entry #228	2025-06-15 08:47:46.054219
4729	5	48	Transaction #229	2025-06-11	908.16	Auto-generated transaction entry #229	2025-06-15 08:47:46.054219
4730	5	47	Transaction #230	2025-06-09	119.33	Auto-generated transaction entry #230	2025-06-15 08:47:46.054219
4731	5	45	Transaction #231	2025-06-14	486.52	Auto-generated transaction entry #231	2025-06-15 08:47:46.054219
4732	5	48	Transaction #232	2025-06-07	650.87	Auto-generated transaction entry #232	2025-06-15 08:47:46.054219
4733	5	46	Transaction #233	2025-05-26	154.33	Auto-generated transaction entry #233	2025-06-15 08:47:46.054219
4734	5	44	Transaction #234	2025-05-28	640.29	Auto-generated transaction entry #234	2025-06-15 08:47:46.054219
4735	5	44	Transaction #235	2025-05-19	114.07	Auto-generated transaction entry #235	2025-06-15 08:47:46.054219
4736	5	45	Transaction #236	2025-06-01	251.85	Auto-generated transaction entry #236	2025-06-15 08:47:46.054219
4737	5	47	Transaction #237	2025-05-23	243.91	Auto-generated transaction entry #237	2025-06-15 08:47:46.054219
4738	5	44	Transaction #238	2025-05-30	539.57	Auto-generated transaction entry #238	2025-06-15 08:47:46.054219
4739	5	45	Transaction #239	2025-05-31	201.60	Auto-generated transaction entry #239	2025-06-15 08:47:46.054219
4740	5	46	Transaction #240	2025-05-17	110.16	Auto-generated transaction entry #240	2025-06-15 08:47:46.054219
4741	5	45	Transaction #241	2025-05-20	782.91	Auto-generated transaction entry #241	2025-06-15 08:47:46.054219
4742	5	46	Transaction #242	2025-06-06	67.22	Auto-generated transaction entry #242	2025-06-15 08:47:46.054219
4743	5	47	Transaction #243	2025-06-08	702.76	Auto-generated transaction entry #243	2025-06-15 08:47:46.054219
4744	5	46	Transaction #244	2025-05-28	937.20	Auto-generated transaction entry #244	2025-06-15 08:47:46.054219
4745	5	47	Transaction #245	2025-06-14	333.96	Auto-generated transaction entry #245	2025-06-15 08:47:46.054219
4746	5	45	Transaction #246	2025-06-02	627.72	Auto-generated transaction entry #246	2025-06-15 08:47:46.054219
4747	5	46	Transaction #247	2025-06-13	424.51	Auto-generated transaction entry #247	2025-06-15 08:47:46.054219
4748	5	46	Transaction #248	2025-06-07	131.57	Auto-generated transaction entry #248	2025-06-15 08:47:46.054219
4749	5	48	Transaction #249	2025-05-24	628.92	Auto-generated transaction entry #249	2025-06-15 08:47:46.054219
4750	5	46	Transaction #250	2025-05-30	886.76	Auto-generated transaction entry #250	2025-06-15 08:47:46.054219
4751	5	46	Transaction #251	2025-06-02	997.21	Auto-generated transaction entry #251	2025-06-15 08:47:46.054219
4752	5	46	Transaction #252	2025-05-17	445.88	Auto-generated transaction entry #252	2025-06-15 08:47:46.054219
4753	5	46	Transaction #253	2025-05-24	88.42	Auto-generated transaction entry #253	2025-06-15 08:47:46.054219
4754	5	44	Transaction #254	2025-05-21	888.93	Auto-generated transaction entry #254	2025-06-15 08:47:46.054219
4755	5	46	Transaction #255	2025-06-02	820.84	Auto-generated transaction entry #255	2025-06-15 08:47:46.054219
4756	5	45	Transaction #256	2025-06-06	772.38	Auto-generated transaction entry #256	2025-06-15 08:47:46.054219
4757	5	44	Transaction #257	2025-05-17	324.19	Auto-generated transaction entry #257	2025-06-15 08:47:46.054219
4758	5	47	Transaction #258	2025-06-04	880.57	Auto-generated transaction entry #258	2025-06-15 08:47:46.054219
4759	5	47	Transaction #259	2025-06-12	448.50	Auto-generated transaction entry #259	2025-06-15 08:47:46.054219
4760	5	47	Transaction #260	2025-06-14	370.88	Auto-generated transaction entry #260	2025-06-15 08:47:46.054219
4761	5	45	Transaction #261	2025-06-04	579.56	Auto-generated transaction entry #261	2025-06-15 08:47:46.054219
4762	5	45	Transaction #262	2025-05-19	202.23	Auto-generated transaction entry #262	2025-06-15 08:47:46.054219
4763	5	48	Transaction #263	2025-06-13	707.29	Auto-generated transaction entry #263	2025-06-15 08:47:46.054219
4764	5	47	Transaction #264	2025-06-02	517.24	Auto-generated transaction entry #264	2025-06-15 08:47:46.054219
4765	5	46	Transaction #265	2025-05-30	211.91	Auto-generated transaction entry #265	2025-06-15 08:47:46.054219
4766	5	46	Transaction #266	2025-05-24	882.69	Auto-generated transaction entry #266	2025-06-15 08:47:46.054219
4767	5	48	Transaction #267	2025-05-17	514.11	Auto-generated transaction entry #267	2025-06-15 08:47:46.054219
4768	5	46	Transaction #268	2025-05-22	714.23	Auto-generated transaction entry #268	2025-06-15 08:47:46.054219
4769	5	46	Transaction #269	2025-05-31	589.99	Auto-generated transaction entry #269	2025-06-15 08:47:46.054219
4770	5	47	Transaction #270	2025-05-21	339.29	Auto-generated transaction entry #270	2025-06-15 08:47:46.054219
4771	5	45	Transaction #271	2025-05-16	306.29	Auto-generated transaction entry #271	2025-06-15 08:47:46.054219
4772	5	45	Transaction #272	2025-06-09	367.06	Auto-generated transaction entry #272	2025-06-15 08:47:46.054219
4773	5	47	Transaction #273	2025-06-10	222.27	Auto-generated transaction entry #273	2025-06-15 08:47:46.054219
4774	5	48	Transaction #274	2025-06-05	103.55	Auto-generated transaction entry #274	2025-06-15 08:47:46.054219
4775	5	44	Transaction #275	2025-06-13	480.68	Auto-generated transaction entry #275	2025-06-15 08:47:46.054219
4776	5	46	Transaction #276	2025-05-19	862.82	Auto-generated transaction entry #276	2025-06-15 08:47:46.054219
4777	5	47	Transaction #277	2025-06-04	488.93	Auto-generated transaction entry #277	2025-06-15 08:47:46.054219
4778	5	47	Transaction #278	2025-06-08	443.57	Auto-generated transaction entry #278	2025-06-15 08:47:46.054219
4779	5	47	Transaction #279	2025-06-11	378.75	Auto-generated transaction entry #279	2025-06-15 08:47:46.054219
4780	5	48	Transaction #280	2025-05-23	179.48	Auto-generated transaction entry #280	2025-06-15 08:47:46.054219
4781	5	45	Transaction #281	2025-05-17	290.58	Auto-generated transaction entry #281	2025-06-15 08:47:46.054219
4782	5	46	Transaction #282	2025-06-07	131.97	Auto-generated transaction entry #282	2025-06-15 08:47:46.054219
4783	5	44	Transaction #283	2025-05-30	931.77	Auto-generated transaction entry #283	2025-06-15 08:47:46.054219
4784	5	48	Transaction #284	2025-06-08	692.84	Auto-generated transaction entry #284	2025-06-15 08:47:46.054219
4785	5	44	Transaction #285	2025-06-07	609.56	Auto-generated transaction entry #285	2025-06-15 08:47:46.054219
4786	5	46	Transaction #286	2025-05-30	468.98	Auto-generated transaction entry #286	2025-06-15 08:47:46.054219
4787	5	47	Transaction #287	2025-05-30	232.00	Auto-generated transaction entry #287	2025-06-15 08:47:46.054219
4788	5	45	Transaction #288	2025-06-05	373.09	Auto-generated transaction entry #288	2025-06-15 08:47:46.054219
4789	5	45	Transaction #289	2025-06-05	903.20	Auto-generated transaction entry #289	2025-06-15 08:47:46.054219
4790	5	45	Transaction #290	2025-06-07	965.98	Auto-generated transaction entry #290	2025-06-15 08:47:46.054219
4791	5	47	Transaction #291	2025-06-02	840.50	Auto-generated transaction entry #291	2025-06-15 08:47:46.054219
4792	5	44	Transaction #292	2025-05-23	637.92	Auto-generated transaction entry #292	2025-06-15 08:47:46.054219
4793	5	44	Transaction #293	2025-05-19	175.74	Auto-generated transaction entry #293	2025-06-15 08:47:46.054219
4794	5	48	Transaction #294	2025-05-17	96.89	Auto-generated transaction entry #294	2025-06-15 08:47:46.054219
4795	5	44	Transaction #295	2025-06-15	367.77	Auto-generated transaction entry #295	2025-06-15 08:47:46.054219
4796	5	47	Transaction #296	2025-06-11	438.43	Auto-generated transaction entry #296	2025-06-15 08:47:46.054219
4797	5	45	Transaction #297	2025-06-14	987.95	Auto-generated transaction entry #297	2025-06-15 08:47:46.054219
4798	5	46	Transaction #298	2025-06-14	832.77	Auto-generated transaction entry #298	2025-06-15 08:47:46.054219
4799	5	48	Transaction #299	2025-06-10	244.95	Auto-generated transaction entry #299	2025-06-15 08:47:46.054219
4800	5	45	Transaction #300	2025-05-26	741.73	Auto-generated transaction entry #300	2025-06-15 08:47:46.054219
4801	5	47	Transaction #301	2025-05-20	690.72	Auto-generated transaction entry #301	2025-06-15 08:47:46.054219
4802	5	45	Transaction #302	2025-05-29	713.27	Auto-generated transaction entry #302	2025-06-15 08:47:46.054219
4803	5	45	Transaction #303	2025-05-22	553.05	Auto-generated transaction entry #303	2025-06-15 08:47:46.054219
4804	5	46	Transaction #304	2025-05-17	803.69	Auto-generated transaction entry #304	2025-06-15 08:47:46.054219
4805	5	47	Transaction #305	2025-06-01	827.07	Auto-generated transaction entry #305	2025-06-15 08:47:46.054219
4806	5	47	Transaction #306	2025-06-03	660.19	Auto-generated transaction entry #306	2025-06-15 08:47:46.054219
4807	5	44	Transaction #307	2025-06-10	92.47	Auto-generated transaction entry #307	2025-06-15 08:47:46.054219
4808	5	47	Transaction #308	2025-06-04	827.11	Auto-generated transaction entry #308	2025-06-15 08:47:46.054219
4809	5	47	Transaction #309	2025-06-08	439.11	Auto-generated transaction entry #309	2025-06-15 08:47:46.054219
4810	5	47	Transaction #310	2025-05-21	193.42	Auto-generated transaction entry #310	2025-06-15 08:47:46.054219
4811	5	48	Transaction #311	2025-05-23	100.89	Auto-generated transaction entry #311	2025-06-15 08:47:46.054219
4812	5	45	Transaction #312	2025-05-23	195.94	Auto-generated transaction entry #312	2025-06-15 08:47:46.054219
4813	5	48	Transaction #313	2025-05-27	506.86	Auto-generated transaction entry #313	2025-06-15 08:47:46.054219
4814	5	45	Transaction #314	2025-06-11	971.31	Auto-generated transaction entry #314	2025-06-15 08:47:46.054219
4815	5	47	Transaction #315	2025-06-15	696.05	Auto-generated transaction entry #315	2025-06-15 08:47:46.054219
4816	5	48	Transaction #316	2025-05-19	616.11	Auto-generated transaction entry #316	2025-06-15 08:47:46.054219
4817	5	48	Transaction #317	2025-05-17	421.57	Auto-generated transaction entry #317	2025-06-15 08:47:46.054219
4818	5	46	Transaction #318	2025-05-22	964.93	Auto-generated transaction entry #318	2025-06-15 08:47:46.054219
4819	5	45	Transaction #319	2025-05-31	182.88	Auto-generated transaction entry #319	2025-06-15 08:47:46.054219
4820	5	46	Transaction #320	2025-06-06	359.64	Auto-generated transaction entry #320	2025-06-15 08:47:46.054219
4821	5	44	Transaction #321	2025-06-11	460.39	Auto-generated transaction entry #321	2025-06-15 08:47:46.054219
4822	5	47	Transaction #322	2025-06-06	974.33	Auto-generated transaction entry #322	2025-06-15 08:47:46.054219
4823	5	44	Transaction #323	2025-06-01	636.69	Auto-generated transaction entry #323	2025-06-15 08:47:46.054219
4824	5	48	Transaction #324	2025-06-05	186.61	Auto-generated transaction entry #324	2025-06-15 08:47:46.054219
4825	5	47	Transaction #325	2025-05-19	944.87	Auto-generated transaction entry #325	2025-06-15 08:47:46.054219
4826	5	46	Transaction #326	2025-05-19	101.91	Auto-generated transaction entry #326	2025-06-15 08:47:46.054219
4827	5	45	Transaction #327	2025-06-08	606.89	Auto-generated transaction entry #327	2025-06-15 08:47:46.054219
4828	5	46	Transaction #328	2025-05-24	626.36	Auto-generated transaction entry #328	2025-06-15 08:47:46.054219
4829	5	48	Transaction #329	2025-05-23	998.00	Auto-generated transaction entry #329	2025-06-15 08:47:46.054219
4830	5	47	Transaction #330	2025-05-23	917.30	Auto-generated transaction entry #330	2025-06-15 08:47:46.054219
4831	5	46	Transaction #331	2025-05-21	392.06	Auto-generated transaction entry #331	2025-06-15 08:47:46.054219
4832	5	48	Transaction #332	2025-06-06	319.08	Auto-generated transaction entry #332	2025-06-15 08:47:46.054219
4833	5	45	Transaction #333	2025-05-27	484.73	Auto-generated transaction entry #333	2025-06-15 08:47:46.054219
4834	5	46	Transaction #334	2025-06-02	730.07	Auto-generated transaction entry #334	2025-06-15 08:47:46.054219
4835	5	44	Transaction #335	2025-05-27	219.09	Auto-generated transaction entry #335	2025-06-15 08:47:46.054219
4836	5	45	Transaction #336	2025-06-06	456.87	Auto-generated transaction entry #336	2025-06-15 08:47:46.054219
4837	5	47	Transaction #337	2025-06-12	152.74	Auto-generated transaction entry #337	2025-06-15 08:47:46.054219
4838	5	46	Transaction #338	2025-05-29	641.28	Auto-generated transaction entry #338	2025-06-15 08:47:46.054219
4839	5	44	Transaction #339	2025-06-01	504.98	Auto-generated transaction entry #339	2025-06-15 08:47:46.054219
4840	5	44	Transaction #340	2025-06-10	81.84	Auto-generated transaction entry #340	2025-06-15 08:47:46.054219
4841	5	48	Transaction #341	2025-06-15	510.99	Auto-generated transaction entry #341	2025-06-15 08:47:46.054219
4842	5	47	Transaction #342	2025-05-28	369.89	Auto-generated transaction entry #342	2025-06-15 08:47:46.054219
4843	5	44	Transaction #343	2025-05-30	656.46	Auto-generated transaction entry #343	2025-06-15 08:47:46.054219
4844	5	44	Transaction #344	2025-05-23	385.38	Auto-generated transaction entry #344	2025-06-15 08:47:46.054219
4845	5	47	Transaction #345	2025-05-24	388.92	Auto-generated transaction entry #345	2025-06-15 08:47:46.054219
4846	5	45	Transaction #346	2025-05-17	725.18	Auto-generated transaction entry #346	2025-06-15 08:47:46.054219
4847	5	47	Transaction #347	2025-06-04	803.33	Auto-generated transaction entry #347	2025-06-15 08:47:46.054219
4848	5	48	Transaction #348	2025-05-23	757.85	Auto-generated transaction entry #348	2025-06-15 08:47:46.054219
4849	5	47	Transaction #349	2025-05-27	664.33	Auto-generated transaction entry #349	2025-06-15 08:47:46.054219
4850	5	46	Transaction #350	2025-06-08	171.91	Auto-generated transaction entry #350	2025-06-15 08:47:46.054219
4851	5	48	Transaction #351	2025-06-04	510.07	Auto-generated transaction entry #351	2025-06-15 08:47:46.054219
4852	5	45	Transaction #352	2025-05-30	774.89	Auto-generated transaction entry #352	2025-06-15 08:47:46.054219
4853	5	45	Transaction #353	2025-05-20	788.65	Auto-generated transaction entry #353	2025-06-15 08:47:46.054219
4854	5	48	Transaction #354	2025-06-04	93.30	Auto-generated transaction entry #354	2025-06-15 08:47:46.054219
4855	5	46	Transaction #355	2025-05-30	622.42	Auto-generated transaction entry #355	2025-06-15 08:47:46.054219
4856	5	44	Transaction #356	2025-06-09	472.61	Auto-generated transaction entry #356	2025-06-15 08:47:46.054219
4857	5	46	Transaction #357	2025-06-06	736.04	Auto-generated transaction entry #357	2025-06-15 08:47:46.054219
4858	5	46	Transaction #358	2025-05-19	626.46	Auto-generated transaction entry #358	2025-06-15 08:47:46.054219
4859	5	44	Transaction #359	2025-06-15	377.56	Auto-generated transaction entry #359	2025-06-15 08:47:46.054219
4860	5	47	Transaction #360	2025-06-01	874.92	Auto-generated transaction entry #360	2025-06-15 08:47:46.054219
4861	5	44	Transaction #361	2025-05-24	723.37	Auto-generated transaction entry #361	2025-06-15 08:47:46.054219
4862	5	47	Transaction #362	2025-06-08	629.32	Auto-generated transaction entry #362	2025-06-15 08:47:46.054219
4863	5	46	Transaction #363	2025-06-09	287.22	Auto-generated transaction entry #363	2025-06-15 08:47:46.054219
4864	5	46	Transaction #364	2025-06-11	610.61	Auto-generated transaction entry #364	2025-06-15 08:47:46.054219
4865	5	48	Transaction #365	2025-06-05	544.96	Auto-generated transaction entry #365	2025-06-15 08:47:46.054219
4866	5	46	Transaction #366	2025-05-26	344.95	Auto-generated transaction entry #366	2025-06-15 08:47:46.054219
4867	5	47	Transaction #367	2025-05-17	696.95	Auto-generated transaction entry #367	2025-06-15 08:47:46.054219
4868	5	45	Transaction #368	2025-06-11	266.51	Auto-generated transaction entry #368	2025-06-15 08:47:46.054219
4869	5	47	Transaction #369	2025-06-01	208.63	Auto-generated transaction entry #369	2025-06-15 08:47:46.054219
4870	5	48	Transaction #370	2025-06-01	350.19	Auto-generated transaction entry #370	2025-06-15 08:47:46.054219
4871	5	48	Transaction #371	2025-06-11	185.26	Auto-generated transaction entry #371	2025-06-15 08:47:46.054219
4872	5	45	Transaction #372	2025-05-25	405.32	Auto-generated transaction entry #372	2025-06-15 08:47:46.054219
4873	5	47	Transaction #373	2025-06-08	557.21	Auto-generated transaction entry #373	2025-06-15 08:47:46.054219
4874	5	48	Transaction #374	2025-05-31	392.54	Auto-generated transaction entry #374	2025-06-15 08:47:46.054219
4875	5	44	Transaction #375	2025-06-09	228.61	Auto-generated transaction entry #375	2025-06-15 08:47:46.054219
4876	5	46	Transaction #376	2025-06-08	599.46	Auto-generated transaction entry #376	2025-06-15 08:47:46.054219
4877	5	44	Transaction #377	2025-05-21	729.57	Auto-generated transaction entry #377	2025-06-15 08:47:46.054219
4878	5	47	Transaction #378	2025-05-29	977.71	Auto-generated transaction entry #378	2025-06-15 08:47:46.054219
4879	5	48	Transaction #379	2025-06-06	927.31	Auto-generated transaction entry #379	2025-06-15 08:47:46.054219
4880	5	46	Transaction #380	2025-06-11	793.70	Auto-generated transaction entry #380	2025-06-15 08:47:46.054219
4881	5	44	Transaction #381	2025-06-10	599.64	Auto-generated transaction entry #381	2025-06-15 08:47:46.054219
4882	5	47	Transaction #382	2025-05-29	67.07	Auto-generated transaction entry #382	2025-06-15 08:47:46.054219
4883	5	46	Transaction #383	2025-06-05	109.68	Auto-generated transaction entry #383	2025-06-15 08:47:46.054219
4884	5	44	Transaction #384	2025-06-15	857.99	Auto-generated transaction entry #384	2025-06-15 08:47:46.054219
4885	5	45	Transaction #385	2025-05-25	148.27	Auto-generated transaction entry #385	2025-06-15 08:47:46.054219
4886	5	45	Transaction #386	2025-05-18	155.31	Auto-generated transaction entry #386	2025-06-15 08:47:46.054219
4887	5	47	Transaction #387	2025-06-12	501.21	Auto-generated transaction entry #387	2025-06-15 08:47:46.054219
4888	5	46	Transaction #388	2025-05-17	670.74	Auto-generated transaction entry #388	2025-06-15 08:47:46.054219
4889	5	44	Transaction #389	2025-05-21	616.10	Auto-generated transaction entry #389	2025-06-15 08:47:46.054219
4890	5	44	Transaction #390	2025-05-21	962.00	Auto-generated transaction entry #390	2025-06-15 08:47:46.054219
4891	5	44	Transaction #391	2025-06-01	711.07	Auto-generated transaction entry #391	2025-06-15 08:47:46.054219
4892	5	47	Transaction #392	2025-05-20	305.93	Auto-generated transaction entry #392	2025-06-15 08:47:46.054219
4893	5	48	Transaction #393	2025-06-10	521.54	Auto-generated transaction entry #393	2025-06-15 08:47:46.054219
4894	5	48	Transaction #394	2025-06-01	565.70	Auto-generated transaction entry #394	2025-06-15 08:47:46.054219
4895	5	48	Transaction #395	2025-05-22	668.24	Auto-generated transaction entry #395	2025-06-15 08:47:46.054219
4896	5	44	Transaction #396	2025-06-13	149.60	Auto-generated transaction entry #396	2025-06-15 08:47:46.054219
4897	5	48	Transaction #397	2025-06-14	881.16	Auto-generated transaction entry #397	2025-06-15 08:47:46.054219
4898	5	44	Transaction #398	2025-05-18	430.21	Auto-generated transaction entry #398	2025-06-15 08:47:46.054219
4899	5	48	Transaction #399	2025-06-07	472.29	Auto-generated transaction entry #399	2025-06-15 08:47:46.054219
4900	5	45	Transaction #400	2025-06-01	553.47	Auto-generated transaction entry #400	2025-06-15 08:47:46.054219
4901	5	45	Transaction #401	2025-06-02	615.55	Auto-generated transaction entry #401	2025-06-15 08:47:46.054219
4902	5	47	Transaction #402	2025-05-30	820.91	Auto-generated transaction entry #402	2025-06-15 08:47:46.054219
4903	5	48	Transaction #403	2025-05-21	768.47	Auto-generated transaction entry #403	2025-06-15 08:47:46.054219
4904	5	45	Transaction #404	2025-05-27	967.08	Auto-generated transaction entry #404	2025-06-15 08:47:46.054219
4905	5	46	Transaction #405	2025-05-29	336.60	Auto-generated transaction entry #405	2025-06-15 08:47:46.054219
4906	5	46	Transaction #406	2025-05-21	686.95	Auto-generated transaction entry #406	2025-06-15 08:47:46.054219
4907	5	44	Transaction #407	2025-06-03	612.34	Auto-generated transaction entry #407	2025-06-15 08:47:46.054219
4908	5	47	Transaction #408	2025-05-25	484.06	Auto-generated transaction entry #408	2025-06-15 08:47:46.054219
4909	5	46	Transaction #409	2025-06-08	264.79	Auto-generated transaction entry #409	2025-06-15 08:47:46.054219
4910	5	46	Transaction #410	2025-05-25	395.21	Auto-generated transaction entry #410	2025-06-15 08:47:46.054219
4911	5	47	Transaction #411	2025-05-19	929.92	Auto-generated transaction entry #411	2025-06-15 08:47:46.054219
4912	5	45	Transaction #412	2025-05-21	464.55	Auto-generated transaction entry #412	2025-06-15 08:47:46.054219
4913	5	47	Transaction #413	2025-06-08	576.06	Auto-generated transaction entry #413	2025-06-15 08:47:46.054219
4914	5	47	Transaction #414	2025-05-23	946.12	Auto-generated transaction entry #414	2025-06-15 08:47:46.054219
4915	5	46	Transaction #415	2025-06-12	766.88	Auto-generated transaction entry #415	2025-06-15 08:47:46.054219
4916	5	46	Transaction #416	2025-05-23	244.27	Auto-generated transaction entry #416	2025-06-15 08:47:46.054219
4917	5	45	Transaction #417	2025-06-02	947.91	Auto-generated transaction entry #417	2025-06-15 08:47:46.054219
4918	5	45	Transaction #418	2025-05-16	319.05	Auto-generated transaction entry #418	2025-06-15 08:47:46.054219
4919	5	47	Transaction #419	2025-05-20	77.11	Auto-generated transaction entry #419	2025-06-15 08:47:46.054219
4920	5	48	Transaction #420	2025-05-30	261.35	Auto-generated transaction entry #420	2025-06-15 08:47:46.054219
4921	5	44	Transaction #421	2025-05-30	381.18	Auto-generated transaction entry #421	2025-06-15 08:47:46.054219
4922	5	47	Transaction #422	2025-05-22	949.72	Auto-generated transaction entry #422	2025-06-15 08:47:46.054219
4923	5	45	Transaction #423	2025-06-03	804.52	Auto-generated transaction entry #423	2025-06-15 08:47:46.054219
4924	5	47	Transaction #424	2025-05-21	719.40	Auto-generated transaction entry #424	2025-06-15 08:47:46.054219
4925	5	48	Transaction #425	2025-05-27	599.75	Auto-generated transaction entry #425	2025-06-15 08:47:46.054219
4926	5	45	Transaction #426	2025-05-27	616.83	Auto-generated transaction entry #426	2025-06-15 08:47:46.054219
4927	5	45	Transaction #427	2025-06-04	806.95	Auto-generated transaction entry #427	2025-06-15 08:47:46.054219
4928	5	48	Transaction #428	2025-05-18	260.80	Auto-generated transaction entry #428	2025-06-15 08:47:46.054219
4929	5	48	Transaction #429	2025-05-22	351.94	Auto-generated transaction entry #429	2025-06-15 08:47:46.054219
4930	5	48	Transaction #430	2025-05-27	673.83	Auto-generated transaction entry #430	2025-06-15 08:47:46.054219
4931	5	44	Transaction #431	2025-06-04	389.21	Auto-generated transaction entry #431	2025-06-15 08:47:46.054219
4932	5	48	Transaction #432	2025-06-02	430.42	Auto-generated transaction entry #432	2025-06-15 08:47:46.054219
4933	5	47	Transaction #433	2025-06-08	726.83	Auto-generated transaction entry #433	2025-06-15 08:47:46.054219
4934	5	47	Transaction #434	2025-05-19	332.08	Auto-generated transaction entry #434	2025-06-15 08:47:46.054219
4935	5	48	Transaction #435	2025-05-18	143.84	Auto-generated transaction entry #435	2025-06-15 08:47:46.054219
4936	5	47	Transaction #436	2025-06-01	243.52	Auto-generated transaction entry #436	2025-06-15 08:47:46.054219
4937	5	47	Transaction #437	2025-06-13	332.05	Auto-generated transaction entry #437	2025-06-15 08:47:46.054219
4938	5	44	Transaction #438	2025-06-06	617.30	Auto-generated transaction entry #438	2025-06-15 08:47:46.054219
4939	5	48	Transaction #439	2025-06-10	238.68	Auto-generated transaction entry #439	2025-06-15 08:47:46.054219
4940	5	46	Transaction #440	2025-05-27	578.77	Auto-generated transaction entry #440	2025-06-15 08:47:46.054219
4941	5	48	Transaction #441	2025-05-28	273.45	Auto-generated transaction entry #441	2025-06-15 08:47:46.054219
4942	5	44	Transaction #442	2025-06-14	991.27	Auto-generated transaction entry #442	2025-06-15 08:47:46.054219
4943	5	48	Transaction #443	2025-06-01	389.46	Auto-generated transaction entry #443	2025-06-15 08:47:46.054219
4944	5	47	Transaction #444	2025-06-09	369.77	Auto-generated transaction entry #444	2025-06-15 08:47:46.054219
4945	5	45	Transaction #445	2025-05-20	739.70	Auto-generated transaction entry #445	2025-06-15 08:47:46.054219
4946	5	46	Transaction #446	2025-05-18	438.56	Auto-generated transaction entry #446	2025-06-15 08:47:46.054219
4947	5	44	Transaction #447	2025-06-09	781.57	Auto-generated transaction entry #447	2025-06-15 08:47:46.054219
4948	5	48	Transaction #448	2025-06-11	63.37	Auto-generated transaction entry #448	2025-06-15 08:47:46.054219
4949	5	46	Transaction #449	2025-06-02	465.02	Auto-generated transaction entry #449	2025-06-15 08:47:46.054219
4950	5	44	Transaction #450	2025-06-13	141.30	Auto-generated transaction entry #450	2025-06-15 08:47:46.054219
4951	5	48	Transaction #451	2025-06-01	844.48	Auto-generated transaction entry #451	2025-06-15 08:47:46.054219
4952	5	45	Transaction #452	2025-05-18	499.58	Auto-generated transaction entry #452	2025-06-15 08:47:46.054219
4953	5	44	Transaction #453	2025-05-24	800.62	Auto-generated transaction entry #453	2025-06-15 08:47:46.054219
4954	5	44	Transaction #454	2025-06-04	580.38	Auto-generated transaction entry #454	2025-06-15 08:47:46.054219
4955	5	45	Transaction #455	2025-06-04	369.13	Auto-generated transaction entry #455	2025-06-15 08:47:46.054219
4956	5	44	Transaction #456	2025-05-31	91.34	Auto-generated transaction entry #456	2025-06-15 08:47:46.054219
4957	5	46	Transaction #457	2025-06-02	304.96	Auto-generated transaction entry #457	2025-06-15 08:47:46.054219
4958	5	46	Transaction #458	2025-05-27	421.85	Auto-generated transaction entry #458	2025-06-15 08:47:46.054219
4959	5	44	Transaction #459	2025-05-30	484.91	Auto-generated transaction entry #459	2025-06-15 08:47:46.054219
4960	5	44	Transaction #460	2025-06-10	743.17	Auto-generated transaction entry #460	2025-06-15 08:47:46.054219
4961	5	46	Transaction #461	2025-05-26	801.94	Auto-generated transaction entry #461	2025-06-15 08:47:46.054219
4962	5	44	Transaction #462	2025-06-02	919.28	Auto-generated transaction entry #462	2025-06-15 08:47:46.054219
4963	5	47	Transaction #463	2025-06-06	308.39	Auto-generated transaction entry #463	2025-06-15 08:47:46.054219
4964	5	48	Transaction #464	2025-06-14	352.11	Auto-generated transaction entry #464	2025-06-15 08:47:46.054219
4965	5	48	Transaction #465	2025-05-30	811.94	Auto-generated transaction entry #465	2025-06-15 08:47:46.054219
4966	5	45	Transaction #466	2025-05-22	205.51	Auto-generated transaction entry #466	2025-06-15 08:47:46.054219
4967	5	46	Transaction #467	2025-05-17	450.65	Auto-generated transaction entry #467	2025-06-15 08:47:46.054219
4968	5	45	Transaction #468	2025-06-13	101.85	Auto-generated transaction entry #468	2025-06-15 08:47:46.054219
4969	5	48	Transaction #469	2025-06-11	921.40	Auto-generated transaction entry #469	2025-06-15 08:47:46.054219
4970	5	45	Transaction #470	2025-06-08	449.99	Auto-generated transaction entry #470	2025-06-15 08:47:46.054219
4971	5	46	Transaction #471	2025-05-19	400.70	Auto-generated transaction entry #471	2025-06-15 08:47:46.054219
4972	5	44	Transaction #472	2025-05-24	151.64	Auto-generated transaction entry #472	2025-06-15 08:47:46.054219
4973	5	44	Transaction #473	2025-05-24	228.86	Auto-generated transaction entry #473	2025-06-15 08:47:46.054219
4974	5	45	Transaction #474	2025-06-07	965.30	Auto-generated transaction entry #474	2025-06-15 08:47:46.054219
4975	5	48	Transaction #475	2025-05-30	427.41	Auto-generated transaction entry #475	2025-06-15 08:47:46.054219
4976	5	46	Transaction #476	2025-06-03	377.53	Auto-generated transaction entry #476	2025-06-15 08:47:46.054219
4977	5	45	Transaction #477	2025-05-22	543.87	Auto-generated transaction entry #477	2025-06-15 08:47:46.054219
4978	5	47	Transaction #478	2025-05-26	696.21	Auto-generated transaction entry #478	2025-06-15 08:47:46.054219
4979	5	44	Transaction #479	2025-06-06	331.09	Auto-generated transaction entry #479	2025-06-15 08:47:46.054219
4980	5	46	Transaction #480	2025-05-17	262.96	Auto-generated transaction entry #480	2025-06-15 08:47:46.054219
4981	5	47	Transaction #481	2025-06-14	456.14	Auto-generated transaction entry #481	2025-06-15 08:47:46.054219
4982	5	45	Transaction #482	2025-05-22	799.49	Auto-generated transaction entry #482	2025-06-15 08:47:46.054219
4983	5	48	Transaction #483	2025-06-11	826.59	Auto-generated transaction entry #483	2025-06-15 08:47:46.054219
4984	5	48	Transaction #484	2025-05-20	850.85	Auto-generated transaction entry #484	2025-06-15 08:47:46.054219
4985	5	46	Transaction #485	2025-05-26	332.37	Auto-generated transaction entry #485	2025-06-15 08:47:46.054219
4986	5	46	Transaction #486	2025-05-17	638.24	Auto-generated transaction entry #486	2025-06-15 08:47:46.054219
4987	5	46	Transaction #487	2025-06-08	304.67	Auto-generated transaction entry #487	2025-06-15 08:47:46.054219
4988	5	44	Transaction #488	2025-05-30	635.54	Auto-generated transaction entry #488	2025-06-15 08:47:46.054219
4989	5	48	Transaction #489	2025-06-05	430.66	Auto-generated transaction entry #489	2025-06-15 08:47:46.054219
4990	5	44	Transaction #490	2025-05-16	621.16	Auto-generated transaction entry #490	2025-06-15 08:47:46.054219
4991	5	48	Transaction #491	2025-06-09	767.02	Auto-generated transaction entry #491	2025-06-15 08:47:46.054219
4992	5	47	Transaction #492	2025-06-06	787.95	Auto-generated transaction entry #492	2025-06-15 08:47:46.054219
4993	5	45	Transaction #493	2025-06-06	364.88	Auto-generated transaction entry #493	2025-06-15 08:47:46.054219
4994	5	46	Transaction #494	2025-05-28	446.77	Auto-generated transaction entry #494	2025-06-15 08:47:46.054219
4995	5	45	Transaction #495	2025-06-08	246.17	Auto-generated transaction entry #495	2025-06-15 08:47:46.054219
4996	5	44	Transaction #496	2025-06-06	639.45	Auto-generated transaction entry #496	2025-06-15 08:47:46.054219
4997	5	48	Transaction #497	2025-06-05	334.87	Auto-generated transaction entry #497	2025-06-15 08:47:46.054219
4998	5	47	Transaction #498	2025-05-31	743.65	Auto-generated transaction entry #498	2025-06-15 08:47:46.054219
4999	5	48	Transaction #499	2025-06-06	201.81	Auto-generated transaction entry #499	2025-06-15 08:47:46.054219
5000	5	46	Transaction #500	2025-06-09	499.95	Auto-generated transaction entry #500	2025-06-15 08:47:46.054219
\.


--
-- Data for Name: user_achievements; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_achievements (user_id, achievement_id, unlocked_at) FROM stdin;
\.


--
-- Data for Name: user_friends; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_friends (user_id, friend_id, status, requested_at, accepted_at) FROM stdin;
60	59	accepted	2025-06-15 02:27:28.040743	2025-06-15 02:27:44.733499
4	59	accepted	2025-06-15 08:57:55.921814	2025-06-15 09:01:01.491444
3	59	accepted	2025-06-15 08:57:44.50453	2025-06-15 09:01:02.615823
2	59	accepted	2025-06-15 08:57:30.894714	2025-06-15 09:01:03.725712
5	59	accepted	2025-06-15 08:58:08.101142	2025-06-15 09:01:05.029573
6	59	accepted	2025-06-15 08:58:21.952535	2025-06-15 09:01:05.980853
7	59	accepted	2025-06-15 08:58:41.293903	2025-06-15 09:01:06.953612
9	59	accepted	2025-06-15 08:59:08.208512	2025-06-15 09:01:07.939357
8	59	accepted	2025-06-15 08:58:56.51976	2025-06-15 09:01:08.704248
10	59	accepted	2025-06-15 08:59:21.824561	2025-06-15 09:01:09.382806
11	59	accepted	2025-06-15 08:59:33.21924	2025-06-15 09:01:10.041005
12	59	accepted	2025-06-15 09:00:13.185149	2025-06-15 09:01:10.741094
13	59	accepted	2025-06-15 09:00:24.372503	2025-06-15 09:01:11.349657
14	59	accepted	2025-06-15 09:00:34.720668	2025-06-15 09:01:11.964167
15	59	accepted	2025-06-15 09:00:46.854944	2025-06-15 09:01:12.516509
1	59	accepted	2025-06-15 08:57:14.988137	2025-06-15 09:01:14.34103
\.


--
-- Data for Name: user_purchases; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_purchases (id, user_id, item_id, purchased_at) FROM stdin;
3	59	5	2025-06-15 03:25:25.975152
4	59	6	2025-06-15 03:26:51.515738
5	59	21	2025-06-15 03:27:47.010769
6	1	22	2025-06-15 09:21:26.830274
7	1	21	2025-06-15 09:21:30.320936
8	1	23	2025-06-15 09:26:07.18416
9	1	24	2025-06-15 09:27:17.221775
10	1	25	2025-06-15 09:31:24.88677
11	1	26	2025-06-15 09:48:08.995791
12	1	27	2025-06-15 09:52:14.059472
13	1	28	2025-06-15 09:53:04.936311
16	1	29	2025-06-15 10:15:46.077744
17	1	30	2025-06-15 10:15:47.687931
18	1	31	2025-06-15 10:20:32.078861
19	1	32	2025-06-15 10:45:41.865027
20	1	3	2025-06-15 11:03:51.663101
21	1	33	2025-06-15 11:30:30.206987
22	1	34	2025-06-15 11:30:40.104208
23	1	19	2025-06-15 11:40:17.876029
24	1	35	2025-06-15 12:10:55.149049
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, username, first_name, last_name, email, password_hash, created_at, is_deleted, xp, level, points, last_login, preferred_currency, currency_symbol, last_streak_date, current_streak, theme) FROM stdin;
16	ahernandez	Alex	Hernandez	ahernandez@example.com	$2a$10$qUiKD/WZCIfbeFYh2hWJuOtgaljOrqvMgvDVcif8HSJvpolY2gtEK	2025-06-15 01:58:09.665	f	0	1	0	\N	EUR	€	\N	0	light
17	manderson	Mary	Anderson	manderson@example.com	$2a$10$//z24nvqYY5YhdDLhSFcEuKvaJOlPYrXMhj9YURU1MPGHc3YbsRDO	2025-06-15 01:58:21.771	f	0	1	0	\N	EUR	€	\N	0	light
18	nwinters	Nicole	Winters	nwinters@example.com	$2a$10$RzjEGYI2X/708ywkcdXdxOtEwXYLfuldFDvfiiYKZ9IuNSPQW4USK	2025-06-15 01:58:35.009	f	0	1	0	\N	EUR	€	\N	0	light
19	twarner	Tonya	Warner	twarner@example.com	$2a$10$05aPSYh5RiXvPGn4kzFjkOeumpk3ZpGpToExMbHLxqHB5Cu25F4SK	2025-06-15 01:58:50.896	f	0	1	0	\N	EUR	€	\N	0	light
20	rwilliams	Roger	Williams	rwilliams@example.com	$2a$10$PeNJi0TVf5rbX0Cjr0EY8.ML1ioz3X5kjKJ6WdKnN/dsDvZECyIsC	2025-06-15 01:59:03.593	f	0	1	0	\N	EUR	€	\N	0	light
21	agriffin	Ann	Griffin	agriffin@example.com	$2a$10$Qht2JOQkORk.OCf7Nx4cl.WTqXN8xmnh4Q09wB9nei6pLFaWC5Y36	2025-06-15 01:59:15.202	f	0	1	0	\N	EUR	€	\N	0	light
22	bvilla	Bryan	Villa	bvilla@example.com	$2a$10$OhJYDHxdK8LrXtIsBW4H7.O92nzpzzdMO/xad.oM2znwLzXh4Vh4O	2025-06-15 01:59:56.07	f	0	1	0	\N	EUR	€	\N	0	light
23	hgilbert	Hayley	Gilbert	hgilbert@example.com	$2a$10$BvnKkPCGM61ejOR6kd.iy.SaD7qjGZKm4OY7z8nTdEn6KfXcDHPX.	2025-06-15 02:00:10.216	f	0	1	0	\N	EUR	€	\N	0	light
24	eramos	Elizabeth	Ramos	eramos@example.com	$2a$10$yZef.CtoOS6lrtQQckwXJ.9YTgXWfrSQebso2DT4voqcA2k98wgR6	2025-06-15 02:00:24.428	f	0	1	0	\N	EUR	€	\N	0	light
25	sduncan	Steven	Duncan	sduncan@example.com	$2a$10$1d2mvtjY3Cj4VdB9YT8OeubhuNduxaca0aJabbjh.TF71.ZP5x8ji	2025-06-15 02:00:38.084	f	0	1	0	\N	EUR	€	\N	0	light
26	ahoward	Alexandra	Howard	ahoward@example.com	$2a$10$kbuKuqoKU6XVK3K0TCRBeOga29ULn8YksMB1667K1ud0gC.ygMRCS	2025-06-15 02:00:51.446	f	0	1	0	\N	EUR	€	\N	0	light
27	jbaxter	Jeremy	Baxter	jbaxter@example.com	$2a$10$QkXD99ESmjzNNRojvrEogemlTZsiu4972phfUgy3GE8IGzrQjXCoO	2025-06-15 02:01:04.156	f	0	1	0	\N	EUR	€	\N	0	light
28	grodriguez	Guy	Rodriguez	grodriguez@example.com	$2a$10$gyT3iwwExuVQxRUVZqu7Z.Z2xhCwICWgXyZ8dxY./nUvW2LxW0XRW	2025-06-15 02:01:17.223	f	0	1	0	\N	EUR	€	\N	0	light
29	ahill	Andrea	Hill	ahill@example.com	$2a$10$HN/X0qu.MpxgvVdHlhCGzOwvk3D5VYGpTim6inmKbeuzVkSF3pz0i	2025-06-15 02:01:29.119	f	0	1	0	\N	EUR	€	\N	0	light
30	djohnson	Darren	Johnson	djohnson@example.com	$2a$10$Rwdq0fLNiOhKabLpSPfsg.kk4Hx0zXlWFqKHnRlpzxA/8oU5IXrjq	2025-06-15 02:01:42.774	f	0	1	0	\N	EUR	€	\N	0	light
31	tperry	Tracy	Perry	tperry@example.com	$2a$10$5SptaSVyBLnLK61SA2j0devQb91/CqdcVNIkYWzB6viuqjA2O/Q.u	2025-06-15 02:01:54.884	f	0	1	0	\N	EUR	€	\N	0	light
32	jgreene	Joseph	Greene	jgreene@example.com	$2a$10$UaSh/ogbVczPVw1SlDfwd.dt7oKnP5SQUnpgct99KJfZs8nQDbg1W	2025-06-15 02:02:06.198	f	0	1	0	\N	EUR	€	\N	0	light
33	kgomez	Keith	Gomez	kgomez@example.com	$2a$10$kLP54ajW3uSwxBulCjLcbO11cXMs6FrI2dooFcNvrU8hVpSJd11x.	2025-06-15 02:02:16.999	f	0	1	0	\N	EUR	€	\N	0	light
34	jward	Jennifer	Ward	jward@example.com	$2a$10$es5CX4hAcgS34Yhyjcy4H.ABdjeKWKaAg3/mkOdi4jW3.Iqy1yMZ.	2025-06-15 02:02:37.185	f	0	1	0	\N	EUR	€	\N	0	light
35	jbarber	Joseph	Barber	jbarber@example.com	$2a$10$MwQbJfZLxeA8EdoxAO6Zt.2lPqStr..LO9PJWZ3ALyPu.aBVh48Hu	2025-06-15 02:02:50.721	f	0	1	0	\N	EUR	€	\N	0	light
36	mwalker	Megan	Walker	mwalker@example.com	$2a$10$Bb3rs3GSs56lu.5xvs9E/ePgdVxVhO38x/2P/5dknJlOKajDcBwaG	2025-06-15 02:03:10.549	f	0	1	0	\N	EUR	€	\N	0	light
37	sgarza	Shane	Garza	sgarza@example.com	$2a$10$3EUD3JeK/n7.VY9PiOupp.MYLj4xH.3AXGb4igqLae0mC9pU7hyG2	2025-06-15 02:03:22.806	f	0	1	0	\N	EUR	€	\N	0	light
38	nflowers	Nicholas	Flowers	nflowers@example.com	$2a$10$DxO8FTBinGU7ea/vJ7I5Q.nCsfp93QGa1ef7BaIDo8pW5.JIcUyG2	2025-06-15 02:03:36.609	f	0	1	0	\N	EUR	€	\N	0	light
39	msmith	Michael	Smith	msmith@example.com	$2a$10$UUfnPuSGl25kWfjAsVoilObTxgoGM/eIv778zX2c4qBHDUgZphXoC	2025-06-15 02:03:48.688	f	0	1	0	\N	EUR	€	\N	0	light
40	abutler	Alexander	Butler	abutler@example.com	$2a$10$EZxfn3cFoJcdQvaEZhOSy.fO/i3i3KRiTJ8cr2qxEe0Psjl7za3gC	2025-06-15 02:04:02.578	f	0	1	0	\N	EUR	€	\N	0	light
41	pdunn	Patricia	Dunn	pdunn@example.com	$2a$10$v6It0Wyun2P7ckYalP8juueI1YMgRu5KAvFG2QioGayN5BbZ2G1aS	2025-06-15 02:04:13.911	f	0	1	0	\N	EUR	€	\N	0	light
4	akrause	Andrea	Krause	akrause@example.com	$2a$10$URLzIeOn4E7L5HMcgrrOd.6Fb0/zY0e9KRiILY93kTlN/U2p8yUG6	2025-06-15 01:53:36.106	f	0	1	0	2025-06-15 08:57:51.889092	EUR	€	2025-06-15	1	light
3	jsnyder	James	Snyder	jsnyder@example.com	$2a$10$TtEVHSr4HMb9CymHNwW0ZedLsbjJWobmB7O0XAN2hLHGL7RWDmPmq	2025-06-15 01:53:18.763	f	0	1	0	2025-06-15 08:57:39.882591	EUR	€	2025-06-15	1	light
2	jscott	Jennifer	Scott	jscott@example.com	$2a$10$xw3Fd6Ls379E0QqUZ3Oj1u2UbsNN6XgJXQe.q.yMqkws/xHa00IHK	2025-06-15 01:52:31.751	f	0	1	0	2025-06-15 08:57:25.033784	EUR	€	2025-06-15	1	light
5	sharvey	Savannah	Harvey	sharvey@example.com	$2a$10$gVIpl6shJHaMdpk1RmWaG.V8pYCVPZ8IkSbwWIQFlIvlbdd.XQdam	2025-06-15 01:53:54.691	f	0	1	0	2025-06-15 08:58:03.636916	EUR	€	2025-06-15	1	light
6	jgarner	Jason	Garner	jgarner@example.com	$2a$10$sMnFSlGIfl9bdrEnE3MaEeS7..NdAM9R2LSPmNDuDw8icD3KUjJoq	2025-06-15 01:54:16.834	f	0	1	0	2025-06-15 08:58:15.500703	EUR	€	2025-06-15	1	light
7	ballison	Brenda	Allison	ballison@example.com	$2a$10$ouxujmvJQLuqq2hK838Un.KwWJlWYLK.Cdbn5CvxEJEsNVkiO8N1W	2025-06-15 01:54:34.369	f	0	1	0	2025-06-15 08:58:36.630081	EUR	€	2025-06-15	1	light
8	aellis	Andrew	Ellis	aellis@example.com	$2a$10$Tr1Wflur46vjgTOnATAX4uBFys0RP3rCIPic2F4o0dJwBI9T0S2MC	2025-06-15 01:54:50.996	f	0	1	0	2025-06-15 08:58:52.842412	EUR	€	2025-06-15	1	light
9	jjohnson	Justin	Johnson	jjohnson@example.com	$2a$10$H95QuzLJjuW4tqI44Xm6e.l0fCsnh4bSjm.E3ZEqJSNPbj.GNTmxO	2025-06-15 01:56:39.884	f	0	1	0	2025-06-15 08:59:04.113676	EUR	€	2025-06-15	1	light
10	ewhite	Edward	White	ewhite@example.com	$2a$10$GNSA5l7OITu3SX8qMcs5vuGEOVD./IO79P71/yuS6fPmqrmch8sye	2025-06-15 01:56:53.062	f	0	1	0	2025-06-15 08:59:14.945577	EUR	€	2025-06-15	1	light
11	clee	Caroline	Lee	clee@example.com	$2a$10$IjF8KTwmS4SrT8t6Lw29POkcX.yyYz8YiahyM/reHvf70r47U.cOa	2025-06-15 01:57:06.002	f	0	1	0	2025-06-15 08:59:29.37097	EUR	€	2025-06-15	1	light
12	rhartman	Rebecca	Hartman	rhartman@example.com	$2a$10$4/ejr9kJ92c6FTM0kSUzZOlMNRtadiPNr5HvkfQbf4o05ikKkS.p2	2025-06-15 01:57:19.501	f	0	1	0	2025-06-15 09:00:07.70587	EUR	€	2025-06-15	1	light
13	lhernandez	Linda	Hernandez	lhernandez@example.com	$2a$10$py0hWRMbBl691lK3rFGCPOzOVfwNh0XHSbrsj5YZ1WvUPIebW5OvC	2025-06-15 01:57:32.41	f	0	1	0	2025-06-15 09:00:20.996055	EUR	€	2025-06-15	1	light
14	kgutierrez	Kelsey	Gutierrez	kgutierrez@example.com	$2a$10$NvKL/YqhF//6aXzlhqXJOOS5brlxn9Nxs8m7XXGu3gkZktjlrKXK6	2025-06-15 01:57:43.499	f	0	1	0	2025-06-15 09:00:30.915783	EUR	€	2025-06-15	1	light
15	dflores	David	Flores	dflores@example.com	$2a$10$ZU/8phuIVPyyt0hSBYedDO03cdL90YWlS1QaFujFkx7wtxyO2xbAG	2025-06-15 01:57:58.267	f	0	1	0	2025-06-15 09:00:41.875327	EUR	€	2025-06-15	1	light
42	epruitt	Erik	Pruitt	epruitt@example.com	$2a$10$FGothftlwjs.4ErfldOL0Ot8OtMkXkdBJAenOF/1SudLJ9gsYS13u	2025-06-15 02:04:32.906	f	0	1	0	\N	EUR	€	\N	0	light
43	ajohnson	Ashley	Johnson	ajohnson@example.com	$2a$10$TfK/65RmY8Kt2M4bWedIGejLi2C9uXNxlLULp8VTtU6pVyCJGd9fS	2025-06-15 02:04:45.373	f	0	1	0	\N	EUR	€	\N	0	light
44	jsmith	Jenna	Smith	jsmith@example.com	$2a$10$x4Db9WN7Uu2T5R8kB9OE1.08RgoDcc9NjnbbuFVWrgv5Yxs9T2Piy	2025-06-15 02:04:56.205	f	0	1	0	\N	EUR	€	\N	0	light
45	nsmith	Natalie	Smith	nsmith@example.com	$2a$10$HiNcnhrrddQuDK4Qb.dH0eCckMHbzyZqhOvC.XzJ2r07tvPYkb4A6	2025-06-15 02:05:08.215	f	0	1	0	\N	EUR	€	\N	0	light
46	tpatterson	Thomas	Patterson	tpatterson@example.com	$2a$10$bRxHaTAAneAUwBii0iVaKOW2b6VoJ1vtGzGCpsOzgLHy2c605eGW2	2025-06-15 02:05:20.392	f	0	1	0	\N	EUR	€	\N	0	light
47	smurphy	Scott	Murphy	smurphy@example.com	$2a$10$.rn.Op7/X9ZRADkdlke86u76b0AJxfMCGPGRiyevunouvlwWXXQg2	2025-06-15 02:05:33.358	f	0	1	0	\N	EUR	€	\N	0	light
48	ltaylor	Lauren	Taylor	ltaylor@example.com	$2a$10$.SIDUiEeXiDwLCuKcOmhL.9BRHRJ1/anoLY42.qwgMNjGmd3o4l.q	2025-06-15 02:05:49.054	f	0	1	0	\N	EUR	€	\N	0	light
49	cwilliams	Christina	Williams	cwilliams@example.com	$2a$10$GvGIzHrB88k9wZRKEP.Rt.G7Kuz/D5vfwOTtTObW/aj6rzK6RDi9m	2025-06-15 02:06:15.612	f	0	1	0	\N	EUR	€	\N	0	light
50	swaters	Shawn	Waters	swaters@example.com	$2a$10$Ew7Z2Q8xmGleqB8zV0LHAea6Z582oHek/922qD.mtOu9h24BV2LF2	2025-06-15 02:06:28.085	f	0	1	0	\N	EUR	€	\N	0	light
51	dorr	Dennis	Orr	dorr@example.com	$2a$10$ZNYV4UQD3FR08/CZW0uWn.KNEueyst1yP5roSgqryPRS2ntHx0VOa	2025-06-15 02:06:41.745	f	0	1	0	\N	EUR	€	\N	0	light
52	tsmith	Taylor	Smith	tsmith@example.com	$2a$10$oubSSEGtYfk1an4gBGR1eebePVXUHbNpLK2PUPCdpt8MwY.m9gw3C	2025-06-15 02:06:53.402	f	0	1	0	\N	EUR	€	\N	0	light
53	ckrause	Caleb	Krause	ckrause@example.com	$2a$10$vYMsrt/YuzcO.nA/O5/4AOCUewo1MtL/KJ2lt8f2Tm66KFDOIOlwi	2025-06-15 02:07:06.979	f	0	1	0	\N	EUR	€	\N	0	light
54	jskinner	Jennifer	Skinner	jskinner@example.com	$2a$10$.6G3jZsW48GNcHXQAR1yVO.tPLCKUpAEMzHiaHgaLOz7D0SCq4T4S	2025-06-15 02:07:50.135	f	0	1	0	\N	EUR	€	\N	0	light
55	cswanson	Christina	Swanson	cswanson@example.com	$2a$10$uEH7JUhvop4c3Sj.tvk5LebHbVTSzveUDwcVVs66lHPuRNyFHKi5W	2025-06-15 02:08:01.508	f	0	1	0	\N	EUR	€	\N	0	light
56	eharvey	Evan	Harvey	eharvey@example.com	$2a$10$G9KsRzRZbMumjcSCmb.PYePx5v4nPW1skjupsODGyi/0M9sofAntK	2025-06-15 02:08:14.778	f	0	1	0	\N	EUR	€	\N	0	light
57	nhodge	Natalie	Hodge	nhodge@example.com	$2a$10$RUiSaNGzrXTmQgNshoUSXOItTmeWF5tZSa0xs4a8Xg2jkduP9xI7W	2025-06-15 02:08:26.009	f	0	1	0	\N	EUR	€	\N	0	light
58	ljohnson	Larry	Johnson	ljohnson@example.com	$2a$10$cUfzOuGdk1fl2p7lP6/BxOvrZyK8axpCDx.UOTfqanZi8Bu9syuGe	2025-06-15 02:08:39.344	f	0	1	0	\N	EUR	€	\N	0	light
59	dadepremo	Davide	Premoli	dadepremo@stocazzo.com	$2a$10$8V0guBUBmwwHjW3brvaEfeQ.3mad9NNnbuxtnYtR0YqgrwqDu8zfm	2025-06-15 02:09:54.363	f	0	1	20	2025-06-15 10:41:24.130643	USD	$	2025-06-15	1	light
60	admin	admin	admin	admin@stocazzo.com	$2a$10$uQq19Ahy5CZk7CBew1lY0O0oDhorjQTEjip92uTENkxMRb/r9IugO	2025-06-15 02:27:13.006	f	0	1	0	2025-06-15 03:06:49.24803	EUR	€	2025-06-15	1	light
1	kmurray	Kelly	Murray	kmurray@example.com	$2a$10$5m8lSC43UHvfCcsa0foQQ.oKkRq35VNqSP8c1SBA1zTWvnoiR6IYy	2025-06-15 01:52:14.29	f	1000	6	1350	2025-06-15 12:10:42.056973	EUR	€	2025-06-15	5000	light
\.


--
-- Data for Name: xp_givers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.xp_givers (id, name, description, value, is_deleted) FROM stdin;
2	normalLiabilityBonus	Bonus given when a liability is added to the portfolio	-500	f
1	normalAssetBonus	Bonus given when an asset is added to the portfolio	1000	f
\.


--
-- Name: achievements_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.achievements_id_seq', 60, true);


--
-- Name: assets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.assets_id_seq', 12, true);


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_id_seq', 55, true);


--
-- Name: liabilities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.liabilities_id_seq', 2, true);


--
-- Name: login_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.login_history_id_seq', 17, true);


--
-- Name: net_worth_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.net_worth_history_id_seq', 1, false);


--
-- Name: shop_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.shop_items_id_seq', 35, true);


--
-- Name: transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.transactions_id_seq', 5000, true);


--
-- Name: user_purchases_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_purchases_id_seq', 24, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 60, true);


--
-- Name: xp_givers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.xp_givers_id_seq', 1, true);


--
-- Name: achievements achievements_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.achievements
    ADD CONSTRAINT achievements_code_key UNIQUE (code);


--
-- Name: achievements achievements_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.achievements
    ADD CONSTRAINT achievements_pkey PRIMARY KEY (id);


--
-- Name: assets assets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assets
    ADD CONSTRAINT assets_pkey PRIMARY KEY (id);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: liabilities liabilities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.liabilities
    ADD CONSTRAINT liabilities_pkey PRIMARY KEY (id);


--
-- Name: net_worth_history net_worth_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.net_worth_history
    ADD CONSTRAINT net_worth_history_pkey PRIMARY KEY (id);


--
-- Name: shop_items shop_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shop_items
    ADD CONSTRAINT shop_items_pkey PRIMARY KEY (id);


--
-- Name: transactions transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (id);


--
-- Name: categories unique_user_category; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT unique_user_category UNIQUE (user_id, name);


--
-- Name: net_worth_history unique_user_date; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.net_worth_history
    ADD CONSTRAINT unique_user_date UNIQUE (user_id, date);


--
-- Name: user_achievements user_achievements_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_achievements
    ADD CONSTRAINT user_achievements_pkey PRIMARY KEY (user_id, achievement_id);


--
-- Name: user_friends user_friends_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_friends
    ADD CONSTRAINT user_friends_pkey PRIMARY KEY (user_id, friend_id);


--
-- Name: user_purchases user_purchases_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_purchases
    ADD CONSTRAINT user_purchases_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: xp_givers xp_givers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.xp_givers
    ADD CONSTRAINT xp_givers_pkey PRIMARY KEY (id);


--
-- Name: assets assets_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assets
    ADD CONSTRAINT assets_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: categories categories_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: net_worth_history fk_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.net_worth_history
    ADD CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: liabilities liabilities_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.liabilities
    ADD CONSTRAINT liabilities_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: login_history login_history_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.login_history
    ADD CONSTRAINT login_history_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: transactions transactions_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id) ON DELETE SET NULL;


--
-- Name: transactions transactions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: user_achievements user_achievements_achievement_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_achievements
    ADD CONSTRAINT user_achievements_achievement_id_fkey FOREIGN KEY (achievement_id) REFERENCES public.achievements(id) ON DELETE CASCADE;


--
-- Name: user_achievements user_achievements_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_achievements
    ADD CONSTRAINT user_achievements_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: user_friends user_friends_friend_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_friends
    ADD CONSTRAINT user_friends_friend_fk FOREIGN KEY (friend_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: user_friends user_friends_user_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_friends
    ADD CONSTRAINT user_friends_user_fk FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: user_purchases user_purchases_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_purchases
    ADD CONSTRAINT user_purchases_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.shop_items(id);


--
-- Name: user_purchases user_purchases_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_purchases
    ADD CONSTRAINT user_purchases_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

