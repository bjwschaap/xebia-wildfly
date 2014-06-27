#
class wildfly::config::logging(
  $logging_properties = $wildfly::logging_porperties,
  $install_dir        = $wildfly::install_dir,
  $mode               = $wildfly::mode
){

  file{"${install_dir}/wildfly/${mode}/configuration/logging.properties":
    ensure  => present,
    content => template('wildfly/config/logging.properties.erb')
    }
}