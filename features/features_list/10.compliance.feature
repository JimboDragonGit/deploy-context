# language: fr
@fr @deploycontext @project
  Fonctionnalité: Je suis le testeur du déployeur de deploy-context avec project
  
    @initialize
    Scénario: Phase initialisation project
    Étant donné l'idée deploy_chef_cookbook_with_habitat_while_inspecting
    Quand l'inspection habitat naturel est complété
    Et démaré l'habitat d'inspection spec/habitat
    Et démarré l'habitat de cuisine habitat/plan.sh/chef_repo

