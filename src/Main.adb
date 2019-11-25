with Ada.Text_Io;         use Ada.Text_Io;
with Ada.Integer_Text_Io; use Ada.Integer_Text_Io;

procedure Main is

   type T_Menu is (Menu_A, Menu_B, Quitter);

   type T_Etat is record
      Cle  : Integer;
      Menu : T_Menu;
   end record;

   procedure Afficher_Menu_A (Etat : in out T_Etat) is
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
            Etat.Menu := Menu_B;
         when others =>
            Etat.Menu := Quitter;
      end case;
   end Afficher_Menu_A;

   procedure Afficher_Menu_B (Etat : in out T_Etat) is
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
            Etat.Menu := Menu_A;
         when others =>
            Etat.Menu := Quitter;
      end case;
   end Afficher_Menu_B;

   procedure Afficher_Menu (Etat : in out T_Etat) is
   begin
      case Etat.Menu is
         when Menu_A =>
            Afficher_Menu_A (Etat);
         when Menu_B =>
            Afficher_Menu_B (Etat);
         when others =>
            Etat.Menu := Quitter;
      end case;
   end Afficher_Menu;

   Etat : T_Etat := (Cle => 0, Menu => Menu_A);

begin

   while Etat.Menu /= Quitter loop
      Afficher_Menu (Etat);
   end loop;

end Main;
