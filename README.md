# Proctor

__proc·tor__ _/ˈpräktər/_ _noun_: a person appointed to keep watch over students at examinations.

Proctor is a web front-end for RSpec and MiniTest.

## Clients (Developers)

Developers only need RSpec/MiniTest and a Proctor Formatter.

* [proctor-rspec](http://github.com/c00lryguy/proctor-rspec)
* [proctor-minitest](http://github.com/c00lryguy/proctor-minitest)

## Server

The Proctor server depends on node, redis, and juggernaut.

### Installation

#### Install [Node.js](http://nodejs.org)

If you're using the [Brew](http://mxcl.github.com/homebrew) package management system, use that:

    brew install node

Or follow the [Node build instructions](https://github.com/joyent/node/wiki/Installation)

#### Install [Redis](http://code.google.com/p/redis)

If you're using the Brew package, use that:

    brew install redis
    
Or follow the [Redis build instructions](http://redis.io/download)

#### Install Juggernaut

Juggernaut is distributed by [npm](http://npmjs.org), you'll need to [install that](http://npmjs.org) first if you haven't already.

    npm install -g juggernaut

#### Install Proctor

Simply install Proctor through RubyGems:

    gem install proctor

> Note: If you are using RVM, make sure you are in the default or global gemset, so the binary will always be available to you.

### Usage

#### Running Redis

Run the Redis server by running the following:

    redis-server

#### Running Juggernaut

Run the Juggernaut server by running the following:

    juggernaut

#### Running Proctor

Once you have installed Proctor, you can now run the server by running the `proctor` binary:

    proctor

You can run Proctor in daemon mode by passing `-d` to the binary.  
Run `proctor --help` to see the full options available.

> I would suggest using Monit or God to run/monitor Redis, Juggernaut, and Proctor.

## TODO

* Test::Unit support
* CI support