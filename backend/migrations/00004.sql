-- TITLE: Add User tabel
-- DESCRIPTION: Creating the user table

-- Creation user
CREATE TABLE POSTS (
  id SERIAL PRIMARY KEY,
  description TEXT NOT NULL,
  link VARCHAR(255),
  image VARCHAR(255),
  image_subtitle VARCHAR(255),
  users INT NOT NULL, 
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  CONSTRAINT posts_fk_users
        FOREIGN KEY(users) 
	        REFERENCES USERS(id)
);
-@@-

-- Creating set timestamp to updated_at 
CREATE TRIGGER tg_set_timestamp_from_posts
    BEFORE UPDATE ON POSTS
    FOR EACH ROW
    EXECUTE PROCEDURE fn_set_timestamp();
-@@-