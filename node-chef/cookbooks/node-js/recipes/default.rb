#
# Cookbook:: node-js
# Recipe:: default
#
# Copyright:: 2024, The Authors, All Rights Reserved.
# Install Node.js
apt_update 'update' do
    action :update
  end
  
# Install npm
package 'npm' do
    action :install
  end
  
  # Ensure Nginx is installed
  package 'nginx' do
    action :install
  end
  
  service 'nginx' do
    action [:enable, :start]
  end
  
  # Clone your Node.js app
  git '/var/www/my_node_app' do
    repository 'https://github.com/Venkat-267/nodejs-jenkins-trial'
    revision 'main'
    action :sync
  end
  
  # Install app dependencies
  execute 'npm install' do
    cwd '/var/www/my_node_app'
    command 'npm install'
    action :run
  end
  
  # Configure Nginx for the Node.js app
  template '/etc/nginx/sites-available/default' do
    source 'nginx-site.erb'
    notifies :restart, 'service[nginx]', :immediately
  end
  
  # Create Systemd service for Node.js app
  template '/etc/systemd/system/node-app.service' do
    source 'node-app.service.erb'
    notifies :run, 'execute[reload systemd]', :immediately
  end
  
  # Reload systemd to recognize new service
  execute 'reload systemd' do
    command 'systemctl daemon-reload'
    action :nothing
  end
  
  # Enable and start Node.js app as a service
  service 'node-app' do
    action [:enable, :start]
  end
  