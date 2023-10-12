# language: fr
@fr @deploycontext @habitat
  Fonctionnalité: Je suis le testeur du déployeur de deploy-context avec habitat
  
    Scénario: Phase initialisation habitat
      Étant donné la suite kitchen default-vb
      Et le plan habitat/plan.sh
      Quand le studio habitat est initialisé
      Alors construit selon le plan
      Et enregistre le statut habitat_ok

  
    Scénario: Phase de planification habitat
      Étant donné la suite kitchen default-vb
      Et l'organisation jimbodragon
      Et l'application deploy-context
      Et le plan habitat/plan.sh
      Quand le studio habitat est initialisé
      Alors construit selon le plan
      Et démarre une tâche pour construire
      Et enregistre le statut habitat_build_ok
  
    Scénario: Phase exécutif habitat
      Étant donné la suite kitchen default-vb
      Et l'organisation jimbodragon
      Et l'application deploy-context
      Et le plan habitat/plan.sh
      Quand une tâche est dispatché
      Alors attendre qu'elle soit complété
      Et promouvoir la dite tâche
      Et enregistre le statut habitat_promote_ok
  
    Scénario: Phase closure habitat
      Étant donné la suite kitchen default-vb
      Et l'organisation jimbodragon
      Et l'application deploy-context
      Et le plan habitat/plan.sh
      Quand son status est Complete
      Alors promouvoir la dite tâche
      Et enregistre le numéro de build
      Et enregistre le statut habitat_promote_ok
  
