#== Class: wildfly
class wildfly(
  $bind_address             = $wildfly::params::bind_address,
  $bind_address_management  = $wildfly::params::bind_address_management,
  $user                     = $wildfly::params::user,
  $shell                    = $wildfly::params::shell,
  $install_dir              = $wildfly::params::install_dir,
  $install_java             = $wildfly::params::install_java,
  $version                  = $wildfly::params::version,
  $mode                     = $wildfly::params::mode,
  $profile                  = $wildfly::params::profile,
  $wait_time                = $wildfly::params::wait_time,
  $console_log              = $wildfly::params::console_log,
  $pid_file                 = $wildfly::params::pid_file,
  $proxy_url                = $wildfly::params::proxy_url,
  $deployment_dir           = $wildfly::params::deployment_dir,
  $admin_user               = $wildfly::params::admin_user,
  $admin_password           = $wildfly::params::admin_password
) inherits wildfly::params {

  # variables
  $profile_extensions = [
      "org.jboss.as.clustering.infinispan",
      "org.jboss.as.connector",
      "org.jboss.as.deployment-scanner",
      "org.jboss.as.ee",
      "org.jboss.as.ejb3",
      "org.jboss.as.jacorb",
      "org.jboss.as.jaxrs",
      "org.jboss.as.jdr",
      "org.jboss.as.jmx",
      "org.jboss.as.jpa",
      "org.jboss.as.jsf",
      "org.jboss.as.jsr77",
      "org.jboss.as.logging",
      "org.jboss.as.mail",
      "org.jboss.as.messaging",
      "org.jboss.as.naming",
      "org.jboss.as.pojo",
      "org.jboss.as.remoting",
      "org.jboss.as.sar",
      "org.jboss.as.security",
      "org.jboss.as.threads",
      "org.jboss.as.transactions",
      "org.jboss.as.webservices",
      "org.jboss.as.weld",
      "org.wildfly.extension.batch",
      "org.wildfly.extension.io",
      "org.wildfly.extension.undertow"
  ]
  $profile_subsystems = [
      "jboss:domain:batch:1.0",
      "jboss:domain:datasources:2.0",
      "jboss:domain:deployment-scanner:2.0",
      "jboss:domain:ee:2.0",
      "jboss:domain:ejb3:2.0",
      "jboss:domain:infinispan:2.0",
      "jboss:domain:io:1.0",
      "jboss:domain:jacorb:1.3",
      "jboss:domain:jaxrs:1.0",
      "jboss:domain:jca:2.0",
      "jboss:domain:jdr:1.0",
      "jboss:domain:jmx:1.3",
      "jboss:domain:jpa:1.1",
      "jboss:domain:jsf:1.0",
      "jboss:domain:jsr77:1.0",
      "jboss:domain:logging:2.0",
      "jboss:domain:mail:2.0",
      "jboss:domain:messaging:2.0",
      "jboss:domain:naming:2.0",
      "jboss:domain:pojo:1.0",
      "jboss:domain:remoting:2.0",
      "jboss:domain:resource-adapters:2.0",
      "jboss:domain:sar:1.0",
      "jboss:domain:security:1.2",
      "jboss:domain:threads:1.1",
      "jboss:domain:transactions:2.0",
      "jboss:domain:undertow:1.0",
      "jboss:domain:webservices:1.2",
      "jboss:domain:weld:2.0",
  ]

  #flow
  anchor{'wildfly::begin': } ->
  class{'wildfly::install': } ->
  class{'wildfly::config': } ~>
  class{'wildfly::service': } ->
  anchor{'wildfly::end': }

}
