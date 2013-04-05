node  jbossdev {
    include java   
    include jboss
    Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }
}



