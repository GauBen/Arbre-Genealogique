with Ada.Text_Io;         use Ada.Text_Io;
with Ada.Integer_Text_Io; use Ada.Integer_Text_Io;
with Ada.Io_Exceptions;

procedure Main is

   Todo_Exception : exception;

   type T_Menu is
     (Menu_Principal, Menu_Registre, Menu_Registre_Consultation,Menu_Registre_Ajout, Quitter);

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
      Correct : Boolean := False;
      -- Premiere_Entree : Boolean := True;
   begin
      while not Correct loop
         Put ("Votre choix [");
         Afficher_Liste_Choix;
         -- Fonctionnalité desactivée :
         --if not Premiere_Entree then
         --   Put (" / 0 pour quitter");
         --end if;
         Put ("] : ");
         begin
            Get (Choix);
            Correct := Choix in 1 .. Nb_Choix;
            --Correct := Choix in 0 .. Nb_Choix;
         exception
            when Ada.Io_Exceptions.Data_Error =>
               Correct := False;
         end;
         Skip_Line;
         if not Correct then
            Put_Line ("Choix incorrect.");
            New_Line;
         end if;
         -- Premiere_Entree := False;
      end loop;

   end Choisir;

   procedure Choisir_Cle (Cle : out Integer) is
      Correct         : Boolean := False;
      Premiere_Entree : Boolean := True;
   begin
      while not Correct loop
         Put ("Votre choix");
         if not Premiere_Entree then
            Put (" [0 pour retour]");
         end if;
         Put (" : ");
         begin
            Get (Cle);
            Correct := Cle >= 0;
         exception
            when Ada.Io_Exceptions.Data_Error =>
               Correct := False;
         end;
         Skip_Line;
         if not Correct then
            Put_Line ("Clé incorrecte.");
            New_Line;
         end if;
         Premiere_Entree := False;
      end loop;
   end Choisir_Cle;

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
            Etat.Menu := Menu_Registre;
         when 2 =>
            raise Todo_Exception;
         when others =>
            Etat.Menu := Quitter;
      end case;
      New_Line;
   end Afficher_Menu_Principal;

   procedure Afficher_Menu_Registre (Etat : in out T_Etat) is
      Choix : Integer;
   begin
      Put_Line ("* Registre *");
      New_Line;
      Put_Line ("Menu :");
      Put_Line ("1. Consulter une personne a partir de sa clé");
      Put_Line ("2. Chercher une personne a partir de son nom");
      Put_Line ("3. Ajouter une personne");
      Put_Line ("4. Retour");
      New_Line;
      Choisir (4, Choix);
      case Choix is
         when 1 =>
            Etat.Menu := Menu_Registre_Consultation;
         when 2 =>
            raise Todo_Exception;
         when 3 =>
            raise Todo_Exception;
         when 4 =>
            Etat.Menu := Menu_Principal;
         when others =>
            Etat.Menu := Quitter;
      end case;
      New_Line;
   end Afficher_Menu_Registre;

   procedure Afficher_Menu_Registre_Consultation (Etat : in out T_Etat) is
      Cle : Integer;
   begin
      Put_Line ("* Consultation du registre *");
      New_Line;
      Put_Line ("Entrez la clé de la personne que vous voulez consulter.");
      Choisir_Cle (Cle);
      if Cle = 0 then
         Etat.Menu := Menu_Registre;
         return;
      end if;
      raise Todo_Exception;
   end Afficher_Menu_Registre_Consultation;

   procedure Afficher_Menu_Registre_Ajout (Etat : in out T_Etat) is
      Nom_Usuel : Sb.Bounded_String;
      Nom_Complet : Sb.Bounded_String;
      Personne : T_Personne;
      Choix : Character;
      Cle : Integer;
   begin
      Put_Line("* Ajouter une personne au registre*");
      New_Line;
      Put_Line("Informations requises : nom usuel, nom complet, sexe, date et lieu de naissance.");
      New_Line;
      Put("Nom usuel : ");
      Get(Nom_Usuel);
      New_Line;
      Put("Nom Complet : ");
      Get(Nom_Complet);
      New_Line;
      Put("Confirmer l'ajout [O pour oui, N pour non] : ");
      Get(Choix);
      while Choix/='o' or Choix/= 'O' or Choix /= 'n' or Choix /= 'N' loop
         Put_Line("Choix incorrect")
         Put("Confirmer l'ajout [O pour oui, N pour non] : ");
         Get(Choix);
      end loop;
      Personne := (Nom_Usuel,Nom_Complet);
      if Choix = 'o' or Choix = 'O' then
         Generer_Cle(Arbre,Cle);
         Attribuer_Registre(Arbre,Cle,Personne);
         Put_Line("Personne ajoutée avec la clé : ");
         Put(Cle);
      end if;
      
   end Afficher_Menu_Registre_Ajout;

   procedure Afficher_Menu (Etat : in out T_Etat) is
   begin
      case Etat.Menu is
         when Menu_Principal =>
            Afficher_Menu_Principal (Etat);
         when Menu_Registre =>
            Afficher_Menu_Registre (Etat);
         when Menu_Registre_Consultation =>
            Afficher_Menu_Registre_Consultation (Etat);
         when Menu_Registre_Ajout =>
            Afficher_Menu_Registre_Ajout (Etat);
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
