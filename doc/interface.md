# Arbre-Généalogique

## Les différents écrans de l'application

Menu principal :

```console
**********************
* Arbre Généalogique *
**********************

Menu principal :
1. Accéder au registre ✔
2. Accéder à un arbre généalogique
3. Quitter ✔

Votre choix [1, 2 ou 3] : 
```

Menu du registre :

```console
* Registre *

Menu :
1. Consulter une personne à partir de sa clé ✔
2. Chercher une personne à partir de son nom ✔
3. Ajouter une personne ✔
4. Retour ✔

Votre choix [1, 2, 3 ou 4] : 
```

Interface *consulter une personne* :

```console
* Consultation du registre *

Entrez la clé de la personne que vous voulez consulter : 
```

Si la personne est trouvée :

```console
<clé>
Jean Bon
 * Nom complet : Jean Patrick Lionnel Bon de Bravitude
 * Homme
 * Né le 25/12/1990 à Paris, France

Menu :
1. Consulter son arbre généalogique
2. Modifier les informations ✔
3. Retour ✔

Votre choix [1, 2 ou 3] : 
```

Si la personne n'est pas trouvée :

```console
Clé inconnue.

Entrez la clé de la personne que vous voulez consulter (0 pour quitter) : 
```

Interface de recherche :

```console
* Recherche dans le registre *

Entrez votre recherche (nom de la personne cherchée) :
```

Affichage des résultats :

```console
12 résultats, page 1/3 :

1. Jean Michel Brute <clé>
2. Jean Bonbeurre <clé>
3. Patrick L'Étoile de Mer <clé>
4. Bob L'Éponge <clé>
5. Carlos Calamar <clé>

Menu :
1, 2, 3, 4 ou 5. Accéder à une personne ✔
6. Afficher les résultats suivants ✔
0. Quitter ✔

Votre choix [0-6] : 
```

Page suivante :

```console
12 résultats, page 2/3 :

6.
7.
8.
9.
10.

Menu :
5. Afficher les résultats précédents
6, 7, 8, 9 ou 10. Accéder à une personne
11. Afficher les résultats suivants
0. Quitter

Votre choix [0 / 5-11] : 
```

Sinon, si aucun résultat :

```console
Aucun résultat.

Menu :
1. Modifier votre recherche ✔
2. Retour

Votre choix [1 ou 2] : 
```

Ajouter une personne :

```console
* Ajouter une personne au registre *

Informations requises : nom usuel, nom complet, sexe, date et lieu de naissance.

Nom usuel : 
Nom complet : 
Sexe [F pour féminin, M pour masculin, A pour autre] : 
Date de naissance [au format JJMMAAAA] : 
Lieu de naissance [au format Ville, Pays] : 
Confirmer l'ajout [O pour oui, N pour non] :

Personne ajoutée avec la clé : <clé>
```

Modification d'une personne :

```console
* Modification d'une personne du registre *

Informations actuelles :
<clé>
 * Nom usuel : Jean Bon
 * Nom complet : Jean Patrick Lionnel Bon de Bravitude
 * Sexe : Masculin
 * Né le 25/12/1990
 * Né à Paris, France

Nom usuel : 
Nom complet : 
Sexe [F pour féminin, M pour masculin, A pour autre] : 
Date de naissance [au format JJMMAAAA] : 
Lieu de naissance [au format Ville, Pays] : 
Confirmer la modification [O pour oui, N pour non] :

Personne modifiée avec succès.
```

Menu arbre généalogique :

```console
* Arbre généalogique *

Entrez la clé de l'arbre d'une personne que vous souhaitez consulter
(0 pour quitter) :
```

Ensuite :

```console
* Consultation d'un arbre généalogique *

<clé>
Jean Bon

Parents :
    - Pierre Bon <clé>
    - Marie Bon <clé>
Enfant :
    - James Bon <clé>
Épouse :
    - Ana Bon <clé>

Menu :
1. Consulter dans le registre
2. Consulter une personne liée
3. Ajouter une relation
4. Supprimer une relation
5. Afficher un arbre de parenté
6. Recherche avancée sur l'arbre
7. Retour

Votre choix [1 à 7] :
```

Consulter une personne liée :

```console
Consulter une personne liée :
1. Pierre Bon <clé>
2. Marie Bon <clé>
3. James Bon <clé>
4. Ana Bon <clé>
0. Retour

Votre choix [0-4] :
```

Ajouter une relation :

```console
Ajout d'une relation de parenté avec Jean Bon <clé> :
1. Ajouter un parent
2. Ajouter un enfant
3. Ajouter un conjoint

Votre choix [1, 2 ou 3] :

Clé de la personne liée :

(Ici peut-être : Cette personne n'existe pas / Cette personne est déjà liée)

Confirmer l'ajout [O pour oui, N pour non] :

Relation ajoutée avec succès !
```

Supprimer une relation :

```console
Supprimer une relation :
1. Pierre Bon <clé>
2. Marie Bon <clé>
3. James Bon <clé>
4. Ana Bon <clé>
0. Retour

Votre choix [0-4] :
```

Arbre de parenté :

```console
Nombre de générations à afficher [0 à 9] : 

Jean Bon <clé>
    -- Pierre Bon <clé>
        --
        --
            --
                --
    -- Marie Bon <clé>
        --
            --
        --
            --
            --
```

Recherche avancée :

```console
À voir
```
