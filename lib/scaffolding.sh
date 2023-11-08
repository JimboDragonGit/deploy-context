
echo "Executing a scaffolding script for deploy-context"


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

show_current_folder 'check in scaffolding context'
