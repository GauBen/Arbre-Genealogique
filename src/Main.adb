with Ada.Text_Io;         use Ada.Text_Io;
with Ada.Integer_Text_Io; use Ada.Integer_Text_Io;
with Ada.Io_Exceptions;

procedure Main is

   Todo_Exception : exception;

   type T_Menu is (Menu_Principal, Quitter);

   type T_Etat is record
      Cle  : Integer;
      Menu : T_Menu;
   end record;

   procedure Choisir (Nb_Choix : in Integer; Choix : out Integer) is
      procedure Afficher_Liste_Choix is
      begin
         for I in 1 .. Nb_Choix - 2 loop
            Put (I, 0);
            Put (", ");
         end loop;
         Put (Nb_Choix - 1, 0);
         Put (" ou ");
         Put (Nb_Choix - 0, 0);
      end Afficher_Liste_Choix;
      Correct         : Boolean := False;
      Premiere_Entree : Boolean := True;
   begin
      while not Correct loop
         Put ("Votre choix [");
         Afficher_Liste_Choix;
         if not Premiere_Entree then
            Put (" / 0 pour quitter");
         end if;
         Put ("] : ");
         begin
            Get (Choix);
            Correct := Choix in 0 .. Nb_Choix;
         exception
            when Ada.Io_Exceptions.Data_Error =>
               Correct := False;
         end;
         Skip_Line;
         if not Correct then
            Put_Line ("Chox incorrect.");
            New_Line;
         end if;
         Premiere_Entree := False;
      end loop;

   end Choisir;

   procedure Afficher_Menu_Principal (Etat : in out T_Etat) is
      Choix : Integer;
   begin
      Put_Line ("**********************");
      Put_Line ("* Arbre Généalogique *");
      Put_Line ("**********************");
      New_Line;
      Put_Line ("Menu principal :");
      Put_Line ("1. Accéder au registre");
      Put_Line ("2. Accéder a un arbre généalogique");
      Put_Line ("3. Quitter");
      New_Line;
      Choisir (3, Choix);
      case Choix is
         when 1 =>
            raise Todo_Exception;
         when 2 =>
            raise Todo_Exception;
         when others =>
            Etat.Menu := Quitter;
      end case;
   end Afficher_Menu_Principal;

   procedure Afficher_Menu (Etat : in out T_Etat) is
   begin
      case Etat.Menu is
         when Menu_Principal =>
            Afficher_Menu_Principal (Etat);
         when others =>
            Etat.Menu := Quitter;
      end case;
   end Afficher_Menu;

   Etat : T_Etat := (Cle => 0, Menu => Menu_Principal);

begin

   while Etat.Menu /= Quitter loop
      Afficher_Menu (Etat);
   end loop;

end Main;
