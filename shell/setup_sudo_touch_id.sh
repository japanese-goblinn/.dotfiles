SCRIPT_DIR_PATH="$( cd "$(dirname "$0")" && pwd )"
source "$SCRIPT_DIR_PATH/functions.sh"

if [[ "$(id -u)" != 0 ]]; then
  _print_error "'sudo' is required"
  exit $ERROR_CODE
fi

sudo_file="/etc/pam.d/sudo"
if grep -q "pam_tid.so" "$sudo_file"; then
  _print_warning "Touch ID for 'sudo' already configured"
else
  # lines after are aligned this way becouse otherwise lines inserted with spacing at the beggining :c
  sed -i '' '1a\
auth       sufficient     pam_tid.so\
' "$sudo_file"
  _print_success "Touch ID for 'sudo' configured"
fi