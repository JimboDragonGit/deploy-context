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
  do_default_build
}

do_check() {
  # do_default_check
  echo "Locating somewhere"
  echo $(pwd)
  echo "Il faut bien commencer à quelque part de très loin"
}

do_install() {
  do_default_install
  ls -alh $PREFIX
}

do_strip() {
  do_default_strip
}

do_end() {
  do_default_end
}
