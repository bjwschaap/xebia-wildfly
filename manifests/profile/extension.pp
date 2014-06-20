define wildfly::profile::extension(
  $target,
  $extension = $name,
  $order = "5"
){

  concat::fragment{"extension:${extension}":
    content => template("wildfly/standalone/extension.xml.erb")
  }

}