CREATE TABLE token (
  token_id       SERIAL PRIMARY KEY NOT NULL,
  token_key      VARCHAR(255) NOT NULL, -- Refresh | Access
  value          VARCHAR(1024) NOT NULL,
  date_created   TIMESTAMP WITHOUT TIME ZONE DEFAULT (now() AT TIME ZONE 'utc'),
  date_updated   TIMESTAMP WITHOUT TIME ZONE DEFAULT (now() AT TIME ZONE 'utc')
);

CREATE TABLE user_profile (
  user_profile_id   SERIAL PRIMARY KEY NOT NULL,
  name              VARCHAR(255) NOT NULL,
  email             VARCHAR(1024) NOT NULL,
  access_token_id   INTEGER NULL,
  date_created      TIMESTAMP WITHOUT TIME ZONE DEFAULT (now() AT TIME ZONE 'utc'),
  date_updated      TIMESTAMP WITHOUT TIME ZONE DEFAULT (now() AT TIME ZONE 'utc'),

  CONSTRAINT user_profile_token_access_token_id FOREIGN KEY (access_token_id)
      REFERENCES token (token_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE user_refresh_token (
  user_refresh_token_id   SERIAL PRIMARY KEY NOT NULL,
  user_profile_id         INTEGER NOT NULL,
  refresh_token_id        INTEGER NOT NULL,
  is_active               BIT DEFAULT 0::BIT NOT NULL,
  date_created            TIMESTAMP WITHOUT TIME ZONE DEFAULT (now() AT TIME ZONE 'utc'),
  date_updated            TIMESTAMP WITHOUT TIME ZONE DEFAULT (now() AT TIME ZONE 'utc'),

  CONSTRAINT user_profile_token_user_profile_id FOREIGN KEY (user_profile_id)
      REFERENCES user_profile (user_profile_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,

  CONSTRAINT user_profile_token_refresh_token_id FOREIGN KEY (refresh_token_id)
      REFERENCES token (token_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);
