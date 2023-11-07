pkg_name="deploy-context"
pkg_origin="jimbodragon"
pkg_version=$(cat /src/VERSION)
pkg_maintainer="Jimmy Provencher <jimmy.provencher@hotmail.ca>"
pkg_license=("MIT")
pkg_scaffolding=jimbodragon/inspec-profile-deploy-context

show_current_folder() {
  echo "Showing current folder in $1 step"
  echo $(pwd)
  ls -alh
}

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
  find /src --iname *.lock --delete
}

do_begin() {
  show_current_folder 'begin in platform context'
  do_default_begin
}

do_download() {
  show_current_folder 'download in platform context'
  do_default_download
}

do_verify() {
  show_current_folder 'verify in platform context'
  do_default_verify
}

do_clean() {
  show_current_folder 'clean in platform context'
  do_default_clean
  clean_deploy
}

do_unpack() {
  show_current_folder 'unpack in platform context'
  do_default_unpack

  cp -r /src/libraries lib
  cp -r /src/features/step_definitions lib/deploy-definitions
}

do_prepare() {
  show_current_folder 'prepare in plan context'
  do_default_prepare
  clean_deploy
}

do_build() {
  show_current_folder 'build in plan context'
  use_make=false
  if [ "$use_make" == "true" ]
  then
    do_default_build
  fi
}

do_check() {
  show_current_folder 'check in plan context'
  do_default_exist=false
  if [ "$do_default_exist" == "true" ]
  then
    do_default_check
  fi
}

do_install() {
  show_current_folder 'install in plan context'
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
  show_current_folder 'strip in platform context'
  do_default_strip
  clean_deploy
}

do_end() {
  show_current_folder 'end in platform context'
  do_default_end
}
