with Ada.Strings.Bounded;

package Arbre_Genealogique is

   -- Documentation : https://en.wikibooks.org/wiki/Ada_Programming/Strings
   package Sb is new Ada.Strings.Bounded.Generic_Bounded_Length (Max => 1023);

   -- Diverses informations sur une personne.
   type T_Genre is (Masculin, Feminin, Autre, Non_Renseigne);
   type T_Date is record
      Annee : Integer;
      Mois  : Integer;
      Jour  : Integer;
   end record;
   type T_Lieu is record
      Pays  : Sb.Bounded_String;
      Ville : Sb.Bounded_String;
   end record;

   -- Permet de définir une personne.
   type T_Personne is record
      -- Les noms sont toujours problématiques ; lire cet article en anglais
      -- https://www.kalzumeus.com/2010/06/17/falsehoods-programmers-believe-about-names/
      Nom_Usuel         : Sb.Bounded_String; -- Jean Bon
      Nom_Complet       : Sb.Bounded_String; -- Jean, Michel, Léon Bon
      Genre             : T_Genre;
      Date_De_Naissance : T_Date;
      Lieu_De_Naissance : T_Lieu;
      Vivant            : Boolean;
   end record;

   type T_Personne_Enregistree is private;

   -- Instancie le package Arbre_Binaire avec des personnes enregistrées.
   package Arbre is new Arbre_Binaire (T_Personne_Enregistree,);

   -- Enregistre une personne en lui attribuant une clé.
   function Enregistrer (Personne : T_Personne) return T_Personne_Enregistree;

   -- Crée un nouvel arbre.
   function Nouvel_Arbre
     (Racine : T_Personne_Enregistree) return T_Arbre_Binaire;

   -- Ajoute un parent.
   procedure Ajouter_Parent
     (Arbre  : T_Arbre_Binaire; Enfant : T_Personne_Enregistree;
      Parent : T_Personne_Enregistree);

   -- Retire un parent, et toute la partie de l'arbre associée.
   procedure Retirer_Parent
     (Arbre  : T_Arbre_Binaire; Enfant : T_Personne_Enregistree;
      Parent : T_Personne_Enregistree);

   -- Compte les ancêtres d'une personne donnée.
   function Nombre_Ancetres
     (Arbre : T_Arbre_Binaire; Racine : T_Personne_Enregistree) return Integer;

   -- Affiche un arbre.
   procedure Afficher_Arbre (Arbre : T_Arbre_Binaire);

   -- Renvoie les personnes qui ont exactement `N` parents connus,
   -- où `N` est dans {0, 1, 2}.
   function Personnes_Dont_N_Parents_Sont_Connus
     (Arbre : T_Arbre_Binaire; Racine : T_Personne_Enregistree; N : Integer);

   -- Renvoie vrai si deux personnes ont un ancêtre homonyme.
   function Ont_Un_Ancetre_Homonyme (jesaispastrop : Boolean) return Boolean;

private

   -- Stocke une personne et sa clé en mémoire.
   -- Nécessaire pour l'arbre généalogique.
   type T_Personne_Enregistree is record
      Cle      : Integer;
      Personne : T_Personne;
   end record;

end Arbre_Genealogique;
