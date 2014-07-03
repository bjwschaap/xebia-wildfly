define wildfly::config::loggin_setting(
  $value,
  $logging_file

){
  ini_setting { $name:
    path    => $logging_file,
    ensure  => present,
    section => '',
    setting => $name,
    value   => $value
  }
}