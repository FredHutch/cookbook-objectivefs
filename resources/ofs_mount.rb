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
  directory env do
    owner 'root'
    group 'root'
    mode '0640'
  end

  # Create configuration files
  file "#{env}/AWS_ACCESS_KEY_ID" do # ~FC005
    content aws_access_key_id
    owner 'root'
    group 'root'
    mode '0440'
  end

  file "#{env}/AWS_DEFAULT_REGION" do
    content aws_default_region
    owner 'root'
    group 'root'
    mode '0440'
  end

  file "#{env}/AWS_SECRET_ACCESS_KEY" do
    content aws_secret_access_key
    owner 'root'
    group 'root'
    mode '0440'
  end

  file "#{env}/OBJECTIVEFS_LICENSE" do
    content objectivefs_license
    owner 'root'
    group 'root'
    mode '0440'
  end

  directory mount_point do
    owner 'root'
    group 'root'
  end

  mount mount_point do
    device bucket_uri
    fstype 'objectivefs'
    options "auto,_netdev,env=#{env}"
    action :enable
  end
end

action :mount do
  mount mount_point do
    action :mount
  end
end
