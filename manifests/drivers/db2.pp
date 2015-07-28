#
class wildfly::drivers::db2(
  $install_dir        = $wildfly::install_dir,
  $user               = $wildfly::user,
  $version            = $wildfly::db2_version,
  $download_url       = $wildfly::db2_download_url,
  $proxy_url          = $wildfly::proxy_url
){

  # variables
  if !$download_url {
    fail( 'You must specify a download location for the DB2 JDBC4 driver JAR file.' )
  }

  $destination_dir = "${install_dir}/wildfly/modules/com/ibm/db2/main"

  File {
    ensure => 'directory',
    owner  => $user,
    mode   => '0644'
  }


  # flow
  Wildfly_driver_download[$download_url] ->
  File["${destination_dir}/module.xml"]

  # physical driver
  wildfly_driver_download{$download_url:
    proxy_url       => $proxy_url,
    destinationdir  => $destination_dir,
  }


  # module file
  file{"${destination_dir}/module.xml":
    ensure  => present,
    content => template('wildfly/drivers/db2/module.xml.erb')
  }

}
