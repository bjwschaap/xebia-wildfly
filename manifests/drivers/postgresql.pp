# This installs the Postgresql JDBC drivers
class wildfly::drivers::postgresql(
  $install_dir        = $wildfly::install_dir,
  $user               = $wildfly::user,
  $postgresql_version = $wildfly::postgresql_version,
  $proxy_url          = $wildfly::proxy_url
){

  # variables
  $download_url        = "http://jdbc.postgresql.org/download/postgresql-${postgresql_version}.jdbc41.jar"
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
    destinationdir  =>  "${install_dir}/wildfly/modules/org/postgresql/main",
  }


  # module file
  file{"${destination_dir}/module.xml":
    ensure  => present,
    content => template('wildfly/drivers/postgresql/module.xml.erb')
  }

  # addition to the profile file

}