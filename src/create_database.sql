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
	CONSTRAINT users_email_key UNIQUE (email),
	CONSTRAINT users_pkey PRIMARY KEY (id),
	CONSTRAINT users_username_key UNIQUE (username)
);

CREATE TABLE public.xp_givers (
    id serial PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description VARCHAR(200) NOT NULL,
    value INT DEFAULT 50,
    is_deleted BOOLEAN DEFAULT false
);

-- truncate
TRUNCATE assets, categories, liabilities, net_worth_history, transactions RESTART IDENTITY CASCADE;
UPDATE users SET xp = 0, level = 1, points = 0;





