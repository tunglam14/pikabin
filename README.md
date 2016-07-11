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

What does pikabin has
---------------------

* Security:

    - Encrypt content with random password: [[...]](https://github.com/tunglam14/pikabin/blob/master/lib/cryptor.rb#L12)
    - [Don't log password](https://github.com/tunglam14/pikabin/blob/master/config/initializers/filter_parameter_logging.rb#L4), [request URI](https://github.com/tunglam14/pikabin/blob/master/config/environments/production.rb#L49) in production environment
    - Remove expired document immediately [[...]](https://github.com/tunglam14/pikabin/blob/master/app/models/document.rb#L114)
    - Remove document after reading

* Friendliness:

    - Front-end framework: Semantic-UI
    - Editor: ACE Editor
    - Syntax highlighting: SyntaxHighlighter
