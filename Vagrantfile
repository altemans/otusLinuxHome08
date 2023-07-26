# -*- mode: ruby -*- 
# vi: set ft=ruby : vsa
Vagrant.configure(2) do |config| 
    config.vm.box = "centos/7" 
    config.vm.box_version = "2004.01" 
    config.vm.provider "virtualbox" do |v| 
    v.memory = 512 
    v.cpus = 2 
    config.vbguest.auto_update = false
    end 
    config.vm.define "systemd" do |systemd| 
        systemd.vm.box_check_update = false
        systemd.vm.network "private_network", ip: "192.168.50.10",  virtualbox__intnet: "net1" 
        systemd.vm.hostname = "systemd" 
        systemd.vm.provision "file", source: "./httpd-first", destination: "/tmp/httpd-first"
        systemd.vm.provision "file", source: "./httpd-second", destination: "/tmp/httpd-second"
        systemd.vm.provision "file", source: "./httpd.service", destination: "/tmp/httpd.service"
        systemd.vm.provision "file", source: "./first.conf", destination: "/tmp/first.conf"
        systemd.vm.provision "file", source: "./second.conf", destination: "/tmp/second.conf"
        systemd.vm.provision "file", source: "./spawn-fcgi", destination: "/tmp/spawn-fcgi"
        systemd.vm.provision "file", source: "./spawn-fcgi.service", destination: "/tmp/spawn-fcgi.service"
        systemd.vm.provision "shell", path: "script.sh"
    end 
   end 
   
   