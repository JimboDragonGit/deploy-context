pkg_name=inspec-profile-deploy-context
pkg_version=$(cat /src/VERSION)
pkg_origin=jimbodragon
pkg_svc_user=root
pkg_license='Apache-2.0'
pkg_scaffolding="chef/scaffolding-chef-inspec"

show_current_folder() {
  echo "Showing current folder in $1 step"
  echo $(pwd)
  ls -alh
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
}

do_unpack() {
  show_current_folder 'unpack in platform context'
  do_default_unpack
}

do_prepare() {
  show_current_folder 'prepare in plan context'
  do_default_prepare
}

do_build() {
  show_current_folder 'build in plan context'
  do_default_build
}

do_check() {
  show_current_folder 'check in plan context'
  # do_default_check
}

do_install() {
  show_current_folder 'install in plan context'
  do_default_install
  cp -r /src/lib/ $PREFIX
  ls -alh $PREFIX
}

do_strip() {
  show_current_folder 'strip in platform context'
  do_default_strip
}

do_end() {
  show_current_folder 'end in platform context'
  do_default_end
}
