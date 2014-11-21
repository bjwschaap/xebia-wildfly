require 'uri'
require 'etc'
require "digest/md5"
require File.expand_path(File.join(File.dirname(__FILE__), '..','zip.rb'))


Puppet::Type.type(:wildfly_netinstall).provide(:curl, :parent => Puppet::Provider::Zip)  do

  confine :osfamily => [:redhat,:debian]

  commands  :curl     => '/usr/bin/curl',
            :mktemp   => '/bin/mktemp',
            :mkdir    => '/bin/mkdir',
            :unzip    => '/usr/bin/unzip',
            :rm       => '/bin/rm',
            :chown    => '/bin/chown',
            :chgrp    => '/bin/chgrp'



  def create

    #file_type = extension(resource[:version])

    begin

      download_dir = mktemp('-d').strip

      mkdir('-p', "#{resource[:destinationdir]}")

      set_proxy_url

      curl( '--output', "#{download_dir}/archive.zip", url(resource[:version]))

      unzip("#{download_dir}/archive.zip", '-d', "#{resource[:destinationdir]}")

      chown('-R',"#{resource[:user]}:#{resource[:group]}", "#{resource[:destinationdir]}" )

    rescue Exception => e

      rm('-rf', download_dir) unless download_dir.nil?
      rm('-rf', "#{resource[:destinationdir]}/wildfly-#{resource[:version]}") if File.directory?("#{resource[:destinationdir]}/wildfly-#{resource[:version]}")

      self.fail e.message

    end
  end


end
