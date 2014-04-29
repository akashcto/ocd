cookbook_file "/etc/chef/validation.pem" do
	source "validation.pem"
	end

ruby_block "edit hosts" do
	block do
		open('/etc/hosts', 'a') do |f|
  		f.puts "10.114.90.164 OneclickDeployment1.wipro.com"
		end
	end
end
