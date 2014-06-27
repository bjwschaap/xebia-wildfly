require 'spec_helper'

describe 'wildfly::config::logging' do
  let(:facts) {{ :osfamily => 'RedHat',
                 :concat_basedir => '/var/tmp' }}
  context 'basic file test' do
    let(:params) {{
        :install_dir        => '/opt',
        :logging_properties => {'loggers' => 'com.arjuna', 'test' => 'foobar'},
        :mode               => 'standalone' }}

    it {should contain_file('/opt/wildfly/standalone/configuration/logging.properties').with_content(/loggers = com.arjuna/)}
  end
end
