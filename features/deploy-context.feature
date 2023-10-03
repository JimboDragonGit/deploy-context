# language: fr
@fr @deploycontext
Fonctionnalité: Je suis le testeur du déployeur de deploy-context

  Plan de Scénario: Démarrer un simple cycle de projet
  Étant donné le projet <projet>
  Alors démarrer un simple cycle de <projet>
  Et bumper la version de <projet>
  Et déployer le projet <projet>

  Exemple:
    |projet|
    |deploy-context|
