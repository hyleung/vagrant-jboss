class jboss {
    $conf = hiera_hash('jboss::install',undef)
    notice("$conf")
    if $conf {
        create_resources('jboss::install',$conf)
    }
    if !$conf {
        notice("no conf")
    }
}