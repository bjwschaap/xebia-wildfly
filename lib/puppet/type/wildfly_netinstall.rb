require 'pathname'

Puppet::Type.newtype(:wildfly_netinstall) do

  desc 'download and unpack a wildfly archive file from the interwebs'

  ensurable do
    desc "wildfly_netinstall resource state"

    defaultto(:present)

    newvalue(:present) do
      provider.create
    end

    newvalue(:absent) do
      provider.destroy
    end
  end



  newparam(:version, :namevar => true) do
    desc 'the version or wildfly you want to install'
  end

  newparam(:destinationdir) do
    desc 'destination of the extraction operation'
    validate do |value|

      fail('invalid pathname') unless Pathname.new(value).absolute?
    end
  end

  newparam(:proxy_url) do
    desc 'http proxy url'
  end

  newproperty(:owner) do
    desc 'the owner setting of the license file'
    defaultto 'wildfly'
  end

  newproperty(:group) do
    desc 'the group setting of the license file'
    defaultto 'wildfly'
  end

end