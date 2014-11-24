# This sets the WildFly profile
#
class wildfly::config::profile(
  $install_dir                = $wildfly::install_dir,
  $mode                       = $wildfly::mode,
  $profile                    = $wildfly::profile,
  $install_postgresql_driver  = $wildfly::install_postgresql_driver,
  $install_mq_driver          = $wildfly::install_mq_driver,
  $user                       = $wildfly::user,
  $system_properties          = $wildfly::system_properties
){

# variables
  case $profile {
    'standalone-full': {
      $profile_extensions = [
        'org.jboss.as.clustering.infinispan',
        'org.jboss.as.connector',
        'org.jboss.as.deployment-scanner',
        'org.jboss.as.ee',
        'org.jboss.as.ejb3',
        'org.jboss.as.jacorb',
        'org.jboss.as.jaxrs',
        'org.jboss.as.jdr',
        'org.jboss.as.jmx',
        'org.jboss.as.jpa',
        'org.jboss.as.jsf',
        'org.jboss.as.jsr77',
        'org.jboss.as.logging',
        'org.jboss.as.mail',
        'org.jboss.as.messaging',
        'org.jboss.as.naming',
        'org.jboss.as.pojo',
        'org.jboss.as.remoting',
        'org.jboss.as.sar',
        'org.jboss.as.security',
        'org.jboss.as.threads',
        'org.jboss.as.transactions',
        'org.jboss.as.webservices',
        'org.jboss.as.weld',
        'org.wildfly.extension.batch',
        'org.wildfly.extension.io',
        'org.wildfly.extension.undertow'
      ]
      $profile_subsystems = [
        'jboss:domain:batch:1.0',
        'jboss:domain:datasources:2.0',
        'jboss:domain:deployment-scanner:2.0',
        'jboss:domain:ee:2.0',
        'jboss:domain:ejb3:2.0',
        'jboss:domain:infinispan:2.0',
        'jboss:domain:io:1.0',
        'jboss:domain:jacorb:1.3',
        'jboss:domain:jaxrs:1.0',
        'jboss:domain:jca:2.0',
        'jboss:domain:jdr:1.0',
        'jboss:domain:jmx:1.3',
        'jboss:domain:jpa:1.1',
        'jboss:domain:jsf:1.0',
        'jboss:domain:jsr77:1.0',
        'jboss:domain:logging:2.0',
        'jboss:domain:mail:2.0',
        'jboss:domain:messaging:2.0',
        'jboss:domain:naming:2.0',
        'jboss:domain:pojo:1.0',
        'jboss:domain:remoting:2.0',
        'jboss:domain:resource-adapters:2.0',
        'jboss:domain:sar:1.0',
        'jboss:domain:security:1.2',
        'jboss:domain:threads:1.1',
        'jboss:domain:transactions:2.0',
        'jboss:domain:undertow:1.0',
        'jboss:domain:webservices:1.2',
        'jboss:domain:weld:2.0',
      ]
    }
    'standalone':  {
      $profile_extensions = [
        'org.jboss.as.clustering.infinispan',
        'org.jboss.as.connector',
        'org.jboss.as.deployment-scanner',
        'org.jboss.as.ee',
        'org.jboss.as.ejb3',
        'org.jboss.as.jaxrs',
        'org.jboss.as.jdr',
        'org.jboss.as.jmx',
        'org.jboss.as.jpa',
        'org.jboss.as.jsf',
        'org.jboss.as.logging',
        'org.jboss.as.mail',
        'org.jboss.as.naming',
        'org.jboss.as.pojo',
        'org.jboss.as.remoting',
        'org.jboss.as.sar',
        'org.jboss.as.security',
        'org.jboss.as.threads',
        'org.jboss.as.transactions',
        'org.jboss.as.webservices',
        'org.jboss.as.weld',
        'org.wildfly.extension.batch',
        'org.wildfly.extension.io',
        'org.wildfly.extension.undertow'
      ]
      $profile_subsystems = [
        'jboss:domain:batch:1.0',
        'jboss:domain:datasources:2.0',
        'jboss:domain:deployment-scanner:2.0',
        'jboss:domain:ee:2.0',
        'jboss:domain:ejb3:2.0',
        'jboss:domain:infinispan:2.0',
        'jboss:domain:io:1.0',
        'jboss:domain:jaxrs:1.0',
        'jboss:domain:jca:2.0',
        'jboss:domain:jdr:1.0',
        'jboss:domain:jmx:1.3',
        'jboss:domain:jpa:1.1',
        'jboss:domain:jsf:1.0',
        'jboss:domain:logging:2.0',
        'jboss:domain:mail:2.0',
        'jboss:domain:naming:2.0',
        'jboss:domain:pojo:1.0',
        'jboss:domain:remoting:2.0',
        'jboss:domain:resource-adapters:2.0',
        'jboss:domain:sar:1.0',
        'jboss:domain:security:1.2',
        'jboss:domain:threads:1.1',
        'jboss:domain:transactions:2.0',
        'jboss:domain:undertow:1.0',
        'jboss:domain:webservices:1.2',
        'jboss:domain:weld:2.0',
      ]
    }
    default: {
      fail 'Unsupported profile setting'
    }
  }

  concat { "${install_dir}/wildfly/${mode}/configuration/${profile}.xml":
    owner => $user,
    group => $user,
    mode  => 0644,
  }

  Concat::Fragment{target => "${install_dir}/wildfly/${mode}/configuration/${profile}.xml" }

  concat::fragment{'file_header':
    content => template('wildfly/standalone/file_header.xml.erb'),
    order   => '10'
  }
  concat::fragment{'extension_header':
    content => template('wildfly/standalone/extensions_header.xml.erb'),
    order   => '20'
  }
  wildfly::profile::extension{$profile_extensions:
    target => "${install_dir}/wildfly/${mode}/configuration/${profile}",
    order  => '25'
  }

  concat::fragment{'extension_footer':
    content => template('wildfly/standalone/extensions_footer.xml.erb'),
    order   => '30'
  }

  concat::fragment{'system_properties_header':
    content => template('wildfly/standalone/system_properties_header.xml.erb'),
    order   => '32'
  }

  wildfly::profile::system_properties{$system_properties:
    target => "${install_dir}/wildfly/${mode}/configuration/${profile}",
    order  => '34',
    notify => Service['wildfly']
  }

  concat::fragment{'system_properties_footer':
    content => template('wildfly/standalone/system_properties_footer.xml.erb'),
    order   => '36'
  }

  concat::fragment{'management_section':
    content => template('wildfly/standalone/management_section.xml.erb'),
    order   => '40'
  }
  concat::fragment{'profile_header':
    content => template('wildfly/standalone/profile_header.xml.erb'),
    order   => '50',
  }
  wildfly::profile::subsystem{$profile_subsystems:
    target => "${install_dir}/wildfly/${mode}/configuration/${profile}",
    order  => '55'
  }
  concat::fragment{'profile_footer':
    content => template('wildfly/standalone/profile_footer.xml.erb'),
    order   => '60'
  }
  concat::fragment{'interfaces':
    content => template('wildfly/standalone/interfaces.xml.erb'),
    order   => '70'
  }
  concat::fragment{'socket_bindings':
    content => template('wildfly/standalone/socket_bindings.xml.erb'),
    order   => '80'
  }
  concat::fragment{'file_footer':
    content => template('wildfly/standalone/file_footer.xml.erb'),
    order   => '90'
  }
}
