pkg_name=inspec-profile-deploy-context
pkg_version=$(cat /src/VERSION)
pkg_origin=jimbodragon
pkg_svc_user=root
pkg_license='Apache-2.0'
pkg_scaffolding="chef/scaffolding-chef-inspec"

show_folder() {
  echo "Showing current folder in $1 step"
  echo $2
  ls -alh $2
}

show_current_folder() {
  show_folder "$1" "$(pwd)"
}

show_context_folder() {
  show_current_folder "$1 in $2 context"
  show_folder "$1 in $2 context" '/hab/cache/src'
}

do_begin() {
  show_current_folder 'begin in platform context'
  do_default_begin
}

do_download() {
  show_context_folder 'download' 'platform'
  do_default_download
}

do_verify() {
  show_context_folder 'verify' 'platform'
  do_default_verify
}

do_clean() {
  show_context_folder 'clean' 'platform'
  do_default_clean
}

do_unpack() {
  show_context_folder 'unpack' 'platform'
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
