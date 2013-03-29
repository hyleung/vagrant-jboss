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
    $serverConf
) 
{
    file {
        "$baseDir/$version/server/$serverConf/deploy/$name-xa-ds.xml":
            ensure => present,
            content => template("jboss/xa-ds.xml.erb");
    }
}