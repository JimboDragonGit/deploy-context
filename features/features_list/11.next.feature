# language: fr
@fr @deploycontext @next
  Fonctionnalité: Je suis celui qui voit plus loin de deploy-context

      @closure
      Plan du Scénario: Phase initialisation du audit
      Étant donné l'idée <idea>
      Et l'organisation jimbodragon
      Et l'application <application_name>
      Et le plan <habitat_plan>
      Et l'inspecteur d'habitat <spec_path>
      Et la branche maîtresse
      Quand le rapport git à au moins 29 succès, au plus 2 erreurs et au plus 5 passer
      Et le rapport knife à au moins 53 succès, au plus 1 erreurs et au plus 1 passer
      Et la planification du rapport kitchen à au moins 5 succès, au plus 0 erreurs et au plus 0 passer
      Et l'exécution du rapport kitchen à au moins 2 succès, au plus 1 erreurs et au plus 2 passer
      Et le rapport habitat à au moins 1000 succès, au plus 0 erreurs et au plus 0 passer
      Et le rapport rake à au moins 1000 succès, au plus 0 erreurs et au plus 0 passer
      Et le rapport supermarket à au moins 1000 succès, au plus 0 erreurs et au plus 0 passer
      Et le rapport install à au moins 1000 succès, au plus 0 erreurs et au plus 0 passer
      Et le rapport compliance à au moins 8 succès, au plus 0 erreurs et au plus 0 passer
      Et le rapport git à au moins 1000 succès, au plus 0 erreurs et au plus 0 passer
      Alors écrire la prochaine version
      Et récupère les dernières modifications
      Et va sur la branche non maîtresse <idea>
      Et fusionne le dépot avec la branche master
      Et déploi les modifications de la branche <idea>
      Et nettoie le plan de travail
      Et note les modifications au dépot
      Et interne les changements sur le dépot
  
      Exemples:
        |              idea              | habitat_plan |        application_name       |             spec_path              |               waiver_file             |          input_file        |
        | integrate_cucumber_into_recipe | spec/habitat | inspec-profile-deploy-context | compliance/profiles/deploy-context | compliance/waivers/deploy-context.yml | compliance/inputs/user.yml |
