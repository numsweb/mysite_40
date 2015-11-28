

#set :user, "jkropka"
#set :remote, "jkropka"
set :scm_user, 'jkropka'

#set :deploy_to, "/home/jkropka/#{application}.oneoriginalgeek.com"
#set :deploy_via, :remote_cache
set :keep_releases, 10
set :use_sudo, false

=begin
set :ssh_options, { 
  forward_agent: true
  #:port => 3456
  #:keys => ["#{ENV['HOME']}/.ssh/id_rsa_pipeline"], 
  #:host_key => 'ssh-dss',
  #:paranoid => false
}
=end
#ssh_options[:keys] = ["#{ENV['HOME']}/.ssh/id_dsa"]

#set :chmod755, "app config db lib public vendor script script/* public/disp*"



#set :user, 'jkropka'  # Your dreamhost account's username
set :domain, 'oneoriginalgeek.com'  # Dreamhost servername where your account is located 
set :project, 'mysite'  # Your application as its called in the repository
set :application, 'mysite.oneoriginalgeek.com'  # Your app's location (domain or sub-domain name as setup in panel)
set :application_dir, "/home/jkropka/website"  # The standard Dreamhost setup

# roles (servers)
role :web, 'oneoriginalgeek.com'
role :app, 'oneoriginalgeek.com'
role :db,  'oneoriginalgeek.com', :primary => true

# deploy config
set :deploy_to, '/home/jkropka/mysite.oneoriginalgeek.com'
set :deploy_via, :export
set :tmp_dir, '/home/jkropka/mysite.oneoriginalgeek.com/tmp'

set  :stage, :staging


server 'oneoriginalgeek.com',
   user: 'jkropka',
   roles: %w{web app},
   port: 22

###
# Custom Tasks
###



#before "deploy:migrate", "fix_perms"
#before "deploy:migrate", "custom_symlinks"

#after "deploy", "custom_symlinks"
#after "deploy", "deploy:cleanup"
=begin
desc "Bork Permissions"
task :bork_perms do
   "chmod 777 #{deploy_to}"
   "chmod 777 #{releases_path}" rescue nil
   "chmod 777 #{shared_path}" rescue nil
   "chmod -R 777 #{shared_path}/cached-copy" rescue nil
end

desc "Unbork Permissions"
task :unbork_perms do
   "chmod 775 #{deploy_to}"
  "chmod 775 #{releases_path}"
  "chmod 775 #{shared_path}"
end

desc "Fix Permissions"
task :fix_perms do
   "chmod 777 #{current_path}/log"
   "chmod 666 #{shared_path}/log/*" rescue nil
  # is this right? or needed? we ARE running the deploy as jkropka...
     "chown -R  jkropka pg1767984 #{current_path}/*"
     "chown -R  jkropka pg1767984 #{shared_path}/cached-copy"
end

desc "Custom Symlinks"
task :custom_symlinks do
  #run "cp -Rf #{shared_path}/config/*.yml #{release_path}/config"  #could fix this one, but would need to remove the database file from the repo
  #run "ln -nfs #{shared_path}/blog_photos #{current_path}/public/blog_photos"
  #run "ln -nfs #{shared_path}/photos #{current_path}/public/photos"
end
=end
namespace :deploy do
  #desc "Load the default dataset"
  #task :load_dataset do
  #  run "rake db:dataset:load"
  #end
  
  before :starting, :bork_perms do
    on roles(:web) do
      "chmod 777 #{deploy_to}"
      "chmod 777 #{releases_path}" rescue nil
      "chmod 777 #{shared_path}" rescue nil
      "chmod -R 777 #{shared_path}/cached-copy" rescue nil
    end
  end
  
  after :starting, :unbork_perms do
    "chmod 775 #{deploy_to}"
    "chmod 775 #{releases_path}"
    "chmod 775 #{shared_path}"
  end
  
  before :updated, :bork_perms do
    "chmod 777 #{deploy_to}"
    "chmod 777 #{releases_path}" rescue nil
    "chmod 777 #{shared_path}" rescue nil
    "chmod -R 777 #{shared_path}/cached-copy" rescue nil
    
  end
  
  after :updated, :unbork_perms do
    "chmod 775 #{deploy_to}"
    "chmod 775 #{releases_path}"
    "chmod 775 #{shared_path}"
  end
  
  after :finished, :custom_symlinks do
    #run "cp -Rf #{shared_path}/config/*.yml #{release_path}/config"  #could fix this one, but would need to remove the database file from the repo
    #run "ln -nfs #{shared_path}/blog_photos #{current_path}/public/blog_photos"
    #run "ln -nfs #{shared_path}/photos #{current_path}/public/photos"
  end

end



# server-based syntax
# ======================
# Defines a single server with a list of roles and multiple properties.
# You can define all roles on a single server, or split them:

# server 'example.com', user: 'deploy', roles: %w{app db web}, my_property: :my_value
# server 'example.com', user: 'deploy', roles: %w{app web}, other_property: :other_value
# server 'db.example.com', user: 'deploy', roles: %w{db}



# role-based syntax
# ==================

# Defines a role with one or multiple servers. The primary server in each
# group is considered to be the first unless any  hosts have the primary
# property set. Specify the username and a domain or IP for the server.
# Don't use `:all`, it's a meta role.

# role :app, %w{deploy@example.com}, my_property: :my_value
# role :web, %w{user1@primary.com user2@additional.com}, other_property: :other_value
# role :db,  %w{deploy@example.com}



# Configuration
# =============
# You can set any configuration variable like in config/deploy.rb
# These variables are then only loaded and set in this stage.
# For available Capistrano configuration variables see the documentation page.
# http://capistranorb.com/documentation/getting-started/configuration/
# Feel free to add new variables to customise your setup.



# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult the Net::SSH documentation.
# http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start
#
# Global options
# --------------
#  set :ssh_options, {
#    keys: %w(/home/rlisowski/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }
#
# The server-based syntax can be used to override options:
# ------------------------------------
# server 'example.com',
#   user: 'user_name',
#   roles: %w{web app},
#   ssh_options: {
#     user: 'user_name', # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: 'please use keys'
#   }
