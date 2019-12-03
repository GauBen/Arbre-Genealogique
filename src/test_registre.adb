with registre;
with text_io; use text_io;
with ada.integer_text_io; use ada.integer_text_io;

procedure Test_Registre is

   package Registre_Test is new registre (20, integer);
   use Registre_Test;

   mon_reg : t_registre;

begin

   initialiser(mon_reg);
   if not existe(mon_reg, 42) then
      put("ca chemar");
   end if;

   attribuer(mon_reg, 42, 0);
   attribuer(mon_reg, 22, 1);
   attribuer(mon_reg, 42, 2);
   if existe(mon_reg, 42) then
      put("ca chemar");
   end if;
   if existe(mon_reg, 22) then
      put("ca chemar");
   end if;

   put(acceder(mon_reg, 42));
   put(acceder(mon_reg, 22));

   --Supprimer(mon_reg, 42);
   --Supprimer(mon_reg, 22);

   if not Est_Vide(mon_reg) then put(" oh "); end if;

   Detruire(mon_reg);

   if Est_Vide(mon_reg) then put("yeah"); end if;

end Test_Registre;
