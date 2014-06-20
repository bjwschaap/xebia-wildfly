require 'uri'
require 'etc'
require "digest/md5"
require File.expand_path(File.join(File.dirname(__FILE__), '..','jar.rb'))


Puppet::Type.type(:wildfly_download_driver).provide(:curl, :parent => Puppet::Provider::Jar)  do

  confine :osfamily => [:redhat]


  commands  :curl     => '/usr/bin/curl',
            :mktemp   => '/bin/mktemp',
            :mkdir    => '/bin/mkdir',
            :rm       => '/bin/rm',
            :chown    => '/bin/chown',
            :chgrp    => '/bin/chgrp'



  def create

    begin



      mkdir('-p', "#{resource[:destinationdir]}")


      set_proxy_url

      
      curl( '--output', "#{full_file_path}" , "#{resource[:url]}" )


      chown('-R',"#{resource[:user]}:#{resource[:group]}", "#{full_file_path}" )

    rescue Exception => e


      rm('-rf', "#{full_file_path}") if File.exist?("#{full_file_path}")

      self.fail e.message

    end
  end


end