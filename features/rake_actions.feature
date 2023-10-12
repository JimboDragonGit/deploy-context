# language: fr
@fr @deploycontext @rake
  Fonctionnalité: Je suis le testeur du déployeur de deploy-context avec rake
  
    Scénario: Phase initialisation rake
      Étant donné la suite kitchen default-vb
      Et le plan habitat/plan.sh
      Et la branche non maîtresse integrate_cucumber_into_recipe
      Quand la suite kitchen est vérifié
      Et le studio habitat réussi
      Alors note les modifications au dépot
      Et interne les changements sur le dépot
      Et enregistre le statut rake_ok
  
    Scénario: Phase execution rake
      Étant donné la suite kitchen default-vb
      Et le plan habitat/plan.sh
      Et la branche non maîtresse integrate_cucumber_into_recipe
      Alors vérify que le tout est OK
      Et enregistre le statut rake_integration_ok

    Scénario: Phase closure rake
      Étant donné la branche maîtresse
      Et la suite kitchen default-vb
      Et le plan habitat/plan.sh
      Quand la suite kitchen est vérifié
      Et le studio habitat réussi
      Alors récupère les dernières modifications
      Et actionne release avec rake
      Et bump la version
      Et enregistre la version et la date
      Et enregistre le statut rake_bump_ok
