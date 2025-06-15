CREATE TABLE public.assets (
	id serial4 NOT NULL,
	user_id int4 NULL,
	"name" varchar(100) NOT NULL,
	"type" varchar(50) NOT NULL,
	value numeric(12, 2) NOT NULL,
	acquired_date date NULL,
	notes text NULL,
	is_liquid bool DEFAULT false NULL,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	last_updated timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	is_deleted bool DEFAULT false NULL,
	CONSTRAINT assets_pkey PRIMARY KEY (id),
	CONSTRAINT assets_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE
);

CREATE TABLE public.liabilities (
    id serial4 NOT NULL,
    user_id int4 NOT NULL,
    "name" varchar(100) NOT NULL,
    type varchar(50) NOT NULL,
    amount numeric(12, 2) NOT NULL,
    amount_remaining numeric(12, 2) NULL,
    interest_rate numeric(5, 2) NULL,
    start_date date NULL,
    due_date date NULL,
    notes text NULL,
    is_active bool DEFAULT true,
    created_at timestamp DEFAULT CURRENT_TIMESTAMP,
    last_updated timestamp DEFAULT CURRENT_TIMESTAMP,
    is_deleted bool DEFAULT false,
    CONSTRAINT liabilities_pkey PRIMARY KEY (id),
    CONSTRAINT liabilities_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE
);

CREATE TABLE public.shop_items (
	id serial4 NOT NULL,
	"name" text NOT NULL,
	description text NULL,
	price int4 NOT NULL,
	category text NULL,
	available bool DEFAULT true NULL,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	CONSTRAINT shop_items_pkey PRIMARY KEY (id)
);

CREATE TABLE public.user_purchases (
	id serial4 NOT NULL,
	user_id int4 NOT NULL,
	item_id int4 NOT NULL,
	purchased_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	CONSTRAINT user_purchases_pkey PRIMARY KEY (id),
	CONSTRAINT user_purchases_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.shop_items(id),
	CONSTRAINT user_purchases_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id)
);

CREATE TABLE public.net_worth_history (
	id serial4 NOT NULL,
	user_id int4 NOT NULL,
	"date" date NOT NULL,
	assets_value numeric(12, 2) NOT NULL,
	liabilities_value numeric(12, 2) NOT NULL,
	net_worth numeric(12, 2) NOT NULL,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	CONSTRAINT net_worth_history_pkey PRIMARY KEY (id),
	CONSTRAINT unique_user_date UNIQUE (user_id, date),
	CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE
);

CREATE TABLE public.achievements (
    id SERIAL PRIMARY KEY,
    code VARCHAR(50) UNIQUE NOT NULL,        -- Unique key for programmatic use, e.g., 'FIRST_EXPENSE'
    name VARCHAR(100) NOT NULL,              -- Human-readable title
    description TEXT NOT NULL,               -- What the user must do
    points_reward INT DEFAULT 0,             -- Points earned on unlock
    xp_reward INT DEFAULT 0,                 -- XP earned on unlock
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE public.user_achievements (
    user_id INT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    achievement_id INT NOT NULL REFERENCES achievements(id) ON DELETE CASCADE,
    unlocked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, achievement_id)
);

CREATE TABLE public.categories (
    id serial4 NOT NULL,
    user_id int4 NOT NULL,
    name varchar(50) NOT NULL,
    type varchar(20) NOT NULL CHECK (type IN ('income', 'expense')),
    is_deleted bool DEFAULT false,
    created_at timestamp DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT categories_pkey PRIMARY KEY (id),
    CONSTRAINT categories_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE
);

CREATE TABLE public.transactions (
    id serial4 NOT NULL,
    user_id int4 NOT NULL,
    category_id int4 NULL,
    name varchar(50) NOT NULL,
    date date NOT NULL,
    amount numeric(12, 2) NOT NULL,
    description text NULL,
    created_at timestamp DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT transactions_pkey PRIMARY KEY (id),
    CONSTRAINT transactions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE,
    CONSTRAINT transactions_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id) ON DELETE SET NULL
);

CREATE TABLE public.users (
	id serial4 NOT NULL,
	username varchar(50) NOT NULL,
	first_name varchar(50) NOT NULL,
	last_name varchar(50) NOT NULL,
	email varchar(100) NOT NULL,
	password_hash text NOT NULL,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	is_deleted bool DEFAULT false NULL,
	xp int4 DEFAULT 0 NULL,
	"level" int4 DEFAULT 1 NULL,
	points int4 DEFAULT 1000 NULL,
	last_login timestamp NULL,
	preferred_currency VARCHAR(10) DEFAULT 'EUR',
	currency_symbol VARCHAR(5) DEFAULT '€',
	last_streak_date date,
    current_streak int DEFAULT 0,
    theme VARCHAR(20) DEFAULT 'light';
	CONSTRAINT users_email_key UNIQUE (email),
	CONSTRAINT users_pkey PRIMARY KEY (id),
	CONSTRAINT users_username_key UNIQUE (username)
);

CREATE TABLE public.login_history (
	id serial4 NOT NULL,
	user_id int4 NOT NULL,
	login_date date NOT NULL,
	CONSTRAINT login_history_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id)
);

CREATE TABLE public.user_friends (
    user_id int4 NOT NULL,
    friend_id int4 NOT NULL,
    status varchar(20) NOT NULL DEFAULT 'pending', -- 'pending', 'accepted', 'blocked'
    requested_at timestamp DEFAULT CURRENT_TIMESTAMP,
    accepted_at timestamp NULL,
    CONSTRAINT user_friends_pkey PRIMARY KEY (user_id, friend_id),
    CONSTRAINT user_friends_user_fk FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE,
    CONSTRAINT user_friends_friend_fk FOREIGN KEY (friend_id) REFERENCES public.users(id) ON DELETE CASCADE,
    CONSTRAINT user_friends_no_self_friend CHECK (user_id <> friend_id)
);


CREATE TABLE public.xp_givers (
    id serial PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description VARCHAR(200) NOT NULL,
    value INT DEFAULT 50,
    is_deleted BOOLEAN DEFAULT false
);

-- truncate
TRUNCATE TABLE
    assets,
    categories,
    liabilities,
    login_history,
    net_worth_history,
    transactions,
    user_achievements,
    user_friends,
    user_purchases,
    users
RESTART IDENTITY CASCADE;





