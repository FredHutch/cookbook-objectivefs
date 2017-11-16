#
# Cookbook:: objectivefs
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# Install and configure objectivefs

package 'objectivefs' do
  provider node['objectivefs']['package']['provider']
  source node['objectivefs']['package']['source']
end
