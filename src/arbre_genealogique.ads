with Ada.Strings.Bounded;
with Graphe;
with Registre;
with Date; use Date;
package Arbre_Genealogique is

   Relation_Existante : exception;

   -- Documentation : https://en.wikibooks.org/wiki/Ada_Programming/Strings
   package Sb is new Ada.Strings.Bounded.Generic_Bounded_Length (Max => 1023);

   subtype T_Etiquette_Sommet is Integer;
   type T_Etiquette_Arete is
     (A_Pour_Parent, A_Pour_Enfant, A_Pour_Frere, A_Pour_Conjoint);

   type T_Genre is (Masculin, Feminin, Autre);

   type T_Personne is record
      -- Les noms sont toujours problématiques ; lire cet article en anglais
      -- https://www.kalzumeus.com/2010/06/17/falsehoods-programmers-believe-about-names/
      Nom_Usuel         : Sb.Bounded_String; -- Jean Bon
      Nom_Complet       : Sb.Bounded_String; -- Jean, Michel, Léon Bon
      Genre             : T_Genre;
      Date_De_Naissance : T_Date;
      Lieu_De_Naissance : Sb.Bounded_String;
   end record;

   type T_Arbre_Genealogique is limited private;

   -- Instanciation du module Graphe
   package Graphe_Genealogique is new Graphe (T_Etiquette_Sommet,
      T_Etiquette_Arete);
   use Graphe_Genealogique;

   subtype T_Liste_Relations is T_Liste_Adjacence;
   subtype T_Arete_Etiquetee is Graphe_Genealogique.T_Arete_Etiquetee;

   -- Initialise un arbre
   -- Paramètre :
   --    Arbre : out T_Arbre_Genealogique
   -- Necessite : Vrai
   -- Assure : Un arbre généalogique vide est créé.
   procedure Initialiser (Arbre : out T_Arbre_Genealogique);

   -- Détruit un arbre généalogique
   -- Paramètre :
   --    Arbre : in out T_Arbre_Généalogique
   -- Nécessite : Vrai
   -- Assure : Arbre détruit et libération de l'espace alloué à l'arbre
   procedure Detruire (Arbre : in out T_Arbre_Genealogique);

   -- Ajoute une personne à l'arbre généalogique (registre + graphe généalogique)
   -- Paramètres :
   --    Cle : out Integer  Clé généré pour cette personne
   --    Arbre : in out T_Arbre_Généalogique
   --    Personne : in T_Personne   Les données de la personne à ajouter
   -- Nécessite : Vrai
   -- Assure : Personne ajoutée au registre et un sommet lui est créé dans le graphe généalogique
   procedure Ajouter_Personne
     (Arbre : in out T_Arbre_Genealogique; Personne : in T_Personne;
      Cle   :    out Integer);

   -- Renvoie  les données du registre associée à une certaine clé (fonction pont de la fonction "Acceder" du package Registre
   -- Paramètres :
   --    Arbre : in T_Arbre Généalogique
   --    Cle : in Integer  la clé de la personne dont l'on veut les données
   -- Renvoie un T_Personne (les données de la personne associée à la clé)
   -- Exception : lève l'exception Cle_Absente_Exception si la clé n'est pas présente dans le registre .
   function Lire_Registre
     (Arbre : T_Arbre_Genealogique; Cle : Integer) return T_Personne;

   -- Ajoute une relation entre deux personnes (procedure pont de la procedure "Ajouter_Arete" du package Graphe
   -- Paramètres :
   --    Arbre : in out T_Arbre_Généalogique
   --    Personne_Origine : in T_Etiquette_Sommet  la clé de la personne à lier
   --    Personne_Destination : in T_Etiquette_ Sommet   la clé de l'autre personne à lier
   --    Relation : in T_Etiquette_Arete    le nom de la relation liant les deux personnes
   -- Exception : lève l'exception Relation_Existante si les deux personnes ont déjà une relation ensemble
   --             lève l'exception Sommet_Non_Trouve si une des clés ne se trouve pas dans le graphe généalogique
   -- Assure : La relation entre les deux personnes est créée.
   procedure Ajouter_Relation
     (Arbre                : in out T_Arbre_Genealogique;
      Personne_Origine     : in     T_Etiquette_Sommet;
      Relation             : in     T_Etiquette_Arete;
      Personne_Destination : in     T_Etiquette_Sommet);

   -- Permet d'obtenir la liste des relations d'une personne (procedure pont de la procedure "Chaine_Adjacence" du package Graphe)
   -- Paramètres :
   --    Adjacence : out T_Liste Relations   La liste des relations de la personne
   --    Arbre : in  T_Arbre_Généalogique
   --    Origine : in T_Etiquette_Sommet  La clé de la personne dont l'on veut la liste des relations
   -- Exception : lève l'exception Sommet_Non_Trouve si Origine n'est pas dans le graphe Généalogique
   -- Assure : Retourne la liste des relations d'une personne.
   procedure Liste_Relations
     (Adjacence :    out T_Liste_Relations; Arbre : in T_Arbre_Genealogique;
      Origine   : in     T_Etiquette_Sommet);

   -- Renvoie un booléen selon si la liste est vide.
   function Liste_Non_Vide (Adjacence : T_Liste_Relations) return Boolean;

   -- Renvoie la relation suivante dans la liste des relations (procedure pont de la procedure "Arete_Suivante" du package Graphe)
   -- Paramètres :
   --    Adjacence : in out T_Liste_Relations
   --    Arete : out T_Arete_Etiquetee
   procedure Relation_Suivante
     (Adjacence : in out T_Liste_Relations; Arete : out T_Arete_Etiquetee);

   -- Supprime une relation entre deux personnes (procedure pont de la procedure "Supprimer_Arete" du package Graphe)
   -- Paramètres :
   --    Arbre : in out T_Arbre_Généalogique
   --    Personne_Origine : in T_Etiquette_Sommet  Clé de la personne à délier
   --    Personne_Destination : in T_Etiquette_Sommet  Clé de l'autre personne à délier
   -- Exception : lève l'exception Sommet_Non_Trouve si une des deux clés n'est pas dans le graphe généalogique
   procedure Supprimer_Relation
     (Arbre                : in out T_Arbre_Genealogique;
      Personne_Origine     : in     T_Etiquette_Sommet;
      Relation             : in     T_Etiquette_Arete;
      Personne_Destination : in     T_Etiquette_Sommet);

   -- Attribue des données à une personne dans le registre (procedure pont de la procedure "Attribuer" du package Registre)
   -- Paramètres :
   --    Arbre : in out T_Arbre_Genealogique
   --    Cle : in Integer
   --    Element : in T_Personne les données à attribuer
   -- Nécessite : Vrai
   -- Assure : les données ont été attribuées.
   procedure Attribuer_Registre
     (Arbre   : in out T_Arbre_Genealogique; Cle : in Integer;
      Element : in     T_Personne);
   -- Renvoie un Booléen pour savoir si la clé existe dans le registre (function pont de la fonction " Existe" du package Registre)
   function Existe_Registre
     (Arbre : T_Arbre_Genealogique; Cle : Integer) return Boolean;

   generic
      with procedure P (Cle : in Integer; Personne : in T_Personne);
   procedure Appliquer_Sur_Registre (Arbre : in out T_Arbre_Genealogique);

   generic
      with procedure P (Cle : in Integer; Liste : in out T_Liste_Relations);
   procedure Appliquer_Sur_Graphe (Arbre : in out T_Arbre_Genealogique);

private

   package Registre_Civil is new Registre (100, T_Personne);
   use Registre_Civil;

   type T_Arbre_Genealogique is record
      Graphe         : T_Graphe;
      Registre       : T_Registre;
      Auto_Increment : Integer;
   end record;

end Arbre_Genealogique;
