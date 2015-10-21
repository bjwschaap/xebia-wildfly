xebia-wildfly
=============

####Table of Contents

1. [Overview](#overview)

2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with xebia-wildfly](#setup)
    * [What xebia-wildfly affects](#what-xebia-wildfly-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with xebia-wildfly](#beginning-with-xebia-wildfly)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)todo
5. [Limitations - OS compatibility, etc.](#limitations)todo
6. [Development - Guide for contributing to the module](#development)todo
7  [Wish list - What i really want to do in the near future](#wishlist)
overview
--------
This wildfly module enables you to install, configure and manage jboss community editon (wildfly)

module-description
------------------
Wildfly is one of the last java application servers. This module is aimed at installing and configuring it using puppet.
It supports full and web profile installations as well as standalone and domain setups.

setup
-----
**what-xebia-wildfly-affects:**

* installation/service/configuration files for Wildfly
* listened-to ports
* driver installation (only postgresql for now)
* installs compatible java version (optional)
*

**setup-requirements**

This module requires the usual suspects in terms of dependency modules: puppetlabs-stdlib, puppetlabs-concat and puppetlabs-inifile


**beginning-with-xebia-wildfly**

Basic usage when installing a wildfly server

    class{wildfly:}

For a more comprehensive setup

    class{wildfly:
        install_java                      => true,
        bind_address                      => '0.0.0.0',
        http_port                         => '8080'
     }

Basic client setup

    class{xldeploy:
        server => false
     }

**usage**

*parameters*
####`bind_address`
    this will set the default bind address the application server will listen on (default: 0.0.0.0)
####`bind_address_management`
    this will set the  bind address the application server management port will listen on (default: 0.0.0.0)
####`user`
    specify the user the application server should be installed under and run as. (default: wildfly)
####`shell`
    specify the shell the application server user should get (default: /bin/bash)
####`install_dir`
    the base installation dir both the installation and home dir for wildfly are created under (default: /opt)
####`install_java`
    specify if java should be installed (default: 'true')
####`version`
    specify the version of wildfly that needs to be installed (default: 8.1.0.Final)
####`mode`
    specify wether this should be a domain or standalone installation (default: standalone)
####`profile`
    specify wether this should be a web or a full profile: values standalone/standalone-full (default: standalone-full)
####`wait_time`
    specify the amount of time in seconds that the server should wait before a startup of shutdown (default: 60)
####`console_log`
    specify where the console log will  (default: /var/log/wildfly/console.log)
####`pid_file`
    specify where the pid file will go (default: /var/run/wildfly/wildfly.pid)
####`proxy_url`
    specify the proxy url to use when behind a corporate proxy. This is used to download the wildfly installation file from the boys over at redhat
####`deployment_dir`
    specify the directory that wildfly scans for new deployments (shitty default: /var/tmp)
####`admin_user`
    specify the admin user for the wildfly admin console (default: wildfly-admin)
####`admin_password`
    specify the admin password for the wildfly admin console (default: changeme <.... and you should>)
####`ajp_port`
    the ajp port setting. (default: 8009)
####`http_port`
    the http port setting. (default: 8080)
####`https_port`
    the https port setting. (default: 8443)
####`management_http_port`
    the management http port (default: 9990)
####`management_https_port`
    the management https port setting (default: 9993)
####`install_postgresql_driver`
    specify whether the postgreql driver should be installed (default: 'false')
####`postgresql_download_url`
    the url where the postgresql jdbc driver can be downloaded from (default: 'https://jdbc.postgresql.org/download/postgresql-9.2-1004.jdbc41.jar')
####`install_mq_driver`
    downloads and installs the IBM Websphere MQ driver from $mq_download_url
####`mq_download_url`
    url to a location where the IBM Websphere MQ wmq.jmsra.rar resource adapter file can be downloaded
####`mq_config`
    optional hash with the configuration for the IBM Websphere MQ resource adapter.
    Example:
     { 'username'      => 'mquser',
       'password'      => 's3cr3t',
       'transportType' => 'CLIENT',
       'ccdtURL'       => 'file:///kvk/wildfly/standalone/configuration/MYMQMAS.TAB',
       'queueManager'  => '*MQMAS'
     }
####`xmx`
    specify the xmx startup setting (default: 256m)
####`xms`
    specify the xms startup setting (default: 512m)
####`maxpermsize`
    specify the maxpermsize setting (default: 128m)
####`logging_properties`
    specify the logging_properties you might be inclined to set.
    this is a hash parameter with a bit of a special construction behind it .
    See the examples further on (if i ever get around to writing them)

wishlist
--------------------------
**domain setup**
i haven't got around to put any efford into the domain installation.
basicly your on your own if you want to give it a try.
Any pull request concerning this subject will be greatly appreciated
