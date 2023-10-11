
require 'git-version-bump'

name 'deploy-context'
maintainer 'Jimmy Provencher'
maintainer_email 'jimmy.provencher@hotmail.ca'
license 'All Rights Reserved'
description 'Installs/Configures deploy-context'
# version "#{GVB.major_version(true)}.#{GVB.minor_version(true)}.#{GVB.patch_version(true)}"
version File.read('VERSION')
chef_version '>= 16.0'

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
# issues_url 'https://github.com/<insert_org_here>/deploy-context/issues'

# The `source_url` points to the development repository for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
# source_url 'https://github.com/<insert_org_here>/deploy-context'

# gem "chef-bin", require: true
# gem "chef-cli", require: true
# gem "cheffish", require: true
# gem "kitchen-vagrant", require: true
# gem "kitchen-dokken", require: true
# gem "kitchen-ec2", require: true
# gem "knife", require: true
# gem "knife-ec2", require: true
# gem "simplecov", require: true
# gem "cucumber",  '9.0.0', require: true
# gem "down", require: true
# gem "unix-crypt", require: true
# gem "ruby-shadow", require: true
# gem "securerandom", require: true
# gem "git-version-bump", require: true
