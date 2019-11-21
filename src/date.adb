
package Date is



   function D1_Inf_D2 (Date1 : T_Date; Date2 : T_Date) return Boolean;
   begin

      if Date1.Annee < Date2.Annee then
         return True;
      elsif Date1.Annee > Date2.Annee then
         return False;
      else
         if Date1.Mois < Date2.Mois then
            return True;
         elsif Date1.Mois > Date2.Mois then
            return False;
         else
            if Date1.Jour < Date2.Jour then
               return True;
            else
               return False;
            end if;
         end if;
      end if;
   end D1_Inf_D2;

   function D1_Egal_D2 (Date1 : T_Date; Date2 : T_Date) return Boolean;
   begin
      if Date1.Annee = Date2.Anne and Date1.Mois = Date2.Mois and Date1.Jour = Date2.Jour then
         return True;
      else
         return False;
   end D1_Egal_D2;

end Date;



