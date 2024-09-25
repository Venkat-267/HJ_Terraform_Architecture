# See https://docs.chef.io/workstation/config_rb/ for more information on knife configuration options

current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "admin134"
client_key               "#{current_dir}/admin134.pem"
chef_server_url          "https://ip-172-31-36-31.ap-south-1.compute.internal/organizations/orgs"
cookbook_path            ["#{current_dir}/../cookbooks"]
