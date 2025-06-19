
-- users
DROP TABLE IF EXISTS public.users;

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
	points int4 DEFAULT 0 NOT NULL,
	last_login timestamp NULL,
	preferred_currency varchar(10) DEFAULT 'EUR'::character varying NULL,
	currency_symbol varchar(5) DEFAULT '€'::character varying NULL,
	last_streak_date date NULL,
	current_streak int4 DEFAULT 0 NULL,
	theme varchar(20) DEFAULT 'light'::character varying NULL,
	CONSTRAINT users_email_key UNIQUE (email),
	CONSTRAINT users_pkey PRIMARY KEY (id),
	CONSTRAINT users_username_key UNIQUE (username)
);

-- xp_givers
DROP TABLE IF EXISTS public.xp_givers;

CREATE TABLE public.xp_givers (
	id serial4 NOT NULL,
	"name" varchar(50) NOT NULL,
	description varchar(200) NOT NULL,
	value int4 DEFAULT 50 NULL,
	is_deleted bool DEFAULT false NULL,
	CONSTRAINT xp_givers_pkey PRIMARY KEY (id)
);

-- achievements
DROP TABLE IF EXISTS public.achievements;

CREATE TABLE public.achievements (
	id serial4 NOT NULL,
	code varchar(50) NOT NULL,
	"name" varchar(100) NOT NULL,
	description text NOT NULL,
	points_reward int4 DEFAULT 0 NULL,
	xp_reward int4 DEFAULT 0 NULL,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	CONSTRAINT achievements_code_key UNIQUE (code),
	CONSTRAINT achievements_pkey PRIMARY KEY (id)
);

