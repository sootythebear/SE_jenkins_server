VAGRANTFILE_API_VERSION = '2'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.define 'demopuppetagent' do |puppetagent|

    #    if Vagrant.has_plugin?('vagrant-proxyconf')
    #       puppetmaster.proxy.http = 'http://proxy.xxx.xxx.xxx:8080'
    #       puppetmaster.proxy.https = 'http://proxy.xxx.xxx.xxx:8080'
    #       puppetmaster.proxy.no_proxy = 'localhost,127.0.0.1,172.28.128.9'
    #       puppetmaster.yum_proxy.http = 'http://proxy.xxx.xxx.xxx:8080'
    #       puppetmaster.apt_proxy.http = 'http://proxy.xxx.xxx.xxx:8080'
    #       puppetmaster.apt_proxy.https = 'http://proxy.xxx.xxx.xxx:8080'
    #    end

    puppetagent.vm.network 'private_network', ip: '172.28.128.9'

    puppetagent.vm.hostname = 'demopuppetagent.corp.net'
    puppetagent.vm.box = 'puppetlabs/centos-7.2-64-nocm'

    puppetagent.vm.provider 'virtualbox' do |v|
       v.memory = 1024
    end

    puppetagent.vm.provision "shell", path: "scripts/puppetagent.sh"
  end
end
