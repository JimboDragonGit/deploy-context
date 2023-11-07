pkg_name="deploy-context"
pkg_origin="jimbodragon"
pkg_version=$(cat /src/VERSION)
pkg_maintainer="Jimmy Provencher <jimmy.provencher@hotmail.ca>"
pkg_license=("MIT")
pkg_scaffolding=jimbodragon/inspec-profile-deploy-context

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
    rmdir bin
  fi
  find /src -iname *.lock -delete
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
  rake release --trace || echo
  clean_deploy
}

do_strip() {
  do_default_strip
  clean_deploy
}

do_end() {
  show_current_folder 'end in platform context'
  do_default_end
}