INSERT INTO public.achievements (code, "name", description, points_reward, xp_reward, created_at) VALUES('FIRST_EXPENSE', 'First Expense', 'Log your first expense', 100, 500, '2025-06-12 16:13:54.576');
INSERT INTO public.achievements (code, "name", description, points_reward, xp_reward, created_at) VALUES('FIRST_INCOME', 'First Income', 'Log your first income', 100, 1000, '2025-06-12 16:13:54.576');
INSERT INTO public.achievements (code, "name", description, points_reward, xp_reward, created_at) VALUES('LOGIN_STREAK_14_DAYS', '14 days!', 'You logged in for 14 days straight.&Good job!', 200, 500, '2025-06-12 21:51:27.089');
INSERT INTO public.achievements (code, "name", description, points_reward, xp_reward, created_at) VALUES('FIRST_BIG_EXPENSE', 'This was a big one!', 'Log your first big expense', 1000, 1000, '2025-06-12 16:13:54.576');
INSERT INTO public.achievements (code, "name", description, points_reward, xp_reward, created_at) VALUES('FIRST_BIG_INCOME', 'Get that check!', 'Log your first big income', 1000, 5000, '2025-06-12 16:13:54.576');
INSERT INTO public.achievements (code, "name", description, points_reward, xp_reward, created_at) VALUES('LEVEL_10', 'Level Up!', 'Reach level 10', 100, 500, '2025-06-12 16:13:54.576');
INSERT INTO public.achievements (code, "name", description, points_reward, xp_reward, created_at) VALUES('LEVEL_50', 'Half way there!', 'Get to level 50', 1000, 5000, '2025-06-12 16:13:54.576');
INSERT INTO public.achievements (code, "name", description, points_reward, xp_reward, created_at) VALUES('LEVEL_100', 'Conquered the peak ... or did you?', 'Get to level 100', 1000, 10000, '2025-06-12 16:13:54.576');
INSERT INTO public.achievements (code, "name", description, points_reward, xp_reward, created_at) VALUES('LOGIN_STREAK_7_DAYS', '7 days!', 'You logged in for 7 days straight.&Good job!', 100, 500, '2025-06-12 21:43:31.284');
INSERT INTO public.achievements (code, "name", description, points_reward, xp_reward, created_at) VALUES('WEEKLY_SAVER', 'Weekly Saver', 'Save money every week for a month', 500, 2000, '2025-06-13 11:46:21.288');
INSERT INTO public.achievements (code, "name", description, points_reward, xp_reward, created_at) VALUES('MONTHLY_BUDGET_MASTER', 'Monthly Budget Master', 'Stick to your budget for a month', 200, 1200, '2025-06-13 11:46:21.288');
INSERT INTO public.achievements (code, "name", description, points_reward, xp_reward, created_at) VALUES('CATEGORY_TRACKER', 'Category Tracker', 'Track spending in 5 different categories', 200, 800, '2025-06-13 11:46:21.288');
INSERT INTO public.achievements (code, "name", description, points_reward, xp_reward, created_at) VALUES('DAILY_LOGGER_7', 'Daily Logger', 'Log a transaction every day for a week', 300, 900, '2025-06-13 11:46:21.288');
INSERT INTO public.achievements (code, "name", description, points_reward, xp_reward, created_at) VALUES('DAILY_LOGGER_30', 'Consistent Logger', 'Log a transaction daily for 30 days', 1000, 3000, '2025-06-13 11:46:21.288');
INSERT INTO public.achievements (code, "name", description, points_reward, xp_reward, created_at) VALUES('SAVED_1000', 'Saved 1000', 'Save a total of 1000 credits', 500, 2500, '2025-06-13 11:46:21.288');
INSERT INTO public.achievements (code, "name", description, points_reward, xp_reward, created_at) VALUES('SAVED_10000', 'Saved 10k', 'Save a total of 10,000 credits', 1000, 5000, '2025-06-13 11:46:21.288');
INSERT INTO public.achievements (code, "name", description, points_reward, xp_reward, created_at) VALUES('TRACKED_100_EXPENSES', 'Expense Analyst', 'Track 100 expenses', 700, 2000, '2025-06-13 11:46:21.288');
INSERT INTO public.achievements (code, "name", description, points_reward, xp_reward, created_at) VALUES('TRACKED_100_INCOMES', 'Income Tracker', 'Track 100 income entries', 700, 2000, '2025-06-13 11:46:21.288');
INSERT INTO public.achievements (code, "name", description, points_reward, xp_reward, created_at) VALUES('NO_SPENDING_WEEK', 'No-Spend Week', 'Spend nothing for 7 days straight', 1000, 1500, '2025-06-13 11:46:21.288');
INSERT INTO public.achievements (code, "name", description, points_reward, xp_reward, created_at) VALUES('ADDED_10_CATEGORIES', 'Organizer', 'Add 10 custom categories', 300, 900, '2025-06-13 11:46:21.288');
INSERT INTO public.achievements (code, "name", description, points_reward, xp_reward, created_at) VALUES('ADDED_50_CATEGORIES', 'Master Organizer', 'Add 50 custom categories', 600, 1800, '2025-06-13 11:46:21.288');
INSERT INTO public.achievements (code, "name", description, points_reward, xp_reward, created_at) VALUES('BUDGET_SET_5', 'Budget Beginner', 'Set 5 budgets', 300, 700, '2025-06-13 11:46:21.288');
INSERT INTO public.achievements (code, "name", description, points_reward, xp_reward, created_at) VALUES('BUDGET_SET_20', 'Budget Pro', 'Set 20 budgets', 800, 1600, '2025-06-13 11:46:21.288');
INSERT INTO public.achievements (code, "name", description, points_reward, xp_reward, created_at) VALUES('BUDGET_GOAL_REACHED', 'Goal Achiever', 'Reach a budget goal', 400, 1000, '2025-06-13 11:46:21.288');
INSERT INTO public.achievements (code, "name", description, points_reward, xp_reward, created_at) VALUES('EXPENSE_TAGGER', 'Tag It!', 'Tag 50 expenses', 300, 600, '2025-06-13 11:46:21.288');
INSERT INTO public.achievements (code, "name", description, points_reward, xp_reward, created_at) VALUES('INCOME_TAGGER', 'Smart Earner', 'Tag 50 incomes', 300, 600, '2025-06-13 11:46:21.288');
INSERT INTO public.achievements (code, "name", description, points_reward, xp_reward, created_at) VALUES('REVIEWED_STATS', 'Data Lover', 'Check your statistics page', 100, 250, '2025-06-13 11:46:21.288');
INSERT INTO public.achievements (code, "name", description, points_reward, xp_reward, created_at) VALUES('EXPORT_CSV', 'Export Master', 'Export your data to CSV', 100, 300, '2025-06-13 11:46:21.288');
INSERT INTO public.achievements (code, "name", description, points_reward, xp_reward, created_at) VALUES('THEMES_CHANGED', 'Style Changer', 'Try both light and dark themes', 200, 400, '2025-06-13 11:46:21.288');
INSERT INTO public.achievements (code, "name", description, points_reward, xp_reward, created_at) VALUES('FIRST_GOAL_SET', 'First Goal!', 'Set your first saving goal', 200, 500, '2025-06-13 11:46:21.288');
INSERT INTO public.achievements (code, "name", description, points_reward, xp_reward, created_at) VALUES('GOAL_REACHED', 'Goal Met!', 'Reach a saving goal', 400, 1200, '2025-06-13 11:46:21.288');
INSERT INTO public.achievements (code, "name", description, points_reward, xp_reward, created_at) VALUES('GOAL_REACHED_5X', 'Serial Achiever', 'Reach 5 saving goals', 800, 2000, '2025-06-13 11:46:21.288');
INSERT INTO public.achievements (code, "name", description, points_reward, xp_reward, created_at) VALUES('TRACKED_100_TRANSACTIONS', 'Money Mover', 'Track 100 transactions total', 600, 1800, '2025-06-13 11:46:21.288');
INSERT INTO public.achievements (code, "name", description, points_reward, xp_reward, created_at) VALUES('TRACKED_1000_TRANSACTIONS', 'Money Manager', 'Track 1000 transactions total', 1200, 3500, '2025-06-13 11:46:21.288');
INSERT INTO public.achievements (code, "name", description, points_reward, xp_reward, created_at) VALUES('DELETED_TRANSACTION', 'Oops!', 'Delete a transaction', 50, 150, '2025-06-13 11:46:21.288');
INSERT INTO public.achievements (code, "name", description, points_reward, xp_reward, created_at) VALUES('FIRST_TAG_CREATED', 'Custom Tagger', 'Create a custom tag', 150, 400, '2025-06-13 11:46:21.288');
INSERT INTO public.achievements (code, "name", description, points_reward, xp_reward, created_at) VALUES('FREQUENT_LOGGER', 'Habitual Logger', 'Log at least once a day for 60 days', 1500, 5000, '2025-06-13 11:46:21.288');
INSERT INTO public.achievements (code, "name", description, points_reward, xp_reward, created_at) VALUES('LONG_STREAK_100', '100-Day Streak!', 'Login 100 days in a row', 2000, 6000, '2025-06-13 11:46:21.288');
INSERT INTO public.achievements (code, "name", description, points_reward, xp_reward, created_at) VALUES('APP_SHARED', 'Sharing is Caring', 'Share the app with a friend', 200, 1000, '2025-06-13 11:46:21.288');
INSERT INTO public.achievements (code, "name", description, points_reward, xp_reward, created_at) VALUES('BILL_REMINDER_SET', 'On Schedule', 'Set a bill reminder', 100, 250, '2025-06-13 11:46:21.288');
INSERT INTO public.achievements (code, "name", description, points_reward, xp_reward, created_at) VALUES('BILL_REMINDER_COMPLETED', 'Paid On Time', 'Mark a bill as paid', 200, 600, '2025-06-13 11:46:21.288');
INSERT INTO public.achievements (code, "name", description, points_reward, xp_reward, created_at) VALUES('WEEKLY_SUMMARY_READ', 'Check In', 'Read your weekly summary', 150, 300, '2025-06-13 11:46:21.288');
INSERT INTO public.achievements (code, "name", description, points_reward, xp_reward, created_at) VALUES('DAILY_NOTES_WRITTEN_10', 'Note Taker', 'Write 10 notes in your transactions', 250, 800, '2025-06-13 11:46:21.288');
INSERT INTO public.achievements (code, "name", description, points_reward, xp_reward, created_at) VALUES('DAILY_NOTES_WRITTEN_100', 'Writer', 'Write 100 notes', 600, 2000, '2025-06-13 11:46:21.288');
INSERT INTO public.achievements (code, "name", description, points_reward, xp_reward, created_at) VALUES('CURRENCY_SWITCHED', 'Explorer', 'Switch your app currency', 100, 300, '2025-06-13 11:46:21.288');
INSERT INTO public.achievements (code, "name", description, points_reward, xp_reward, created_at) VALUES('LONG_TERM_USER', 'Old Friend', 'Use the app for 365 days', 2500, 8000, '2025-06-13 11:46:21.288');
INSERT INTO public.achievements (code, "name", description, points_reward, xp_reward, created_at) VALUES('PROFILE_PICTURE_SET', 'Looking Good', 'Set a profile picture', 150, 400, '2025-06-13 11:46:21.288');
INSERT INTO public.achievements (code, "name", description, points_reward, xp_reward, created_at) VALUES('DAILY_SPENDING_LIMIT', 'Disciplined', 'Set a daily spending limit', 300, 1000, '2025-06-13 11:46:21.288');
INSERT INTO public.achievements (code, "name", description, points_reward, xp_reward, created_at) VALUES('LIMIT_REACHED_5X', 'Budget Slayer', 'Reach your spending limit 5 times', 500, 1500, '2025-06-13 11:46:21.288');
INSERT INTO public.achievements (code, "name", description, points_reward, xp_reward, created_at) VALUES('CATEGORIES_CLEANUP', 'Organizer Pro', 'Delete 10 unused categories', 250, 800, '2025-06-13 11:46:21.288');
INSERT INTO public.achievements (code, "name", description, points_reward, xp_reward, created_at) VALUES('ARCHIVED_OLD_DATA', 'Archivist', 'Archive old transactions', 200, 500, '2025-06-13 11:46:21.288');
INSERT INTO public.achievements (code, "name", description, points_reward, xp_reward, created_at) VALUES('TAGGED_ALL_ENTRIES', 'Tag Champ', 'All entries tagged for a full month', 800, 2500, '2025-06-13 11:46:21.288');
INSERT INTO public.achievements (code, "name", description, points_reward, xp_reward, created_at) VALUES('DAILY_SUMMARY_OPENED', 'Quick Peek', 'Open the daily summary 10 times', 100, 400, '2025-06-13 11:46:21.288');
INSERT INTO public.achievements (code, "name", description, points_reward, xp_reward, created_at) VALUES('TWEAKED_SETTINGS', 'Personalizer', 'Update your settings/preferences', 100, 300, '2025-06-13 11:46:21.288');
INSERT INTO public.achievements (code, "name", description, points_reward, xp_reward, created_at) VALUES('DAILY_REMINDER_SET', 'Reminded', 'Set a daily reminder', 150, 350, '2025-06-13 11:46:21.288');
INSERT INTO public.achievements (code, "name", description, points_reward, xp_reward, created_at) VALUES('DAILY_REMINDER_USED_30', 'Disciplined Tracker', 'Use reminders 30 days in a row', 800, 2500, '2025-06-13 11:46:21.288');
INSERT INTO public.achievements (code, "name", description, points_reward, xp_reward, created_at) VALUES('LOGIN_STREAK_30_DAYS', '30 days!', 'You logged in for 30 days straight.&Good job!', 500, 1000, '2025-06-12 21:52:13.289');

