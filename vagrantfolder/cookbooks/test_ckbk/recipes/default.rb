#
# Cookbook Name:: test_ckbk
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#package "test_ckbk" do						#works fine : debian
#case node[:platform_family]
#  when "debian"
#  exec("wget #{node[:source]} -P #{node[:path]}")
#  end
#end

#case node[:platform_family]					#works fine : debian
#   when "debian"
#	execute "mycomm" do
#	   command "wget #{node[:source]} -P #{node[:path]}"
# 	   action :run
#	end
#   end
case node[:platform_family]
   when "debian"
#	remote_file "#{node[:path_for_jenkinswar_slave]}/jenkins.war" do		#works fine...should work with windows too..by changing path
#   	  source "#{node[:source_for_jenkinswar]}"
#	end	

	remote_directory "#{node[:jenkins_conf_path_in_slave]}" do
	  source "#{node[:path_to_jenkins_conf]}"
 	end


#	execute "run_jenkins_war" do					#check if this applies for windows or use powershell
#	  command "#{node[:java_home_slave]} -jar #{node[:path]}/jenkins.war"
#	  action :run
#   	end
end
#http_request "test_ckbk" do
#   url "http://10.114.10.200:8081/nexus/content/repositories/ctomavenrepo/jboss/javassist/3.3.ga/javassist-3.3.ga.jar"
#   action :get
#end

#exec('wget http://10.114.10.200:8081/nexus/content/repositories/ctomavenrepo/jboss/javassist/3.3.ga/javassist-3.3.ga.jar -P /home/wipro/')
#ruby "test_ckbk" do
#code "
#require 'net/http'
#Net::HTTP.start('10.114.10.200', '8081') do |http|
#    resp = http.get('/nexus/content/repositories/ctomavenrepo/jboss/javassist/3.3.ga/javassist-3.3.ga.jar')
#Net::HTTP.start('repo1.maven.org') do |http|
#     resp = http.get('/maven2/javassist/javassist/3.12.1.GA/javassist-3.12.1.GA.jar')
#    open('jassist.jar', 'wb') do |file|
#        file.write(resp.body)
#    end
#end
#"
#action :run
#end
