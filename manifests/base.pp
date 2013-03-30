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
    jboss::xaDatasource {
        "mobilePanel":
            dsClass => "oracle.jdbc.xa.client.OracleXADataSource",
            dsUrl => "jdbc:oracle:thin:@127.0.0.1:1521:XE",
            dsUser => "mobilepanel",
            dsPassword => "password",
            dsExceptionSorterClass => "org.jboss.resource.adapter.jdbc.vendor.OracleExceptionSorter",
            dsTypeMapping => "Oracle11g",
            baseDir => "/opt",
            version => "jboss-6.1.0.Final",
            serverConf => "standard";
    } <- Jboss::Install["as1"]

    jboss::lib {
        "ojdbc5.jar":
            baseDir=> "/opt",
            version => "jboss-6.1.0.Final",
            serverConf => "standard",
            libFile => "/vagrant/files/ojdbc5.jar",            
    } <- Jboss::Install["as1"] 
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


