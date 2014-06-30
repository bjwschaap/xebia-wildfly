require 'spec_helper_acceptance'

describe 'server:', :unless => UNSUPPORTED_PLATFORMS.include?(fact('osfamily')) do


  it 'test loading class with no parameters' do
    pp = <<-EOS.unindent
      class { 'wildfly': }
    EOS

    apply_manifest(pp, :catch_failures => true)
    apply_manifest(pp, :catch_changes => true)
  end

  describe port(9990) do
    it { should be_listening }
  end
end