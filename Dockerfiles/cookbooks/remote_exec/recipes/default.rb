#
# Cookbook Name:: remote_exec
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

ruby_block "execute_command_in_jenkins_master" do
	block do
		require 'rubygems'
		require 'net/ssh'

#		HOST = '10.114.90.221'
#		USER = 'vagrant'
#		PASS = 'vagrant'

#		Net::SSH.start( HOST, USER, :password => PASS ) do|ssh|
		Net::SSH.start( node[:host], node[:user], :password => node[:password] ) do|ssh|
	        output = ssh.exec('java -jar jenkins-cli.jar')
		puts output
		end
	end
end
