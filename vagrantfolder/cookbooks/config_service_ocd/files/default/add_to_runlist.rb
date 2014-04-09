require "rubygems"
require 'sinatra'
require 'bundler/setup'
require 'chef'
require 'uri'
require 'json'
require "ffi-rzmq"
require 'chef/cookbook_uploader'

$flag = "success"
$trackid = Hash.new
$stage = Hash.new

def add_to_runlist(node_name, env)
        $flag = "success"
        puts "adding run_list for " + node_name
        begin
        url = URI.encode("https://testchefserver.wipro.com")
        Chef::Config.from_file("/root/.chef/knife.rb")
        rest = Chef::REST.new(url)
        node1 = Chef::Node.load("#{node_name}")

        if env == "build"
                recipe_list = ["chef_handler::client_run_result", "cookbook-curl", "apt::default", "java::default", "ant::default", "maven::default", "git::default", "jenkins::node"]
        elsif env == "dev"
                recipe_list = ["chef_handler_failure::client_run_result", "chef-tomcat-bin", "nexus_war"] #"phantom_call" "chef_handler::client_run_result","apt::defau$
        else
                recipe_list = ["nonbuild::default"]
        end

        recipe_list.each do |recipe|
                str_rec = "recipe[#{recipe}]"
                node1.run_list << str_rec
                puts node1.run_list
        end
        Chef::Node.load("#{node_name}").destroy()
        node1.create()
        rescue Net::HTTPServerException
                $flag = "object_not_found"
                puts "server exception...node not created"
        rescue => e
                $flag = "failure"
                puts "exception other than serverexception"
                puts e.backtrace
        end
end

#def empty_runlist(node_name)
#       url = URI.encode("https://oneclickdeployment1.wipro.com")
#        Chef::Config.from_file("/home/oneclick1/.chef/knife.rb")
#        rest = Chef::REST.new(url)
#        node1 = Chef::Node.load("#{node_name}")
#       node1.run_list.remove("recipe[chef_handler::client_run_result]")
#       Chef::Node.load("#{node_name}").destroy()
#        node1.create()
#end

def runlist_remove(node_name)
        url = URI.encode("https://testchefserver.wipro.com")
        Chef::Config.from_file("/root/.chef/knife.rb")
        node1 = Chef::Node.load("#{node_name}")
        puts node1.run_list
        if (node1.run_list.include?"recipe[nexus_war]")
                node1.run_list.remove("recipe[nexus_war]")
        end
        puts node1.run_list
        Chef::Node.load("#{node_name}").destroy()
        node1.create()
end

def file_overwrite(war_name)
        File.open('/home/vagrant/chef-repo/cookbooks/nexus_war/attributes/default.rb', 'w') do |f2|
                f2.puts "default[\"file_path1\"] = \"/usr/local/tomcat/webapps/site_#{war_name}.war\"\ndefault[\"file_source1\"] = \"http://172.17.42.1:8081/content/repositories/chef_test/site_#{war_name}.war\"\ndefault[\"war_name\"] = \"site_#{war_name}\""
        end
end

def cookbook_upload(cookbook)
        url = URI.encode("https://testchefserver.wipro.com")
        #url = URI.encode("http://10.114.90.164")
        Chef::Config.from_file("/root/.chef/knife.rb")
        rest = Chef::REST.new(url)
        ckbk = Chef::CookbookVersion.new("#{cookbook}")
        ckbk_ldr = Chef::CookbookLoader.new("/home/vagrant/chef-repo/cookbooks").load_cookbook("#{cookbook}")
        upld = Chef::CookbookUploader.new(ckbk_ldr,"/home/vagrant/chef-repo/cookbooks")
        upld.upload_cookbooks
end

def str_rem(str, rem)
        str.slice!(rem)
        return str
end

def name_fromip_base(ip)

        puts "ip received is #{ip}"
        url = URI.encode("https://testchefserver.wipro.com")
        Chef::Config.from_file("/root/.chef/knife.rb")
        rest = Chef::REST.new(url)
        query = Chef::Search::Query.new
        #nodes = query.search('node', "ipaddress:10.114.90.195")
        nodes = query.search('node', "ipaddress:#{ip}").first rescue []
        if(nodes.empty?)
                puts "ip not registered"
                return "ip not registered"
        end
        puts nodes
        nodes.each do |node|
          puts node.name
          return node.name
        end
end

def name_fromip(ip)
        ret_name = name_fromip_base(ip)
        count = 0
        while(ret_name=="ip not registered" && count<10)
                sleep(20)
                ret_name = name_fromip_base(ip)
                count = count + 1
        end
        return ret_name
end

@context1 = ZMQ::Context.new(1)
def rec_pop
        while(true)
#       pop_req = @context.socket(ZMQ::REQ)
#        pop_req.connect("tcp://10.114.90.164:5561")
        str_tosend = 'give the request'
        req_reply = "empty queue"
        while req_reply=="empty queue"
                pop_req = @context1.socket(ZMQ::REQ)
                pop_req.connect("tcp://0.0.0.0:5571")
                pop_req.send_string str_tosend
                puts "request to pop from queue sent"
                pop_req.recv_string(req_reply)
                puts "received reply is " + req_reply
                if req_reply=="empty queue"
                        sleep(30)
                end
        pop_req.close
        end
        json_req = JSON.parse(req_reply)
        job_id = json_req["job_id"]
        puts "job id is " + job_id
        $stage.store(job_id.to_s, "Configuration Underway")
        puts "after storing stage"
