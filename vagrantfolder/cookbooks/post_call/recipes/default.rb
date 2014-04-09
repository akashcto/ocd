#
# Cookbook Name:: post_call
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

if platform_family?("windows")
	os = "windows"
else
	os = "linux"
end

ruby_block "make_post_call" do
	block do
		require "net/http"
		require "uri"
		
#		uri = URI.parse("http://10.114.10.13:4567/config")	
		uri = URI.parse("#{node[:url]}")
#		request = Net::HTTP::Post.new(uri, {"os" => "#{os}", "name" => "#{node[:hostname]}"})
		http = Net::HTTP.new(uri.host, uri.port)
		request = Net::HTTP::Post.new(uri.request_uri)
		request.set_form_data({"os" => "#{os}", "name" => "#{node[:hostname]}"})
		response = http.request(request)
	end
end
