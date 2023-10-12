# language: fr
@fr @deploycontext @knife
  Fonctionnalité: Je suis le testeur du déployeur de deploy-context avec knife
  
    Scénario: Phase initialisation knife
      Quand on peut lister les cookbooks
      Et un couteau mannequin est accessible
      Et un couteau default est accessible
      Et un couteau deploy est accessible
      Et enregistre le statut coutelleries_ok

    Scénario: Phase planning
      Quand on peut lister les cookbooks
      Et un couteau context est accessible
      Étant donné le couteau context
      Alors je peux affiché l'aide du couteau
      Et enregistre le statut couteau_ok

    Plan du Scénario: Phase executing knife sur les cookbooks
      Étant donné le couteau context
      Alors autopublier le cookbook <cookbook_name>
      Et enregistre le statut knife_cookbook_upload_ok

    Exemples:
      | cookbook_name |
      | deploy-context |

    Plan du Scénario: Phase testing knife
      Étant donné le couteau <knife_name>
      Et la commande couteau <command_name>
      Quand un couteau <knife_name> est accessible
      Alors je peux affiché l'aide du couteau
      Et exécute la commande couteau <command_name>
      Et enregistre le statut knife_command_ok

    Exemples:
      | knife_name | command_name |
      | deploy | context |
      | default | studio |
  
