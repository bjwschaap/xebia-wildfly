# == Class wildfly::params
#
# This class is meant to be called from wildfly
# It sets variables according to platform
#
class wildfly::params {
  $bind_address             = '0.0.0.0'
  $bind_address_management  = '0.0.0.0'
  $user = 'wildfly'
  $shell = '/bin/bash'
  $install_dir = '/opt'
  $version = '9.0.0.CR2'
  $mode = 'standalone'
  $profile = 'standalone-full'
  $wait_time = '60'
  $console_log = '/var/log/wildfly/console.log'
  $pid_file = '/var/run/wildfly/wildfly.pid'
  $proxy_url = undef
  $install_java = true
  $java_home = undef
  $deployment_dir = '/var/tmp'

  # admin user
  $admin_user = 'wildfly-admin'
  $admin_password = 'changeme'

  #port config
  $ajp_port                 = '8009'
  $http_port                = '8080'
  $https_port               = '8443'
  $management_http_port     = '9990'
  $management_https_port    = '9993'

  #driver config
  $install_postgresql_driver = false
  $postgresql_download_url   = 'https://jdbc.postgresql.org/download/postgresql-9.2-1004.jdbc41.jar'
  $install_mq_driver         = false
  $mq_download_url           = undef
  $mq_config                 = undef
  $install_db2_driver        = false
  $db2_download_url          = undef

  #memory settings
  $xms                      = '512m'
  $xmx                      = '512m'
  $maxpermsize              = '128m'

  #logging settings
  $default_logging_properties = {
    'logger.level' => 'INFO',
    'logger.handlers' => 'CONSOLE,FILE',
    'logger.jacorb.level' => 'WARN',
    'logger.jacorb.useParentHandlers' => 'true',
    'logger.com.arjuna.level' => 'WARN',
    'logger.com.arjuna.useParentHandlers' => 'true',
    'logger.org.apache.tomcat.util.modeler.level' => 'WARN',
    'logger.org.apache.tomcat.util.modeler.useParentHandlers' => 'true',
    'logger.org.jboss.as.config.level' => 'DEBUG',
    'logger.org.jboss.as.config.useParentHandlers' => 'true',
    'logger.jacorb.config.level' => 'ERROR',
    'logger.jacorb.config.useParentHandlers' => 'true',
    'logger.sun.rmi.level' => 'WARN',
    'logger.sun.rmi.useParentHandlers' => 'true',
    'handler.CONSOLE' => 'org.jboss.logmanager.handlers.ConsoleHandler',
    'handler.CONSOLE.level' => 'INFO',
    'handler.CONSOLE.formatter' => 'COLOR-PATTERN',
    'handler.CONSOLE.properties' => 'autoFlush,target,enabled',
    'handler.CONSOLE.autoFlush' => 'true',
    'handler.CONSOLE.target' => 'SYSTEM_OUT',
    'handler.CONSOLE.enabled' => 'true',
    'handler.FILE' => 'org.jboss.logmanager.handlers.PeriodicRotatingFileHandler',
    'handler.FILE.level' => 'ALL',
    'handler.FILE.formatter' => 'PATTERN',
    'handler.FILE.properties' => 'append,autoFlush,enabled,suffix,fileName',
    'handler.FILE.append' => 'true',
    'handler.FILE.autoFlush' => 'true',
    'handler.FILE.enabled' => 'true',
    'handler.FILE.suffix' => '.yyyy-MM-dd',
    'handler.FILE.fileName' => "${wildfly::install_dir}/wildfly/${wildfly::mode}/log/server.log",
    'formatter.PATTERN' => 'org.jboss.logmanager.formatters.PatternFormatter',
    'formatter.PATTERN.properties' => 'pattern',
    'formatter.PATTERN.pattern' => '%d{yyyy-MM-dd HH\:mm\:ss,SSS} %-5p [%c] (%t) %s%e%n',
    'formatter.COLOR-PATTERN' => 'org.jboss.logmanager.formatters.PatternFormatter',
    'formatter.COLOR-PATTERN.properties' => 'pattern',
    'formatter.COLOR-PATTERN.pattern' => '%K{level}%d{HH\:mm\:ss,SSS} %-5p [%c] (%t) %s%e%n'
  }

  $logging_properties       = {}

  $system_properties        = {}

  case $::osfamily {
    'RedHat': {
      $default_conf = '/etc/default/wildfly.conf'
      $init_script = 'wildfly-init-redhat.sh'
    }
    'Debian': {
      $default_conf = '/etc/default/wildfly'
      $init_script = 'wildfly-init-debian.sh'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }

}
