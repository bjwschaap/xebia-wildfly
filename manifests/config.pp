# == Class wildfly::config
#
class wildfly::config(
  $install_dir              = $wildfly::install_dir,
  $mode                     = $wildfly::mode,
  $user                     = $wildfly::user,
  $profile                  = $wildfly::profile,
  $default_conf             = $wildfly::default_conf,
  $init_script              = $wildfly::init_script,
  $wait_time                = $wildfly::wait_time,
  $bind_address             = $wildfly::bind_address,
  $bind_address_management  = $wildfly::bind_address_management,
  $deployment_dir           = $wildfly::deloyment_dir
) {

  file { "${install_dir}/wildfly/${mode}/configuration/${profile}":
    ensure  => present,
    require => [ User["${user}"], File["${install_dir}/wildfly"] ],
    owner   => "${user}",
    group   => "${user}",
    mode    => 0644,
    content => template('wildfly/${profile}.erb')
  }

  file { "${default_conf}":
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => 0644,
    content => template('wildfly/wildfly.conf.erb')
  }

  file { "/etc/init.d/wildfly":
    ensure  => present,
    require => File["${default_conf}"],
    owner   => root,
    group   => 0755,
    source  => [ "puppet:///modules/wildfly/${init_script}" ]
  }

}
