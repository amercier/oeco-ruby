oeco
====

oeco architectes website


Continuous deployment
---------------------

Continuous integration is managed by [Travis CI](https://travis-ci.org/).
Code analysis is performed by [Code Climate](https://codeclimate.com/).
Code coverage is reported to [Coveralls](https://coveralls.io/).
Dependency tracking is managed by [Gemnasium](https://gemnasium.com/).

[![Build Status](http://img.shields.io/travis/amercier/oeco-ruby/master.svg?style=flat-square)](https://travis-ci.org/amercier/oeco-ruby/builds)
[![Code Climate](http://img.shields.io/codeclimate/github/amercier/oeco-ruby.svg?style=flat-square)](https://codeclimate.com/github/amercier/oeco)
[![Test Coverage](http://img.shields.io/coveralls/amercier/oeco-ruby/master.svg?style=flat-square)](https://coveralls.io/r/amercier/oeco-ruby?branch=master)
[![Dependency Status](http://img.shields.io/gemnasium/amercier/oeco-ruby.svg?style=flat-square)](https://gemnasium.com/amercier/oeco-ruby)

Pushes on master branch are automatically deployed on
[http://oeco-staging.herokuapp.com](http://oeco-staging.herokuapp.com).

Tags are automatically deployed on
[http://oeco.herokuapp.com](http://oeco.herokuapp.com).

Step 1: deploy to master

    git push

Step 2: test at [http://oeco-staging.herokuapp.com](http://oeco-staging.herokuapp.com)

Step 3: deploy to production

    git tag vX.Y.Z
    git push --tags


Heroku initial deployment
-------------------------

Heroku configuration:

    heroku keys:add

Staging environment:

    git remote add staging git@heroku.com:oeco-staging.git
    git push staging
    heroku run rake db:setup --app oeco-staging
    heroku run rake db:migrate --app oeco-staging
    heroku config:add STAGING=true --app oeco-staging
    heroku config:add USERNAME=oeco --app oeco-staging
    heroku config:add PASSWORD=[secure] --app oeco-staging

Production environment:

    git remote add production git@heroku.com:oeco.git
    git push production
    heroku run rake db:setup --app oeco
    heroku run rake db:migrate --app oeco
