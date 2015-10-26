#
class wildfly::drivers::generic(
  $install_dir        = $wildfly::install_dir,
  $user               = $wildfly::user
){

  # Variables
  $destination_dir    = "${install_dir}/wildfly/modules/${name}"

  # Defaults
  File {
    ensure => 'directory',
    owner  => $user,
    mode   => '0644'
  }

  Exec {
    path   => '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin',
  }

  # Create directory and set ownership
  exec { "Create ${destination_dir}/main":
    command => "mkdir -p ${destination_dir}/main",
    unless  => "test -d ${destination_dir}/main",
  } ->
  exec { "Make ${user} owner of ${destination_dir}":
    command => "chown -R ${user} ${destination_dir}",
    unless  => "test $(stat -c '%U' ${destination_dir}) = '${user}'",
  } ->

  # module file
  file{"${destination_dir}/main/module.xml":
    ensure  => present,
    content => template('wildfly/drivers/generic/module.xml.erb'),
  }

}
