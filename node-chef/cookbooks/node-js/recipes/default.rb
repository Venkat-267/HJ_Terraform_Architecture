# recipes/default.rb

# Update apt package index
execute 'apt-get update' do
  command 'apt-get update'
end

# Install Node.js and npm
package 'nodejs'
package 'npm'

# Install Git
package 'git'

# Clone Node.js application from GitHub
git '/home/ubuntu/app' do
  repository 'https://github.com/Venkat-267/nodejs-jenkins-2'
  revision 'main'
  action :sync
  user 'ubuntu'
end

# Install dependencies for the Node.js app
execute 'npm install' do
  cwd '/home/ubuntu/app'
  command 'npm install'
  user 'ubuntu'
end

# Start the Node.js application
execute 'start nodejs app' do
  cwd '/home/ubuntu/app'
  command 'npm start &'
  user 'ubuntu'
end

file '/etc/systemd/system/nodeapp.service' do
  content <<-EOU
  [Unit]
  Description=Node.js App

  [Service]
  ExecStart=/usr/bin/npm start
  WorkingDirectory=/home/ubuntu/app
  Restart=always
  User=ubuntu
  Group=ubuntu
  Environment=PATH=/usr/bin:/usr/local/bin
  Environment=NODE_ENV=production
  ExecReload=/bin/kill -s HUP $MAINPID
  KillMode=process
  KillSignal=SIGINT
  TimeoutStopSec=10

  [Install]
  WantedBy=multi-user.target
  EOU
  mode '0644'
end

# Reload systemd to register the service
execute 'reload systemd' do
  command 'systemctl daemon-reload'
end

# Enable and start the service
service 'nodeapp' do
  action [:enable, :start]
end
