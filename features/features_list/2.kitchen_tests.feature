# language: fr
@fr @deploycontext @kitchen
  Fonctionnalité: Je suis le testeur du déployeur de deploy-context avec kitchen
  
    Scénario: Phase initialisation kitchen
      Étant donné la suite kitchen default-vb
      Quand on initialise le projet
      Alors converge la suite kitchen
      Et vérify que le tout est OK
      Et enregistre le statut kitchen_init_ok
  
    Scénario: Phase planning kitchen
      Étant donné la suite kitchen default-vb
      Quand la suite kitchen n'est pas vérifié
      Alors converge la suite kitchen
      Et enregistre le statut kitchen_plan_ok

    Scénario: Phase executing kitchen
      Étant donné la suite kitchen default-vb
      Quand la suite kitchen n'est pas vérifié
      Alors vérifie la suite kitchen
      Et enregistre le statut kitchen_exec_ok
  
    Scénario: Phase closing kitchen
      Étant donné la suite kitchen default-vb
      Quand la suite kitchen est vérifié
      Et le projet est terminé
      Alors détruire la suite kitchen
      Et enregistre le statut kitchen_close_ok
