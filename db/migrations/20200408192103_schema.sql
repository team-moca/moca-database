-- migrate:up
CREATE TYPE status AS ENUM ('DEFAULT', 'PINNED', 'ARCHIVED');


CREATE SEQUENCE users_user_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1;

CREATE TABLE "users" (
    "user_id" integer DEFAULT nextval('users_user_id_seq') NOT NULL,
    "phone_number" character varying(255) NOT NULL,
    "email" character varying(255),
    "displayname" character varying(255) NOT NULL,
    CONSTRAINT "users_user_id" PRIMARY KEY ("user_id")
) WITH (oids = false);


CREATE SEQUENCE chats_chat_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1;

CREATE TABLE "chats" (
    "chat_id" integer DEFAULT nextval('chats_chat_id_seq') NOT NULL,
    "user_id" integer NOT NULL,
    "is_muted" boolean NOT NULL,
    "status" status NOT NULL,
    "service_type" uuid NOT NULL,
    CONSTRAINT "chats_chat_id" PRIMARY KEY ("chat_id"),
    CONSTRAINT "chats_user_id_fkey" FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE NOT DEFERRABLE
) WITH (oids = false);


CREATE SEQUENCE services_service_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1;

CREATE TABLE "services" (
    "service_id" integer DEFAULT nextval('services_service_id_seq') NOT NULL,
    "user_id" integer NOT NULL,
    "service_type" uuid NOT NULL,
    "settings" json NOT NULL,
    CONSTRAINT "services_service_id" PRIMARY KEY ("service_id"),
    CONSTRAINT "services_user_id_fkey" FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE NOT DEFERRABLE
) WITH (oids = false);

-- migrate:down
DROP TABLE "chats";
DROP TABLE "services";
DROP TABLE "users";
DROP TYPE status;
DROP SEQUENCE chats_chat_id_seq;
DROP SEQUENCE services_service_id_seq;
DROP SEQUENCE users_user_id_seq;