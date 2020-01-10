# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"

  config.vm.network "private_network", ip: "192.168.33.10"

  # config.vm.synced_folder "./ansible", "/vagrant", disabled: true
  config.vm.synced_folder "./playbooks", "/vagrant", disabled: false

  config.vm.define "server" do |server|
    disk = "./vmdisk/secondDisk.vdi"

    server.vm.hostname = "kubernetes01"

    config.vm.provider "virtualbox" do |vb|
      unless File.exist?(disk)
        vb.customize ['createhd', '--filename', disk, '--variant', 'Fixed', '--size', 20 * 1024]
      end

      vb.customize ['storageattach', :id,  '--storagectl', 'IDE', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', disk]
      vb.memory = "2048"
      vb.cpus   = "2"
    end
  end

  # config.vm.provision "ansible_local", run: "always" do |ansible|
  config.vm.provision "ansible_local" do |ansible|
    ansible.playbook = "ansible/main.yml"
    ansible.verbose = true
  end

  config.vm.provision "shell", run: "always", inline: <<-SHELL
    sudo yum install python3 -y
    # sudo -u vagrant /usr/bin/pip install kubernetes --user
    sudo -u vagrant /usr/bin/python3 /vagrant/pods.py
  SHELL

end
