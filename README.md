pikabin
=======

Paste tool with inline commenting support.

Installation
------------

```bash
# Cloning repo
git clone git@github.com:tunglam14/pikabin.git
cd pikabin/

# Setup
export RAILS_ENV=production
bundle install

# Config db
vim config/database.yml
cat config/database.yml
#production:
#  adapter: sqlite3
#  pool: 5
#  timeout: 5000
#  database: /var/run/pikabin_production.sqlite3

bundle exec rake db:migrate
bundle exec rake assets:precompile

# Start service with puma
SECRET_KEY_BASE=$(bundle exec rake secret) bundle exec puma
# Listening on tcp://127.0.0.1:8080
```
