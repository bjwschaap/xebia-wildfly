#== Class: wildfly
class wildfly(
  $bind_address             = $wildfly::params::bind_address,
  $bind_address_management  = $wildfly::params::bind_address_management,
  $user                     = $wildfly::params::user,
  $shell                    = $wildfly::params::shell,
  $install_dir              = $wildfly::params::install_dir,
  $install_java             = $wildfly::params::install_java,
  $version                  = $wildfly::params::version,
  $mode                     = $wildfly::params::mode,
  $profile                  = $wildfly::params::profile,
  $wait_time                = $wildfly::params::wait_time,
  $console_log              = $wildfly::params::console_log,
  $pid_file                 = $wildfly::params::pid_file,
  $proxy_url                = $wildfly::params::proxy_url
) inherits wildfly::params {

  anchor{'wildfly::begin': } ->
  class{'wildfly::install': } ->
  class{'wildfly::config': } ~>
  class{'wildfly::service': } ->
  anchor{'wildfly::end': }

}
