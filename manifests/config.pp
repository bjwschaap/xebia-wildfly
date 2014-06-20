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
  $deployment_dir           = $wildfly::deployment_dir,
  $admin_user               = $wildfly::admin_user,
  $admin_password           = $wildfly::admin_password,
  $profile_extensions       = $wildfly::profile_extensions,
  $profile_subsystems       = $wildfly::profile_subsystems
) {

  #file { "${install_dir}/wildfly/${mode}/configuration/${profile}":
  #  ensure  => present,
  #  require => [ User["${user}"], File["${install_dir}/wildfly"] ],
  #  owner   => "${user}",
  #  group   => "${user}",
  #  mode    => 0644,
  #  content => template("wildfly/${profile}.erb")
  #}

  concat { "${install_dir}/wildfly/${mode}/configuration/${profile}":
    ensure => present,
    require => [ User["${user}"], File["${install_dir}/wildfly"] ],
    owner   => "${user}",
    group   => "${user}",
    mode    => 0644,
  }

  Concat::Fragment{target => "${install_dir}/wildfly/${mode}/configuration/${profile}" }

  concat::fragment{'file_header':
    content => template('wildfly/standalone/file_header.xml.erb'),
    order   => '10'
  }
  concat::fragment{'extension_header':
    content => template('wildfly/standalone/profile_header.xml.erb'),
    order   => '20'
  }
  wildfly::profile::extension{$profile_extensions:
    target => "${install_dir}/wildfly/${mode}/configuration/${profile}",
    order  => '25'
  }

  concat::fragment{'extension_footer':
    content => template('wildfly/standalone/profile_header.xml.erb'),
    order   => '30'
  }

  concat::fragment{'management_section':
    content => template('wildfly/standalone/management_section.xml.erb'),
    order   => '40'
  }
  concat::fragment{'profile_header':
    content => template('wildfly/standalone/profile_header.xml.erb'),
    order   => '50',
  }
  wildfly::profile::subsystems{$profile_subsystems:
    target => "${install_dir}/wildfly/${mode}/configuration/${profile}",
    order  => '55'
  }
  concat::fragment{'profile_footer':
    content => template('wildfly/standalone/profile_footer.xml.erb'),
    order   => '60'
  }
  concat::fragment{'interfaces':
    content => template('wildfly/standalone/interfaces.xml.erb'),
    order   => '70'
  }
  concat::fragment{'socket_bindings':
    content => template('wildfly/standalone/socket_bindings.xml.erb'),
    order   => '80'
  }
  concat::fragment{'file_footer':
    content => template('wildfly/standalone/file_footer.xml.erb'),
    order   => '90'
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

  exec { "${install_dir}/wildfly/bin/add-user.sh ${admin_user} ${admin_password} --silent && touch ${install_dir}/wildfly/${mode}/admin_user.created":
    creates => "${install_dir}/wildfly/${mode}/admin_user.created"
  }

}
