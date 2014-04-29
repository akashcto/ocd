include_recipe 'chef_handler::default'

cookbook_file "#{Chef::Config[:file_cache_path]}/client_run_failure.rb" do
  source 'handlers/client_run_failure.rb'
  mode 0600
end.run_action(:create)

chef_handler 'Report_result' do
  source "#{Chef::Config[:file_cache_path]}/client_run_failure.rb"
  supports :report => true, :exception => true
  action :enable
end.run_action(:enable)
#dfs
#asddasda
#kjghbkj
#lkhkjn
#lhjhf3
#flnfdnn
