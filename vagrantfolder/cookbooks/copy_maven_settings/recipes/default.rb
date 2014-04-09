#
# Cookbook Name:: copy_maven_settings
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

cookbook_file "/home/jenkins/.m2/settings.xml" do
  source "settings.xml"
end
