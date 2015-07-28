#
class wildfly::drivers(
  $install_postgresql_driver  = $wildfly::install_postgresql_driver,
  $install_mq_driver          = $wildfly::install_mq_driver,
  $install_db2_driver         = $wildfly::install_db2_driver
) {



  anchor{'wildfly::drivers::begin':}
  -> anchor{'wildfly::drivers::end':}

  Anchor['wildfly::drivers::begin']
  ->class{'wildfly::drivers::generic':
      name => 'org/wildfly/resources'
    }
  -> Anchor['wildfly::drivers::end']

  if str2bool($install_postgresql_driver) {
    Anchor['wildfly::drivers::begin']
    -> class{'wildfly::drivers::postgresql':}
    -> Anchor['wildfly::drivers::end']
  }

  if str2bool($install_mq_driver){
    Anchor['wildfly::drivers::begin']
    -> class{'wildfly::drivers::mq':}
    -> Anchor['wildfly::drivers::end']
  }

  if str2bool($install_db2_driver){
    Anchor['wildfly::drivers::begin']
    -> class{'wildfly::drivers::db2':}
    -> Anchor['wildfly::drivers::end']
  }



}
