require 'spec_helper'

describe 'wildfly::install' do
  let(:facts) {{ :osfamily => 'RedHat',
                 :concat_basedir => '/var/tmp' }}

  context 'with install_java set to true' do
    let (:params) {{ :install_java => 'true',
                     :user         => 'wildfly'
                  }}

    it {should contain_package('java-1.7.0-openjdk').with_ensure('present')}
  end

  context 'with install_java set to false' do
    let (:params) {{ :install_java => 'false',
                     :user         => 'wildfly'
    }}

    it {should_not contain_package('java-1.7.0-openjdk')}
  end

  context 'with install_dir set to /opt' do
    let (:params) {{ :install_dir => '/opt',
                     :version     => '8.1.0.Final',
                     :user        => 'wildfly'
    }}

    it {should contain_wildfly_netinstall('8.1.0.Final').with_destinationdir('/opt')}
    it {should contain_file('/opt/wildfly').with_ensure('link').with_target('/opt/wildfly-8.1.0.Final')}

  end

  context 'with install_dir set to /opt' do
    let (:params) {{ :install_dir => '/opt',
                     :version     => '8.1.0.Final',
                     :user        => 'jboss',
                     :shell       => '/bin/bash'
    }}

    it {should contain_wildfly_netinstall('8.1.0.Final').with_destinationdir('/opt').with_user('jboss').with_group('jboss')}
    it {should contain_file('/opt/wildfly').with_ensure('link').with_target('/opt/wildfly-8.1.0.Final').with_owner('jboss').with_group('jboss')}
    it {should contain_user('jboss').with_shell('/bin/bash')}
  end

end


# $version      = $wildfly::version,
#$install_dir  = $wildfly::install_dir,
#    $install_java = $wildfly::install_java,
#    $user         = $wildfly::user,
#    $shell        = $wildfly::shell,
#    $proxy_url    = $wildfly::proxy_url

# flow
# User[$user] ->
#     Wildfly_netinstall[$version] ->
#     File["${install_dir}/wildfly"]
#
# # java?
# if str2bool($install_java) == true {
#     case $::osfamily {
#   'RedHat' : {
#       $java_packages = ['java-1.7.0-openjdk']
#   User[$user] -> Package[$java_packages] -> Wildfly_netinstall[$version]
#
#   package { $java_packages: ensure => present }
# }
# default  : {
#         fail("${::osfamily}:${::operatingsystem} not supported by this module")
#     }
# }
# }
#
# wildfly_netinstall{$version:
#     destinationdir => "${install_dir}",
#     user           => $user,
#         group          => $user,
#         proxy_url      => $proxy_url,
# }
#
# file { "${install_dir}/wildfly":
#     ensure  => 'link',
#     force   => true,
#         owner   => "${user}",
#     group   => "${user}",
#     target  => "${install_dir}/wildfly-${version}",
# }
#
# user { "${user}":
#     shell   => "${shell}",
#     ensure  => "present"
# }
#
#
#
# }
