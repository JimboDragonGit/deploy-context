# language: fr
@fr @deploycontext @cucumber
  Fonctionnalité: Je suis le testeur du déployeur de deploy-context avec cucumber
  
    Plan du Scénario: Phase initialisation cucumber
      Étant donné la suite de test <tag_name>
      Quand les tests sont réussi
      Et enregistre le statut cucumber_ok

    Exemples:
      |tag_name|
      |kitchen|
      |habitat|
      |knife|
      |git|
      |rake|
      |chef|
