# moca-database

Database for the moca project.

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Setup

1. Copy `.env.example` to `.env`. The default values will do for a development environment, but make sure to use save credentials for the production environment.
2. `docker-compose up`

That's all. You can now reach postgres at port `5432` with the credentials you chose.

## Migrations

We use [dbmate](https://github.com/amacneil/dbmate) to manage migrations for this project.

To alter the database, create a new migration:

```bash
dbmate new describe_what_you_did
```

A new file will be created at `db/migrations/`. Fill in the sql commands for doing the changes (up) and rolling back the changes (down).

Then, run `dbmate up` to apply your changes.
