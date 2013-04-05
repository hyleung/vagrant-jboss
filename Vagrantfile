# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "precise64"
#  config.vm.box_url = "http://files.vagrantup.com/precise64_vmware_fusion.box"
  config.vm.network :forwarded_port, guest: 8080, host: 8080
  config.vm.hostname = "jbossdev.example.com"
  config.vm.provision :puppet,:module_path => "modules"  do |puppet|
     puppet.manifests_path = "manifests"
     puppet.manifest_file  = "base.pp"
     puppet.options = "--hiera_config /vagrant/files/hiera.yaml"
  end
end
