# Action Path Server
Rails server that communicates with the Action Path mobile app.

## Dependencies

* Ruby >= 2.2.0
* Rails >= 4.2

## Installation

After downloading the source, create the database:

    rake db:migrate

To run:

    rails server
    
## REST API

### /users

Methods: POST

### /users/:user_id

Methods: GET

### /issues

Methods: GET

### /issues/:issue_id

Methods: GET

### /subscriptions/user/:user_id

Methods: POST

### /subscriptions/:subscription_id

Methods: DELETE