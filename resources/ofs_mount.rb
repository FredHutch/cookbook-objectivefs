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
  file "#{env}/AWS_ACCESS_KEY_ID" do
    owner 'root'
    group 'root'
    mode '0440'
    content aws_access_key_id
  end

  file "#{env}/AWS_DEFAULT_REGION" do
    owner 'root'
    group 'root'
    mode '0440'
    content aws_default_region
  end

  file "#{env}/AWS_SECRET_ACCESS_KEY" do
    owner 'root'
    group 'root'
    mode '0440'
    content aws_secret_access_key
  end

  file "#{env}/OBJECTIVEFS_LICENSE" do
    owner 'root'
    group 'root'
    mode '0440'
    content objectivefs_license
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
