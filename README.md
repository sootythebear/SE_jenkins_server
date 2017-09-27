# SE_jenkins_server

This repo spins up a Puppet Agent environment, within VirtualBox via Vagrant, which will then be used to install a Jenkins server and change the 'request' port to 8000 (see `Script` section of this Readme).

The repo:
 * creates a Puppet Client instance on Centos 7
 * installs the Puppet Agent on the Puppet Client
 * pulls the `rtyler/jenkins` module from the Puppet Forge
 * performs a `puppet apply` against the `jenkins` module, which installs Jenkins and specifies, via the `config_hash` struct, the port change requirement.

## Demo Setup

This demo utilises `VirtualBox` and `Vagrant` to build and provision the environment. This software will need to be installed and configured before the demo can be run. The ability to 'sync' the present working folder, and download software over the Internet, requires that the Vagrant plug-ins - `vagrant-share`, `vagrant-vbguest` and `vagrant-proxyconf` have already been installed (use: `vagrant plugin install <plugin>` in install as required). The setup script checks for these plug-ins and that Vagrant is version 1.9.2, or above (required to resolve a private network interface issue with RH Linux versions).

This repo provides the `Vagrantfile` and provisioning scripts required. The repo at present has the domain hard coded to `corp.net` - change this in the `Vagrantfile` accordingly. 


**Setup the environment**

    1. `Git clone` this GitHub repo.
    2. Change directory into the `SE_jenkins_server` folder
    3. If environment uses proxy servers, edit `Vagrantfile` accordingly. 
    4. Run the command: `./setup_demo.sh`
Note: the setup takes about 5-10 minutes to configure, expect some additional time if the Centos 7.2 image needs to be initially downloaded.

## Known Issues/constraints
  * This demo is specifically performed on a Centos/RHEL installation via Vagrant. If another Linux flavor is used, the `config_hash PORT` string may need to be changed accordingly.
  * Any flat ASCII file copied over runs the risk of being 'spammed' going between DOS and *nix - dos2unix is installed and run to mitigate.

## Script

### Access Jenkins Server on new port

### Simplistic Demo (suggestion):

#### Steps:

1. **Web browser:** Open new tab on server running VirtualBox/Vagrant, and goto: `http://172.28.128.9:8000` 

## Manual overview

This demo performs the following steps:

1. Installs the Puppet agent via:
```
rpm -Uvh https://yum.puppetlabs.com/puppet5/puppet5-release-el-7.noarch.rpm
yum -y install puppet-agent
```

2. Removes the `ipatables` configuration
```
iptables -F
```

3. Pulls the `rtyler/jenkins` module from the Puppet Forge
```
/opt/puppetlabs/bin/puppet module install rtyler-jenkins
```

4. Applies the module and alters the `request` port. Note: this command can be run multiple times without affecting the desired state.
```
/opt/puppetlabs/bin/puppet apply -v /vagrant/jenkins_install.pp
```

Contents of the `jenkins_install.pp` file:
```
class { 'jenkins':
  config_hash => {
     'JENKINS_PORT' => { 'value' => '8000' },   
     'JENKINS_HTTPS_PORT' => { 'value' => '8001' },  
     'JENKINS_APJ_PORT' => { 'value' => '8001' },   
  }  
}
```

