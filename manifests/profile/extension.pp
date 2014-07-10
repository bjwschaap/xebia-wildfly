define wildfly::profile::extension(
  $target,
  $extension = $name,
  $order = "25"
){

  concat::fragment{"extension:${extension}":
    content => template("wildfly/standalone/extension.xml.erb"),
    order   => $order
  }

}