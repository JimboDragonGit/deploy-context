# language: fr
@fr @deploycontext @habitat
  Fonctionnalité: Je suis le testeur du déployeur de deploy-context avec habitat
  
    Scénario: Phase initialisation habitat
      Étant donné la suite kitchen default-vb
      Et le plan habitat/plan.sh
      Quand le studio habitat est initialisé
      Et la suite kitchen est vérifié
      Alors construit selon le plan
      Et vérify que le tout est OK
      Et enregistre le statut habitat_ok
