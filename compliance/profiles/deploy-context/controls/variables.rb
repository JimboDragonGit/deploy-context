
require_relative '../../../../libraries/deploy-context'

extend Context::CucumberSuiteHelper
extend Context::DeployKnifeConstant

title 'deploy-context environment variables control'

only_once = 0

%w(
  sshprivatekey
  sshpublickey
  email
  fullname
  client_name
  kitchen_user
  kitchen_workstation
  chef_repo_name
  chef_repo_git
  chef_organisation_name
  application_name
  cucumber_publish_token
  circleci_token
  circleci_api_token
  circleci_org_optin
  hab_auth_token
  hab_origin
  hab_license
  aws_access_key_id
  aws_secret_access_key
  dockerhub_user
  dockerhub_password
  do_check
  aws_ssh_deploycontext_kitchen_key
  aws_ssh_deploycontext_security_group
  aws_ssh_deploycontext_subnet_id
  aws_ssh_deploycontext_domain_name
  hab_studio_secret_chef_server_url
  hab_studio_secret_chefvalidatorkey
  hab_studio_secret_sshprivatekey
  hab_studio_secret_sshpublickey
  hab_studio_secret_client_name
  hab_studio_secret_client_key
  hab_studio_secret_gemapi
  hab_studio_secret_email
  hab_studio_secret_fullname
  hab_studio_secret_client_secret
).each do |variable_name|
  control [variable_name, '01'].join('-') do
    impact 0.7
    title "#{variable_name} environment variable with inspec"
    desc "This is the #{variable_name} control for deploy-context environment variable."

    describe ENV[variable_name.upcase] do
      extend Context::DeployKnifeConstant
      # it_behaves_like variable_name
      # it_should_behaves_like variable_name
      it do
        should_not include 'ENV['
      end
    end
  end

  control [variable_name, '02'].join('-') do
    impact 0.7
    title "#{variable_name} input variable with inspec"
    desc "This is the #{variable_name} control for deploy-context environment variable."

    describe input(variable_name), :skip do
      extend Context::DeployKnifeConstant
      # it_behaves_like variable_name
      # it_should_behaves_like variable_name
      it do
        should_not include 'ENV['
      end
    end
  end
end
