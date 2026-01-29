DO $$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM information_schema.columns
    WHERE table_name = 'messages'
      AND column_name = 'id'
      AND data_type = 'uuid'
  ) THEN
    ALTER TABLE messages
      ALTER COLUMN id SET DEFAULT gen_random_uuid();
  ELSE
    ALTER TABLE messages
      ALTER COLUMN id SET DEFAULT gen_random_uuid()::text;
  END IF;
END $$;
