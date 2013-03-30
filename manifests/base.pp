node  jbossdev {
    include java    
    include jboss
    Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }

    # class { "jboss::install":        
    #  } <- Class["jbossdev::configure"]
    # jboss::xaDatasource {
    #     "mobilePanel":
    #         dsClass => "oracle.jdbc.xa.client.OracleXADataSource",
    #         dsUrl => "jdbc:oracle:thin:@127.0.0.1:1521:XE",
    #         dsUser => "mobilepanel",
    #         dsPassword => "password",
    #         dsExceptionSorterClass => "org.jboss.resource.adapter.jdbc.vendor.OracleExceptionSorter",
    #         dsTypeMapping => "Oracle11g",
    #         baseDir => "/opt",
    #         version => "jboss-6.1.0.Final",
    #         serverConf => "standard";
    # } <- Jboss::Install["as1"]

    # jboss::lib {
    #     "ojdbc5.jar":
    #         baseDir=> "/opt",
    #         version => "jboss-6.1.0.Final",
    #         serverConf => "standard",
    #         libFile => "/vagrant/files/ojdbc5.jar",            
    # } <- Jboss::Install["as1"] 
}



