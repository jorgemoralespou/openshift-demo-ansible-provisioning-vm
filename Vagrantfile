# -*- mode: ruby -*-
# vi: set ft=ruby :
#
# Maintainer: Jorge Morales <jmorales@redhat.com>
#
#
VAGRANTFILE_API_VERSION = "2"
Vagrant.require_version ">= 1.7.2"

$ec2_creds_script = <<SCRIPT
   echo "source /aws-keys/ec2-creds" >> /home/vagrant/.bashrc
SCRIPT

$ec2_envs_script = <<SCRIPT
   echo "export AWS_ACCESS_KEY_ID='#{ENV['AWS_ACCESS_KEY_ID']}' " >> /home/vagrant/.bashrc
   echo "export AWS_SECRET_ACCESS_KEY='#{ENV['AWS_SECRET_ACCESS_KEY']}' " >> /home/vagrant/.bashrc
SCRIPT


EC2_CREDS = File.join(File.dirname(__FILE__), "ec2-creds")
Vagrant.configure(2) do |config|

   # vagrant box add --name fedora/23-cloud-base Fedora-Cloud-Base-Vagrant-23-20151030.x86_64.vagrant-libvirt.box
   config.vm.box = "fedora/23-cloud-base"
   config.vm.box_check_update = false

   config.vm.synced_folder ".", "/vagrant", disabled: true
   config.vm.synced_folder "scripts", "/scripts", type: "rsync"
   config.vm.synced_folder "aws-keys", "/aws-keys", type: "rsync"

   config.vm.provider "virtualbox" do |vb|
      #   vb.gui = true
      vb.memory = "4096"
      vb.cpus = 2
   end

   if File.exist?(EC2_CREDS)
      config.vm.provision "shell", inline: $ec2_creds_script
   else
      config.vm.provision "shell", inline: $ec2_envs_script 
   end 


   config.vm.provision "shell", path: "scripts/provisioning.sh"
   
   config.vm.provision "shell", run: "always", inline: <<-SHELL
      echo
      echo " OpenShift Demo ansible Provisioner VM created. Now you can provision your OpenShift demos easily."
      echo
      echo
      echo "vagrant ssh"
      echo
      echo "cd demo-ansible"
      echo 
      echo "REMEMBER: You need to add your ec2 ssh key to the VM with ssh-add <path to key file>"
      echo
      echo "./run.py  <OPTIONS>"
      echo
      echo "There are some examples in /vagrant/examples.txt or in https://github.com/2015-Middleware-Keynote/demo-ansible"
      echo
   SHELL

end
