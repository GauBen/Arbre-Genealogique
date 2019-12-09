with Ada.Unchecked_Deallocation;

package body Registre is

   procedure Initialiser (Registre : out T_Registre) is
   begin
      Registre := (others => null);
   end Initialiser;

   function Hash (Cle : Integer) return Integer is
   begin
      return Cle mod Modulo;
   end Hash;

   function Est_Vide (Registre : T_Registre) return Boolean is
   begin
      for i in Registre'range loop
         if Registre (i) /= null then
            return False;
         end if;
      end loop;
      return True;
   end Est_Vide;

   -- Renvoie vrai si la clé est presente dans le registre.
   function Existe (Registre : T_Registre; Cle : Integer) return Boolean is
      Pointeur : T_Pointeur_Sur_Maillon;
   begin
      Pointeur := Registre (Hash (Cle));
      while Pointeur /= null loop
         if Pointeur.all.Cle = Cle then
            return True;
         end if;
         Pointeur := Pointeur.all.Suivant;
      end loop;
      return False;
   end Existe;

   procedure Attribuer
     (Registre : in out T_Registre; Cle : in Integer; Element : in T_Element)
   is
      Pointeur : T_Pointeur_Sur_Maillon;
   begin
      if Registre (Hash (Cle)) = null then
         Pointeur              := new T_Maillon;
         Pointeur.all          := (Cle, Element, null);
         Registre (Hash (Cle)) := Pointeur;
      else
         Pointeur := Registre (Hash (Cle));
         while Pointeur.all.Suivant /= null loop
            if Pointeur.all.Cle = Cle then
               Pointeur.all.Element := Element;
               return;
            end if;
            Pointeur := Pointeur.all.Suivant;
         end loop;
         if Pointeur.all.Cle = Cle then
            Pointeur.all.Element := Element;
         else
            Pointeur.all.Suivant     := new T_Maillon;
            Pointeur.all.Suivant.all := (Cle, Element, null);
         end if;
      end if;
   end Attribuer;

   function Acceder (Registre : T_Registre; Cle : Integer) return T_Element is
      Pointeur : T_Pointeur_Sur_Maillon;
   begin
      Pointeur := Registre (Hash (Cle));
      while Pointeur /= null loop
         if Pointeur.all.Cle = Cle then
            return Pointeur.all.Element;
         end if;
         Pointeur := Pointeur.all.Suivant;
      end loop;
      raise Cle_Absente_Exception;
   end Acceder;

   procedure Desallouer_Maillon is new Ada.Unchecked_Deallocation (T_Maillon,
      T_Pointeur_Sur_Maillon);

   procedure Supprimer (Registre : in out T_Registre; Cle : in Integer) is
      Pointeur : T_Pointeur_Sur_Maillon;
      Ancien   : T_Pointeur_Sur_Maillon;
   begin
      if Registre (Hash (Cle)) /= null then
         Pointeur := Registre (Hash (Cle));
         if Pointeur.all.Cle = Cle then
            Registre (Hash (Cle)) := Pointeur.all.Suivant;
            Desallouer_Maillon (Pointeur);
            return;
         end if;
         while Pointeur.all.Suivant /= null loop
            if Pointeur.all.Suivant.all.Cle = Cle then
               Ancien               := Pointeur.all.Suivant;
               Pointeur.all.Suivant := Pointeur.all.Suivant.all.Suivant;
               Desallouer_Maillon (Ancien);
               return;
            end if;
            Pointeur := Pointeur.all.Suivant;
         end loop;
      end if;
   end Supprimer;

   procedure Supprimer_Maillons (Pointeur : in out T_Pointeur_Sur_Maillon) is
   begin
      if Pointeur /= null then
         Supprimer_Maillons (Pointeur.all.Suivant);
      end if;
      Desallouer_Maillon (Pointeur);
   end Supprimer_Maillons;

   procedure Detruire (Registre : in out T_Registre) is
   begin
      for i in Registre'range loop
         Supprimer_Maillons (Registre (i));
      end loop;
   end Detruire;

   procedure Appliquer_sur_registre(Registre : in out T_Registre) is
   begin
      for i in [1..Modulo] loop
         Appliquer_sur_tous(Registre(i);
      end loop;
   end Appliquer_sur_registre;

   procedure Appliquer_sur_tous(Pointeur : in out T_Pointeur_Sur_Maillon) is 
   begin
       if E/=Null then
           Appliquer_sur_tous(Pointeur.all.Suivant);
           Predicat(Pointeur.all.Cle,Pointeur.all.Element,Assertion);
       else
           Null;
       end if;
   end Appliquer_sur_tous;
end Registre;