-- shop_items
DROP TABLE IF EXISTS public.shop_items;

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

INSERT INTO public.shop_items ("name", description, price, category, available, created_at) VALUES('Dark Mode Theme', 'Switch to a sleek dark interface.', 300, 'Theme', true, '2025-06-14 13:54:58.178');
INSERT INTO public.shop_items ("name", description, price, category, available, created_at) VALUES('Daily Motivation Quotes', 'Receive inspiring quotes daily in the app.', 120, 'Fun', true, '2025-06-14 14:24:06.550');
INSERT INTO public.shop_items ("name", description, price, category, available, created_at) VALUES('Dashboard Title Animation', 'The dashboard title slides in and pulses.', 100, 'Animation', true, '2025-06-15 03:00:57.006');
INSERT INTO public.shop_items ("name", description, price, category, available, created_at) VALUES('Make your username BIG', 'The username is visualized in caps lock.', 50, 'Graphic', true, '2025-06-15 09:17:32.536');
INSERT INTO public.shop_items ("name", description, price, category, available, created_at) VALUES('Expenses are no good!', 'Make the expenses total RED.', 50, 'Cosmetics', true, '2025-06-15 09:23:53.749');
INSERT INTO public.shop_items ("name", description, price, category, available, created_at) VALUES('Incomes are so good!', 'Make the expenses total GREEN.', 50, 'Cosmetics', true, '2025-06-15 09:23:53.749');
INSERT INTO public.shop_items ("name", description, price, category, available, created_at) VALUES('Streak calendar', 'Be able to visualize your login streak calendar.', 50, 'Cosmetics', true, '2025-06-15 09:28:52.871');
INSERT INTO public.shop_items ("name", description, price, category, available, created_at) VALUES('Celebrate your new assets!', 'Have confetti celebrations when you add a new asset.', 50, 'Animation', true, '2025-06-15 09:47:09.219');
INSERT INTO public.shop_items ("name", description, price, category, available, created_at) VALUES('Liabilities are no good!', 'Make the expenses total RED.', 50, 'Cosmetics', true, '2025-06-15 09:50:37.636');
INSERT INTO public.shop_items ("name", description, price, category, available, created_at) VALUES('Assets are so good!', 'Make the expenses total GREEN.', 50, 'Cosmetics', true, '2025-06-15 09:50:37.636');
INSERT INTO public.shop_items ("name", description, price, category, available, created_at) VALUES('Income pie chart', 'Visualize your income divided by categories in a pie chart.', 50, 'Functionality', true, '2025-06-15 10:02:00.098');
INSERT INTO public.shop_items ("name", description, price, category, available, created_at) VALUES('Expenses pie chart', 'Visualize your expenses divided by categories in a pie chart.', 50, 'Functionality', true, '2025-06-15 10:02:00.098');
INSERT INTO public.shop_items ("name", description, price, category, available, created_at) VALUES('Net Worth details', 'Visualize your net worth details.', 50, 'Functionality', true, '2025-06-15 10:19:21.751');
INSERT INTO public.shop_items ("name", description, price, category, available, created_at) VALUES('Bicolor Xp Bar', 'Animate your xp bar with two colors.', 50, 'Animation', true, '2025-06-15 10:43:29.544');
INSERT INTO public.shop_items ("name", description, price, category, available, created_at) VALUES('Fire it up!', 'Light your streak button on fire.', 50, 'Cosmetics', true, '2025-06-15 11:26:36.423');
INSERT INTO public.shop_items ("name", description, price, category, available, created_at) VALUES('Refreshing', 'Animate your refresh button.', 50, 'Animation', true, '2025-06-15 11:28:01.407');
INSERT INTO public.shop_items ("name", description, price, category, available, created_at) VALUES('Golden Badge', 'A shiny golden badge for financial excellence.', 150, 'Badge', false, '2025-06-14 13:54:58.178');
INSERT INTO public.shop_items ("name", description, price, category, available, created_at) VALUES('Streak Master Badge', 'Awarded for maintaining a 30-day savings streak.', 200, 'Badge', false, '2025-06-14 13:54:58.178');
INSERT INTO public.shop_items ("name", description, price, category, available, created_at) VALUES('Ocean Theme', 'A relaxing ocean-blue UI theme.', 250, 'Theme', false, '2025-06-14 13:54:58.178');
INSERT INTO public.shop_items ("name", description, price, category, available, created_at) VALUES('Daily Double Boost', 'Double your reward points for the next 24 hours.', 500, 'Boost', false, '2025-06-14 13:54:58.178');
INSERT INTO public.shop_items ("name", description, price, category, available, created_at) VALUES('Expense Tracker Pro', 'Unlocks advanced analytics and forecasting.', 750, 'Boost', false, '2025-06-14 13:54:58.178');
INSERT INTO public.shop_items ("name", description, price, category, available, created_at) VALUES('Confetti Celebration', 'Adds confetti animations on achievements.', 100, 'Fun', false, '2025-06-14 13:54:58.178');
INSERT INTO public.shop_items ("name", description, price, category, available, created_at) VALUES('Financial Toolkit', 'Downloadable PDF with advanced budgeting templates.', 400, 'Tool', false, '2025-06-14 13:54:58.178');
INSERT INTO public.shop_items ("name", description, price, category, available, created_at) VALUES('Weekly Budget Reminder', 'Set up automated weekly budget push alerts.', 150, 'Tool', false, '2025-06-14 13:54:58.178');
INSERT INTO public.shop_items ("name", description, price, category, available, created_at) VALUES('Silver Star Badge', 'Awarded for reaching silver-level savings goals.', 100, 'Badge', false, '2025-06-14 14:24:06.550');
INSERT INTO public.shop_items ("name", description, price, category, available, created_at) VALUES('Holiday Theme', 'Festive holiday colors and icons for your app.', 280, 'Theme', false, '2025-06-14 14:24:06.550');
INSERT INTO public.shop_items ("name", description, price, category, available, created_at) VALUES('XP Booster', 'Earn double experience points for 12 hours.', 450, 'Boost', false, '2025-06-14 14:24:06.550');
INSERT INTO public.shop_items ("name", description, price, category, available, created_at) VALUES('Spending Insights Pro', 'Unlock deeper spending insights and reports.', 800, 'Boost', false, '2025-06-14 14:24:06.550');
INSERT INTO public.shop_items ("name", description, price, category, available, created_at) VALUES('Monthly Savings Challenge', 'Participate in monthly savings challenges.', 350, 'Boost', false, '2025-06-14 14:24:06.550');
INSERT INTO public.shop_items ("name", description, price, category, available, created_at) VALUES('Animated Badge Pack', 'Get badges with cool animations.', 220, 'Fun', false, '2025-06-14 14:24:06.550');
INSERT INTO public.shop_items ("name", description, price, category, available, created_at) VALUES('Personalized Budget Planner', 'Custom budget planner tailored to your habits.', 500, 'Tool', false, '2025-06-14 14:24:06.550');
INSERT INTO public.shop_items ("name", description, price, category, available, created_at) VALUES('TransACTING', 'Animate the add transaction button.', 50, 'Animation', true, '2025-06-15 12:10:06.053');
INSERT INTO public.shop_items ("name", description, price, category, available, created_at) VALUES('Welcome!', 'Animate the welcome message.', 50, 'Animation', true, '2025-06-15 12:10:06.053');
INSERT INTO public.shop_items ("name", description, price, category, available, created_at) VALUES('Points animation', 'Animate the points balance.', 50, 'Animation', true, '2025-06-15 12:10:06.053');
INSERT INTO public.shop_items ("name", description, price, category, available, created_at) VALUES('Liabilities animation', 'Animate the liabilities amount.', 50, 'Animation', true, '2025-06-15 12:10:06.053');
INSERT INTO public.shop_items ("name", description, price, category, available, created_at) VALUES('Assets animation', 'Animate the assets value.', 50, 'Animation', true, '2025-06-15 12:10:06.053');
INSERT INTO public.shop_items ("name", description, price, category, available, created_at) VALUES('Expenses animation', 'Animate the expenses amount.', 50, 'Animation', true, '2025-06-15 12:10:06.053');
INSERT INTO public.shop_items ("name", description, price, category, available, created_at) VALUES('Income animation', 'Animate the income amount.', 50, 'Animation', true, '2025-06-15 12:10:06.053');

