# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  # Required plugins
  config.vagrant.plugins = [
    "vagrant-env",
    "vagrant-share",
  ]

  # Load .env file
  config.env.enable

  # Hide sensitive values from output and logs
  config.vagrant.sensitive = [
    "hunter2",
    ENV["AWS_SECRET_ACCESS_KEY"],
    ENV["WINDOWS_PASSWORD"],
  ]

  # Configure Hyper-V provider
  config.vm.provider "hyperv" do |hyperv|
    hyperv.enable_virtualization_extensions = true
    hyperv.linked_clone = true
    hyperv.vm_integration_services = {
      guest_service_interface: true,
      heartbeat:               true,
      key_value_pair_exchange: true,
      shutdown:                true,
      time_synchronization:    true,
      vss:                     true,
    }
    hyperv.vmname = "3pe-iaas-poc-dev"
  end

  # Select box
  config.vm.box = "generic/alpine311"

  # Setup SMB share
  config.vm.synced_folder ".", "/vagrant", type: "smb",
    smb_username: ENV["WINDOWS_USERNAME"],
    smb_password: ENV["WINDOWS_PASSWORD"]

  # Provision guest
  id = ENV['AWS_ACCESS_KEY_ID'] || "NO_AWS"
  key = ENV['AWS_SECRET_ACCESS_KEY'] || "NO_AWS"
  region = ENV['AWS_DEFAULT_REGION'] || "eu-north-1"
  tz = ENV['TZ'] || "UTC"
  config.vm.provision "bootstrap", type: "shell" do |s|
    s.args = "#{id} #{key} #{region} #{tz}"
    s.privileged = false
    s.inline = <<-BASH
      P12G=/vagrant/provisioning
      sudo $P12G/00-bootstrap.sh $4
      sudo $P12G/01-packages.sh $P12G
      $P12G/02-aws-configure.sh $1 $2 $3
      $P12G/99-status.sh
      sudo rm -rf /var/cache/apk/*
    BASH
  end

  # Echo guest IP address
  config.vm.provision "ip", type: "shell", run: "always" do |s|
    s.inline = <<-BASH
      IP=$(ip route get 1 | awk '{ print $NF; exit }')
      echo "nginx serving content on <http://$IP/>"
    BASH
  end

end