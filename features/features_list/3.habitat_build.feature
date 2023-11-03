# language: fr
@fr @deploycontext @habitat
  Fonctionnalité: Je suis le testeur du déployeur de deploy-context avec habitat

    @preinit
    Plan du Scénario: Phase pré initialiatique de habitat
      Étant donné le plan <habitat_plan>
      Quand le studio habitat est initialisé
      Et le secret CHEF_SERVER_URL est disponible
      Et le secret CHEFVALIDATORKEY est disponible
      Et le secret SSHPRIVATEKEY est disponible
      Et le secret CLIENT_NAME est disponible
      Et le secret CLIENT_KEY est disponible
      Et le secret GEMAPI est disponible
      Et le secret EMAIL est disponible
      Et le secret FULLNAME est disponible
      Et afficher les variables usagers
      Et enregistre le statut habitat_secret_ok

      Exemples:
        | habitat_plan | application_name |
        | spec/habitat | inspec-profile-deploy-context |
        | habitat/plan.sh | deploy-context |
  
    @initialize
    Plan du Scénario: Phase initialisation habitat
      Étant donné le plan <habitat_plan>
      Quand le studio habitat est initialisé
      Alors nettoie le plan de travail
      Et enregistre la version et la date
      Et prépare le plan de travail
      Et enregistre le statut habitat_ok

      Exemples:
      | habitat_plan | application_name |
      | spec/habitat | inspec-profile-deploy-context |
      | habitat/plan.sh | deploy-context |

    @planning
    Plan du Scénario: Phase de planification habitat
      Étant donné l'organisation jimbodragon
      Et l'application <application_name>
      Et le plan <habitat_plan>
      Quand le studio habitat est initialisé
      Et construit selon le plan
      Et démarre une tâche pour construire
      Et enregistre le statut habitat_build_ok

      Exemples:
      | habitat_plan | application_name |
      | spec/habitat | inspec-profile-deploy-context |
      | habitat/plan.sh | deploy-context |
  
    @execution
    Plan du Scénario: Phase exécutif habitat
      Étant donné l'organisation jimbodragon
      Et l'application <application_name>
      Et le plan <habitat_plan>
      Quand une tâche est dispatché
      Alors attendre qu'elle soit complété
      Et promouvoir la dite tâche
      Et enregistre le statut habitat_promote_ok

      Exemples:
      | habitat_plan | application_name |
      | spec/habitat | inspec-profile-deploy-context |
      | habitat/plan.sh | deploy-context |
  
    @closure
    Plan du Scénario: Phase closure habitat
      Étant donné l'organisation jimbodragon
      Et l'application <application_name>
      Et le plan <habitat_plan>
      Quand son status est Complete
      Alors promouvoir la dite tâche
      Et enregistre le numéro de build
      Et enregistre le statut habitat_promote_ok

    Exemples:
    | habitat_plan | application_name |
    | spec/habitat | inspec-profile-deploy-context |
    | habitat/plan.sh | deploy-context |
