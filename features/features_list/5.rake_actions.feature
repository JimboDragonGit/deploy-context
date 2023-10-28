# language: fr
@fr @deploycontext @rake
  Fonctionnalité: Je suis le testeur du déployeur de deploy-context avec rake
  
    @initialize
    Scénario: Phase initialisation rake
      Étant donné la suite kitchen workstation-vb
      Et le plan habitat/plan.sh
      Et la branche non maîtresse integrate_cucumber_into_recipe
      Quand la suite kitchen est vérifié
      Et le studio habitat réussi
      Alors nettoie le plan de travail
      Et note les modifications au dépot
      Et interne les changements sur le dépot
      Et enregistre le statut rake_ok
  
    @planning
    Scénario: Phase execution rake
      Étant donné la suite kitchen workstation-vb
      Et le plan habitat/plan.sh
      Et la branche non maîtresse integrate_cucumber_into_recipe
      Alors vérify que le tout est OK
      Et enregistre le statut rake_integration_ok

    @execution
    Scénario: Phase closure rake
      Étant donné la branche non maîtresse integrate_cucumber_into_recipe
      Et la suite kitchen workstation-vb
      Et le plan habitat/plan.sh
      Quand la suite kitchen est vérifié
      Et le studio habitat réussi
      Et actionne release avec rake
      Et enregistre le statut rake_bump_ok

    @post_mortem
    Scénario: Phase post-mortem rake
      Étant donné la branche maîtresse
      Et la suite kitchen workstation-vb
      Et le plan habitat/plan.sh
      Quand la suite kitchen est vérifié
      Et le studio habitat réussi
      Alors récupère les dernières modifications
      Et actionne release avec rake
      Et bump la version
      Et enregistre la version et la date
      Et enregistre le statut rake_bump_ok
      Et nettoie le plan de travail
      Et note les modifications au dépot
      Et interne les changements sur le dépot
