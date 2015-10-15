#
#
class wildfly::validation{

  case $wildfly::mode{
    'standalone', 'domain' : {}
    default                : {fail("${wildfly::mode}: unsupported value for parameter mode")}
  }
  case $wildfly::profile{
    'standalone', 'standalone-full' : {}
    default                         : {fail("${wildfly::profile}: unsupported value for parameter mode")}
  }

  if $wildfly::install_postgresql_driver and !$wildfly::postgresql_download_url {
    fail('You must specify a download url for the PostgreSQL JDBC driver')
  }

}