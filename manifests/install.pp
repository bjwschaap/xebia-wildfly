# == Class wildfly::install
#
class wildfly::install(
  $version      = $wildfly::version,
  $install_dir  = $wildfly::install_dir,
  $install_java = $wildfly::install_java,
  $user         = $wildfly::user,
  $shell        = $wildfly::shell,
  $proxy_url    = $wildfly::proxy_url
) {

  # flow
  User[$user] ->
  Wildfly_netinstall[$version] ->
  File["${install_dir}/wildfly"]

  # java?
  if str2bool($install_java) {
    case $::osfamily {
      'RedHat' : {
                    $java_packages = ['java-1.7.0-openjdk']
                    User[$user] -> Package[$java_packages] -> Wildfly_netinstall[$version]

                    package { $java_packages: ensure => present }
                  }
      default  : {
                    fail("${::osfamily}:${::operatingsystem} not supported by this module")
                  }
            }
    }

  wildfly_netinstall{$version:
    destinationdir => "${install_dir}",
    user           => $user,
    group          => $user,
    proxy_url      => $proxy_url,
    }

  file { "${install_dir}/wildfly":
    ensure  => 'link',
    force   => true
    owner   => "${user}",
    group   => "${user}",
    target  => "${install_dir}/wildfly-${version}",
  }

  user { "${user}":
    shell   => "${shell}",
    ensure  => "present"
  }



}
