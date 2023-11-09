# Cookbook:: deploy-context

# The Chef InSpec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec/resources/
module Context
  module InspecHelpers
    module DeployContextControlsHelper
      def control_deployer_command
        %w(kitchen knife habitat inspec compliance rake install supermarket ).each do |app_name|
          initial_counter = 0
          control_app(app_name, initial_counter, 'knife')
          control_app(app_name, initial_counter, 'cucumber')
          control_app(app_name, initial_counter, 'inspec')
        end

        def control_json_report
          [
            'git_json',
            'knife_json',
            'planning_json',
            'kitchen_json planning',
            'kitchen_json execution',
            'habitat_json',
            'rake_json',
            'supermarket_json',
            'install_json',
            # 'compliance_json',
            'git_json',
          ].each do |command_to_perform|
            control_cucumber_command("knife deploy context cucumber #{command_to_perform}", command_to_perform)
          end
        end

        def load_inspec_dependencies
          include_controls "supermarket-profile" do
            extend Context::InspecHelpers::DeployProcess

            17.times do |control_number|
              skip_control get_control_name('os', control_number)
            end

            10.times do |control_number|
              skip_control get_control_name('package', control_number)
            end

            35.times do |control_number|
              skip_control get_control_name('sysctl', control_number)
            end
          end
        end

        def control_deploy_context_environment_variables
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
            control_env_var variable_name
          end
        end
      end
    end
  end
end
