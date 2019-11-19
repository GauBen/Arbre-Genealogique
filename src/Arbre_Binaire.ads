with Ada.Text_Io; use Ada.Text_Io;
with Pile;

generic
   type T_Identifiant is private;
package Arbre_Binaire is

   package Pile_De_Cles is new Pile (T_Identifiant);

   type T_Arbre_Binaire is limited private;

        -- Initisalier un Arbre Binaire abr. L'Arbre Binaire est vide.
        -- Paramètres :
        --             Arbre : out T_Arbre_Binaire   L'arbre que l'on veut créer
        --             ID    : in T_Identifiant      L'identifiant de la racine
        -- Exception : Aucune
        -- Assure :
        --        Arbre créé avec pour racine l'identifiant donné.
        procedure Initialiser (Arbre : out T_Arbre_Binaire;ID : in T_Identifiant) with
            Post => Est_Present(Arbre,ID);

        -- Ajouter un noeud à une racine
        -- Paramètres :
        --              Arbre : in out T_Arbre_Binaire  L'arbre que 'l'on veut modifier
        --              ID_Racine : in T_Identifiant  L'identifiant de la racine à laquelle on veut rajouter une feuille
        --              ID_feuille : in T_Identifiant  L'identifiant de la feuille que l'on veut rajouter
        -- Exception : Identifiant_Present_Exception si L'identifiant de la feuille rajouté est déjà présent dans l'arbre.
        --             Identifiant_Absent_Exception si l'identifiant de la racine n'est pas présent dans l'arbre.
        -- Assure :
        --        Dans les bonnes conditions, la feuille est rajouté à l'arbre
        procedure Ajouter(Arbre : in out T_Arbre_Binaire;ID_racine : in T_Identifiant; ID_feuille : in T_Identifiant) with
            Post => Est_Present(Arbre : in T_Arbre, ID_feuille);

        -- Donner le nombre de successeurs d'un noeud
        -- Paramètres :
        --              Arbre : in T_Arbre_Binaire  L'arbre sur lequel nous voulons l'information
        --              ID : in T_Identifiant       Le noeud de départ
        -- Exception : Identifiant_Absent_Exception si l'identifiant n'est pas présent dans l'arbre.
        -- Assure :
        --        Nombre_de_successeurs(Arbre,Id) = nombre de feuilles sous le noeud
        function Nombre_de_successeurs(Arbre : in T_Arbre_Binaire; ID : in T_Identifiant) return Integer;

        -- Obtenir les Identifiants des successeur d'un noeud d'une certaine génération
        -- Paramètres :
        --              Arbre : in T_Arbre_Binaire l'arbre sur lequel nous voulons l'information
        --              ID : in T_Identifiant      Le noeud de départ
        --              Generation : in Integer    La génération sur laquelle nous voulons des informations.
        -- Exception : Identifiant_Absent_Exception si l'identifiant n'est pas présent dans l'arbre.
        -- Assure : Obt_ID_Successeuer(Arbre,ID,Generation) = Pile des Identifiant des successeurs de la génération demandée.
        function  Obt_Id_Successeur (Arbre : in T_Arbre_Binaire ; ID : in T_Identifiant ; Generation : in Integer) return T_Pile;

        -- afficher l'arbre à partir d'un certain noeud.
        -- Paramètre :
        --           Arbre : in T_Arbre_Binaire    L'arbre que nous voulons afficher
        --           ID : in T_Identifiant      L'identifiant du noeud de départ
        -- Exception : Identifiant_Absent_Exception si l'identifiant n'est pas présent dans l'arbre.
        -- Assure :
        --           L'arbre est affiché.
        procedure Afficher_Sous_Arbre(Arbre : in T_Arbre_Binaire; ID : in T_Identifiant);

        -- Supprimer un noeud et ses successeurs.
        -- Paramètres :
        --              Arbre : in T_Arbre_Binaire L'arbre que nous voulons modifier.
        --              ID : in T_Identifiant L'identifiant du noeud de départ.
        --Exception : Identifiant_Absent_Exception si l'identifiant n'est pas présent dans l'arbre
        -- Assure :
        --         Le noeud et ses successeurs ne sont plus présent.
        procedure Supprimer_Sous_Arbre(Arbre : in T_Arbre_Binaire; ID : in T_Identifiant);

        -- Obtenir l'ensemble des clés ayant n {0,1,2} branches directes suivantes.
        -- Paramètres :
        --              Arbre : in T_Arbre_Binaire L'arbre sur lequel nous voulons l'information
        --              N : in Integer  Le nombres de successeurs directs.
        -- Exception : Identifiant_Absent_Exception si l'identifiant n'est pas présent dans l'arbre
        function Id_Possedant_N_Successeurs_Directs(Arbre : in T_Arbre_Binaire; N : in Integer) return T_Pile;

private

   type T_Noeud;
   type T_Arbre_Binaire is access T_Noeud;
   type T_Noeud is record
      Id                : T_Identifiant;
      Sous_Arbre_Gauche : T_Arbre_Binaire;
      Sous_Arbre_Droit  : T_Arbre_Binaire;
   end record;

end Arbre_Binaire;
