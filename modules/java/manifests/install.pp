class java::install {
        exec {
    "/usr/bin/apt-get -y update":
      alias => "aptUpdate",
      timeout => 3600;
  }
    package {
        "alien":
            ensure => installed,
            require => Exec["aptUpdate"];
    }
    file {
        ["/root","/root/files"]:
            ensure => directory;
    }
    file {
        "/root/files/jdk-6u41-linux-x64-rpm.bin":
            source => "puppet:///modules/java/jdk-6u41-linux-x64-rpm.bin",
            mode => 0755;
    }
    exec {
        "extract-rpm":            
            command => "/root/files/jdk-6u41-linux-x64-rpm.bin",
            cwd => "/root/files",
            creates => "/root/files/jdk-6u41-linux-amd64.rpm",
            require => File["/root/files/jdk-6u41-linux-x64-rpm.bin"];           
        "alien-rpm":
            command => "/usr/bin/alien --to-deb --scripts /root/files/jdk-6u41-linux-amd64.rpm",
            cwd => "/root/files",    
            creates => "/root/files/jdk_1.6.041-1_amd64.deb",
            require => [Package["alien"],Exec["extract-rpm"]],            
            user => root;
    }

    package {
        "jdk":        
            ensure => present,
            provider => 'dpkg',
            source => "/root/files/jdk_1.6.041-1_amd64.deb",
            require => Exec["alien-rpm"];
    }
}