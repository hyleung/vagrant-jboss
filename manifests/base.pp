node  jbossdev {
    include java
    include jboss
    include jbossdev::configure
    
    Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }
    jboss::install {
        "as1":
            baseDir => "/opt",
            version => "jboss-6.1.0.Final",
            serverConf => "standard";
    }
}


class jbossdev::configure{


    file {        
        "/etc/puppet/hiera.yaml":
            source => "/vagrant/files/hiera.yaml";
        "/etc/puppet/common.yaml":
            source => "/vagrant/files/common.yaml",
            require => File["/etc/puppet/hiera.yaml"];
        "/etc/puppet/jboss-config.yaml":
            source => "/vagrant/files/jboss-config.yaml",
            require => File["/etc/puppet/hiera.yaml"];
        "/etc/puppet/fileserver.conf":
            source => "/vagrant/files/fileserver.conf",
            require => File["/var/lib/puppet/files"];   
        "/var/lib/puppet/files":
            ensure => directory;        
    }   
  
}


