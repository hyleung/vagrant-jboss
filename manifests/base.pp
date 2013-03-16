node  jbossdev {
    include jbossdev::configure
}


class jbossdev::configure {
    file {
        "/etc/puppet/hiera.yaml":
            source => "/vagrant/files/hiera.yaml";
        "/etc/puppet/common.yaml":
            source => "/vagrant/files/common.yaml";            
        "/etc/puppet/jboss-config.yaml":
            source => "/vagrant/files/jboss-config.yaml";
    } 
}
