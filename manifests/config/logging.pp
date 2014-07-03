#
class wildfly::config::logging(
  $logging_properties = $wildfly::logging_properties,
  $install_dir        = $wildfly::install_dir,
  $mode               = $wildfly::mode
){

  $default_logging_properties = {'loggers' => { value => 'com.arjuna,jacorb,org.jboss.as.config,org.apache.tomcat.util.modeler,sun.rmi,jacorb.config'},
     'logger.level' => { value => 'INFO'},
     'logger.handlers' => { value => 'CONSOLE,FILE'},
     'logger.jacorb.level' => { value => 'WARN'},
     'logger.jacorb.useParentHandlers' => { value => 'true'},
     'logger.com.arjuna.level' => { value => 'WARN'},
     'logger.com.arjuna.useParentHandlers' => { value => 'true'},
     'logger.org.apache.tomcat.util.modeler.level' => { value => 'WARN'},
     'logger.org.apache.tomcat.util.modeler.useParentHandlers' => { value => 'true'},
     'logger.org.jboss.as.config.level' => { value => 'DEBUG'},
     'logger.org.jboss.as.config.useParentHandlers' => { value => 'true'},
     'logger.jacorb.config.level' => { value => 'ERROR'},
     'logger.jacorb.config.useParentHandlers' => { value => 'true'},
     'logger.sun.rmi.level' => { value => 'WARN'},
     'logger.sun.rmi.useParentHandlers' => { value => 'true'},
     'handler.CONSOLE' => { value => 'org.jboss.logmanager.handlers.ConsoleHandler'},
     'handler.CONSOLE.level' => { value => 'INFO'},
     'handler.CONSOLE.formatter' => { value => 'COLOR-PATTERN'},
     'handler.CONSOLE.properties' => { value => 'autoFlush,target,enabled'},
     'handler.CONSOLE.autoFlush' => { value => 'true'},
     'handler.CONSOLE.target' => { value => 'SYSTEM_OUT'},
     'handler.CONSOLE.enabled' => { value => 'true'},
     'handler.FILE' => { value => 'org.jboss.logmanager.handlers.PeriodicRotatingFileHandler'},
     'handler.FILE.level' => { value => 'ALL'},
     'handler.FILE.formatter' => { value => 'PATTERN'},
     'handler.FILE.properties' => { value => 'append,autoFlush,enabled,suffix,fileName'},
     'handler.FILE.constructorProperties' => { value => 'fileName,append'},
     'handler.FILE.append' => { value => 'true'},
     'handler.FILE.autoFlush' => { value => 'true'},
     'handler.FILE.enabled' => { value => 'true'},
     'handler.FILE.suffix' => { value => '.yyyy-MM-dd'},
     'handler.FILE.fileName' => { value => '/opt/wildfly/standalone/log/server.log'},
     'formatter.PATTERN' => { value => 'org.jboss.logmanager.formatters.PatternFormatter'},
     'formatter.PATTERN.properties' => { value => 'pattern'},
     'formatter.PATTERN.pattern' => { value => '%d{yyyy-MM-dd HH\:mm\:ss,SSS} %-5p [%c] (%t) %s%E%n'},
     'formatter.COLOR-PATTERN' => { value => 'org.jboss.logmanager.formatters.PatternFormatter'},
     'formatter.COLOR-PATTERN.properties' => { value => 'pattern'},
     'formatter.COLOR-PATTERN.pattern' => { value => '%K{level}%d{HH\:mm\:ss,SSS} %-5p [%c] (%t) %s%E%n'}
  }


  $default_settings = {'logging_file' => "${install_dir}/wildfly/${mode}/configuration/logging.properties" }

  create_resources(wildfly::config::logging_setting, merge($default_logging_properties, $logging_properties), $default_settings )
}

