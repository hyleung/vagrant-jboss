class jboss {
    Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }
    jboss::install {
        "as1":
            baseDir => "/opt",
            version => "jboss-as-distribution-6.1.0.Final";
    }
}