# == Class wildfly::config
#
class wildfly::config(
  $install_dir               = $wildfly::install_dir,
  $mode                      = $wildfly::mode,
  $user                      = $wildfly::user,
  $profile                   = $wildfly::profile,
  $default_conf              = $wildfly::default_conf,
  $init_script               = $wildfly::init_script,
  $wait_time                 = $wildfly::wait_time,
  $bind_address              = $wildfly::bind_address,
  $bind_address_management   = $wildfly::bind_address_management,
  $deployment_dir            = $wildfly::deployment_dir,
  $admin_user                = $wildfly::admin_user,
  $admin_password            = $wildfly::admin_password,
  $java_home                 = $wildfly::java_home,

) {

  file { "${install_dir}/wildfly/bin/standalone.conf":
    ensure  => present,
    content => template('wildfly/standalone.conf.erb'),
    owner   => $user,
    group   => $user,
    mode    => '0755'
  }

  file { $default_conf:
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template('wildfly/wildfly.conf.erb')
  }

  file { '/etc/init.d/wildfly':
    ensure  => present,
    require => File[$default_conf],
    owner   => root,
    group   => '0755',
    source  => [ "puppet:///modules/wildfly/${init_script}" ]
  }

  exec { "${install_dir}/wildfly/bin/add-user.sh ${admin_user} '${admin_password}' --silent && touch ${install_dir}/wildfly/${mode}/admin_user.created":
    creates => "${install_dir}/wildfly/${mode}/admin_user.created"
  }

}
