-- Package Graphe
-- Gère le stockage et la manipulation de graphes orientés.

-- Généricité :
-- Les sommets et les arêtes sont étiquetés par les éléments des types
-- T_Etiquette_Sommet et T_Etiquette_Arete
generic
   type T_Etiquette_Sommet is private;
   type T_Etiquette_Arete is private;
package Graphe is

   -- Type accessibles de l'extérieur : le graphe et la liste d'adjacence,
   -- pour explorer les arêtes sortant d'un sommet
   type T_Graphe is limited private;
   type T_Liste_Adjacence is limited private;

   -- Type public pour la lecture de la liste d'adjacence
   type T_Arete_Etiquetee is record
      Etiquette   : T_Etiquette_Arete;
      Destination : T_Etiquette_Sommet;
   end record;

   -- Exceptions : une étiquette donnée ne correspond �  aucun sommet
   Sommet_Non_Trouve : exception;
   -- La liste donnée est vide
   Vide : exception;

   -- ! Debug
   procedure Pouet;

   -- Initialise un graphe vide.
   procedure Initialiser (Graphe : out T_Graphe);

   -- Libère l'espace mémoire occupé par un graphe.
   procedure Detruire (Graphe : in out T_Graphe);

   -- Ajoute un sommet au graphe avec l'étiquette donnée.
   procedure Ajouter_Sommet
     (Graphe : in out T_Graphe; Etiquette : T_Etiquette_Sommet);

   -- Ajoute une arête entre deux sommets donnés.
   procedure Ajouter_Arete
     (Graphe    : in out T_Graphe; Origine : in T_Etiquette_Sommet;
      Etiquette : in T_Etiquette_Arete; Destination : in T_Etiquette_Sommet);

   -- Renvoie la liste des arêtes sortant du sommet donné.
   procedure Chaine_Adjacence
     (Adjacence :    out T_Liste_Adjacence; Graphe : in T_Graphe;
      Origine   : in     T_Etiquette_Sommet);

   -- Renvoie vrai si on peut continuer �  itérer.
   function Adjacence_Non_Vide (Adjacence : T_Liste_Adjacence) return Boolean;

   -- Lit l'arête suivante et avance la lecture.
   procedure Arete_Suivante
     (Adjacence : in out T_Liste_Adjacence; Arete : out T_Arete_Etiquetee);

   procedure Supprimer_Arete
     (Graphe          : in T_Graphe; Origine : in T_Etiquette_Sommet;
      Etiquette_Arete : in T_Etiquette_Arete;
      Destination     : in T_Etiquette_Sommet);

   function Indiquer_Sommet_Existe
     (Graphe : T_Graphe; Etiquette : T_Etiquette_Sommet) return Boolean;

   function Est_Vide (Graphe : T_Graphe) return Boolean;
private

   -- Un graphe est représenté par une liste chaînée de sommets
   -- et les arêtes par une liste chaînée aussi

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
