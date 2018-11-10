#
# Cookbook:: composer_test
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

ruby_block 'Save node attributes' do
  block do
    File.write(
      '/tmp/node.json',
      { composer: node['composer'] }.to_json
    )
  end
end

# Install PHP
apt_update 'update'
package 'php-fpm'

# Install composer
include_recipe 'composer::default'
