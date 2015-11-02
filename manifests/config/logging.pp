#
class wildfly::config::logging(
  $logging_properties = $wildfly::logging_properties,
  $install_dir        = $wildfly::install_dir,
  $mode               = $wildfly::mode,
  $user               = $wildfly::user
){

  $_logging_properties = merge($::wildfly::params::default_logging_properties, $logging_properties)

  file { 'logging.properties':
    ensure  => "file",
    path    => "${install_dir}/wildfly/${mode}/configuration/logging.properties",
    replace => false,
    owner   => $user,
    group   => $user,
    content => template('wildfly/logging.properties.erb'),
  }

}

