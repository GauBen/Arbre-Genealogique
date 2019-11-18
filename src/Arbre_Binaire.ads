with Ada.Text_IO;
use Ada.Text_IO;
with Pile;

generic
	type T_Identifiant is private;
package Arbre_Binaire is

        package Pile_Arbre_Binaire is
        new Pile ( T_Element => T_Identifiant);
        type T_Abr is limited private;

        Identifiant_Present_Exception : Exception;
        Identifiant_Absent_Exception : Exception;

        -- Initisalier un Arbre Binaire abr. L'Arbre Binaire est vide.
        procedure Initialiser (Abr : out T_Arbre_Binaire;ID : in T_Identifiant)

        -- Ajouter un noeud
        -- Exception : Identifiant_Present_Exception si L'identifiant est déjà présent dans l'arbre.
        procedure Ajouter(Abr : in out T_Arbre_Binaire;ID_racine : in T_Identifiant; ID_feuille : in T_Identifiant);

        -- Donner le nombre de successeurs d'un noeud
        -- Exception : Identifiant_Absent_Exception si l'identifiant n'est pas présent dans l'arbre.
        function Nombre_de_successeurs(Abr : in T_Arbre_Binaire; ID : in T_Identifiant) return Integer;

        -- Obtenir les Identifiants des successeur d'un noeud jusqu'à une certaine génération
        -- Exception : Identifiant_Absent_Exception si l'identifiant n'est pas présent dans l'arbre.
        function  Obt_Id_Successeur (Abr : in T_Arbre_Binaire ; ID : in T_Identifiant ; Generation : in Integer) return T_Pile;

        -- afficher l'arbre à partir d'un certain noeud
        -- Exception : Identifiant_Absent_Exception si l'identifiant n'est pas présent dans l'arbre.
        procedure Afficher_Sous_Arbre(Abr : in T_Arbre_Binaire; ID : in T_Identifiant);

        -- Supprimer un noeud et ses successeurs
        --Exception : Identifiant_Absent_Exception si l'identifiant n'est pas présent dans l'arbre
        procedure Supprimer_Sous_Arbre(Abr : in T_Arbre_Binaire; ID : in T_Identifiant);

        -- Obtenir l'ensemble des clés ayant n branches directes suivantes
        -- Exception : Identifiant_Absent_Exception si l'identifiant n'est pas présent dans l'arbre
        function Id_Possedant_N_Successeurs_Directs(Abr : in T_Arbre_Binaire; ID : in T_Identifiant; N : in Integer) return T_Pile;

private

	type T_Noeud;
	type T_Arbre_Binaire is access T_Noeud;
	type T_Noeud is
	    record

		ID : T_Identifiant;
		Sous_Arbre_Gauche : T_Arbre_Binaire;
		Sous_Arbre_Droit : T_Arbre_Binaire;
	    end record



end Arbre_Binaire;
