require 'chefspec'

describe 'nexus_war::default' do
  let(:chef_run) { ChefSpec::Runner.new }

  it 'installs tomcat' do
    chef_run.node.set['file_path1'] = '/usr/local/tomcat/webapps/site_ocd_check_10617.war'
    chef_run.node.set['file_source1'] = 'http://10.114.10.200:8081/nexus/content/repositories/chef_test/built_artifacts/site_ocd_check_10617.war'
    chef_run.converge(described_recipe)
    expect(chef_run).to create_remote_file_if_missing('/usr/local/tomcat/webapps/site_ocd_check_10617.war')
  end
end
