Action Path Server
==================

Rails server that communicates with the Action Path mobile app.

Installation
------------

1. `bundle install`
2. `rake db:migrate`
3. `sudo apt-get install imagemagick -y`

To Run It
----------

On your computer:
```shell
rails server
```

Or on c9:
```shell
rails s -b $IP -p $PORT
```

Deploying to Production
-----------------------

1. Make sure to compile the assets: `RAILS_ENV=production bin/rake assets:precompile`
2. Make sure to put a secret token for production in `config/secrets.yml`
3. Make sure to `sudo chown -R www-data:www-data public/` so the web user can save images
