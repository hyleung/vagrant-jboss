define jboss::lib(
    $libDir,
    $libFile,
    $user,
    $group
) {
    file {
        "$libDir/$name":
            source => $libFile,            
            ensure => present,
            owner => $user;
    } 
}