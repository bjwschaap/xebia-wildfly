# == Class wildfly::install
#
class wildfly::install(
  $version = $wildfly::version,
  $install_dir = $wildfly::install_dir,
  $user        = $wildfly::user,
  $shell       = $wildfly::shell,
  $proxy_url   = $wildfly::proxy_url,
) {

  wildfly_netinstall{$version:
    destinationdir => "${install_dir}/wildfly-${version}",
    user           => $user,
    group          => $group,
    proxy_url      => $proxy_url,
    }

  file { "${install_dir}/wildfly":
    ensure  => 'link',
    owner   => "${user}",
    group   => "${user}",
    target  => "${install_dir}/wildfly-${version}",
    require => Exec['untar-wildfly']
  }

  user { "${user}":
    shell   => "${shell}",
    ensure  => "present"
  }



}
