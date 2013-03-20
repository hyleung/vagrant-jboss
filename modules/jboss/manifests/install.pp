define jboss::install($baseDir, $version) {
    file {
        "/var/lib/puppet/files/${version}.zip":
            ensure => present,
            source => "puppet:///modules/jboss/${version}.zip";
        "${baseDir}":
            ensure => directory;           
    }
    package {
        "unzip":
            ensure => installed;
    }
    exec {
        "unzip-jboss":
            command => "unzip -o /var/lib/puppet/files/${version}.zip -d ${baseDir}",
            require => [File["/var/lib/puppet/files/${version}.zip"], 
                        File["${baseDir}"],
                        Package["unzip"]];
    } ->  Notify["unzip completed"]

    notify {
        "unzip completed":
            message => "'${version}' unzipped to directory ${baseDir}"
    }
    
}