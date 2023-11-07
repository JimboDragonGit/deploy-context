# To learn more about Custom Resources, see https://docs.chef.io/custom_resources/
# name 'Resource file for chef_workstation_initialize'
# maintainer 'Jimbo Dragon'
# maintainer_email 'jimbo_dragon@hotmail.com'
# license 'MIT'
# description 'Resource file for chef_workstation_initialize'
# version '0.1.0'
# chef_version '>= 16.6.14'
# issues_url 'https://github.com/jimbodragon/chef_workstation_initialize/issues'
# source_url 'https://github.com/jimbodragon/chef_workstation_initialize'

# To learn more about Custom Resources, see https://docs.chef.io/custom_resources/

resource_name :deploy_context
provides :deploy_context

property :owner, String, name_property: true
property :parent_path, String, default: ENV['HOME']
property :skip_failure, [TrueClass, FalseClass], default: false
property :profile_name, String, default: 'html_report'
property :organisation_name, String
property :application_name, String, default: 'deploy-context'
property :chef_repo_name, String
property :chef_repo_git, String

default_action :build_cucumber

# use_inline_resources
unified_mode true

load_current_value do |current_resource|
end

action :planning do
  converge_by("Planning #{new_resource.parent_path} finished correctly") do
    sync_chef_repo_git(new_resource.owner, new_resource.parent_path, 'deploy-context', 'git@github.com:JimboDragonGit/deploy-context.git')
    sync_chef_repo_git(new_resource.owner, new_resource.parent_path, new_resource.chef_repo_name, new_resource.chef_repo_git)
  end
end

action :build_habitat do
  converge_by("Deploying deploy-context with habitat") do
    action_planning

    ruby_block 'build habitat plan' do
      block do
        extend Context::CucumberSuiteHelper
        ::Dir.chdir new_resource.parent_path
        ::Dir.chdir new_resource.application_name
        Chef::Log.warn "Now in #{::Dir.pwd}"
        # then_build_plan(new_resource)
      end
      action :run
    end
  end
end

action :build_kitchen do
  converge_by("Deploying deploy-context with kitchen") do
    action_planning

    ruby_block 'converge kitchen' do
      block do
        extend Context::CucumberSuiteHelper
        ::Dir.chdir new_resource.parent_path
        ::Dir.chdir new_resource.application_name
        Chef::Log.warn "Now in #{::Dir.pwd}"
        # when_converge_kitchen(new_resource)
      end
      action :run
    end
  end
end

action :build_cucumber do
  converge_by("Deploying deploy-context with cucumber") do
    action_planning

    build_cucumber(new_resource.parent_path, new_resource.application_name, new_resource.skip_failure)
    build_cucumber(new_resource.parent_path, new_resource.chef_repo_name, new_resource.skip_failure)

    # ruby_block 'build cucumber report' do
    #   block do
    #     extend Context::CucumberSuiteHelper
    #     ::Dir.chdir new_resource.parent_path
    #     ::Dir.chdir new_resource.application_name
    #     Chef::Log.warn "Now in #{::Dir.pwd}"
    #     # system('ls -alh')
    #     # system('cucumber --profile @html_report')
    #     given_profile_name(new_resource)
    #     report_the_report(new_resource)
    #   end
    #   action :run
    # end
  end
end

action :build_inspec do
  converge_by("Deploying deploy-context with inspec") do
    action_planning
    execute 'inspec spec' do
      cwd ::File.join(new_resource.parent_path, new_resource.application_name)
    end
  end
end

action_class do
  def sync_chef_repo_git(owner, parent_path, repository_name, repository)
    git ::File.join(parent_path, repository_name) do
      user owner
      repository repository
      revision 'master'
      action :sync
    end
  end

  def build_cucumber(parent_path, application_name, skip_failure)
    execute 'chef exec cucumber --profile html_report' do
      cwd ::File.join(parent_path, application_name)
    end
  end
end ## end action_class
