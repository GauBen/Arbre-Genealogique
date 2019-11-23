generic
   type T_Etiquette_Sommet is private;
   type T_Etiquette_Arete is private;
package Graphe is

   type T_Graphe is limited private;

   Sommet_Non_Trouve : exception;

   procedure Pouet;

   procedure Initialiser (Graphe : out T_Graphe);

   procedure Detruire (Graphe : in out T_Graphe);

   procedure Ajouter_Sommet
     (Graphe : in out T_Graphe; Etiquette : T_Etiquette_Sommet);

   procedure Ajouter_Arete
     (Graphe    : in out T_Graphe; Origine : in T_Etiquette_Sommet;
      Etiquette : in T_Etiquette_Arete; Destination : in T_Etiquette_Sommet);

private

   type T_Sommet;
   type T_Arete;

   type T_Graphe is access T_Sommet;
   type T_Pointeur_Arete is access T_Arete;

   type T_Sommet is record
      Etiquette : T_Etiquette_Sommet;
      Arete     : T_Pointeur_Arete;
      Suivant   : T_Graphe;
   end record;

   type T_Arete is record
      Etiquette   : T_Etiquette_Arete;
      Destination : T_Graphe;
      Suivante    : T_Pointeur_Arete;
   end record;

end Graphe;
