pkg_name="deploy-context"
pkg_origin="jimbodragon"
pkg_version=$(cat /src/VERSION)
pkg_maintainer="Jimmy Provencher <jimmy.provencher@hotmail.ca>"
pkg_license=("MIT")
# pkg_scaffolding=core/scaffolding-ruby
# pkg_deps=(core/ruby)
# pkg_deps=(chef/chef-infra-client core/git core/bash)
pkg_deps=(core/git core/bash core/bundler chef/chef-infra-client core/scaffolding-ruby core/coreutils core/shadow)
pkg_build_deps=(core/make core/gcc)

do_mix_cookbook(){
  chef-client --override-runlist $1
}

do_mix_named_cookbook(){
  chef-client --chef-license accept --named-run-list $1
}

do_deploy_context_action(){
  echo "Executing action $1 at version $pkg_version in folder $(pwd) PLAN_CONTEXT = $PLAN_CONTEXT"
  ruby plan.rb $1 || echo  "Ruby not avaialble yet"
}

do_begin() {
  do_default_begin
}

do_download() {
  do_default_download
  if [ -d lib ]
  then
    rm -rf lib
  fi
  cp -r /src/libraries lib
  cp -r /src/features/step_definitions lib/deploy-definitions
}

do_verify() {
  do_default_verify

  mkdir -p /etc/chef

  cat > /etc/chef/client.pem <<EOM
$CLIENT_KEY
EOM

  cat > /etc/chef/client.rb <<EOM
log_level                :info
node_name                $CLIENT_NAME
chef_server_url          '$CHEF_SERVER_URL'
secret_file              '/etc/chef/secret'
data_bag_encrypt_version 3
named_run_list 'deploy-context'
EOM

  cat > /etc/chef/secret <<EOM
$CLIENT_KEY
EOM

  if [ ! -d ~/.local/share/gem ]
  then
    mkdir -p ~/.local/share/gem
  fi

  cat > ~/.local/share/gem/credentials <<EOM
:rubygems_api_key: $GEMAPI
EOM

cat ~/.local/share/gem/credentials

# cat > /usr/bin/env <<EOM
# EOM
# chmod a+x /usr/bin/env
# cp $(which irb) /usr/bin/env
}

do_clean() {
  do_default_clean
  if [ -f Gemfile.lock ]
  then
    rm Gemfile.lock
  fi
  if [ -d bin ]
  then
    rmdir bin
  fi
}

do_unpack() {
  do_default_unpack
}

do_prepare() {
  do_default_prepare

  # do_mix_named_cookbook 'deploy-context'
}

do_build() {
  use_make=false
  if [ "$use_make" == "true" ]
  then
    do_default_build
  fi
  echo "The secret is $AWS_ACCESS_KEY_ID"
}

do_check() {
  do_default_exist=false
  if [ "$do_default_exist" == "true" ]
  then
    do_default_exist
  fi
  return 0
}

do_install() {
  do_rules_ready=false
  if [ "$do_rules_ready" == "true" ]
  then
    do_default_install
  fi
  
  # ls -alh /usr/bin/env
  # cat /usr/bin/env

  fix_interpreter $(which rake) core/coreutils bin/env

  which rake

  rake release --trace || echo
  mv pkg/* $pkg_prefix
  ls -alh $pkg_prefix
}

do_strip() {
  do_default_strip
  rmdir ../pkg
  rm -rf lib
}

do_end() {
  do_default_end
  gem install deploy-context
}
