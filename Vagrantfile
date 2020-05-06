# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  # Required plugins
  config.vagrant.plugins = ["vagrant-env", "vagrant-share"]

  # Hide sensitive values from output and logs
  config.vagrant.sensitive = ["hunter2", ENV["AWS_SECRET_ACCESS_KEY"]]

  # Configure Hyper-V provider
  config.vm.provider "hyperv" do |hyp|
    hyperv.vm_integration_services = {
      guest_service_interface: true,
      heartbeat:               true,
      key_value_pair_exchange: true,
      shutdown:                true,
      time_synchronization:    true,
      vss:                     true
    }
    hyperv.vmname = "3pe-iaas-poc-dev"
  end

  # Select box
  config.vm.box = "hashicorp/bionic64"
  #config.vm.box = "hashicorp/focal64"

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
    s.args = "#{id} #{key} #{region}"
    s.privileged = false
    s.reboot = true
    s.inline = <<-SHELL
      p12g=/vagrant/provisioning
      sudo $p12g/00-bootstrap.sh
      sudo $p12g/01-packages.sh
      $p12g/02-aws-configure.sh $1 $2 $3
    SHELL
  end

end