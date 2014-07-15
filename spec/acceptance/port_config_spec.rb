require 'spec_helper_acceptance'

describe 'server:', :unless => UNSUPPORTED_PLATFORMS.include?(fact('osfamily')) do

  after :all do
    pp = <<-EOS.unindent
      package {'java-1.7.0-openjdk': ensure => absent }
    EOS

    apply_manifest(pp)

    shell '/bin/rm -rf /opt/wildfly*'

  end

  it 'test specifying the various port settings' do

    pp = <<-EOS.unindent
      class {'wildfly':
        ajp_port              =>  '10001',
        http_port             =>  '10002',
        https_port            =>  '10003',
        management_http_port  =>  '10004',
        management_https_port =>  '10005'    }
    EOS

    apply_manifest(pp, :catch_failures  => true)
    apply_manifest(pp, :catch_changes   => true)

  end

  describe port(10001) { it { should be_listening } }
  describe port(10002) { it { should be_listening } }
  describe port(10003) { it { should be_listening } }
  describe port(10004) { it { should be_listening } }
  describe port(10005) { it { should be_listening } }


end