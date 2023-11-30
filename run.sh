#!/bin/sh

if [ ! -e /data/inited ]; then
    echo "Initialize moebooru. Reseting database..."
    bundle exec rake db:reset
    bundle exec rake db:migrate
    touch /data/inited
fi

bundle exec rails assets:precompile
bundle exec rails server
