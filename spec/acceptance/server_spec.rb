require 'spec_helper_acceptance'

describe 'server:', :unless => UNSUPPORTED_PLATFORMS.include?(fact('osfamily')) do

  after :all do
    pp = <<-EOS.unindent
      package {'java-1.7.0-openjdk': ensure => absent }
    EOS

    apply_manifest(pp)

    shell '/bin/rm -rf /opt/wildfly*'

  end

  it 'test loading class with no parameters' do
    pp = <<-EOS.unindent
      class { 'wildfly': }
    EOS

    apply_manifest(pp, :catch_failures => true)
    apply_manifest(pp, :catch_changes => true)

  end

  describe service('wildfly') { it {should be_running} }
  describe file('/opt/wildfly') { it {should be_directory} }
end