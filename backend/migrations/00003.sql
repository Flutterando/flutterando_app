-- TITLE: Add User tabel
-- DESCRIPTION: Creating the user table

-- Creation user
CREATE TABLE USERS (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL,
  roles TEXT [] NOT NULL DEFAULT '{"standard"}',
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
-@@-

-- Creating set timestamp to updated_at 
CREATE TRIGGER tg_set_timestamp_from_users
    BEFORE UPDATE ON USERS
    FOR EACH ROW
    EXECUTE PROCEDURE fn_set_timestamp();
-@@-