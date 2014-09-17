## README

Rails demo for creating applications with
* Responsive layouts with Bootstrap 3
* Update forms with Simple Form
* Integrations to external REST API's
* Creating REST API interface
* Localizations
* Deployment to Heroku

## Getting Started

1. Install [Git](http://git-scm.com)

2. Install database

   [MySQL](http://www.mysql.com)

   [PostgreSQL](http://www.postgresql.org)

3. Install [Ruby Version Manager](https://rvm.io)

        curl -L https://get.rvm.io | bash -s stable

4. Install Ruby with RVM

        rvm install ruby-2.1.2
        rvm use ruby-2.1.2
        rvm gemset create rails-demo
        rvm use ruby-2.1.2@rails-demo

5. Install Rails

        gem install --no-rdoc --no-ri rails

6. Create Rails application

        rails new rails-app-demo -d mysql
        or
        rails new rails-app-demo -d postgresql
        cd rails-app-demo

7. Initialize git

        git init
        git add .
        git commit -m "Initial commit"

8. Start coding

        rails s
