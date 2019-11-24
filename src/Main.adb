with Ada.Text_Io;         use Ada.Text_Io;
with Ada.Integer_Text_Io; use Ada.Integer_Text_Io;

procedure Main is

   type T_Menu is (Menu_A, Menu_B, Quitter);

   type T_Etat is record
      Cle : Integer;
   end record;

   procedure Afficher_Menu_A (Etat : in out T_Etat; Menu : in out T_Menu) is
      Choix : Integer;
   begin
      Put_Line ("** Menu A **");
      New_Line;
      Put ("Etat.Cle : ");
      Put (Etat.Cle, 0);
      New_Line;
      Put_Line ("1. Incrementer la cle");
      Put_Line ("2. Aller au menu B");
      New_Line;
      Put ("Votre choix : ");
      Get (Choix);
      Skip_Line;
      case Choix is
         when 1 =>
            Etat.Cle := Etat.Cle + 1;
         when 2 =>
            Menu := Menu_B;
         when others =>
            Menu := Quitter;
      end case;
   end Afficher_Menu_A;

   procedure Afficher_Menu_B (Etat : in out T_Etat; Menu : in out T_Menu) is
      Choix : Integer;
   begin
      Put_Line ("** Menu B **");
      New_Line;
      Put ("Etat.Cle : ");
      Put (Etat.Cle, 0);
      New_Line;
      Put_Line ("1. Decrementer la cle");
      Put_Line ("2. Aller au menu A");
      New_Line;
      Put ("Votre choix : ");
      Get (Choix);
      Skip_Line;
      case Choix is
         when 1 =>
            Etat.Cle := Etat.Cle - 1;
         when 2 =>
            Menu := Menu_A;
         when others =>
            Menu := Quitter;
      end case;
   end Afficher_Menu_B;

   procedure Afficher_Menu (Etat : in out T_Etat; Menu : in out T_Menu) is
   begin
      case Menu is
         when Menu_A =>
            Afficher_Menu_A (Etat, Menu);
         when Menu_B =>
            Afficher_Menu_B (Etat, Menu);
         when others =>
            Menu := Quitter;
      end case;
   end Afficher_Menu;

   Etat : T_Etat := (CLe => 0);

   Menu : T_Menu := Menu_A;

begin

   while Menu /= Quitter loop
      Afficher_Menu (Etat, Menu);
   end loop;

end Main;
