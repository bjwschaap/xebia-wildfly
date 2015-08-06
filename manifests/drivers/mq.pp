# This installs the MQ drivers
class wildfly::drivers::mq(
  $install_dir        = $wildfly::install_dir,
  $download_url       = $wildfly::mq_download_url,
  $proxy_url          = $wildfly::proxy_url
){

  # physical driver
  if !$download_url {
    fail( 'You must specify a download location for the MQ JMS resource adapter RAR file.' )
  }

  wildfly_driver_download{$download_url:
    proxy_url       => $proxy_url,
    destinationdir  => "${install_dir}/wildfly/standalone/deployments",
  }


}
