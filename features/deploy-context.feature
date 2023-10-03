# language: fr
@fr @deploycontext
Fonctionnalité: Je suis le testeur du déployeur de deploy-context

  Plan du Scénario: Démarrer un simple cycle de projet
  Étant donné que le projet <project_name> à la bonne version
  Alors démarrer un simple cycle de <project_name>
  Et bumper la version de <project_name>
  Et déployer le projet <project_name>

  Exemples:
    | project_name |
    | deploy-context |
