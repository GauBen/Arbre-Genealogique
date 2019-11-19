with Ada.Text_Io; use Ada.Text_Io;
with Pile;

generic
   type T_Cle is private;
package Arbre_Binaire is

   package Pile_De_Cles is new Pile (T_Cle);

   type T_Arbre_Binaire is limited private;

   Cle_Presente_Exception : exception;
   Cle_Absente_Exception  : exception;

   -- Initialise un arbre binaire Abr, dont la racine est étiquetée par clé.
   procedure Initialiser (Arbre_Binaire : out T_Arbre_Binaire; Racine : in T_Cle);

   -- Ajoute une feuille à un noeud.
   -- Exceptions :
   --    Cle_Absente_Exception si le noeud parent n'est pas trouvé.
   --    Cle_Presente_Exception si la feuille est déjà présente dans l'arbre.
   procedure Ajouter
     (Arbre_Binaire : in out T_Arbre_Binaire; Noeud : in T_Cle;
      Feuille       : in     T_Cle);

   -- Renvoie le nombre de successeurs d'un noeud.
   -- Exception : Cle_Absente_Exception si le noeud n'est pas présent dans l'arbre.
   function Nombre_De_Successeurs
     (Arbre_Binaire : in T_Arbre_Binaire; Noeud : in T_Cle) return Integer;

   -- Renvoie les clés des successeur d'un noeud jusqu'à la génération donnée.
   -- Exception : Cle_Absente_Exception si le noeud n'est pas présent dans l'arbre.
   function Liste_Des_Successeurs
     (Arbre_Binaire         : in T_Arbre_Binaire; Noeud : in T_Cle;
      Nombre_De_Generations : in Integer) return T_Pile;

   -- Affiche l'arbre à partir du noeud donné.
   -- Exception : Cle_Absente_Exception si le noeud n'est pas présent dans l'arbre.
   procedure Afficher_Sous_Arbre
     (Arbre_Binaire : in T_Arbre_Binaire; Noeud : in T_Cle);

   -- Supprime un noeud et ses successeurs
   -- Exception : Cle_Absente_Exception si le noeud n'est pas présent dans l'arbre.
   procedure Supprimer_Sous_Arbre
     (Arbre_Binaire : in T_Arbre_Binaire; Noeud : in T_Cle);

   -- Renvoie l'ensemble des clés ayant N branches directes.
   -- Exception : Cle_Absente_Exception si le noeud n'est pas présent dans l'arbre.
   function Noeuds_Possedant_N_Successeurs_Directs
     (Arbre_Binaire : in T_Arbre_Binaire; Racine : in T_Cle; N : in Integer) return T_Pile;

private

   type T_Noeud;
   type T_Arbre_Binaire is access T_Noeud;
   type T_Noeud is record
      Id                : T_Cle;
      Sous_Arbre_Gauche : T_Arbre_Binaire;
      Sous_Arbre_Droit  : T_Arbre_Binaire;
   end record;

end Arbre_Binaire;
