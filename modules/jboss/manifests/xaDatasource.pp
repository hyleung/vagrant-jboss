define jboss::xaDatasource(
    $dsJndiName = $name,
    $dsClass,
    $dsUrl,
    $dsUser,
    $dsPassword,
    $dsExceptionSorterClass,
    $dsTypeMapping,
    $baseDir,
    $version,
    $serverConf,
    $user,
    $group
) 
{
    file {
        "$baseDir/$version/server/$serverConf/deploy/$name-xa-ds.xml":
            ensure => present,
            owner => $user,
            group => $group,
            content => template("jboss/xa-ds.xml.erb");
    }
}