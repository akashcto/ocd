#
# Cookbook Name:: nexus_war
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#include_recipe 'chef-tomcat-bin'

ruby_block "remove_recipe" do
  block do
     puts node.run_list
     node.run_list.remove("recipe[nexus_war]") 
     puts node.run_list
  end
end

ruby_block "configuration_done" do
  block do
    require 'net/http'
    require 'uri'
    uri = URI.parse("http://10.114.90.164:4567/configuration/success")
    http = Net::HTTP.new(uri.host, uri.port)
#    http.read_timeout = 5000
#    postData = Net::HTTP.post_form(URI.parse('http://10.114.90.164:4567/result'), {'job_type'=>'Chef Configuration', 'result'=>'success', 'env'=>'dev'})
#    request = Net::HTTP::Post.new(uri.request_uri)
#    request.set_form_data({"job_type" => "Chef Configuration", "result" => "success", "env" => "dev"})
    response = http.request(Net::HTTP::Get.new(uri.request_uri))
  end
  action :create
end

remote_file node[:file_path1] do
         source node[:file_source1]
	action :create_if_missing
       end

#remote_file "#{node[:file_path2]}" do
#         source "#{node[:file_source2]}"
#	action :create_if_missing
#       end

bash "install_tomcat" do
  user "root"
  code <<-EOH
    export CATALINA_OPTS="-Xms512M -Xmx1024M"
    cd /usr/local/tomcat/bin
    sh startup.sh
  EOH
end


ruby_block "deployment_done" do
  block do
    require 'net/http'
    require 'uri'
    uri = URI.parse("http://10.114.90.164:4567/deployment/success")
    http = Net::HTTP.new(uri.host, uri.port)
#    http.read_timeout = 5000
#    postData = Net::HTTP.post_form(URI.parse('http://10.114.90.164:4567/result'), {'job_type'=>'Chef Deployment', 'result'=>'success', 'env'=>'dev'})
#    request = Net::HTTP::Post.new(uri.request_uri)
#    request.set_form_data({"job_type" => "Chef Deployment", "result" => "success", "env" => "dev"})
    response = http.request(Net::HTTP::Get.new(uri.request_uri))
  end
  action :create
end

url = "http://#{node[:ipaddress]}:8080/#{node[:war_name]}"

ruby_block "phantomjs tsting" do
  block do
    require 'net/http'
    require 'uri'
#    postData = Net::HTTP.post_form(URI.parse('http://10.114.90.164:8080/path'), {'url'=>"#{url}", 'ip'=>"#{node[:ipaddress]}"})
    uri = URI.parse("http://10.114.90.164:8080/path")
    http = Net::HTTP.new(uri.host, uri.port)
#    http.read_timeout = 5000
    request = Net::HTTP::Post.new(uri.request_uri)
    request.set_form_data({'url'=>"#{url}", 'ip'=>"#{node[:ipaddress]}"})
    response = http.request(request)
  end
  action :create
end

#ruby_block "ruby code to notify orchestrator" do
#	block do
#		puts "==================================================================================================="
#		puts "ruby block executed"
#	end
#	only_if { File.exist?(node[:file_path]}) }
#end
