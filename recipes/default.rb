#
# Cookbook:: composer
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# Install composer if not already
ruby_block 'ensure_composer_installed' do
  block do
    php_installed = !shell_out("sh -c 'command -v php'").stdout.empty?
    unless php_installed
      raise Chef::Exceptions::MissingLibrary, 'You must have php installed to continue!'
    end

    composer_installed = !shell_out("sh -c 'command -v composer'").stdout.empty?
    unless composer_installed
      SIG_URL = 'https://composer.github.io/installer.sig'.freeze
      INSTALLER_URL = 'https://getcomposer.org/installer'.freeze

      # Get actual checksum
      if (cmd = shell_out("curl --fail -s #{SIG_URL}")).exitstatus != 0
        raise Chef::Exceptions::InvalidRemoteFileURI, SIG_URL
      end
      actual_checksum = cmd.stdout.chomp

      # Download installer and calculate checksum
      if shell_out("wget #{INSTALLER_URL} -O /tmp/composer-setup.php").exitstatus != 0
        raise Chef::Exceptions::InvalidRemoteFileURI, INSTALLER_URL
      end
      shell_out('chmod 0777 /tmp/composer-setup.php')
      tested_checksum = shell_out('shasum -a 384 /tmp/composer-setup.php | cut -c-96').stdout.chomp

      # Bail if checksums don't match
      if actual_checksum != tested_checksum
        shell_out('rm /tmp/composer-setup.php')
        raise Chef::Exceptions::ChecksumMismatch, tested_checksum, actual_checksum
      end

      # Install
      user = node['composer']['keys_user']
      install_command = 'php /tmp/composer-setup.php --install-dir=/tmp --filename=composer --quiet'
      if user != 'root'
        install_command = "sudo su -c '#{install_command}' #{user} 2>&1"
      end
      if (cmd = shell_out(install_command)).exitstatus != 0
        raise cmd.stdout
      end
      shell_out('chown root:root /tmp/composer 2>&1')
      shell_out('mv /tmp/composer /usr/local/bin 2>&1')

      # Clean up
      shell_out('rm /tmp/composer-setup.php')
    end
  end
end
