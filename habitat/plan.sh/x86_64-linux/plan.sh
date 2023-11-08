pkg_name="deploy-context"
pkg_origin="jimbodragon"
pkg_version=$(cat /src/VERSION)
pkg_maintainer="Jimmy Provencher <jimmy.provencher@hotmail.ca>"
pkg_license=("MIT")
pkg_scaffolding=jimbodragon/inspec-profile-deploy-context
pkg_deps=(core/git core/bash core/bundler chef/chef-infra-client core/coreutils core/shadow)

clean_deploy() {
  if [ -d lib ]
  then
    rm -rf lib
  fi

  if [ -d pkg ]
  then
    rm -rf pkg
  fi

  if [ -f Gemfile.lock ]
  then
    rm Gemfile.lock
  fi

  if [ -d bin ]
  then
    echo "Fake bin removal"
    # rmdir bin
  fi
  find $(pwd) -iname *.lock -type f -delete
}

do_begin() {
  do_default_begin
}

do_download() {
  do_default_download
}

do_verify() {
  do_default_verify
}

do_clean() {
  do_default_clean
  clean_deploy
}

do_unpack() {
  do_default_unpack

  cp -r /src/libraries lib
  cp -r /src/features/step_definitions lib/deploy-definitions
}

do_prepare() {
  do_default_prepare
  clean_deploy
}

do_build() {
  use_make=false
  if [ "$use_make" == "true" ]
  then
    do_default_build
  fi
  mkdir -p /etc/chef

  cat > /etc/chef/client.pem <<EOM
-----BEGIN RSA PRIVATE KEY-----
$(echo $CLIENT_KEY | sed 's|\\n|\n|g')
-----END RSA PRIVATE KEY-----
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
$CLIENT_secret

EOM
}

do_check() {
  do_default_exist=false
  if [ "$do_default_exist" == "true" ]
  then
    do_default_check
  fi
}

do_install() {
  do_rules_ready=false
  if [ "$do_rules_ready" == "true" ]
  then
    do_default_install
  fi
  fix_interpreter $(which rake) core/coreutils bin/env

  chef-client --chef-license accept || echo
  clean_deploy
}

do_strip() {
  do_default_strip
  rake release --trace || echo
  clean_deploy
}

do_end() {
  do_default_end
}
