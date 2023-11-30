FROM ruby:latest

# RUN echo "deb http://ftp.debian.org/debian bullseye-backports main" > /etc/apt/sources.list.d/backports.list

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y ca-certificates curl gnupg

RUN mkdir -p /etc/apt/keyrings
RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg

ENV NODE_MAJOR=20
RUN echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list

RUN apt-get update -y

RUN apt-get install -y libpq-dev \
      libxml2-dev \
      libxslt-dev \
      mercurial \
      jhead \
      libgd-dev \
      libmagic-dev \
      imagemagick \
      # dependecy for coffee-rails
      nodejs \
      # ruby calls run_cmd on psql
      postgresql-client

# jsbundling-rails is hard-coded to use yarn and bun (???) (https://github.com/rails/jsbundling-rails/issues/176)
RUN corepack enable

COPY moebooru /moebooru
COPY run.sh /moebooru/run.sh

WORKDIR /moebooru

# [Temporary Workaround] If running on Windows using stupid CRLF line endings, convert them to LF
RUN apt-get install -y dos2unix
RUN dos2unix $(find . -type f)

RUN bundle install

ENTRYPOINT ["sh", "run.sh"]
