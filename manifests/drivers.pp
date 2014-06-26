class wildfly::drivers(
  $install_postgresql_driver  = $wildfly::install_postgresql_driver
  $install_mq_driver          = $wildfly::install_mq_driver
) {



  anchor{'wildfly::driver::begin':}
  if str2bool($install_postgresql_driver) {
    -> class{'wildfly::drivers::postgresql':}
  }

  if str2bool($install_mq){
    -> class{'wildfly::drivers::mq':}
  }
  -> anchor{'wildfly::driver::end':}


}
