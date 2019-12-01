with Ada.Text_Io; use Ada.Text_Io;
--with Ada.Integer_Text_Io; use Ada.Integer_Text_Io;

package body Arbre_Genealogique is

   procedure Initialiser (Arbre : out T_Arbre_Genealogique) is
   begin
      Initialiser (Arbre.Registre);
      Initialiser (Arbre.Graphe);
      Arbre.Auto_Increment := 1;
   end Initialiser;

   procedure Detruire (Arbre : in out T_Arbre_Genealogique) is
   begin
      Detruire (Arbre.Registre);
      Detruire (Arbre.Graphe);
   end Detruire;

   procedure Ajouter_Personne
     (Arbre : in out T_Arbre_Genealogique; Personne : in T_Personne;
      Cle   :    out Integer)
   is
   begin
      Cle := Arbre.Auto_Increment;
      Attribuer (Arbre.Registre, Cle, Personne);
      Ajouter_Sommet (Arbre.Graphe, Cle);
      Arbre.Auto_Increment := Arbre.Auto_Increment + 1;
   end Ajouter_Personne;

   function Lire_Registre
     (Arbre : T_Arbre_Genealogique; Cle : Integer) return T_Personne
   is
   begin
      return Acceder (Arbre.Registre, Cle);
   end Lire_Registre;

   procedure Pouet is
   begin
      Put_Line ("pouet.");
   end Pouet;

end Arbre_Genealogique;
