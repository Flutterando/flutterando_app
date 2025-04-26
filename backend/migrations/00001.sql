-- TITLE: Start migration sys
-- DESCRIPTION: Creating the table that manages migrations 

-- Creation sys_migration
CREATE TABLE sys_migration (
  migration_id SERIAL PRIMARY KEY,
  migration_file VARCHAR(100) UNIQUE NOT NULL,
  migration_content VARCHAR(255),
  migration_description VARCHAR(255),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
-@@-