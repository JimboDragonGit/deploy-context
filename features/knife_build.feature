# language: fr
@fr @deploycontext @knife
  Fonctionnalité: Je suis le testeur du déployeur de deploy-context avec knife
  
    Scénario: Phase initialisation knife
      Quand on peut lister les cookbooks
      Et un couteau mannequin est accessible
      Et un couteau default est accessible
      Et un couteau deploy est accessible
      Et vérify que le tout est OK
      Et enregistre le statut coutelleries_ok

    Scénario: Phase planning
      Quand on peut lister les cookbooks
      Et un couteau context est accessible
      Étant donné le couteau context
      Alors je peux affiché l'aide du couteau
      Et vérify que le tout est OK
      Et enregistre le statut couteau_ok

    Plan du Scénario: Phase executing knife
      Étant donné le couteau context
      Alors autopublier le cookbook <cookbook_name>

    Exemples:
      | cookbook_name |
      | deploy-context |
