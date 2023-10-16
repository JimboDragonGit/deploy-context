
module Context
  module Steps
    module Deploy
      def define_steps(deployer)
        deployer.load_public_dependencies
        # Étantdonnéque('le projet {word} à une dernière version de disponible dans git') do |project_name|
        #   context_exec [project_name, 'cycle']
          
        #   if project_name == deployer.context_name
        #     Dir.chdir deployer.context_folder
        #   else
        #     Dir.chdir File.join(deployer.contexts_container(deployer), project_name)
        #   end
        # end

        Alors('démarrer un simple cycle de {word}') do |project_name|
          pending
          # context_exec [project_name, 'cycle'] || abort("#{project_name} ERROR: Issue with life cycle")
        end

        Alors('déployer le projet {word}') do |project_name|
          abort("Deployer failed to update") unless deployer.do_begin
          pending
          # context_exec [project_name, 'release'] || abort("#{project_name} ERROR: Issue with deploy steps")
        end

        Alors('tester le projet {word}') do |project_name|
          pending
          # context_exec [project_name, 'test'] || abort("#{project_name} ERROR: Issue with testing steps")
        end

        Étantdonnéque('le projet {word} à du code à updater') do |project_name|
          abort("Not on a dirty studio") unless deployer.on_a_dirty_studio?
          # context_exec [project_name, 'check_code_to_update'] || abort("#{project_name} ERROR: Issue to check updated code")
        end

        Alors('bumper la version du patch de {word}') do |project_name|
          pending
          # context_exec [project_name, 'bump'] || abort("#{project_name} ERROR: Issue with bumping version")
        end

        Étantdonnéque('le projet {word} à la bonne version d\'installer') do |project_name|
          abort("Not the latest version installed") unless deployer.current_version_installed?
        end

        Étantdonnéque('le projet {word} à une nouvelle version de disponible') do |project_name|
          abort("Latest version installed") if deployer.current_version_installed?
        end

        Étantdonnéque('le projet {word} est chargé') do |project_name|
          abort("Latest version installed") if deployer.current_version_installed?
        end

        Quand('le studio est disponible') do
          abort("Studio not available") unless deployer.studio_available?
        end
      end
    end
  end
end
