pkg_name=inspec-profile-deploy-context
pkg_version=$(cat /src/VERSION)
pkg_origin=jimbodragon
pkg_svc_user=root
pkg_license='Apache-2.0'
pkg_scaffolding="chef/scaffolding-chef-inspec"

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