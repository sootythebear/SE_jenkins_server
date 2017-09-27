#!/bin/bash

# Pull latest Puppet Agent from web, repository first, then install
rpm -Uvh https://yum.puppetlabs.com/puppet5/puppet5-release-el-7.noarch.rpm
yum -y install puppet-agent

# Remove iptables firewall
iptables -F

# Download Jenkins module from Forge
/opt/puppetlabs/bin/puppet module install rtyler-jenkins

# Apply Jenkins module
/opt/puppetlabs/bin/puppet apply -v /vagrant/jenkins_install.pp
