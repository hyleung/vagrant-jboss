node  jbossdev {

    Java::Install {
        installer => "/vagrant/files/jdk-6u41-linux-x64-rpm.bin"
    }    
    # include jboss
    Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }
    include java
}



