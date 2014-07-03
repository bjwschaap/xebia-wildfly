require 'spec_helper'

describe "wildfly standalone.xml templates content" do
  let(:facts) {{ :osfamily => 'RedHat',
                 :concat_basedir => '/var/tmp' }}

  [
    {
      :filename => '/opt/wildfly/standalone/configuration/standalone-full.xml',
      :title => '',
      :settings => {'install_dir' => '/opt',
                    'mode'        => 'standalone',
                    'profile'     => 'standalone-full'} ,
      :match => [""]
    }
  ].each do |param|

    context "when #{param[:attr]} is #{param[:value]} for #{param[:filename]}" do

    let(:params) { param[:settings] }

    it { should contain_file(param[:filename])}
      it param[:title] do
        verify_contents(subject, param[:filename], Array(param[:match]))
      end  # it
    end # context
  end # each
end #describe
${install_dir}/wildfly/${mode}/configuration/${profile}.xml"