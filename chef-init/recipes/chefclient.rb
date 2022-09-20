#
# Cookbook:: chef-init
# Recipe:: chefclient
#
# Copyright:: 2022, Denis, All Rights Reserved.

# Copying files
cookbook_file '/etc/chef/chefClient.conf' do
  source 'chefClient.conf'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

cookbook_file '/usr/lib/systemd/system/chefClient.service' do
  source 'chefClient.service'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

cookbook_file '/usr/local/bin/chef-cl.sh' do
  source 'chef-cl.sh'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

# Reloading the list of services
execute 'add_service' do
  command <<~EOF
      systemctl daemon-reload
    EOF
end

# Enabling and starting our daemon,it will restart on config change automatically
service 'chefClient' do
  action [ :enable, :start ]
  subscribes :reload, 'file[/etc/chef/chefClient.conf]', :immediately
end
