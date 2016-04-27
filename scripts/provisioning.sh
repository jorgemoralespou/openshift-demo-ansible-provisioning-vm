#!/bin/bash
#
#
# user: vagrant
# 

: ${DEMO_ANSIBLE_TAG:="demo-ansible-2.1.2"}
: ${OPENSHIFT_ANSIBLE_TAG:="openshift-ansible-3.0.47-6"}
: ${_home:="/home/vagrant"}

install_requirements(){
   dnf install -y python python-devel openssl-devel libffi-devel gcc redhat-rpm-config git tmux
   # Install the ansible 1.9.4 package directly from koji
   dnf install -y https://kojipkgs.fedoraproject.org//packages/ansible/1.9.4/1.fc23/noarch/ansible-1.9.4-1.fc23.noarch.rpm
   pip install --upgrade pip
   pip install click
   pip install boto
   pip install pyopenssl
}

clone_demo_ansible(){
   # Install git repositories
   git clone https://github.com/2015-Middleware-Keynote/demo-ansible.git
   pushd demo-ansible
   git checkout ${DEMO_ANSIBLE_TAG}
   popd
   chown vagrant:vagrant -R ${_home}/demo-ansible
}

clone_openshift_ansible(){
   git clone https://github.com/openshift/openshift-ansible.git
   pushd openshift-ansible
   git checkout ${OPENSHIFT_ANSIBLE_TAG}
   popd
   chown vagrant:vagrant -R ${_home}/openshift-ansible
}

configure_ssh(){
   cat <<'EOF' >> ${_home}/.ssh/config
Host *
    StrictHostKeyChecking no
EOF
   for cert in `ls /aws-keys/*.pem`
   do
      chmod 600 ${cert}
      echo "IdentityFile ${cert}" >> ${_home}/.ssh/config
   done

   chmod 600 ${_home}/.ssh/config
   chown vagrant:vagrant -R ${_home}
}

install_requirements
clone_demo_ansible
clone_openshift_ansible
configure_ssh
