package body Date is

   function D1_Inf_D2 (Date1 : T_Date; Date2 : T_Date) return Boolean is
   begin

      if Date1.Annee < Date2.Annee then
         return True;
      elsif Date1.Annee > Date2.Annee then
         return False;
      elsif Date1.Mois < Date2.Mois then
         return True;
      elsif Date1.Mois > Date2.Mois then
         return False;
      elsif Date1.Jour < Date2.Jour then
         return True;
      else
         return False;
      end if;
   end D1_Inf_D2;

   function D1_Egal_D2 (Date1 : T_Date; Date2 : T_Date) return Boolean is
   begin
      return Date1.Annee = Date2.Annee and Date1.Mois = Date2.Mois and
        Date1.Jour = Date2.Jour;
   end D1_Egal_D2;

   -- Renvoie le nombre de jours d'un mois donné.
   function Nombre_Jours (Mois : T_Mois; Annee : Integer) return Integer is
   begin
      case Mois is
         when Janvier | Mars | Mai | Juillet | Aout | Octobre | Decembre =>
            return 31;
         when Fevrier =>
            if Annee mod 400 = 0 then
               return 29;
            elsif Annee mod 100 = 0 then
               return 28;
            elsif Annee mod 4 = 0 then
               return 29;
            else
               return 28;
            end if;
         when others =>
            return 30;
      end case;
   end Nombre_Jours;

   function Creer_Date
     (Jour : Integer; Mois : Integer; Annee : Integer) return T_Date
   is
      Date : T_Date;
   begin
      if Mois < 1 or Mois > 12 or Jour < 1 or Jour > 31 then
         raise Date_Incorrecte;
      end if;
      Date.Mois  := T_Mois'Val (Mois - 1);
      Date.Annee := Annee;
      if Jour > Nombre_Jours (Date.Mois, Date.Annee) then
         raise Date_Incorrecte;
      end if;
      Date.Jour := Jour;
      return Date;
   end Creer_Date;

end Date;
