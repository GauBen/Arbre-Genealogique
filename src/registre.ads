with Piles;
generic
   Modulo : Integer;
   type T_Element is private;
   type T_Truc is private;
-- Un registre est une table de hachage.
package Registre is

   type T_Couple is record
      Cle : Integer;
      Element : T_Element;
   end record;

   package PilesCouple is new Piles(T_Couple);
   use PilesCouple;

   type T_Registre is limited private;

   Cle_Absente_Exception : exception;

   -- Renvoie vrai si le registre est entièrement vide.
   function Est_Vide (Registre : T_Registre) return Boolean;

   -- Initialiser un registre vide.
   procedure Initialiser (Registre : out T_Registre) with
      Post => Est_Vide (Registre);

      -- Renvoie vrai si la clé est presente dans le registre.
   function Existe (Registre : T_Registre; Cle : Integer) return Boolean;

   -- Insère ou modifie un élément dans le registre.
   procedure Attribuer
     (Registre : in out T_Registre; Cle : in Integer; Element : in T_Element);

   -- Renvoie un élément du registre.
   -- Lance Cle_Absente_Exception si la clé n'est pas trouvee.
   function Acceder (Registre : T_Registre; Cle : Integer) return T_Element;

   -- Supprime un élément du registre.
   procedure Supprimer (Registre : in out T_Registre; Cle : in Integer);

   -- Supprime tous les éléments du registre.
   procedure Detruire (Registre : in out T_Registre) with
      Post => Est_Vide (Registre);

generic
   with function Predicat(Un_Element : in T_Element;Un_Truc : T_Truc) return Boolean;
procedure Recherche_Sur_Registre(Registre : in out T_Registre; Pile : in out T_Pile; Un_Truc : in T_Truc);

private

   -- On choisit de representer un registre par un tableau de pointeurs.
   -- Une case de ce tableau contient une chaîne de tous les elements dont
   -- la valeur de la clé par la fonction de hachage est la même.
   type T_Maillon;
   type T_Pointeur_Sur_Maillon is access T_Maillon;

   type T_Maillon is record
      Cle     : Integer;
      Element : T_Element;
      Suivant : T_Pointeur_Sur_Maillon;
   end record;

   type T_Registre is array (1 .. Modulo) of T_Pointeur_Sur_Maillon;

end Registre;
