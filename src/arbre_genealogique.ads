with Ada.Strings.Bounded;
with Ada.Strings.Fixed;  use Ada.Strings.Fixed;
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

   package Graphe_Genealogique is new Graphe (T_Etiquette_Sommet,
      T_Etiquette_Arete);
   use Graphe_Genealogique;

   subtype T_Liste_Relations is T_Liste_Adjacence;
   subtype T_Arete_Etiquetee is Graphe_Genealogique.T_Arete_Etiquetee;

   procedure Initialiser (Arbre : out T_Arbre_Genealogique);

   procedure Detruire (Arbre : in out T_Arbre_Genealogique);

   procedure Ajouter_Personne
     (Arbre : in out T_Arbre_Genealogique; Personne : in T_Personne;
      Cle   :    out Integer);

   function Lire_Registre
     (Arbre : T_Arbre_Genealogique; Cle : Integer) return T_Personne;

   procedure Ajouter_Relation
     (Arbre                : in out T_Arbre_Genealogique;
      Personne_Origine     : in     T_Etiquette_Sommet;
      Relation             : in     T_Etiquette_Arete;
      Personne_Destination : in     T_Etiquette_Sommet);

   procedure Liste_Relations
     (Adjacence :    out T_Liste_Relations; Arbre : in T_Arbre_Genealogique;
      Origine   : in     T_Etiquette_Sommet);

   function Liste_Non_Vide (Adjacence : T_Liste_Relations) return Boolean;

   procedure Relation_Suivante
     (Adjacence : in out T_Liste_Relations; Arete : out T_Arete_Etiquetee);

   procedure Supprimer_Relation
     (Arbre                : in out T_Arbre_Genealogique;
      Personne_Origine     : in     T_Etiquette_Sommet;
      Relation             : in     T_Etiquette_Arete;
      Personne_Destination : in     T_Etiquette_Sommet);

   procedure Attribuer_Registre
     (Arbre   : in out T_Arbre_Genealogique; Cle : in Integer;
      Element : in     T_Personne);

   function Existe_Registre
     (Arbre : T_Arbre_Genealogique; Cle : Integer) return Boolean;

   procedure Recherche_Nom_Registre_Pont(Arbre : in out T_Arbre_Genealogique; Pile : in out T_Pile; Un_Truc : Sb.Bounded_String);

private

   package Registre_Civil is new Registre (100, T_Personne,Sb.Bounded_String);
   use Registre_Civil;

   type T_Arbre_Genealogique is record
      Graphe         : T_Graphe;
      Registre       : T_Registre;
      Auto_Increment : Integer;
   end record;

end Arbre_Genealogique;
