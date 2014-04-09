#
# Cookbook Name:: config_service_ocd
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#include_recipe "apt"
include_recipe "chef-server"
include_recipe "cookbook-curl"

cookbook_file "chef-repo.tar.gz" do
  path "/home/vagrant/chef-repo.tar.gz"
  action :create
end

cookbook_file "dockerprov-1.0-SNAPSHOT-jar-with-dependencies.jar" do
  path "/home/vagrant/dockerprov-1.0-SNAPSHOT-jar-with-dependencies.jar"
  action :create
end

#cookbook_file ".chef.tar.gz" do
#  path "/home/vagrant/.chef.tar.gz"
#  action :create
#end

cookbook_file "gems.tar.gz" do
  path "/home/vagrant/gems.tar.gz"
  action :create
end

#cookbook_file "entire10-3.rb" do
#  path "/home/vagrant/entire10-3.rb"
#  action :create
#end

cookbook_file "queue.rb" do
  path "/home/vagrant/queue.rb"
  action :create
end

cookbook_file "add_to_runlist.rb" do
  path "/home/vagrant/add_to_runlist.rb"
  action :create
end

#cookbook_file "sinatra_server.rb" do
#  path "/home/vagrant/"
#  action :create_if_missing
#end

#directory "/home/vagrant/.chef" do
#  action :create
#end

bash "untar chef-repo and .chef" do
  cwd "/home/vagrant/"
  code <<-EOH
	tar -xvzf chef-repo.tar.gz
#	tar -xvzf .chef.tar.gz
	tar -xvzf gems.tar.gz
#	wget http://10.114.10.200:8081/nexus/content/repositories/chef_test/chef-client/chef_11.8.0-1.ubuntu.12.04_amd64.deb
#	dpkg -i chef_11.8.0-1.ubuntu.12.04_amd64.deb
	curl -L https://www.opscode.com/chef/install.sh | sudo bash
	echo abccd1234 | knife configure -i -s https://#{node[:ipaddress]} -r /home/vagrant/chef-repo --validation-client-name chef-validator --validation-key /etc/chef-server/chef-validator.pem --admin-client-name admin --admin-client-key /etc/chef-server/admin.pem --user vagrant --defaults -y
  EOH
end

package "libtool" do
  action :install
end

package "automake" do
  action :install
end

package "autoconf" do
  action :install
end

include_recipe "zeromq-cookbook"

gem_package "bundler" do
  source "/home/vagrant/gems/bundler-1.5.3.gem"
  action :install
end

gem_package "ffi" do
  source "/home/vagrant/gems/ffi-1.9.3.gem"
  action :install
end

gem_package "ffi-rzmq" do
  source "/home/vagrant/gems/ffi-rzmq-1.0.3.gem"
  action :install
end

gem_package "rack" do
  source "/home/vagrant/gems/rack-1.5.2.gem"
  action :install
end

gem_package "rack-protection" do
  source "/home/vagrant/gems/rack-protection-1.5.1.gem"
  action :install
end

gem_package "tilt" do
  source "/home/vagrant/gems/tilt-1.4.1.gem"
  action :install
end

gem_package "sinatra" do
  source "/home/vagrant/gems/sinatra-1.4.4.gem"
  action :install
end

gem_package "zmq" do
  source "/home/vagrant/gems/zmq-2.1.4.gem"
  action :install
end

#bash "running services" do
#  cwd "/home/vagrant/"
#  user "vagrant"
#  code <<-EOH
#	sudo ruby entire10-3.rb -o 0.0.0.0 &
#EOH
#end
