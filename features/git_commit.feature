# language: fr
@fr @deploycontext @git
  Fonctionnalité: Je suis le testeur du déployeur de deploy-context avec git
  
    Scénario: Phase initialisation git
      Étant donné la branche non maîtresse integrate_cucumber_into_recipe
      Et la suite kitchen default-vb
      Et le plan habitat/plan.sh
      Quand le dépot est brouillonné
      Et la suite kitchen est vérifié
      Et le studio habitat réussi
      Alors note les modifications au dépot
      Et interne les changements sur le dépot
      Et vérify que le tout est OK
      Et enregistre le statut git_commit_ok
  
    Scénario: Phase planning git
      Étant donné la branche non maîtresse integrate_cucumber_into_recipe
      Quand le dépot est propre
      Alors fusionne le dépot avec la branche maîtresse
      Et vérify que le tout est OK
      Et enregistre le statut git_merge_ok
  
    Scénario: Phase execution git
      Étant donné la branche maîtresse
      Quand le dépot est propre
      Alors déploi les modifications
      Et vérify que le tout est OK
      Et enregistre le statut git_push_ok
