require 'spec_helper'

describe 'wildfly::config::logging' do
  let(:facts) {{ :osfamily => 'RedHat',
                 :concat_basedir => '/var/tmp' }}
  context 'basic  test' do
    let(:params) {{
        :install_dir        => '/opt',
        :logging_properties => {'loggers' => { 'value' => 'com.arjuna'}, 'test' => { 'value' => 'foobar'}},
        :mode               => 'standalone' }}

    it {should contain_ini_setting('loggers').with_value('com.arjuna')}
  end
end
