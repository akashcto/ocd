#Set the http_proxy environment variable
template "/etc/profile.d/proxy.sh" do
  source "proxy.erb"
  mode 0444
  owner "root"
  group "root"
  not_if { node[:use_proxy] == "false" }
end

#Set the http_proxy for the apt packages
template "/etc/apt/apt.conf.d/80proxy" do
  source "80proxy.erb"
  mode 0440
  owner "root"
  group "root"
  not_if { node[:use_proxy] == "false" }
end

#restart the networking service
execute "restart_networking" do                                    
         command "sudo /etc/init.d/networking restart"
         action :run
end


