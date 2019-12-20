with Ada.Text_IO; use Ada.Text_IO;
with Registre;

procedure Test_Registre is

   package Registre_Test is new Registre (100, Integer);
   use Registre_Test;

   procedure Test_Initialiser is
      Registre : T_Registre;
   begin
      Initialiser (Registre);
      pragma Assert (Est_Vide (Registre));
      Detruire (Registre);
   end Test_Initialiser;

   procedure Test_Attribuer is
      Registre : T_Registre;
   begin
      Initialiser (Registre);
      Attribuer (Registre, 1, 1);
      pragma Assert (Existe (Registre, 1));
      Detruire (Registre);
   end Test_Attribuer;

   procedure Test_Acceder is
      Registre : T_Registre;
   begin
      Initialiser (Registre);
      Attribuer (Registre, 1, 1);
      pragma Assert (Acceder (Registre, 1) = 1);
      Detruire (Registre);
   end Test_Acceder;

   procedure Test_Supprimer is
      Registre : T_Registre;
   begin
      Initialiser (Registre);
      Attribuer (Registre, 1, 2);
      Supprimer (Registre, 1);
      pragma Assert (not Existe (Registre, 1));
      Detruire (Registre);
   end Test_Supprimer;

   procedure Test_Detruire is
      Registre : T_Registre;
   begin
      Initialiser (Registre);
      Attribuer (Registre, 1, 2);
      Attribuer (Registre, 3, 4);
      Attribuer (Registre, 2, 5);
      Detruire (Registre);
      pragma Assert (Est_Vide (Registre));
   end Test_Detruire;
begin
   Test_Initialiser;
   Test_Acceder;
   Test_Attribuer;
   Test_Supprimer;
   Test_Detruire;
   Put_Line ("Le module est fonctionnel");
end Test_Registre;
