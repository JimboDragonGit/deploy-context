pkg_name="deploy-context"
pkg_origin="jimbodragon"
pkg_version=$(cat /src/VERSION)
pkg_maintainer="Jimmy Provencher <jimmy.provencher@hotmail.ca>"
pkg_license=("MIT")
# pkg_scaffolding=core/scaffolding-ruby
# pkg_deps=(core/ruby)
# pkg_deps=(chef/chef-infra-client core/git core/bash)
pkg_deps=(core/git core/bash core/scaffolding-ruby)
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
  # git clone 'git@github.com:JimboDragonGit/deploy-context.git'
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

  cp -r /src/workstation-space/gem ~/.gem
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
  cat ~/.local/share/gem/credentials
  cat ~/.gitconfig
  ls -alh ~/.gem/.gem/trust
  echo $(realpath ~)
}

do_build() {
  use_make=false
  if [ "$use_make" == "true" ]
  then
    do_default_build
  fi
  # cd deploy-context
  # gem build deploy-context.gemspec
  
  # gem pristine byebug --version 11.1.3
  # gem pristine date --version 3.3.3
  # gem pristine debug_inspector --version 1.1.0
  # gem pristine ed25519 --version 1.3.0
  # gem pristine ffi --version 1.15.5
  # gem pristine ffi-yajl --version 2.6.0
  # gem pristine json --version 2.6.3
  # gem pristine libyajl2 --version 2.1.0
  # gem pristine ruby-shadow --version 2.5.0
  # gem pristine unf_ext --version 0.0.8.2

  # mkdir bin
  # cp /src/bin/deploy-context bin/

  # cd /src

  # mkdir -p /etc/chef/

  # cp -r accepted_licenses /etc/chef
#   cat <<EOF > "/usr/bin/env"

# EOF

#   chmod a+x /usr/bin/env

  # ls -alh /hab/pkgs/chef/chef-infra-client/18.3.0/20230830115804/vendor/bin/

  # chef-shell bash
  
  # do_mix_cookbook 'deploy-context::habitat'
  echo $pkg_prefix



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
  # gem push deploy-context.gem
  ls -alh $pkg_prefix
  rake release --trace
  mv pkg/* $pkg_prefix
}

do_strip() {
  do_default_strip
  rmdir ../pkg
  rmdir ../lib
}

do_end() {
  do_default_end
}
