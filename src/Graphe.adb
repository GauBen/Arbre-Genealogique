with Ada.Text_Io; use Ada.Text_Io;
with Ada.Unchecked_Deallocation;
-- procedure Free is new Ada.Unchecked_Deallocation (T_Cellule, T_Pointeur);

package body Graphe is

   procedure Pouet is
   begin
      Put_Line ("Pouet");
   end Pouet;

   procedure Initialiser (Graphe : out T_Graphe) is
   begin
      Graphe := null;
      Put_Line ("Initialiser");
   end Initialiser;

   procedure Detruire (Graphe : in out T_Graphe) is
   begin
      Graphe := null;
      Put_Line ("Detruire");
   end Detruire;

   procedure Ajouter_Sommet
     (Graphe : in out T_Graphe; Etiquette : T_Etiquette_Sommet)
   is
      Nouveau_Graphe : T_Graphe;
   begin
      Nouveau_Graphe := new T_Sommet;
      Nouveau_Graphe.all := (Etiquette, null, Graphe);
      Graphe := Nouveau_Graphe;
      Put_Line ("Ajouter sommet");
   end Ajouter_Sommet;

   function Trouver_Pointeur_Sommet
     (Graphe : T_Graphe; Etiquette : T_Etiquette_Sommet) return T_Graphe
   is
   begin
      if Graphe = null then
         raise Sommet_Non_Trouve;
      elsif Graphe.all.Etiquette = Etiquette then
         return Graphe;
      else
         return Trouver_Pointeur_Sommet (Graphe.all.Suivant, Etiquette);
      end if;
   end Trouver_Pointeur_Sommet;

   procedure Ajouter_Arete
     (Graphe    : in out T_Graphe; Origine : in T_Etiquette_Sommet;
      Etiquette : in T_Etiquette_Arete; Destination : in T_Etiquette_Sommet)
   is
      Pointeur_Origine     : T_Graphe;
      Pointeur_Destination : T_Graphe;
      Nouvelle_Arete       : T_Pointeur_Arete;
   begin
      Pointeur_Origine     := Trouver_Pointeur_Sommet (Graphe, Origine);
      Pointeur_Destination := Trouver_Pointeur_Sommet (Graphe, Destination);

      Nouvelle_Arete     := new T_Arete;
      Nouvelle_Arete.all :=
        (Etiquette, Pointeur_Destination, Pointeur_Origine.all.Arete);

      Pointeur_Origine.all.Arete := Nouvelle_Arete;

      Put_Line ("Ajouter arete");
   end Ajouter_Arete;

end Graphe;
