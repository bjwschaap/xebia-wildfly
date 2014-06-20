require 'pathname'

Puppet::Type.newtype(:wildfly_driver_download) do

  desc 'download  a wildfly driver jar file from the interwebs'

  ensurable do
    desc "wildfly_driver_download resource state"

    defaultto(:present)

    newvalue(:present) do
      provider.create
    end

    newvalue(:absent) do
      provider.destroy
    end
  end



  newparam(:url, :namevar => true) do
    desc 'url to the driver you want to download'
  end

  newparam(:destinationdir) do
    validate do |value|

      fail('invalid pathname') unless Pathname.new(value).absolute?
    end
  end

  newparam(:proxy_url) do
    desc 'http proxy url'
  end

  newproperty(:user) do
    desc 'the owner setting driver'
    defaultto 'wildfly'
  end

  newproperty(:group) do
    desc 'the group setting driver file'
    defaultto 'wildfly'
  end

end