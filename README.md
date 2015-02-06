![Mana](https://d8izdk6bl4gbi.cloudfront.net/https://d1015h9unskp4y.cloudfront.net/attachments/aefce943-0367-4b97-9ee4-91fdb75d43ac/mana-logo.png)
## Fun automatic project and invoice management.

[![Build Status](https://travis-ci.org/asm-products/mana-rails.svg)](https://travis-ci.org/asm-products/mana-rails)
[![Code Climate](https://codeclimate.com/github/asm-products/mana-rails/badges/gpa.svg)](https://codeclimate.com/github/asm-products/mana-rails)
[![Test Coverage](https://codeclimate.com/github/asm-products/mana-rails/badges/coverage.svg)](https://codeclimate.com/github/asm-products/mana-rails)
<a href="https://assembly.com/mana/bounties"><img src="http://badger.asm.co/mana/badges/tasks.svg" height="20px" alt="Open Tasks" /></a>

## v0.3.0-prealpha.3.0.0
This product is currently in a pre alpha development state and is not yet ready for production use. Please note that the semver file reflects the api version and not the application version.

### The project management, invoicing, team collaboration tool to rule them all!

There are a lot of great invoicing, project management, and team collaboration tools on the market today. The problem is all three of those things are usually handled in two to three different tools. What if one piece of software could effectively manage all aspects of project management, accounting, team management, client management, and sales force management? Mana plans to bring all those small pieces into one easy to use application that every employee in any role within a team will enjoy.

This is a product being built by the Assembly community. You can help push this idea forward by visiting [https://assembly.com/mana](https://assembly.com/mana).

### Development

#### Using Docker

- Install boot2docker (http://boot2docker.io) and fig (http://www.fig.sh/install.html)
- You may consider this for windows: http://stackoverflow.com/questions/27242374/fig-support-on-boot2docker-windows-platform

```
fig build
fig up
fig run web rake db:create
fig run web rake db:migrate
fig run web rake db:seed
```

visit the ip you got from `boot2docker ip` with port 3000 (i.e 192.168.50.1:3000)

#### Local

Install libicu, the way you like / can:

```
sudo apt-get update
sudo apt-get install libicu-dev cmake
```
or
```
brew update
brew install icu4c cmake
```
then
```
bundle install
```

Config your database in `config/database.yml`. Make sure changes are not commit to git!

```
rake db:create
rake db:migrate
rake db:seed
rails s
```

#### Different Teams
Each team is identified by the subdomain of the app. In order to change team localy while development you have to map a domain (with subdomain) to localhost.
- On mac / linux edit `/etc/hosts`
- On windows edit `C:\WINDOWS\SYSTEM32\DRIVERS\ETC\HOSTS`.

For example you added `testteam.example.com`, then visit `testteam.example.com:3000`. Make sure your subdomain matches a given `Team#slug`.

### Tests
First create and migrate the Database
```
rake db:create RAILS_ENV=test
rake db:migrate RAILS_ENV=test
```
Then run tests with
```
rspec
```
or if you have some conflicts
```
bundle exec rspec
```

### How Assembly Works

Assembly products are like open-source and made with contributions from the community. Assembly handles the boring stuff like hosting, support, financing, legal, etc. Once the product launches we collect the revenue and split the profits amongst the contributors.

Visit [https://assembly.com](https://assembly.com) to learn more.
The project management, invoicing, team collaboration tool to rule them all!

There are a lot of great invoicing, project management, and team collaboration tools on the market today. The problem is all three of those things are usually handled in two to three different tools. What if one piece of software could effectively manage all aspects of project management, accounting, team management, client management, and sales force management? Mana plans to bring all those small pieces into one easy to use application that every employee in any role within a team will enjoy.
