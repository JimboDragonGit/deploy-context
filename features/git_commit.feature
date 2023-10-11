# language: fr
@fr @deploycontext @git
  Fonctionnalité: Je suis le testeur du déployeur de deploy-context avec git
  
    Scénario: Phase initialisation git
      Étant donné la branche non maîtresse integrate_cucumber_into_recipe
      Alors va sur la branche non maîtresse integrate_cucumber_into_recipe

    Scénario: Phase planning de git
      Étant donné la suite kitchen default-vb
      Et le plan habitat/plan.sh
      Quand le dépot est brouillonné
      Et la suite kitchen est vérifié
      Et le studio habitat réussi
      Alors note les modifications au dépot
      Et interne les changements sur le dépot
      Et vérify que le tout est OK
      Et enregistre le statut git_commit_ok
  
    Scénario: Phase execution git
      Étant donné la branche non maîtresse integrate_cucumber_into_recipe
      Alors récupère les dernières modifications
      Quand le dépot est propre
      Alors test la suite kitchen
      Et construit selon le plan
      Et vérify que le tout est OK
      Et enregistre le statut git_merge_ok
      Et déploi les modifications
  
    Scénario: Phase strip git
      Étant donné la branche non maîtresse integrate_cucumber_into_recipe
      Alors récupère les dernières modifications
      Quand le dépot est propre
      Alors fusionne le dépot avec la branche master
      Et vérify que le tout est OK
      Et enregistre le statut git_merge_ok
  
    Scénario: Phase closure git
      Étant donné la branche maîtresse
      Alors récupère les dernières modifications
      Quand le dépot est propre
      Alors fusionne le dépot avec la branche integrate_cucumber_into_recipe
      Et vérify que le tout est OK
      Et déploi les modifications
      Et enregistre le statut git_push_ok
      Et va sur la branche non maîtresse integrate_cucumber_into_recipe
