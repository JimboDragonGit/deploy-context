# language: fr
@fr @deploycontext @install
  Fonctionnalité: Je suis le testeur d'installateur de deploy-context avec cucumber
  
    @initialize
    Scénario: Phase initialisation installateur
  
    @execution
    Scénario: Phase execution installateur
    Étant donné le gem deploy-context
    Alors installer le gem deploy-context
    Et vérifier le répertoire d'installation
    
    @closure
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
  
    @closure
    Scénario: Phase closure installateur
    Étant donné le gem deploy-context
    Alors vérifier le répertoire d'installation
