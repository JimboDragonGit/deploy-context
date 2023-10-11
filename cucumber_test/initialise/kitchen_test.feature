# language: fr
@fr @deploycontext
  Fonctionnalité: Je suis le testeur du déployeur de deploy-context
  
    Plan du Scénario: Phase initialisation
    Étant donné la suite kitchen
    Quand on initialise le projet
    Alors converge la suite kitchen
    Et vérify que le tout est OK
    Et enregistré le statut
  
    Exemples:
      | project_name | repertoire |
      | deploy-context | / |
