# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "hashicorp/bionic64"
  config.vm.box_url = "https://vagrantcloud.com/hashicorp/bionic64"

  # Load .env file
  config.env.enable

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provision guest
  id = ENV['AWS_ACCESS_KEY_ID']
  key = ENV['AWS_SECRET_ACCESS_KEY']
  region = ENV['AWS_DEFAULT_REGION']
  config.vm.provision :shell do |s|
    s.privileged = false
    s.args = "#{id} #{key} #{region}"
    s.inline = <<-SHELL
      P12G=/vagrant/provisioning
      sudo $P12G/00-bootstrap.sh
      $P12G/01-aws-configure.sh $1 $2 $3
    SHELL
  end

end