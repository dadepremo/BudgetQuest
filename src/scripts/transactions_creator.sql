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
            WHERE c.user_id = random_user_id AND c.type = 'expenses'
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



