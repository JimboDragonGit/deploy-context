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
    Et le plan spec/habitat
    Quand le studio habitat est initialisé
    Alors nettoyer les fichiers vérouillés
    Et nettoie le plan de travail
    Et achète l'inspecteur
    Et enregistre la version et la date
    Et prépare le plan de travail
    Et exécuter l'inspection spec
  
    @execution
    Scénario: Phase execution de l'inspecteur
    Étant donné l'organisation jimbodragon
    Et l'application deploy-context
    Et l'inspecteur d'habitat spec
    Quand le studio habitat est initialisé
    Alors inspecter l'habitat spec
    Et le plan spec/habitat
    Et construit selon le plan
    Et démarre une tâche pour construire
  
    @closure
    Scénario: Phase closure de l'inspecteur
    Étant donné l'inspecteur d'habitat spec
    Quand une tâche est dispatché
    Alors attendre qu'elle soit complété
    Et install l'inspecteur d'habitat spec
    Et promouvoir la dite tâche
