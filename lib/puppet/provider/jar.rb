
require 'uri'
require 'etc'
require "digest/md5"

class Puppet::Provider::Jar < Puppet::Provider
  def exists?
    File.exist?(full_file_path)
  end


  def destroy
    rm('-rf', full_file_path )
  end

  def user
    uid = File.stat(full_file_path).uid
    Etc.getpwuid(uid).name
  end

  def user=(value)
    chown('-R', "#{resource[:user]}" , full_file_path)
  end

  def group
    gid = File.stat(full_file_path).gid
    Etc.getgrgid(gid).name
  end

  def group=(value)
    chgrp('-R', "#{resource[:group]}", full_file_path)
  end

  private

  def filename
    File.basename(resource[:url])
  end

  def full_file_path
    "#{resource[:destinationdir]}/#{filename}"
  end

  def md5_match?(file)
    unless resource[:md5hash].nil?
      raise "md5 hash does not match" unless resource[:md5hash] == Digest::MD5.file("#{file}").hexdigest
    end
  end

  def set_proxy_url
    unless resource[:proxy_url].nil?
      ENV['http_proxy'] = resource[:proxy_url]
    end
  end



end