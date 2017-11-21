#
# Cookbook:: objectivefs
# Resource:: ofs_mount
#
# Copyright:: 2017, Fred Hutchinson Cancer Research Center, All Rights Reserved
#
resource_name :ofs_mount

property :env, String
property :aws_access_key_id, String
property :aws_default_region, String
property :aws_secret_access_key, String
property :objectivefs_license, String
property :bucket_uri, String
property :mount_point, String

action :create do # rubocop:disable Metrics/BlockLength
  # Create environment directory
  directory new_resource.env do
    owner 'root'
    group 'root'
    mode '0640'
  end

  # Create configuration files
  file "#{new_resource.env}/AWS_ACCESS_KEY_ID" do # ~FC005
    content new_resource.aws_access_key_id
    owner 'root'
    group 'root'
    mode '0440'
  end

  file "#{new_resource.env}/AWS_DEFAULT_REGION" do
    content new_resource.aws_default_region
    owner 'root'
    group 'root'
    mode '0440'
  end

  file "#{new_resource.env}/AWS_SECRET_ACCESS_KEY" do
    content new_resource.aws_secret_access_key
    owner 'root'
    group 'root'
    mode '0440'
  end

  file "#{new_resource.env}/OBJECTIVEFS_LICENSE" do
    content new_resource.objectivefs_license
    owner 'root'
    group 'root'
    mode '0440'
  end

  directory new_resource.mount_point do
    owner 'root'
    group 'root'
  end

  mount new_resource.mount_point do
    device new_resource.bucket_uri
    fstype 'objectivefs'
    options "auto,_netdev,env=#{new_resource.env}"
    action :enable
  end
end

action :mount do
  mount mount_point do
    action :mount
  end
end
