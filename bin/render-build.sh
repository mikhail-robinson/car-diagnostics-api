#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
bundle exec rake assets:precompile
bundle exec rake assets:clean

# Only run database setup if DATABASE_URL is set
if [ -n "$DATABASE_URL" ]; then
  echo "Setting up database..."
  bundle exec rake db:prepare
else
  echo "Skipping database setup - DATABASE_URL not set"
fi