#        name = json_req["hostname"]
        ip = json_req["ip"]
        name = name_fromip(ip)
        if(name == "ip not registered")
                puts "ip not found"
                next
        end
        env = json_req["envName"]
        puts "environment is " + env
        puts "job id aboout to be stored is " + job_id
        puts "stored job id is " + job_id
        torem = "_" + env
        new_ver = str_rem(job_id, torem)
        file_overwrite(new_ver)
        cookbook_upload("nexus_war")
        puts name
        tostore = job_id + "_" + env
        $trackid.store(name, tostore)
        retry_count = 0
        begin
                add_to_runlist(name, env)
                if ($flag == "object_not_found")
                        puts "flag is indeed object not found"
                        retry_count+=1
                        sleep(60)
                end
        end while($flag == "object_not_found" && retry_count<5)
        end
end

set :port, 4568
get '/configuration/success' do
        ip = request.ip
        name = name_fromip(ip)
        runlist_remove(name)
        puts "hostname received in post call is " + name
        job_id = $trackid[name]
        if($stage[job_id]!="Complete")
                $stage[job_id] = "Configuration Success"
                context_conf1 = ZMQ::Context.new(1)
                puts "job id from the map is " + job_id
                result_req = context_conf1.socket(ZMQ::REQ)
                result_req.connect("tcp://172.17.42.1:3335")
                str_tosend = '{"sender":"Chef", "job_type":"Chef Configuration", "job_id":"' + job_id.to_s + '", "ip":"' + ip.to_s + '", "hostname":"' + name.to_s + '", "status":"success"}'
                result_req.send_string str_tosend
                puts "the final message sent to orch is " + str_tosend
                result_req.close
        end
        return "thankyou"
end

get '/deployment/success' do
        ip = request.ip
        name = name_fromip(ip)
        puts "hostname received in post call is " + name
        job_id = $trackid[name]
        if($stage[job_id]!="Complete")
                $stage[job_id] = "Complete"
                context_depl1 = ZMQ::Context.new(1)
                puts "job id from the map is " + job_id
                result_req = context_depl1.socket(ZMQ::REQ)
                result_req.connect("tcp://172.17.42.1:3335")
                str_tosend = '{"sender":"Chef", "job_type":"Chef Deployment", "job_id":"' + job_id.to_s + '", "ip":"' + ip.to_s + '", "hostname":"' + name.to_s + '", "status":"success"}'
                result_req.send_string str_tosend
                puts "the final message sent to orch is " + str_tosend
                result_req.close
        end
        return "thankyou"
end

get '/dev/failure' do
        ip = request.ip
        name = name_fromip(ip)
        puts "hostname received in post call is " + name
        job_id = $trackid[name]
        if($stage[job_id]!="Complete")
                if($stage[job_id] == "Configuration Underway")
                        runlist_remove(name)
                        job_type = "Chef Configuration"
                else
                        job_type = "Chef Deployment"
                end
                $stage[job_id] = "Complete"
                context_fail = ZMQ::Context.new(1)
                puts "job id from the map is " + job_id
                result_req = context_fail.socket(ZMQ::REQ)
                result_req.connect("tcp://172.17.42.1:3335")
                str_tosend = '{"sender":"Chef", "job_type":"' + job_type.to_s + '", "job_id":"' + job_id.to_s + '", "ip":"' + ip.to_s + '", "hostname":"' + name.to_s + '", "status":"failure"}'
                result_req.send_string str_tosend
                puts "the final message sent to orch is " + str_tosend
                result_req.close
        end
        return "thankyou"
end

post '/build/result' do
        result = params[:result]
        ip = request.ip
        name = name_fromip(ip)
#       name = params[:hostname]
        puts "hostname received in post call is " + name
        puts "chef-client run result is " + result
        job_id = $trackid[name]
        puts "job id from the map is " + job_id
        if($stage[job_id]!="Complete")
                $stage[job_id] = "Complete"
                context2 = ZMQ::Context.new(1)
                result_req = context2.socket(ZMQ::REQ)
                #result_req.connect("tcp://10.114.10.13:5557")
                result_req.connect("tcp://172.17.42.1:3335")
                str_tosend = '{"sender":"Chef", "job_type":"Chef Final", "job_id":"' + job_id.to_s + '", "ip":"' + ip.to_s + '", "hostname":"' + name.to_s + '", "status":"' + result.to_s + '"}'
                result_req.send_string str_tosend
                puts "the final message sent to orch is " + str_tosend
#               req_reply = ''
#               result_req.recv_string(req_reply)
#               puts "reply from orch is " + req_reply
                result_req.close
        end
#       empty_runlist(name)
        return "thankyou"
end

post '/phantom' do
        puts "phantom request arrived"
#       ip = request.ip
        ip = params[:ip]
        name = name_fromip(ip)
        test_case = params[:test_case]
        job_id = $trackid[name]
#       phntm = `phantomjs /home/oneclick1/sinatrastuff/zmq_new/phanton_test.js #{ip}`
        phntm = params[:result]
        context3 = ZMQ::Context.new(1)
        phantom_result = context3.socket(ZMQ::REQ)
#       phantom_result.connect("tcp://10.114.10.34:3335")
        phantom_result.connect("tcp://172.17.42.1:3335")
        str_to_send = '{"sender":"Chef", "job_type":"Chef Final", "job_id":"' + job_id.to_s + '", "ip":"' + ip.to_s + '", "hostname":"' + name.to_s + '", "test_case":"'+ test_case.to_s + '", "status":"' + phntm.to_s + '"}'
        phantom_result.send_string str_to_send
        puts "the final message sent to orch after running phantomjs is " + str_to_send
#       req_reply = ''
#        phantom_result.recv_string(req_reply)
#        puts "reply from orch is " + req_reply
        phantom_result.close
#       runlist_remove(name)
        return "received"
        end

t3 = Thread.new{rec_pop()}
