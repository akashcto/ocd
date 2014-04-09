#
# Cookbook Name:: phantom_call
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
ruby_block "getip" do
  block do

    require 'net/http'

postData = Net::HTTP.post_form(URI.parse('http://10.114.90.164:8080/path'), {'ip'=>"#{node[:ipaddress]}"})

  end
  action :create
end

