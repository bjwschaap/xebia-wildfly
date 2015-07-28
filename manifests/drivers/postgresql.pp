# This installs the Postgresql JDBC drivers
class wildfly::drivers::postgresql(
  $install_dir        = $wildfly::install_dir,
  $user               = $wildfly::user,
  $postgresql_version = $wildfly::postgresql_version,
  $download_url       = $wildfly::postgresql_download_url,
  $proxy_url          = $wildfly::proxy_url
){

  # variables
  if !$download_url {
    $download_url = "https://jdbc.postgresql.org/download/postgresql-${postgresql_version}.jdbc41.jar"
  }

  $destination_dir     = "${install_dir}/wildfly/modules/org/postgresql/main"

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
    content => template('wildfly/drivers/postgresql/module.xml.erb')
  }

  # addition to the profile file

}
