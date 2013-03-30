class jboss {
    $conf = hiera_hash('jboss::install',undef)
    $baseDir = $conf["baseDir"]
    $version = $conf["version"]
    $serverConf = $conf["serverConf"]
    $bindAddress = $conf["bindAddress"]
    $user = $conf["user"]

    notice("$conf")

    if $conf {
        class { "jboss::install":
            baseDir => $baseDir,
            version => $version,
            serverConf => $serverConf,
            bindAddress => $bindAddress,
            user => $user
        }
        # Resoure default for lib dir
        Jboss::Lib {
            libDir => "$baseDir/$version/server/$serverConf/lib",
            user => $user,
            group => $user
        }
        $libs = $conf["libs"]
        if $libs {
            create_resources("jboss::lib",$libs)
        }
        $datasources = $conf["datasources"]
        if $datasources {
            Jboss::XaDatasource {
                baseDir => $baseDir,
                version => $version,
                serverConf => $serverConf,
                user => $user,
                group => $user
            }
            create_resources("jboss::xaDatasource",$datasources)
        }
    }
    if !$conf {
        notice("no conf")
    }

}
