define wildfly::profile::subsystem(
  $target,
  $subsystem = $name,
  $order = "35"
){

  concat::fragment{"subsystem:${subsystem}":
    content => template("wildfly/standalone/subsystems/${subsystem}.xml.erb"),
    order   => $order
  }

}