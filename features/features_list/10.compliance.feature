# language: fr
@fr @deploycontext @compliance
  Fonctionnalité: Je suis le testeur du d'auditS de deploy-context
  
    @execution
    Plan du Scénario: Phase initialisation du audit
    Étant donné l'idée deploy_chef_cookbook_with_habitat_while_inspecting
    Et l'organisation jimbodragon
    Et l'application <application_name>
    Et le plan <habitat_plan>
    Et l'inspecteur d'habitat <spec_path>
    Quand le studio habitat est initialisé
    Alors achète l'inspecteur
    # Et démaré l'habitat d'inspection <habitat_plan>
    # Et démarré l'habitat de cuisine <habitat_plan>
    Et avec l'aide de <waiver_file> et les données <input_file>, exécuter l'inspection <spec_path>

    Exemples:
      | habitat_plan |        application_name       |             spec_path              |               waiver_file             |           input_file       |
      | spec/habitat | inspec-profile-deploy-context | compliance/profiles/deploy-context | compliance/waivers/deploy-context.yml | compliance/inputs/user.yml |
  
    @closure @report
      Plan du Scénario: Phase initialisation du audit
      Étant donné l'idée deploy_chef_cookbook_with_habitat_while_inspecting
      Et l'organisation jimbodragon
      Et l'application <application_name>
      Et le plan <habitat_plan>
      Et l'inspecteur d'habitat <spec_path>
      Quand le studio habitat est initialisé
      Alors achète l'inspecteur
      Et démaré l'habitat d'inspection <habitat_plan>
      Et démarré l'habitat de cuisine <habitat_plan>
      Et avec l'aide de <waiver_file> et les données <input_file>, exécuter l'inspection <spec_path>
  
    @closure @next
      Plan du Scénario: Phase initialisation du audit
      Étant donné l'idée <idea>
      Et l'organisation jimbodragon
      Et l'application <application_name>
      Et le plan <habitat_plan>
      Et l'inspecteur d'habitat <spec_path>
      Et la branche maîtresse
      Quand le rapport compliance a atteint 20 succès
      Alors écrire la prochaine version
      Et récupère les dernières modifications
      Et va sur la branche non maîtresse <idea>
      Et fusionne le dépot avec la branche master
      Et déploi les modifications de la branche <idea>
      Et nettoie le plan de travail
      Et note les modifications au dépot
      Et interne les changements sur le dépot
  
      Exemples:
        |              idea              | habitat_plan |        application_name       |             spec_path              |               waiver_file             |          input_file        |
        | integrate_cucumber_into_recipe | spec/habitat | inspec-profile-deploy-context | compliance/profiles/deploy-context | compliance/waivers/deploy-context.yml | compliance/inputs/user.yml |
