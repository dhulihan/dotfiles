alias sc='script/console'
alias sg='script/generate'
alias sd='script/destroy'

alias dbreset="bundle exec rake db:migrate VERSION=0 --trace ; bundle exec rake db:migrate --trace ; bundle exec rake db:seed --trace ; bundle exec rake db:sample --trace"
alias dbreset_test="bundle exec rake db:migrate VERSION=0 RAILS_ENV=test --trace ; bundle exec rake db:migrate --trace RAILS_ENV=test ; bundle exec rake db:seed RAILS_ENV=test"
#alias b="bundle exec"
