pkg_name="deploy-context"
pkg_origin="jimbodragon"
pkg_version=$(cat /src/VERSION)
pkg_maintainer="Jimmy Provencher <jimmy.provencher@hotmail.ca>"
pkg_license=("MIT")
pkg_scaffolding=core/scaffolding-ruby
# pkg_deps=(core/ruby)
pkg_deps=(chef/chef-infra-client)
# pkg_build_deps=(core/make core/gcc)

do_mix_cookbook(){
  chef exec chef-client -z -o $1
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
  rake release
}

do_strip() {
  do_default_strip
}

do_end() {
  do_default_end
}
