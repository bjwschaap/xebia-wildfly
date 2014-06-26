class wildfly::drivers(
  $install_postgresql_driver  = $wildfly::install_postgresql_driver,
  $install_mq_driver          = $wildfly::install_mq_driver
) {



  anchor{'wildfly::driver::begin':}
  -> anchor{'wildfly::driver::end':}

  if str2bool($install_postgresql_driver) {
    Anchor['wildfly::driver::begin']
    -> class{'wildfly::drivers::postgresql':}
    -> Anchor['wildfly::driver::end']
  }

  if str2bool($install_mq){
    Anchor['wildfly::driver::begin']
    -> class{'wildfly::drivers::mq':}
    -> Anchor['wildfly::driver::end']
  }



}
