node  jbossdev {
    include java, jbossdev::hiera, jbossdev::configure
}

class jbossdev::hiera {
    file {
        "/etc/puppet/hiera.yaml":
            source => "/vagrant/files/hiera.yaml";
        "/etc/puppet/common.yaml":
            source => "/vagrant/files/common.yaml";            
        "/etc/puppet/jboss-config.yaml":
            source => "/vagrant/files/jboss-config.yaml";
    }    
}
class jbossdev::configure($myparam="default"){
    file {
        "/tmp/my-param.txt":
            content => "some content: ${myparam}",
            require => Class["jbossdev::hiera"];
    }  
}


