# language: fr
@fr @deploycontext @compliance
  Fonctionnalité: Je suis le testeur du d'auditS de deploy-context
  
    @initialize
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
