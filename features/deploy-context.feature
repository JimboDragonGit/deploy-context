# language: fr
@fr @deploycontext
Fonctionnalité: Je suis le testeur du déployeur de deploy-context

  Scénario: Initialisé deploy-context
  Étant donné que deploy-context est absent localement
  Alors cloner le projet git@github.com:JimboDragonGit/deploy-context.git

  Scénario: Relâcher deploy-context
  Étant donné que deploy-context est présent localement
  Alors compiler deploy-context
  Et publié deploy-context

  Scénario: Tester deploy-context
  Étant donné que deploy-context est présent au public
  Alors installer deploy-context
  Et tester deploy-context

  Scénario: Bump deploy-context
  Étant donné que deploy-context est tester avec succès
  Alors installer deploy-context
  Et tester deploy-context