-- app_settings
DROP TABLE IF EXISTS public.app_settings;

CREATE TABLE public.app_settings (
	"key" varchar(100) NOT NULL,
	value text NOT NULL,
	description text NULL,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
	CONSTRAINT app_settings_pkey PRIMARY KEY (key)
);

INSERT INTO public.app_settings ("key", value, description, updated_at) VALUES('app.version', '1.0.1', 'Current application version', '2025-06-16 19:25:03.440');
INSERT INTO public.app_settings ("key", value, description, updated_at) VALUES('env.mode', 'PROD', 'Current environment mode: dev, staging, production', '2025-06-16 19:25:03.440');
INSERT INTO public.app_settings ("key", value, description, updated_at) VALUES('build.date', '19-06-2025', 'Date of last build or deploy', '2025-06-16 19:25:03.440');

-- categories
DROP TABLE IF EXISTS public.categories;

CREATE TABLE public.categories (
	id serial4 NOT NULL,
	user_id int4 NOT NULL,
	"name" varchar(50) NOT NULL,
	"type" varchar(20) NULL,
	is_deleted bool DEFAULT false NULL,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	CONSTRAINT categories_pkey PRIMARY KEY (id),
	CONSTRAINT categories_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE
);

-- user_purchases
DROP TABLE IF EXISTS public.user_purchases;

