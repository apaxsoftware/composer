name             'composer_test'
maintainer       'Chris Allen'
maintainer_email 'chris@apaxsoftware.com'
license          'Apache 2.0'
description      'Acceptance tests for composer'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.1'

depends          'composer'

recipe           'composer_test::default', 'Test example for default recipe'

supports         'ubuntu'
