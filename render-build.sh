#!/usr/bin/env bash
set -e

echo "Setting up Bundler..."
bundle config set --local deployment 'true'
bundle config set --local without 'development test'
bundle install --jobs=4 --retry=3

echo "Precompiling assets..."
bundle exec rake assets:precompile

echo "Running database migrations..."
bundle exec rake db:migrate
