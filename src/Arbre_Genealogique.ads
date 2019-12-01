with Ada.Strings.Bounded;
with Graphe;
with Registre;

package Arbre_Genealogique is

   -- Documentation : https://en.wikibooks.org/wiki/Ada_Programming/Strings
   package Sb is new Ada.Strings.Bounded.Generic_Bounded_Length (Max => 1023);

   subtype T_Etiquette_Sommet is Integer;
   type T_Etiquette_Arete is
     (A_Pour_Parent, A_Pour_Enfant, A_Pour_Frere, A_Pour_Conjoint);

   type T_Personne is record
      -- Les noms sont toujours problématiques ; lire cet article en anglais
      -- https://www.kalzumeus.com/2010/06/17/falsehoods-programmers-believe-about-names/
      Nom_Usuel   : Sb.Bounded_String; -- Jean Bon
      Nom_Complet : Sb.Bounded_String; -- Jean, Michel, Léon Bon
   end record;

   type T_Arbre_Genealogique is limited private;

   procedure Initialiser (Arbre : out T_Arbre_Genealogique);

   procedure Detruire (Arbre : in out T_Arbre_Genealogique);

   procedure Ajouter_Personne
     (Arbre : in out T_Arbre_Genealogique; Personne : in T_Personne;
      Cle   :    out Integer);

   function Lire_Registre
     (Arbre : T_Arbre_Genealogique; Cle : Integer) return T_Personne;

   procedure Pouet;

private

   package Graphe_Genealogique is new Graphe (T_Etiquette_Sommet,
      T_Etiquette_Arete);
   use Graphe_Genealogique;

   package Registre_Civil is new Registre (100, T_Personne);
   use Registre_Civil;

   type T_Arbre_Genealogique is record
      Graphe         : T_Graphe;
      Registre       : T_Registre;
      Auto_Increment : Integer;
   end record;

end Arbre_Genealogique;
