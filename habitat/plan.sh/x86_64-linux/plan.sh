pkg_name="deploy-context"
pkg_origin="jimbodragon"
pkg_version=$(cat /src/VERSION)
pkg_maintainer="Jimmy Provencher <jimmy.provencher@hotmail.ca>"
pkg_license=("MIT")
# pkg_scaffolding=core/scaffolding-ruby
# pkg_deps=(core/ruby)
# pkg_deps=(chef/chef-infra-client core/git core/bash)
pkg_deps=(core/git core/bash core/bundler core/scaffolding-ruby)
pkg_build_deps=(core/make core/gcc)

do_mix_cookbook(){
  chef-client -o $1
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

  cp -r /src/workstation-space/chef-client /etc/chef

  mkdir -p ~/.local/share/gem/
  cp -r /src/workstation-space/gem_credentials ~/.local/share/gem/credentials

  cp -r /src/workstation-space/ssh ~/.ssh
  cp -r /src/workstation-space/gitconfig ~/.gitconfig

  mkdir ~/.chef
  cp -r /src/workstation-space/chef_credentials ~/.chef/credentials

  for chef_key in $(grep client_key ~/.chef/credentials | cut -d '=' -f 2 | cut -d "'" -f 2)
  do
    file_name=$(basename $chef_key)
    sed -i 's,'"$chef_key"',/src/workstation-space/chef_user_keys/'"$file_name"',' ~/.chef/credentials
  done
}

do_build() {
  use_make=false
  if [ "$use_make" == "true" ]
  then
    do_default_build
  fi
  gem install cucumber
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
  rake release --trace
  mv pkg/* $pkg_prefix
  ls -alh $pkg_prefix
}

do_strip() {
  do_default_strip
  rmdir ../pkg
  rmdir lib
}

do_end() {
  do_default_end
}
