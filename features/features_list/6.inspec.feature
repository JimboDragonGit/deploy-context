# language: fr
@fr @deploycontext @inspec
  Fonctionnalité: Je suis l'inspecteur de deploy-context avec cucumber
  
    @initialize
    Scénario: Phase initialisation de l'inspecteur
    Étant donné l'inspecteur d'habitat spec
    Alors créer l'inspecteur d'habitat spec
    Et charge l'inspecteur d'habitat spec
  
    @planning
    Scénario: Phase planning de l'inspecteur
    Étant donné l'inspecteur d'habitat spec
    Alors nettoyer les fichiers vérouillés
    Et nettoie le plan de travail
    Et achète l'inspecteur
    Et exécuter l'inspection spec
  
    @execution
    Scénario: Phase execution de l'inspecteur
    Étant donné l'inspecteur d'habitat spec
    Alors inspecter l'habitat spec
  
    @closure
    Scénario: Phase closure de l'inspecteur
    Étant donné l'inspecteur d'habitat spec
    Alors install l'inspecteur d'habitat spec
