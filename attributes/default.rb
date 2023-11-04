default['audit']['compliance_phase'] = true

# Set profile location
default['audit']['profiles']['linux-baseline'] = {
# 'supermarket': 'devsec/linux-baseline'
'git': 'https://github.com/dev-sec/linux-baseline'
}
# default['audit']['profiles']['deploy-contexty'] = {
# 'path': 'compliance/profiles/deploy-contexty'
# }

# default['audit']['profiles']['ssh'] = {
#   'supermarket': 'hardening/ssh-hardening'
# }

# Fetch additional profiles
default['audit']['fetcher'] = 'chef-server'
