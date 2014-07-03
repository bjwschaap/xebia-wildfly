#
class wildfly::config::logging(
  $logging_properties = $wildfly::logging_porperties,
  $install_dir        = $wildfly::install_dir,
  $mode               = $wildfly::mode
){

  $default_logging_properties = {
     'loggers' => { "jacorb,com.arjuna,org.apache.tomcat.util.modeler,org.jboss.as.config,jacorb.config,sun.rmi"},
     'logger.level' => { "INFO"},
     'logger.handlers' => { "CONSOLE,FILE"},
     'logger.jacorb.level' => { "WARN"},
     'logger.jacorb.useParentHandlers' => { "true"},
     'logger.com.arjuna.level' => { "WARN"},
     'logger.com.arjuna.useParentHandlers' => { "true"},
     'logger.org.apache.tomcat.util.modeler.level' => { "WARN"},
     'logger.org.apache.tomcat.util.modeler.useParentHandlers' => { 'true'},
     'logger.org.jboss.as.config.level' => { 'DEBUG'},
     'logger.org.jboss.as.config.useParentHandlers' => { 'true'},
     'logger.jacorb.config.level' => { 'ERROR'},
     'logger.jacorb.config.useParentHandlers' => { 'true'},
     'logger.sun.rmi.level' => { 'WARN'},
     'logger.sun.rmi.useParentHandlers' => { 'true'},
     'handler.CONSOLE' => { 'org.jboss.logmanager.handlers.ConsoleHandler'},
     'handler.CONSOLE.level' => { 'INFO'},
     'handler.CONSOLE.formatter' => { 'COLOR-PATTERN'},
     'handler.CONSOLE.properties' => { 'autoFlush,target,enabled'},
     'handler.CONSOLE.autoFlush' => { 'true'},
     'handler.CONSOLE.target' => { 'SYSTEM_OUT'},
     'handler.CONSOLE.enabled' => { 'true'},
     'handler.FILE' => { 'org.jboss.logmanager.handlers.PeriodicRotatingFileHandler'},
     'handler.FILE.level' => { 'ALL'},
     'handler.FILE.formatter' => { 'PATTERN'},
     'handler.FILE.properties' => { 'append,autoFlush,enabled,suffix,fileName'},
     'handler.FILE.constructorProperties' => { 'fileName,append'},
     'handler.FILE.append' => { 'true'},
     'handler.FILE.autoFlush' => { 'true'},
     'handler.FILE.enabled' => { 'true'},
     'handler.FILE.suffix' => { '.yyyy-MM-dd'},
     'handler.FILE.fileName' => { '/opt/wildfly/standalone/log/server.log'},
     'formatter.PATTERN' => { 'org.jboss.logmanager.formatters.PatternFormatter'},
     'formatter.PATTERN.properties' => { 'pattern'},
     'formatter.PATTERN.pattern' => { '%d{yyyy-MM-dd HH\:mm\:ss,SSS} %-5p [%c] (%t) %s%E%n'},
     'formatter.COLOR-PATTERN' => { 'org.jboss.logmanager.formatters.PatternFormatter'},
     'formatter.COLOR-PATTERN.properties' => { 'pattern'},
     'formatter.COLOR-PATTERN.pattern' => { '%K{level}%d{HH\:mm\:ss,SSS} %-5p [%c] (%t) %s%E%n'}
  }


  $default_settings = {'logging_file' => "${install_dir}/wildfly/${mode}/configuration/logging.properties" }

  create_resources(wildfly::config::logging_settings, merge($default_logging_properties, $logging_properties),$default_settings )
}

