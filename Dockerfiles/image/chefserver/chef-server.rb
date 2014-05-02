nginx['enable_non_ssl'] = true

server_name = ENV['HOST']
#server_name = `hostname -f`
#server_name = ip-10-149-8-137.ec2.internal
api_fqdn server_name

nginx['url'] = "https://#{server_name}:443"
nginx['server_name'] = server_name
lb['fqdn'] = server_name
bookshelf['vip'] = server_name
