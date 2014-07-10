# Some documentation...
define wildfly::config::logging_setting(
  $value,
  $logging_file

){
  ini_setting { $name:
    ensure  => present,
    path    => $logging_file,
    section => '',
    setting => $name,
    value   => $value
  }
}