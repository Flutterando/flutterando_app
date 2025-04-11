-- TITLE: Timestamp fn
-- DESCRIPTION: Creating the function to the Timestamp

-- Timestamp Function
CREATE OR REPLACE FUNCTION fn_set_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;
-@@-