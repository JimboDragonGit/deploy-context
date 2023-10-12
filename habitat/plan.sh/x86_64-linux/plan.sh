pkg_name="deploy-context"
pkg_origin="jimbodragon"
pkg_version=$(cat /src/VERSION)
pkg_maintainer="Jimmy Provencher <jimmy.provencher@hotmail.ca>"
pkg_license=("MIT")
pkg_scaffolding=core/scaffolding-ruby
pkg_deps=(chef/chef-infra-client)
pkg_build_deps=(core/make core/gcc)

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
}

do_verify() {
  do_default_verify
}

do_clean() {
  do_default_clean
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
}

do_strip() {
  do_default_strip
}

do_end() {
  do_default_end
}
