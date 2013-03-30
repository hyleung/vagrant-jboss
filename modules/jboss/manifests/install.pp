class jboss::install($baseDir,  
                    $version,
                    $serverConf = "standard",
                    $bindAddress = "0.0.0.0",
                    $user = "jboss") {
    $installDir = "$baseDir/$version"
    $serverBaseDir = "$installDir/server/$serverConf"
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
    file { ["/var","/var/lib","/var/lib/puppet","/var/lib/puppet/files"]:
        ensure => directory
    }
    file {
        "/var/lib/puppet/files/${version}.zip":
            ensure => present,
            source => "puppet:///modules/jboss/${version}.zip",
            require => File["/var/lib/puppet/files"];
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
            creates => "${baseDir}/${version}",
            require => [File["/var/lib/puppet/files/${version}.zip"], 
                        File["${baseDir}"],
                        Package["unzip"]];
    } ->  File["${baseDir}/${version}"]
    
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

    
}