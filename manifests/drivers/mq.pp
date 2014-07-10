class wildfly::drivers::mq(
  $install_dir        = $wildfly::install_dir,
  $user               = $wildfly::user,
){


  # physical driver
  file{"${install_dir}/wildfly/standalone/deployments/wmq.jmsra.rar":
    ensure  => present,
    owner   => $user,
    group   => $user,
    mode    => 0644,
    source  => "puppet:///modules/wildfly/drivers/undisclosed_evil_empire_stuffels_jms-7.5.0.3.rar",
  }

}