CREATE TABLE public.user_purchases (
	id serial4 NOT NULL,
	user_id int4 NOT NULL,
	item_id int4 NOT NULL,
	purchased_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	CONSTRAINT user_purchases_pkey PRIMARY KEY (id),
	CONSTRAINT user_purchases_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.shop_items(id),
	CONSTRAINT user_purchases_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE
);

-- user_friends
DROP TABLE IF EXISTS public.user_friends;

CREATE TABLE public.user_friends (
	user_id int4 NOT NULL,
	friend_id int4 NOT NULL,
	status varchar(20) DEFAULT 'pending'::character varying NOT NULL,
	requested_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	accepted_at timestamp NULL,
	CONSTRAINT user_friends_no_self_friend CHECK ((user_id <> friend_id)),
	CONSTRAINT user_friends_pkey PRIMARY KEY (user_id, friend_id),
	CONSTRAINT user_friends_friend_fk FOREIGN KEY (friend_id) REFERENCES public.users(id) ON DELETE CASCADE,
	CONSTRAINT user_friends_user_fk FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE
);

-- user_achievements
DROP TABLE IF EXISTS public.user_achievements;

CREATE TABLE public.user_achievements (
	user_id int4 NOT NULL,
	achievement_id int4 NOT NULL,
	unlocked_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	CONSTRAINT user_achievements_pkey PRIMARY KEY (user_id, achievement_id),
	CONSTRAINT user_achievements_achievement_id_fkey FOREIGN KEY (achievement_id) REFERENCES public.achievements(id) ON DELETE CASCADE,
	CONSTRAINT user_achievements_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE
);

