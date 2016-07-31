set :branch, ENV["REVISION"] || ENV["BRANCH_NAME"] || "stable"
set :stage, :production

set :application, 'moment.isopt.info'
set :domain, 'moment.isopt.info'
server "54.172.1.223", user: "deployer", roles: %w{web app db}


set :deploy_to, "/home/#{fetch(:user)}/#{fetch(:application)}" 


# set :ssh_options, {
#     user: 'deployer',
#     keys: %w(/home/WonyoungSo/.ssh/id_rsa),
#     forward_agent: false
# }
