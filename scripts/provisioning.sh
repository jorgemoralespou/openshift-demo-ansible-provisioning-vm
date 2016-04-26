#!/bin/bash
#
#
# user: vagrant
# 

: ${DEMO_ANSIBLE_TAG:="demo-ansible-2.1.0"}
: ${OPENSHIFT_ANSIBLE_TAG:="openshift-ansible-3.0.47-6"}

dnf install -y python python-devel openssl-devel libffi-devel gcc redhat-rpm-config git tmux
# dnf install -y rubygem-thor rubygem-parseconfig util-linux pyOpenSSL libffi-devel python-cryptography redhat-rpm-config git tmux

# Install the epel repo if not already present
# dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
# Clean yum metadata and cache to make sure we see the latest packages available
# dnf clean all
# Install the ansible 1.9.4 package directly from koji
dnf install -y https://kojipkgs.fedoraproject.org//packages/ansible/1.9.4/1.fc23/noarch/ansible-1.9.4-1.fc23.noarch.rpm
# Disable EPEL to prevent unexpected packages from being pulled in during installation.
# yum-config-manager epel --disable

pip install --upgrade pip
pip install click
pip install boto
pip install pyopenssl

# Install git repositories
mkdir -p /home/vagrant/ansible-scripts
pushd /home/vagrant/ansible-scripts
git clone https://github.com/2015-Middleware-Keynote/demo-ansible.git
pushd demo-ansible
git checkout ${DEMO_ANSIBLE_TAG}
popd
git clone https://github.com/openshift/openshift-ansible.git
pushd openshift-ansible
git checkout ${OPENSHIFT_ANSIBLE_TAG}
popd
popd
chown vagrant:vagrant -R /home/vagrant/ansible-scripts
