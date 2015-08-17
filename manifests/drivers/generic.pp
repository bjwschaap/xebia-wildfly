#
class wildfly::drivers::generic(
  $install_dir        = $wildfly::install_dir,
  $user               = $wildfly::user
){

  # variables
  $destination_dir    = "${install_dir}/wildfly/modules/${name}"

  File {
    ensure => 'directory',
    owner  => $user,
    mode   => '0644'
  }

  exec { "/bin/mkdir -p ${destination_dir}/main"   : } ->
  exec { "/bin/chown -R ${user} ${destination_dir}": } ->


  # module file
  file{"${destination_dir}/main/module.xml":
    ensure  => present,
    content => template('wildfly/drivers/generic/module.xml.erb'),
  }

}
