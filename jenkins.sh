#!/bin/bash

source "$HOME/.rvm/scripts/rvm"
git submodule update --init
rvm use "1.9.2@unrea"
gem install bundler
bundle install
rm -f db/development.sqlite3
rake db:setup --trace
rake --trace

