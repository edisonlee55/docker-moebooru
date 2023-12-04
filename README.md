# docker-moebooru

Dockerfile for [moebooru](https://github.com/moebooru/moebooru)

## Install Submodule
```bash
$ git submodule update --init --recursive
```

## Setup environment variables
1. Copy `.env.example` to `.env` and edit it.

## Setup config files
1. Copy `moebooru/config/database.yml.example` to `config/database.yml` and edit it.
2. Copy `moebooru/config/local_config.rb.example` to `config/local_config.rb` and edit it.

## Usage
Build Docker image:
```bash
$ docker compose build
```

Start:
```bash
$ docker compose up -d
```
You might need to wait for 5 ~ 10 minutes for assets precompile.


Stop:
```bash
$ docker compose stop
```
