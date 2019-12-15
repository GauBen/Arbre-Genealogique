# Manuel utilisateur

## Menu principal

```console
**********************
* Arbre Généalogique *
**********************

Menu principal :
1. Accéder au registre
2. Accéder à un arbre généalogique
3. Statistiques
4. Quitter

Votre choix [1, 2, 3 ou 4] : 
```

En démarrant le programme, vous arriverez sur le menu principal. Sur ce menu vous pouvez accéder au menu du registre (pour ajouter, consulter et modifier des personnes du registre), accéder au menu des arbres généalogiques (pour construire et consulter les arbres généalogiques des personnes enregistrées), ou encore afficher quelques statistiques sur le registre ou les arbres.

## Menu du registre

```console
* Registre *

Menu :
1. Consulter une personne à partir de sa clé
2. Chercher une personne à partir de son nom
3. Ajouter une personne
4. Retour

Votre choix [1, 2, 3 ou 4] :
```

## Consulter une personne à partir de sa clé

```console
Entrez la clé de la personne que vous voulez consulter [0 pour retour].
Votre choix : 1

<1>
Jean Bon
 * Nom complet : Jean, Eude Bon
 * Sexe : masculin
 * Né le 31 janvier 1960 à Paris, France

Menu :
1. Consulter son arbre généalogique
2. Modifier les informations
3. Retour

Votre choix [1, 2 ou 3] :
```

Si vous connaissez la clé d’une personne enregistrée, vous pouvez accéder à ses données puis éventuellement les modifier ou consulter son arbre généalogique.

## Consulter une personne à partir de son nom

```console
* Recherche dans le registre *

Nom à rechercher [Entrée pour retour] : Kevin

Résultats de la recherche :
 * Kevin Bon <2>

Entrez la clé de la personne que vous voulez consulter [0 pour retour].

Votre choix :
```

À partir du nom d’une personne, vous pouvez accéder à sa clé et ainsi accéder à ses données.

## Modification des données d’une personne

```console
* Modification d'une personne du registre *

Informations actuelles : 
<2>
Kevin Bon
 * Nom complet : Kevin, Junior Bon
 * Sexe : masculin
 * Né le 1 avril 1999 à Toulouse, France

Nom usuel : Kévin Bon
Nom Complet : Kévin, Junior Bon
Sexe [F pour féminin, M pour masculin, A pour autre] : m
Date de naissance [au format JJMMAAAA] : 01041999
Lieu de naissance [au format Ville, Pays] : Toulouse, France

Confirmer la modification [O pour oui, autre pour non] : o
Personne modifiée avec succès.
```

Vous pouvez modifier les données du registre, pour corriger les éventuelles erreurs.

## Ajout d’une personne

```console
* Ajouter une personne au registre *

Informations requises : nom usuel, nom complet, sexe, date et lieu de naissance.

Nom usuel : Gertrude Bon
Nom Complet : Gertrude, Françoise Bon
Sexe [F pour féminin, M pour masculin, A pour autre] : f
Date de naissance [au format JJMMAAAA] : 29021960
Lieu de naissance [au format Ville, Pays] : Strasbourg, France

Confirmer l'ajout [O pour oui, autre pour non] : o
Personne ajoutée avec la clé : 3
```

Lorsque vous voulez enregistrer une personne, le programme vous demande des informations. Une fois la saisie confirmée, le programme vous donne la clé avec laquelle la personne a été enregistrée.

## Menu de consultation d’un arbre généalogique

```console
* Arbre généalogique *

Entrez la clé de la personne dont vous voulez consulter l'arbre [0 pour retour].
Votre choix : 3

Gertrude Bon <3>

Aucune relation.

Menu :
1. Consulter dans le registre
2. Consulter une autre personne
3. Ajouter une relation
4. Supprimer une relation
5. Afficher un arbre de parenté
6. Retour

Votre choix [1, 2, 3, 4, 5 ou 6] :
```

Dans le menu de consultation d’un arbre généalogique, le programme vous demande la clé de la personne dont vous voulez consulter les relations.  Vous pouvez ensuite en ajouter, en supprimer, ou afficher un arbre généalogique.

## Ajout d’une relation

```console
Ajouter une relation :
1. Ajouter un parent
2. Ajouter un enfant
3. Ajouter un conjoint

Votre choix [1, 2 ou 3] : 2

Entrez la clé de la personne a lier [0 pour retour].

Votre choix : 2
Relation ajoutée.

Gertrude Bon <3>

Enfant(s) :
 * Kévin Bon <2>

Menu : ...
```

Pour ajouter une relation, vous choisissez un type de relation puis la clé de la personne à lier. Le programme impose au maximum une relation entre deux personnes. La relation ajoutée est directement visible.

## Afficher un arbre de parenté

```console
Nombre de générations à afficher [> 0 pour les parents,
< 0 pour les enfants, 0 pour retour] : 2

 0   1   2   génération
=======================
-- Kévin Bon <2>
    -- Gertrude Bon <3>
        -- Henry Bon <5>
        -- Luciene Bon <4>
    -- Jean Bon <1>
```

Lorsque vous souhaitez afficher un arbre de parenté, vous pouvez choisir d'afficher un arbre ascendant (vers les ancêtres), comme sur la capture ci-dessus, ou descendant (vers les enfants).

## Statistiques

```console
* Statistiques *

Nombre de personnes enregistrées : 5
Nombre de relations enregistrées : 8
Nombre de personnes sans aucune relation : 0
Nombre de personnes avec
 * Aucun parent connu  : 3
 * Un parent connu     : 0
 * Deux parents connus : 2
 * Trois ou plus       : 0
```
