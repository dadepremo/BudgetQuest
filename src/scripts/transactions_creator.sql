DO $$
DECLARE
    tot INTEGER := 500;
    i INTEGER;
    random_user_id INTEGER := 8;
    random_category_id INTEGER;
BEGIN
    FOR i IN 1..tot LOOP
        BEGIN
            SELECT id INTO random_category_id
            FROM public.categories c
            WHERE c.user_id = random_user_id AND c.type = 'expense'
            ORDER BY RANDOM()
            LIMIT 1;

            -- If no category was found, handle it
            IF random_category_id IS NULL THEN
                random_category_id := 26; -- Fallback default category
            END IF;
        EXCEPTION WHEN NO_DATA_FOUND THEN
            random_category_id := 26; -- Another fallback in case SELECT fails
        END;

        INSERT INTO public.transactions (
            user_id,
            category_id,
            "name",
            "date",
            amount,
            description
        )
        VALUES (
            random_user_id,
            random_category_id,
            'Transaction #' || i,
            CURRENT_DATE - (RANDOM() * 30)::INT,
            ROUND((50 + RANDOM() * 950)::numeric, 2),
            'Auto-generated transaction entry #' || i
        );
    END LOOP;
END $$;

DO $$
DECLARE
    user_id INT := 5;

    income_categories TEXT[] := ARRAY[
        'Salary', 'Freelance', 'Investment', 'Rental Income', 'Dividends', 'Cashback', 'Gifts', 'Royalties'
    ];

    expense_categories TEXT[] := ARRAY[
        'Groceries', 'Rent', 'Utilities', 'Entertainment', 'Transportation', 'Healthcare',
        'Dining Out', 'Clothing', 'Travel', 'Subscriptions'
    ];

    cat_name TEXT;
    cat_type TEXT;
    selected_income TEXT[];
    selected_expense TEXT[];
BEGIN
    -- Randomly pick 3-6 income categories
    SELECT ARRAY(
        SELECT unnest(income_categories) ORDER BY random() LIMIT (3 + floor(random() * 4))::int
    ) INTO selected_income;

    -- Randomly pick 5-8 expense categories
    SELECT ARRAY(
        SELECT unnest(expense_categories) ORDER BY random() LIMIT (5 + floor(random() * 4))::int
    ) INTO selected_expense;

    -- Insert income categories
    FOREACH cat_name IN ARRAY selected_income LOOP
        cat_type := 'income';
        INSERT INTO public.categories (user_id, "name", "type")
        VALUES (user_id, cat_name, cat_type)
        ON CONFLICT DO NOTHING;
    END LOOP;

    -- Insert expense categories
    FOREACH cat_name IN ARRAY selected_expense LOOP
        cat_type := 'expense';
        INSERT INTO public.categories (user_id, "name", "type")
        VALUES (user_id, cat_name, cat_type)
        ON CONFLICT DO NOTHING;
    END LOOP;
END
$$;

