# Action Path Server
Rails server that communicates with the Action Path mobile app.

## Dependencies

Use Ruby >= 2.2.0.  All the other dependencies are in the Gemfile

## Installation

1. `bundle install`
2. `rake db:migrate`
3. `sudo apt-get install imagemagick -y`

## To Run It

On your computer:
```shell
rails server
```

Or on c9:
```shell
rails s -b $IP -p $PORT
```
    
## REST API

### /places

Methods: GET

### /places/:place_id/issues

Methods: GET

### /users

Methods: POST

### /users/:user_id

Methods: GET

### /user/:user_id/subscriptions

Methods: POST, GET

### /issues

Methods: GET

### /issues/:issue_id

Methods: GET

### /subscriptions/:subscription_id

Methods: DELETE

### /logs

Methods: POST
