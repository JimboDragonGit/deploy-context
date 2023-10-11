# language: fr
@fr @deploycontext
Fonctionnalité: Je suis le testeur du déployeur de deploy-context

  Plan du Scénario: Démarrer un simple cycle de projet
  Étant donné que le projet <project_name> à du code à updater
  Alors tester le projet <project_name>
  Et déployer le projet <project_name>

  Exemples:
    | project_name | repertoire |
    | deploy-context | / |


  Plan du Scénario: Démarrer un simple cycle de projet avec le studio
  Étant donné que le projet <project_name> à du code à updater
  Quand le studio est disponible
  Alors tester le projet <project_name>
  Et déployer le projet <project_name>

  Exemples:
    | project_name | repertoire |
    | deploy-context | / |
