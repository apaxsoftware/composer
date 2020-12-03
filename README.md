# composer Cookbook

[![Build Status](https://travis-ci.com/apaxsoftware/composer.svg?branch=master)](https://travis-ci.com/apaxsoftware/composer)

Description
===========

This cookbook installs the php dependency manager `composer` _if and only if_ `php` is already installed.

Requirements
============

## Platforms:

* Ubuntu

Usage
=====

To install composer with keys for the `vagrant` user, your cookbook should have:

```ruby
  $ cat Berksfile
  source 'https://supermarket.chef.io'

  metadata

  cookbook "composer", :github => 'apaxsoftware/composer'
```

```ruby
  $ cat attributes/default.rb
  node.default['composer']['keys_user'] = 'vagrant'
```

```ruby
  $ cat recipes/system.rb
  # Install php WITHOUT apache
  apt_repository 'php7.2' do
    uri 'ppa:ondrej/php'
  end
  apt_package 'php7.2-fpm'

  # Install composer
  include_recipe 'composer'
```

Attributes
==========

* `node['composer']['keys_user']` - The username of the user to install public keys for. Defaults to `root`

Recipes
=======

* `default` - Installs `composer` and checks its validity.

# Local Development

When running `kitchen converge` or `kitchen verify` with vagrant, prefix them with the following:

```bash
$ COMPOSER_USER=vagrant kitchen verify
```

License and Authors
===================

Author:: Chris Allen <chris@apaxsoftware.com>

  Copyright:: 2018, APAX Software

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
