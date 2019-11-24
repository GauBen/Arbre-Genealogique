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
   end Initialiser;

   procedure Detruire (Graphe : in out T_Graphe) is
   begin
      Graphe := null;
      Put_Line ("TODO");
   end Detruire;

   procedure Ajouter_Sommet
     (Graphe : in out T_Graphe; Etiquette : T_Etiquette_Sommet)
   is
      Nouveau_Graphe : T_Graphe;
   begin
      Nouveau_Graphe     := new T_Sommet;
      Nouveau_Graphe.all := (Etiquette, null, Graphe);
      Graphe             := Nouveau_Graphe;
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
      Nouvelle_Arete       : T_Liste_Adjacence;
   begin
      Pointeur_Origine     := Trouver_Pointeur_Sommet (Graphe, Origine);
      Pointeur_Destination := Trouver_Pointeur_Sommet (Graphe, Destination);

      Nouvelle_Arete     := new T_Arete;
      Nouvelle_Arete.all :=
        (Etiquette, Pointeur_Destination, Pointeur_Origine.all.Arete);

      Pointeur_Origine.all.Arete := Nouvelle_Arete;
   end Ajouter_Arete;

   procedure Chaine_Adjacence
     (Adjacence :    out T_Liste_Adjacence; Graphe : in T_Graphe;
      Origine   : in     T_Etiquette_Sommet)
   is
   begin
      Adjacence := Trouver_Pointeur_Sommet (Graphe, Origine).all.Arete;
   end Chaine_Adjacence;

   function Adjacence_Non_Vide
     (Adjacence : T_Liste_Adjacence) return Boolean
   is
   begin
      return Adjacence /= null;
   end Adjacence_Non_Vide;

   procedure Arete_Suivante
     (Adjacence : in out T_Liste_Adjacence; Arete: out T_Arete_Etiquetee)
   is
   begin
      if Adjacence = null then
         raise Vide;
      end if;
      Arete :=
        (Adjacence.all.Etiquette, Adjacence.all.Destination.all.Etiquette);
      Adjacence := Adjacence.all.Suivante;
   end Arete_Suivante;

end Graphe;
