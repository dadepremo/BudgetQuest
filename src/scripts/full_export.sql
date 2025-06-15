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
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories (id, user_id, name, type, is_deleted, created_at) FROM stdin;
\.


--
-- Data for Name: liabilities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.liabilities (id, user_id, name, type, amount, amount_remaining, interest_rate, start_date, due_date, notes, is_active, created_at, last_updated, is_deleted) FROM stdin;
\.


--
-- Data for Name: login_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.login_history (id, user_id, login_date) FROM stdin;
1	59	2025-06-15
2	60	2025-06-15
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
1	Golden Badge	A shiny golden badge for financial excellence.	150	Badge	t	2025-06-14 13:54:58.178461
2	Streak Master Badge	Awarded for maintaining a 30-day savings streak.	200	Badge	t	2025-06-14 13:54:58.178461
3	Dark Mode Theme	Switch to a sleek dark interface.	300	Theme	t	2025-06-14 13:54:58.178461
4	Ocean Theme	A relaxing ocean-blue UI theme.	250	Theme	t	2025-06-14 13:54:58.178461
5	Daily Double Boost	Double your reward points for the next 24 hours.	500	Boost	t	2025-06-14 13:54:58.178461
6	Expense Tracker Pro	Unlocks advanced analytics and forecasting.	750	Boost	t	2025-06-14 13:54:58.178461
7	Pixel Avatar Pack	Customize your avatar with retro pixel art.	200	Fun	t	2025-06-14 13:54:58.178461
8	Confetti Celebration	Adds confetti animations on achievements.	100	Fun	t	2025-06-14 13:54:58.178461
9	Financial Toolkit	Downloadable PDF with advanced budgeting templates.	400	Tool	t	2025-06-14 13:54:58.178461
10	Weekly Budget Reminder	Set up automated weekly budget push alerts.	150	Tool	t	2025-06-14 13:54:58.178461
11	Silver Star Badge	Awarded for reaching silver-level savings goals.	100	Badge	t	2025-06-14 14:24:06.550364
12	Holiday Theme	Festive holiday colors and icons for your app.	280	Theme	t	2025-06-14 14:24:06.550364
13	XP Booster	Earn double experience points for 12 hours.	450	Boost	t	2025-06-14 14:24:06.550364
14	Custom Avatar Frames	Decorate your avatar with exclusive frames.	300	Fun	t	2025-06-14 14:24:06.550364
15	Spending Insights Pro	Unlock deeper spending insights and reports.	800	Boost	t	2025-06-14 14:24:06.550364
16	Monthly Savings Challenge	Participate in monthly savings challenges.	350	Boost	t	2025-06-14 14:24:06.550364
17	Animated Badge Pack	Get badges with cool animations.	220	Fun	t	2025-06-14 14:24:06.550364
18	Personalized Budget Planner	Custom budget planner tailored to your habits.	500	Tool	t	2025-06-14 14:24:06.550364
19	Daily Motivation Quotes	Receive inspiring quotes daily in the app.	120	Fun	t	2025-06-14 14:24:06.550364
20	Backup & Sync Feature	Securely backup and sync your data across devices.	650	Tool	t	2025-06-14 14:24:06.550364
\.


--
-- Data for Name: transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transactions (id, user_id, category_id, name, date, amount, description, created_at) FROM stdin;
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
\.


