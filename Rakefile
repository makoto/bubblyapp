# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rake'

Bubblyapp::Application.load_tasks
require 'pusher'

desc "Summary update"
task :update_summary => :environment do
  config = YAML.load_file(RAILS_ROOT + '/config/config.yml')
  Pusher.app_id = config[:app_id]
  Pusher.key = config[:key]
  Pusher.secret = config[:secret]
  Pusher['twitter'].trigger!('updated', Mention.summary(1.hour.ago))
end
