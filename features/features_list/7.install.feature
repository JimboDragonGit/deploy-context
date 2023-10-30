# language: fr
@fr @deploycontext @install
  Fonctionnalité: Je suis le testeur d'installateur de deploy-context avec cucumber
  
    @initialize
    Scénario: Phase initialisation installateur
  
    @execution
    Scénario: Phase execution installateur
    Étant donné le gem deploy-context
    Alors installer le gem deploy-context
