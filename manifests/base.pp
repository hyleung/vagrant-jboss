node  jbossdev {
    include java
    include jbossdev::configure
}


class jbossdev::configure{
    group {
        "jboss":
            ensure => present;
    }
    package {
        "wget":
            ensure => installed;
    }
    exec {
        "wget-jboss":
            require => [File["/var/lib/puppet/files"],Package["wget"]],
            command => "/usr/bin/wget http://download.jboss.org/jbossas/6.1/jboss-as-distribution-6.1.0.Final.zip -o /var/lib/puppet/files/jboss-as-distribution-6.1.0.Final.zip";
    }
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


