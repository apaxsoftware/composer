# Inspec test for recipe composer::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

node = json('/tmp/node.json')

describe command('composer') do
  it { should exist }
end

describe command("sudo su -c 'composer diagnose' #{node['composer']['keys_user']}") do
  its('exit_status') { should cmp 0 }
end
