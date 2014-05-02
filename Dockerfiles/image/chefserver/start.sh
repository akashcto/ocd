#sysctl -w kernel.shmall=4194304
sysctl -w kernel.shmmax=171798691840
#export HOST=localhost
/opt/chef-server/embedded/bin/runsvdir-start & 
#chef-server-ctl reconfigure
#sleep 10
chef-server-ctl start &
sleep 30
echo abccd1234 | sudo knife configure -i -r /chef-repo --validation-client-name chef-validator --validation-key /etc/chef-server/chef-validator.pem --admin-client-name admin --admin-client-key /etc/chef-server/admin.pem --user ubuntu --defaults -y
echo require \'thread\' > /tmp/testfile
cat /var/lib/gems/1.9.1/gems/chef-11.8.0/lib/chef/cookbook_uploader.rb >> /tmp/testfile
cp /tmp/testfile /var/lib/gems/1.9.1/gems/chef-11.8.0/lib/chef/cookbook_uploader.rb
#umount /etc/hostname
#echo testchef.wipro.com > /etc/hostname
#hostname -F /etc/hostname
knife cookbook upload --all -VV &
sleep 60
cd /ocd
ruby queue.rb &
ruby add_to_runlist.rb -o 0.0.0.0 