-- transactions
DROP TABLE IF EXISTS public.transactions;

CREATE TABLE public.transactions (
	id serial4 NOT NULL,
	user_id int4 NOT NULL,
	category_id int4 NULL,
	"name" varchar(150) NOT NULL,
	"date" date NOT NULL,
	amount numeric(12, 2) NOT NULL,
	description text NULL,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	CONSTRAINT transactions_pkey PRIMARY KEY (id),
	CONSTRAINT transactions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE
);

-- net_worth_history
DROP TABLE IF EXISTS public.net_worth_history;

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

-- login_history
DROP TABLE IF EXISTS public.login_history;

CREATE TABLE public.login_history (
	id serial4 NOT NULL,
	user_id int4 NOT NULL,
	login_date date NOT NULL,
	CONSTRAINT login_history_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE
);

-- liabilities
DROP TABLE IF EXISTS public.liabilities;

CREATE TABLE public.liabilities (
	id serial4 NOT NULL,
	user_id int4 NOT NULL,
	"name" varchar(100) NOT NULL,
	"type" varchar(50) NOT NULL,
	amount_remaining numeric(12, 2) NULL,
	interest_rate numeric(5, 2) NULL,
	start_date date NULL,
	due_date date NULL,
	notes text NULL,
	is_active bool DEFAULT true NULL,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	last_updated timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	is_deleted bool DEFAULT false NULL,
	payment_frequency varchar(20) NULL,
	next_payment_due date NULL,
	minimum_payment numeric(12, 2) NULL,
	liability_status varchar(50) NULL,
	category varchar(50) NULL,
	total_paid numeric(12, 2) DEFAULT 0 NULL,
	last_payment_date date NULL,
	creditor_name varchar(100) NULL,
	creditor_contact varchar(150) NULL,
	reminder_enabled bool DEFAULT false NULL,
	reminder_days_before int4 DEFAULT 7 NULL,
	monthly_payment numeric(12, 2) NULL,
	amount numeric(12, 2) NOT NULL,
	CONSTRAINT liabilities_pkey PRIMARY KEY (id),
	CONSTRAINT liabilities_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE
);

-- assets
DROP TABLE IF EXISTS public.assets;

CREATE TABLE public.assets (
	id serial4 NOT NULL,
	user_id int4 NULL,
	category_id int4 NULL,
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
	CONSTRAINT assets_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id) ON DELETE SET NULL,
	CONSTRAINT assets_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE
);

-- goals
DROP TABLE IF EXISTS public.goals;

CREATE TABLE public.goals (
	id serial4 NOT NULL,
	user_id int4 NOT NULL,
	"name" varchar(100) NOT NULL,
	description text NULL,
	goal_type varchar(30) NOT NULL,
	target_amount numeric(12, 2) NOT NULL,
	current_amount numeric(12, 2) DEFAULT 0 NULL,
	start_date date NOT NULL,
	end_date date NOT NULL,
	is_completed bool DEFAULT false NULL,
	is_deleted bool DEFAULT false NULL,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	CONSTRAINT goals_pkey PRIMARY KEY (id),
	CONSTRAINT fk_goals_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE
);