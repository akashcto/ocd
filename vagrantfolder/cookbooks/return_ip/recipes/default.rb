#
# Cookbook Name:: return_ip
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

ruby_block "getip" do
  block do
    #node[:ip] = `hostname -I | awk '{print $2}'`
#    gotip = `hostname -I | awk '{print $2}'`
#    puts gotip
#    puts gotip
#    puts gotip
#    puts gotip
    
    require 'net/http'
    
#    url = URI.parse("http://10.114.11.42:4567/ip?ip=#{gotip}")
#    urltos = url.to_s
#    puts "url is #{urltos}"
#    req = Net::HTTP::Get.new(urltos)
#    puts "request has been sent #{req}"

#works_but_fails
#     res = Net::HTTP.start('10.114.11.42', 4567) do |http|
#     http.get("/ip?ip=#{gotip}")
#     end
#     puts res.body

#  url = "http://10.114.11.42/ip?ip=#{gotip}"
   url = "http://10.114.11.42/ip"
  uri = URI.parse(url)
  connection = Net::HTTP.new(uri.host, 4567)
#  connection.use_ssl = true

#  resp = connection.request_get(uri.path + '?' + uri.query)
   resp = connection.request_get(uri.path)
  puts resp.body

  end
  action :create
end
