#
# Cookbook:: ofs_mount_test
# Resource:: mount
#
# Copyright:: 2017, Fred Hutchinson Cancer Research Center, All Rights Reserved
#

ofs_mount 'test' do
  env '/etc/objectivefs.env'
  aws_access_key_id '1234'
  aws_default_region 'us-west'
  aws_secret_access_key 'abcdefg'
  objectivefs_license 'letmein'
  objectivefs_passphrase 'itsasecret'
  diskcache_path '/var/cache/objectivefs'
  diskcache_size '100G:2G'
  cachesize '5G'
  bucket_uri 's3://foo/bar'
  mount_point '/mnt/ofs_mount_test'
  action :create
end
