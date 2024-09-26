# Install Node.js and Git
package 'nodejs'
package 'git'

# Clone the GitHub repository
git '/opt/my_node_app' do
  repository 'https://github.com/Venkat-267/nodejs-jenkins-2'
  revision 'main'
  action :sync
end

# Install npm dependencies
execute 'install npm dependencies' do
  command 'npm install'
  cwd '/opt/my_node_app'
  action :run
end

# Create systemd service to run the Node.js app
file '/etc/systemd/system/nodejs-app.service' do
  content <<-EOU
  [Unit]
  Description=Node.js App

  [Service]
  ExecStart=/usr/bin/node /opt/my_node_app/app.js
  Restart=always
  User=nobody
  Group=nobody
  Environment=PATH=/usr/bin:/usr/local/bin
  Environment=NODE_ENV=production
  WorkingDirectory=/opt/my_node_app

  [Install]
  WantedBy=multi-user.target
  EOU
  action :create
end

# Reload systemd and enable the service
execute 'systemctl daemon-reload' do
  action :run
end

service 'nodejs-app' do
  action [:enable, :start]
end
