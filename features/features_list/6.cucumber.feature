# language: fr
@fr @deploycontext @cucumber
  Fonctionnalité: Je suis le testeur du déployeur de deploy-context avec cucumber
  
    @initialize
    Scénario: Phase initialisation cucumber
  
    @execution
    Scénario: Phase execution cucumber

    @report
    Scénario: Phase report cucumber
      Étant donné le profile html_report
      Alors émettre le rapport
