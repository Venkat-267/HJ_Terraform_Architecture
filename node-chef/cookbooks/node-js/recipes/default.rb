#
# Cookbook:: node-js
# Recipe:: default
#
# Copyright:: 2024, The Authors, All Rights Reserved.
# Install Node.js
package 'nodejs' do
    action :install
  end
  
  # Install Nginx
  include_recipe 'nginx::default'
  
  # Enable and start Nginx service
  service 'nginx' do
    action [:enable, :start]
  end
  
  # Clone the Node.js app from GitHub
  git '/var/www/my_node_app' do
    repository 'https://github.com/Venkat-267/nodejs-jenkins-2'
    revision 'main'
    action :sync
  end
  
  # Install Node.js dependencies
  execute 'npm install' do
    cwd '/var/www/my_node_app'
    command 'npm install'
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
  