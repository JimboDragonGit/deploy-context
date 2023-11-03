# language: fr
@fr @deploycontext @knife
  Fonctionnalité: Je suis le testeur du déployeur de deploy-context avec knife
  
    @initialize
    Scénario: Phase initialisation knife
      Quand on peut lister les cookbooks
      Et un couteau mannequin est accessible
      Et un couteau default est accessible
      Et un couteau deploy est accessible
      Et enregistre le statut coutelleries_ok

    @planning
    Scénario: Phase planning knife
      Quand on peut lister les cookbooks
      Et un couteau context est accessible
      Étant donné le couteau context
      Alors je peux affiché l'aide du couteau
      Et enregistre le statut couteau_ok

    @execution
    Plan du Scénario: Phase executing knife sur les cookbooks
      Étant donné le couteau context
      Alors autopublier le cookbook <cookbook_name>
      Et enregistre le statut knife_cookbook_upload_ok

    Exemples:
      | cookbook_name |
      | deploy-context |
    
    @testing_app @closure
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
    
    @testing_sub @closure
    Plan du Scénario: Phase testing knife
      Étant donné le couteau <knife_name>
      Et la commande couteau <command_name>
      Quand un couteau <knife_name> est accessible
      Alors je peux affiché l'aide du couteau
      Et exécute la sous commande couteau <command_name> <sub_command>
      Et enregistre le statut knife_sub_command_ok

    Exemples:
      | knife_name | command_name | sub_command |
      | context | knife | context |
      | context | cookbook | studio |
      | context | cucumber | studio |
      | context | habitat | studio |
      | context | ruby | studio |
  
