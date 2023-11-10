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
      Quand le rapport compliance a atteint 20 succès
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
