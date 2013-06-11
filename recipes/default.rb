#
# Cookbook Name:: mod_rpaf
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

template "/etc/httpd/mods-available/mod_rpaf.load" do
  source "mod_rpaf.load.erb"
  mode 0644
  owner "root"
  group "root"
  action :create_if_missing
end

template "/etc/httpd/mods-available/mod_rpaf.conf" do
  source "mod_rpaf.conf.erb"
  mode 0644
  owner "root"
  group "root"
  action :create_if_missing
end

bash "get mod_rpaf-2.0.so" do
  user "root"
  cwd  "/etc/httpd/modules"
  code <<-EOC
	curl http://static.bis5.net/mod_rpaf/mod_rpaf-2.0.so > mod_rpaf-2.0.so
  EOC
end

execute "enable_mod_rpaf" do
  command "a2enmod mod_rpaf"
  action :run
end

script "restart apache2" do
  interpreter "bash"
  user "root"
  code <<-EOC
	set -x
	service httpd restart
  EOC
end
