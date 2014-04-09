require 'chef'
require 'chef/handler'
require 'net/http'
require 'uri'

class Report_result < Chef::Handler
def report
	if run_status.failed?
		uri = URI.parse("http://10.114.90.164:4567/dev/failure")
		http = Net::HTTP.new(uri.host, uri.port)
		response = http.request(Net::HTTP::Get.new(uri.request_uri))	
	end	
end
end	
