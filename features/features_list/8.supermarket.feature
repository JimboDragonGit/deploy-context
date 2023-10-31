# language: fr
@fr @deploycontext @supermarket
  Fonctionnalité: Je suis le testeur d'installateur de deploy-context avec cucumber
  
    @initialize
    Scénario: Phase initialisation installateur
  
    @closure
    Scénario: Phase execution installateur
    Étant donné le cookbook deploy-context
    Alors partager le cookbook deploy-context
