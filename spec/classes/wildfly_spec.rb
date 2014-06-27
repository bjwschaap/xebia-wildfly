require 'spec_helper'

describe 'wildfly' do
  let(:facts) {{ :osfamily => 'RedHat',
                 :concat_basedir => '/var/tmp' }}

  context 'supported operating systems' do
    ['RedHat'].each do |osfamily|
      describe "deployit class without any parameters on #{osfamily}" do

        let(:params) {{ }}

        it { should contain_class('wildfly::params') }
        it { should contain_class('wildfly::validation') }
        it { should contain_class('wildfly::install')}
        it { should contain_class('wildfly::config')}
        it { should contain_class('wildfly::config::logging')}
        it { should contain_class('wildfly::service')}
        it { should contain_class('wildfly::drivers')}
      end
    end
  end

  context 'unsupported entry for mode parameter' do
    let(:params) {{ :mode => 'foobar' }}
    it do
      expect { should compile }.to raise_error(Puppet::Error)
    end
  end
  context 'unsupported entry for profile parameter' do
    let(:params) {{ :profile => 'foobar' }}
    it do
      expect { should compile }.to raise_error(Puppet::Error)
    end
  end

end



