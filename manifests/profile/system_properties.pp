# Adds a fragment to the WildFly profile
#
define wildfly::profile::system_properties(
  $target,
  $system_property = $name,
  $order = '34'
){

  concat::fragment{"system_property:${system_property}":
    content => template('wildfly/standalone/extension.xml.erb'),
    order   => $order
  }

}
