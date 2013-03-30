define jboss::lib(
    $baseDir,
    $version,
    $serverConf,
    $libFile
) {
    file {
        "$baseDir/$version/server/$serverConf/lib/$name":
            source => $libFile,            
            ensure => present;
    } 
}