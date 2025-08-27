#
# Cookbook:: cr_dbeaver-ce
# Recipe:: default
#
# Copyright:: 2025, The Authors, All Rights Reserved.

if platform_family?('windows')

  windows_package "DBeaver #{node['dbeaver']['version']}" do
    source "https://dbeaver.io/files/#{node['dbeaver']['version']}/dbeaver-ce-#{node['dbeaver']['version']}-x86_64-setup.exe"
    installer_type :custom
    options '/S /allusers'
    action :install
  end

elsif platform_family?('mac_os_x')
  homebrew_package 'dbeaver-community'

elsif platform_family?('debian')


  apt_repository 'dbeaver-ce' do
    if platform?('ubuntu')
      uri 'ppa:serge-rider/dbeaver-ce'
      signed_by false
    else
      key 'https://dbeaver.io/debs/dbeaver.gpg.key'
      uri 'https://dbeaver.io/debs/dbeaver-ce'
      distribution '/'
      components []
    end
    keyserver "keyserver.ubuntu.com"
  end
  package 'dbeaver-ce'
end