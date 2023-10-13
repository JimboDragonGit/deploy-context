# language: fr
@fr @deploycontext @kitchen
  Fonctionnalité: Je suis le testeur du déployeur de deploy-context avec kitchen
  
    @initialize
    Scénario: Phase initialisation kitchen
      Étant donné la suite kitchen workstation-vb
      Quand on initialise le projet
      Alors converge la suite kitchen
      Et vérify que le tout est OK
      Et enregistre la version et la date
      Et enregistre le statut kitchen_init_ok
  
    @planning
    Scénario: Phase planning kitchen
      Étant donné la suite kitchen workstation-vb
      Quand la suite kitchen n'est pas vérifié
      Alors converge la suite kitchen
      Et enregistre le statut kitchen_plan_ok

    @execution
    Scénario: Phase executing kitchen
      Étant donné la suite kitchen workstation-vb
      Quand la suite kitchen n'est pas vérifié
      Alors vérifie la suite kitchen
      Et enregistre le statut kitchen_exec_ok
  
    @closure
    Scénario: Phase closing kitchen
      Étant donné la suite kitchen workstation-vb
      Quand la suite kitchen est vérifié
      Et le projet est terminé
      Alors détruire la suite kitchen
      Et enregistre le statut kitchen_close_ok
