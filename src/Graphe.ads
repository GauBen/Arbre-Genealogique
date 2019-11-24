generic
   type T_Etiquette_Sommet is private;
   type T_Etiquette_Arete is private;
package Graphe is

   type T_Graphe is limited private;
   type T_Liste_Adjacence is limited private;

   type T_Arete_Etiquetee is record
      Etiquette   : T_Etiquette_Arete;
      Destination : T_Etiquette_Sommet;
   end record;

   Sommet_Non_Trouve : exception;
   Vide              : exception;

   procedure Pouet;

   procedure Initialiser (Graphe : out T_Graphe);

   procedure Detruire (Graphe : in out T_Graphe);

   procedure Ajouter_Sommet
     (Graphe : in out T_Graphe; Etiquette : T_Etiquette_Sommet);

   procedure Ajouter_Arete
     (Graphe    : in out T_Graphe; Origine : in T_Etiquette_Sommet;
      Etiquette : in T_Etiquette_Arete; Destination : in T_Etiquette_Sommet);

   procedure Chaine_Adjacence
     (Adjacence :    out T_Liste_Adjacence; Graphe : in T_Graphe;
      Origine   : in     T_Etiquette_Sommet);

   function Adjacence_Non_Vide
     (Adjacence : T_Liste_Adjacence) return Boolean;

   procedure Arete_Suivante
     (Adjacence : in out T_Liste_Adjacence; Arete: out T_Arete_Etiquetee);

private

   type T_Sommet;
   type T_Arete;

   type T_Graphe is access T_Sommet;
   type T_Liste_Adjacence is access T_Arete;

   type T_Sommet is record
      Etiquette : T_Etiquette_Sommet;
      Arete     : T_Liste_Adjacence;
      Suivant   : T_Graphe;
   end record;

   type T_Arete is record
      Etiquette   : T_Etiquette_Arete;
      Destination : T_Graphe;
      Suivante    : T_Liste_Adjacence;
   end record;

end Graphe;
