# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"

  config.vm.provision :shell, :path => "setup.sh", :privileged => false

  config.vm.synced_folder "vagrant-share", "/home/ubuntu/vmshare"

  # config.vm.network "forwarded_port", guest: 80, host: 8899
  config.vm.network "private_network", type: "dhcp"

  config.vm.provider "virtualbox" do |vb|
    vb.name = "ctf_box"
    vb.customize ["modifyvm", :id, "--memory", "8192"]
    vb.customize ["modifyvm", :id, "--cpus", "4"]
  end

end