--
-- Data for Name: user_purchases; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_purchases (id, user_id, item_id, purchased_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, username, first_name, last_name, email, password_hash, created_at, is_deleted, xp, level, points, last_login, preferred_currency, currency_symbol, last_streak_date, current_streak, theme) FROM stdin;
1	kmurray	Kelly	Murray	kmurray@example.com	$2a$10$5m8lSC43UHvfCcsa0foQQ.oKkRq35VNqSP8c1SBA1zTWvnoiR6IYy	2025-06-15 01:52:14.29	f	0	1	0	\N	EUR	€	\N	0	light
2	jscott	Jennifer	Scott	jscott@example.com	$2a$10$xw3Fd6Ls379E0QqUZ3Oj1u2UbsNN6XgJXQe.q.yMqkws/xHa00IHK	2025-06-15 01:52:31.751	f	0	1	0	\N	EUR	€	\N	0	light
3	jsnyder	James	Snyder	jsnyder@example.com	$2a$10$TtEVHSr4HMb9CymHNwW0ZedLsbjJWobmB7O0XAN2hLHGL7RWDmPmq	2025-06-15 01:53:18.763	f	0	1	0	\N	EUR	€	\N	0	light
4	akrause	Andrea	Krause	akrause@example.com	$2a$10$URLzIeOn4E7L5HMcgrrOd.6Fb0/zY0e9KRiILY93kTlN/U2p8yUG6	2025-06-15 01:53:36.106	f	0	1	0	\N	EUR	€	\N	0	light
5	sharvey	Savannah	Harvey	sharvey@example.com	$2a$10$gVIpl6shJHaMdpk1RmWaG.V8pYCVPZ8IkSbwWIQFlIvlbdd.XQdam	2025-06-15 01:53:54.691	f	0	1	0	\N	EUR	€	\N	0	light
6	jgarner	Jason	Garner	jgarner@example.com	$2a$10$sMnFSlGIfl9bdrEnE3MaEeS7..NdAM9R2LSPmNDuDw8icD3KUjJoq	2025-06-15 01:54:16.834	f	0	1	0	\N	EUR	€	\N	0	light
7	ballison	Brenda	Allison	ballison@example.com	$2a$10$ouxujmvJQLuqq2hK838Un.KwWJlWYLK.Cdbn5CvxEJEsNVkiO8N1W	2025-06-15 01:54:34.369	f	0	1	0	\N	EUR	€	\N	0	light
8	aellis	Andrew	Ellis	aellis@example.com	$2a$10$Tr1Wflur46vjgTOnATAX4uBFys0RP3rCIPic2F4o0dJwBI9T0S2MC	2025-06-15 01:54:50.996	f	0	1	0	\N	EUR	€	\N	0	light
9	jjohnson	Justin	Johnson	jjohnson@example.com	$2a$10$H95QuzLJjuW4tqI44Xm6e.l0fCsnh4bSjm.E3ZEqJSNPbj.GNTmxO	2025-06-15 01:56:39.884	f	0	1	0	\N	EUR	€	\N	0	light
10	ewhite	Edward	White	ewhite@example.com	$2a$10$GNSA5l7OITu3SX8qMcs5vuGEOVD./IO79P71/yuS6fPmqrmch8sye	2025-06-15 01:56:53.062	f	0	1	0	\N	EUR	€	\N	0	light
11	clee	Caroline	Lee	clee@example.com	$2a$10$IjF8KTwmS4SrT8t6Lw29POkcX.yyYz8YiahyM/reHvf70r47U.cOa	2025-06-15 01:57:06.002	f	0	1	0	\N	EUR	€	\N	0	light
12	rhartman	Rebecca	Hartman	rhartman@example.com	$2a$10$4/ejr9kJ92c6FTM0kSUzZOlMNRtadiPNr5HvkfQbf4o05ikKkS.p2	2025-06-15 01:57:19.501	f	0	1	0	\N	EUR	€	\N	0	light
13	lhernandez	Linda	Hernandez	lhernandez@example.com	$2a$10$py0hWRMbBl691lK3rFGCPOzOVfwNh0XHSbrsj5YZ1WvUPIebW5OvC	2025-06-15 01:57:32.41	f	0	1	0	\N	EUR	€	\N	0	light
14	kgutierrez	Kelsey	Gutierrez	kgutierrez@example.com	$2a$10$NvKL/YqhF//6aXzlhqXJOOS5brlxn9Nxs8m7XXGu3gkZktjlrKXK6	2025-06-15 01:57:43.499	f	0	1	0	\N	EUR	€	\N	0	light
15	dflores	David	Flores	dflores@example.com	$2a$10$ZU/8phuIVPyyt0hSBYedDO03cdL90YWlS1QaFujFkx7wtxyO2xbAG	2025-06-15 01:57:58.267	f	0	1	0	\N	EUR	€	\N	0	light
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
60	admin	admin	admin	admin@stocazzo.com	$2a$10$uQq19Ahy5CZk7CBew1lY0O0oDhorjQTEjip92uTENkxMRb/r9IugO	2025-06-15 02:27:13.006	f	0	1	0	2025-06-15 02:27:17.694108	EUR	€	2025-06-15	1	light
59	dadepremo	Davide	Premoli	dadepremo@stocazzo.com	$2a$10$8V0guBUBmwwHjW3brvaEfeQ.3mad9NNnbuxtnYtR0YqgrwqDu8zfm	2025-06-15 02:09:54.363	f	0	1	0	2025-06-15 02:27:38.611361	USD	$	2025-06-15	1	light
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

SELECT pg_catalog.setval('public.assets_id_seq', 1, false);


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_id_seq', 1, false);


--
-- Name: liabilities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.liabilities_id_seq', 1, false);


--
-- Name: login_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.login_history_id_seq', 2, true);


--
-- Name: net_worth_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.net_worth_history_id_seq', 1, false);


--
-- Name: shop_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.shop_items_id_seq', 20, true);


--
-- Name: transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.transactions_id_seq', 1, false);


--
-- Name: user_purchases_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_purchases_id_seq', 1, false);


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

