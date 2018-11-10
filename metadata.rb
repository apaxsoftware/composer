name             'composer'
source_url       'https://github.com/apaxsoftware/composer'
issues_url       'https://github.com/apaxsoftware/composer/issues'
maintainer       'Chris Allen'
maintainer_email 'chris@apaxsoftware.com'
license          'Apache 2.0'
description      'Installs and configures composer'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.0'
chef_version     '>= 12.1' if respond_to?(:chef_version)

supports         'ubuntu'
