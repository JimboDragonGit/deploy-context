# language: fr
@fr @deploycontext
  Fonctionnalité: Je suis le testeur du déployeur de deploy-context
  
    Plan du Scénario: Démarrer une suite kitchen
    Étant donné le projet <project_name>
    Et la suite kitchen est réussi
    Et déployer le projet <project_name>
  
    Exemples:
      | project_name | repertoire |
      | deploy-context | / |
