# language: fr
@fr @deploycontext @git
  Fonctionnalité: Je suis le testeur du déployeur de deploy-context avec git
  
    @initialize
    Scénario: Phase initialisation git
      Étant donné la branche non maîtresse integrate_cucumber_into_recipe
      Alors va sur la branche non maîtresse integrate_cucumber_into_recipe

    @planning
    Scénario: Phase planning de git
      Étant donné la branche non maîtresse integrate_cucumber_into_recipe
      Alors va sur la branche non maîtresse integrate_cucumber_into_recipe
      Quand le dépot est brouillonné
      Alors note les modifications au dépot
      Et interne les changements sur le dépot
      Et enregistre le statut git_commit_ok
  
    @execution
    Scénario: Phase execution git
      Étant donné la branche non maîtresse integrate_cucumber_into_recipe
      Alors va sur la branche non maîtresse integrate_cucumber_into_recipe
      Quand le dépot est propre
      Et déploi les courantes modifications
      Et enregistre le statut git_merge_ok
  
    @clean
    Scénario: Phase clean git
      Étant donné la branche maîtresse
      Alors récupère les dernières modifications
      Quand le dépot est brouillonné
      Alors supprime le fichier de status
      Et enregistre le statut git_clean_ok
  
    @closure
    Scénario: Phase closure git
      Étant donné la branche maîtresse
      Alors récupère les dernières modifications
      Quand le dépot est propre
      Alors fusionne le dépot avec la branche integrate_cucumber_into_recipe
      Et déploi les courantes modifications
      Et enregistre le statut git_push_ok

    @post_mortem
    Scénario: Phase post mortem git
      Étant donné la branche maîtresse
      Alors récupère les dernières modifications
      Alors va sur la branche non maîtresse integrate_cucumber_into_recipe
      Et fusionne le dépot avec la branche master
      Et déploi les modifications de la branche integrate_cucumber_into_recipe
      Et enregistre le statut git_post_mortem_ok
