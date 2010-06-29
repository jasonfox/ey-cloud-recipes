#
# Cookbook Name:: cron
# Recipe:: default
#

# get the environment from the node
rails_env = node[:environment][:framework_env]

if ['solo', 'app_master'].include?(node[:instance_role])
  # refresh the search results twice a day, every day
  run_for_app("porschefinder") do |app_name, data|
    cron "refresh search results" do
      day  "*"      # every day
      hour "0,12"   # at midnight and noon
      command "cd /data/#{app_name}/current;RAILS_ENV=#{rails_env} ./script/porschefinder/search"
    end
  end
end
