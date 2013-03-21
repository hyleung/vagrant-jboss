define jboss::install($baseDir,  
                    $version,
                    $serverConf = "standard",
                    $bindAddress = "0.0.0.0",
                    $user = "jboss") {
    group {
        "${user}":
            ensure => present;
    }
    user {
        "${user}":
            ensure => present,
            gid => "${user}",
            require => Group["${user}"];
    }
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
    file {
        "${baseDir}/${version}":            
            owner => "${user}",
            group => "${user}",
            recurse => true,
            require => [User["${user}"],
                        Exec["unzip-jboss"]];
    }
    file {
        "/etc/init.d/jboss":
            ensure => present,
            mode => 0755,
            content => template("jboss/jboss.sh.erb");
    }
    notify {
        "unzip completed":
            message => "'${version}' unzipped to directory ${baseDir}"
    }
    
}