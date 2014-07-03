#
class wildfly::config::logging(
  $logging_properties = $wildfly::logging_porperties,
  $install_dir        = $wildfly::install_dir,
  $mode               = $wildfly::mode
){

  $default_logging_properties = {
    {setting => 'loggers', value =>  "jacorb,com.arjuna,org.apache.tomcat.util.modeler,org.jboss.as.config,jacorb.config,sun.rmi"},
    {setting => 'logger.level', value =>  "INFO"},
    {setting => 'logger.handlers', value =>  "CONSOLE,FILE"},
    {setting => 'logger.jacorb.level', value =>  "WARN"},
    {setting => 'logger.jacorb.useParentHandlers', value =>  "true"},
    {setting => 'logger.com.arjuna.level', value =>  "WARN"},
    {setting => 'logger.com.arjuna.useParentHandlers', value =>  "true"},
    {setting => 'logger.org.apache.tomcat.util.modeler.level', value =>  "WARN"},
    {setting => 'logger.org.apache.tomcat.util.modeler.useParentHandlers', value =>  'true'},
    {setting => 'logger.org.jboss.as.config.level', value =>  'DEBUG'},
    {setting => 'logger.org.jboss.as.config.useParentHandlers', value =>  'true'},
    {setting => 'logger.jacorb.config.level', value =>  'ERROR'},
    {setting => 'logger.jacorb.config.useParentHandlers', value =>  'true'},
    {setting => 'logger.sun.rmi.level', value =>  'WARN'},
    {setting => 'logger.sun.rmi.useParentHandlers', value =>  'true'},
    {setting => 'handler.CONSOLE', value =>  'org.jboss.logmanager.handlers.ConsoleHandler'},
    {setting => 'handler.CONSOLE.level', value =>  'INFO'},
    {setting => 'handler.CONSOLE.formatter', value =>  'COLOR-PATTERN'},
    {setting => 'handler.CONSOLE.properties', value =>  'autoFlush,target,enabled'},
    {setting => 'handler.CONSOLE.autoFlush', value =>  'true'},
    {setting => 'handler.CONSOLE.target', value =>  'SYSTEM_OUT'},
    {setting => 'handler.CONSOLE.enabled', value =>  'true'},
    {setting => 'handler.FILE', value =>  'org.jboss.logmanager.handlers.PeriodicRotatingFileHandler'},
    {setting => 'handler.FILE.level', value =>  'ALL'},
    {setting => 'handler.FILE.formatter', value =>  'PATTERN'},
    {setting => 'handler.FILE.properties', value =>  'append,autoFlush,enabled,suffix,fileName'},
    {setting => 'handler.FILE.constructorProperties', value =>  'fileName,append'},
    {setting => 'handler.FILE.append', value =>  'true'},
    {setting => 'handler.FILE.autoFlush', value =>  'true'},
    {setting => 'handler.FILE.enabled', value =>  'true'},
    {setting => 'handler.FILE.suffix', value =>  '.yyyy-MM-dd'},
    {setting => 'handler.FILE.fileName', value =>  '/opt/wildfly/standalone/log/server.log'},
    {setting => 'formatter.PATTERN', value =>  'org.jboss.logmanager.formatters.PatternFormatter'},
    {setting => 'formatter.PATTERN.properties', value =>  'pattern'},
    {setting => 'formatter.PATTERN.pattern', value =>  '%d{yyyy-MM-dd HH\:mm\:ss,SSS} %-5p [%c] (%t) %s%E%n'},
    {setting => 'formatter.COLOR-PATTERN', value =>  'org.jboss.logmanager.formatters.PatternFormatter'},
    {setting => 'formatter.COLOR-PATTERN.properties', value =>  'pattern'},
    {setting => 'formatter.COLOR-PATTERN.pattern', value =>  '%K{level}%d{HH\:mm\:ss,SSS} %-5p [%c] (%t) %s%E%n'}
  }


  $default_settings = {'logging_file' => "${install_dir}/wildfly/${mode}/configuration/logging.properties" }

  create_resources(wildfly::config::logging_settings, merge($default_logging_properties, $logging_properties),$default_settings )
}

