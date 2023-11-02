# language: fr
@fr @deploycontext @inspec
  Fonctionnalité: Je suis l'inspecteur de deploy-context avec cucumber
  
    @planning
    Scénario: Phase initialisation de l'inspecteur
    Étant donné l'inspecteur d'habitat spec
    Alors exécuter l'inspection spec
    Et exécuter l'inspection spec/unit/recipes
  
    @execution
    Scénario: Phase execution de l'inspecteur
    Étant donné l'inspecteur d'habitat spec
    Alors inspecter l'habitat spec
  
    @closure
    Scénario: Phase execution de l'inspecteur
    Étant donné l'inspecteur d'habitat spec
    Alors install l'inspecteur d'habitat spec
