# language: fr
@fr @deploycontext @inspec
  Fonctionnalité: Je suis l'inspecteur de deploy-context avec cucumber
  
    @initialize
    Plan du Scénario: Phase initialisation de l'inspecteur
    Étant donné l'inspecteur d'habitat <spec_path>
    # Alors créer l'inspecteur d'habitat <spec_path>
    # Et charge l'inspecteur d'habitat <spec_path>
    
    Exemples:
    | spec_path |
    | spec/inspec.yml |
    # | spec/unit/recipes |
    # | spec/integration |
    # | test/integration/default |
  
    @planning
    Plan du Scénario: Phase planning de l'inspecteur
    Étant donné l'inspecteur d'habitat <spec_path>
    Alors nettoyer les fichiers vérouillés
    Et nettoie le plan de travail
    Et achète l'inspecteur
    Et exécuter l'inspection <spec_path>
    
    Exemples:
    | spec_path |
    | spec/inspec.yml |
    # | spec/unit/recipes |
    # | spec/integration |
    # | test/integration/default |
  
    @run_list @planning
      Plan du Scénario: Phase run list de l'inspecteur
    Étant donné l'inspecteur d'habitat <spec_path>
    Alors nettoyer les fichiers vérouillés
    Et nettoie le plan de travail
    Et achète l'inspecteur
    Et exécuter l'inspection <spec_path>
    
    Exemples:
    | spec_path |
    | spec/inspec.yml |
    # | spec/unit/recipes |
    # | spec/integration |
    # | test/integration/default |
  
    @execution
    Plan du Scénario: Phase execution de l'inspecteur
    Étant donné l'inspecteur d'habitat <spec_path>
    Alors achète l'inspecteur
    Et inspecter l'habitat <spec_path>
    
    Exemples:
    | spec_path |
    | spec/inspec.yml |
    # | spec/unit/recipes |
    # | spec/integration |
    # | test/integration/default |
  
    @closure @planning @execution
    Plan du Scénario: Phase closure de l'inspecteur
    Étant donné l'inspecteur d'habitat spec/inspec.yml
    Alors achète l'inspecteur
    Étant donné l'inspecteur d'habitat spec
    Alors achète l'inspecteur
    # Alors install l'inspecteur d'habitat <spec_path>
    
    Exemples:
    | spec_path |
    | spec |
    # | spec/inspec.yml |
    # | spec/unit/recipes |
    # | spec/integration |
    # | test/integration/default |
