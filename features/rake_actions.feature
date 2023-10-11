# language: fr
@fr @deploycontext @rake
  Fonctionnalité: Je suis le testeur du déployeur de deploy-context avec rake
  
    Scénario: Phase initialisation rake
      Étant donné la suite kitchen default-vb
      Et le plan habitat/plan.sh
      Et la branche non maîtresse integrate_cucumber_into_recipe
      Quand la suite kitchen est vérifié
      Et le studio habitat réussi
      Alors interne les changements sur le dépot
      Et actionne release avec rake
      Et vérify que le tout est OK
      Et enregistre le statut rake_ok
