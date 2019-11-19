with Ada.Text_Io; use Ada.Text_Io;
with Pile;

generic
   type T_Cle is private;
package Arbre_Binaire is

   package Pile_De_Cles is new Pile (T_Cle);

   type T_Arbre_Binaire is limited private;

   Cle_Presente_Exception : exception;
   Cle_Absente_Exception  : exception;

   -- Initialise un arbre binaire, dont la racine est étiquetée par la clé Racine.
   -- Paramètres :
   --    Arbre_Binaire : out T_Arbre_Binaire  L'arbre que l'on veut créer
   --    Racine        : in T_Cle             L'identifiant de la racine
   -- Assure :
   --    Arbre créé avec pour racine l'étiquette donnée
   procedure Initialiser (Arbre_Binaire : out T_Arbre_Binaire; Racine : in T_Cle);

   -- Ajoute une feuille à un noeud.
   -- Paramètres :
   --    Arbre_Binaire : in out T_Arbre_Binaire  L'arbre que l'on veut modifier
   --    Noeud         : in T_Cle                L'identifiant de la racine à laquelle on veut rajouter une feuille
   --    Feuille       : in T_Cle                L'identifiant de la feuille que l'on veut rajouter
   -- Exceptions :
   --    Cle_Absente_Exception si le noeud parent n'est pas trouvé
   --    Cle_Presente_Exception si la feuille est déjà présente dans l'arbre
   -- Assure :
   --    La feuille est rajoutée à l'arbre
   procedure Ajouter
     (Arbre_Binaire : in out T_Arbre_Binaire; Noeud : in T_Cle;
      Feuille       : in     T_Cle);

   -- Renvoie le nombre de successeurs d'un noeud.
   -- Paramètres :
   --    Arbre_Binaire : in T_Arbre_Binaire  L'arbre sur lequel nous voulons l'information
   --    Noeud         : in T_Cle            Le noeud de départ
   -- Exception :
   --    Cle_Absente_Exception si le noeud n'est pas présent dans l'arbre
   -- Assure :
   --    Nombre_De_Successeurs(A, N) = nombre de feuilles sous le noeud, incluant le noeud lui-même
   function Nombre_De_Successeurs
     (Arbre_Binaire : in T_Arbre_Binaire; Noeud : in T_Cle) return Integer;

   -- Renvoie les clés des successeur d'un noeud jusqu'à la génération donnée.
   -- Paramètres :
   --    Arbre_Binaire         : in T_Arbre_Binaire  L'arbre sur lequel nous voulons l'information
   --    Noeud                 : in T_Cle            Le noeud de départ
   --    Nombre_De_Generations : in Integer          Le nombre de générations désirées
   -- Exception :
   --     Cle_Absente_Exception si le noeud n'est pas présent dans l'arbre
   -- Assure :
   --    Liste_Des_Successeurs() = Pile des clés des successeurs de la génération demandée
   function Liste_Des_Successeurs
     (Arbre_Binaire         : in T_Arbre_Binaire; Noeud : in T_Cle;
      Nombre_De_Generations : in Integer) return T_Pile;

   -- Affiche l'arbre à partir du noeud donné.
   -- Paramètre :
   --    Arbre_Binaire : in T_Arbre_Binaire  L'arbre que nous voulons afficher
   --    Noeud         : in T_Cle            L'identifiant du noeud de départ
   -- Exception :
   --    Cle_Absente_Exception si le noeud n'est pas présent dans l'arbre
   -- Assure :
   --    Le sous arbre est affiché
   procedure Afficher_Sous_Arbre
     (Arbre_Binaire : in T_Arbre_Binaire; Noeud : in T_Cle);

   --
   -- Exception : Cle_Absente_Exception si le noeud n'est pas présent dans l'arbre.

   -- Supprime un noeud et ses successeurs.
   -- Paramètres :
   --    Arbre_Binaire : in T_Arbre_Binaire  L'arbre que nous voulons modifier
   --    Noeud         : in T_Cle            L'identifiant du noeud de départ
   -- Exception :
   --    Cle_Absente_Exception si le noeud n'est pas présent dans l'arbre
   -- Assure :
   --    Le noeud et ses successeurs ne sont plus présent
   procedure Supprimer_Sous_Arbre
     (Arbre_Binaire : in T_Arbre_Binaire; Noeud : in T_Cle);

   -- Renvoie l'ensemble des clés ayant N (0, 1 ou 2) branches directes.
   -- Paramètres :
   --    Arbre_Binaire : in T_Arbre_Binaire  L'arbre sur lequel nous voulons l'information
   --    Racine        : in T_Cle            La racine de la recherche
   --    N             : in Integer          Le nombres de successeurs directs
   -- Exception :
   --    Cle_Absente_Exception si le noeud n'est pas présent dans l'arbre
   function Noeuds_Possedant_N_Successeurs_Directs
     (Arbre_Binaire : in T_Arbre_Binaire; Racine : in T_Cle; N : in Integer) return T_Pile;

   -- Renvoie vrai si le noeud est présent dans l'arbre.
   -- Paramètres :
   --    Arbre_Binaire : in T_Arbre_Binaire  L'arbre sur lequel nous voulons l'information
   --    Noeud         : in T_Cle            Le noeud que nous voulons vérifier
   -- Assure :
   --    Renvoie Vrai si le noeud est présent et renvoie faux sinon.
   function Est_Present
      (Arbre_Binaire : in T_Arbre_Binaire; Noeud : in T_Cle) return Boolean;

   -- Détruit un arbre binaire.
   -- Paramètres :
   --    Arbre_Binaire : in out T_Arbre_Binaire  L'arbre que nous voulons détruire.
   -- Assure :
   --    L'arbre est détruit.
   procedure detruire
      (Arbre_Binaire : in out T_Arbre_Binaire);

private

   type T_Noeud;
   type T_Arbre_Binaire is access T_Noeud;
   type T_Noeud is record
      Id                : T_Cle;
      Sous_Arbre_Gauche : T_Arbre_Binaire;
      Sous_Arbre_Droit  : T_Arbre_Binaire;
   end record;

end Arbre_Binaire;
