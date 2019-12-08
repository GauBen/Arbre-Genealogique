with Ada.Text_Io;         use Ada.Text_Io;
with Ada.Integer_Text_Io; use Ada.Integer_Text_Io;
with Ada.Io_Exceptions;
with Ada.Text_Io.Bounded_Io;
with Arbre_Genealogique;  use Arbre_Genealogique;
with Date;                use Date;

procedure Main is

   package Ada_Strings_Io is new Ada.Text_Io.Bounded_Io (Sb);
   use Ada_Strings_Io;

   Todo_Exception : exception;

   type T_Menu is
     (Menu_Principal, Menu_Registre, Menu_Registre_Consultation_Selection,
      Menu_Registre_Consultation_Personne, Menu_Registre_Ajout,
      Menu_Registre_Modification, Quitter);

   type T_Etat is record
      Arbre : T_Arbre_Genealogique;
      Cle   : Integer;
      Menu  : T_Menu;
   end record;

   -- Affiche la phrase "Votre choix [1, 2, ... `Nb_Choix`]"
   -- et capture la saisie de l'utilisateur dans `Choix`.
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

   -- Permet de choisir un entier positif ou nul de facon robuste.
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

   -- Affiche le menu principal.
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
      New_Line;
      case Choix is
         when 1 =>
            Etat.Menu := Menu_Registre;
         when 2 =>
            raise Todo_Exception;
         when others =>
            Etat.Menu := Quitter;
      end case;
   end Afficher_Menu_Principal;

   -- Affiche le menu du registre.
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
      New_Line;
      case Choix is
         when 1 =>
            Etat.Menu := Menu_Registre_Consultation_Selection;
         when 2 =>
            raise Todo_Exception;
         when 3 =>
            Etat.Menu := Menu_Registre_Ajout;
         when 4 =>
            Etat.Menu := Menu_Principal;
         when others =>
            Etat.Menu := Quitter;
      end case;
   end Afficher_Menu_Registre;

   -- Affiche toutes les informations d'une personne.
   procedure Afficher_Personne (Cle : in Integer; Personne : in T_Personne) is
   begin
      Put ("<");
      Put (Cle, 0);
      Put (">");
      New_Line;
      Put (Personne.Nom_Usuel);
      New_Line;
      Put (" * Nom complet : ");
      Put (Personne.Nom_Complet);
      New_Line;
      Put (" * Sexe : ");
      Put (T_Genre'Image (Personne.Genre));
      New_Line;
      Put (" * Né le ");
      Put (Personne.Date_De_Naissance.Jour, 0);
      Put (" ");
      Put (T_Mois'Image (Personne.Date_De_Naissance.Mois));
      Put (" ");
      Put (Personne.Date_De_Naissance.Annee, 0);
      Put (" a ");
      Put (Personne.Lieu_De_Naissance);
      New_Line;
   end Afficher_Personne;

   -- Affiche le menu qui permet de choisir une personne a consulter dans le registre.
   procedure Afficher_Menu_Registre_Consultation_Selection
     (Etat : in out T_Etat)
   is
      Cle      : Integer;
      Personne : T_Personne;
      Correct  : Boolean;
   begin
      Put_Line ("* Consultation du registre *");
      New_Line;
      Correct := False;
      while not Correct loop
         Put_Line
         ("Entrez la clé de la personne que vous voulez consulter [0 pour retour].");
         Choisir_Cle (Cle);
         Correct := Cle = 0 or else Existe_Registre (Etat.Arbre, Cle);
         if not Correct then
            Put_Line ("Clé inconnue.");
            New_Line;
         end if;
      end loop;
      if Cle = 0 then
         Etat.Menu := Menu_Registre;
      else
         Personne := Acceder_Personne (Etat.Arbre, Cle);
         Afficher_Personne (Cle, Personne);
         New_Line;
         Etat.Cle  := Cle;
         Etat.Menu := Menu_Registre_Consultation_Personne;
      end if;
   end Afficher_Menu_Registre_Consultation_Selection;

   -- Affiche le menu des possibilités pour une personne du registre.
   procedure Afficher_Menu_Registre_Consultation_Personne
     (Etat : in out T_Etat)
   is
      Choix : Integer;
   begin
      Put_Line ("Menu : ");
      Put_Line ("1. Consulter son arbre généalogique");
      Put_Line ("2. Modifier les informations");
      Put_Line ("3. Retour");
      New_Line;
      Choisir (3, Choix);
      New_Line;
      case Choix is
         when 1 =>
            raise Todo_Exception;
         when 2 =>
            Etat.Menu := Menu_Registre_Modification;
         when 3 =>
            Etat.Menu := Menu_Registre;
         when others =>
            Etat.Menu := Quitter;
      end case;
   end Afficher_Menu_Registre_Consultation_Personne;

   -- Demande a l'utilisateur toutes les informations pour peupler `Personne`.
   procedure Saisir_Personne (Personne : out T_Personne) is
      Nom_Complet       : Sb.Bounded_String;
      Nom_Usuel         : Sb.Bounded_String;
      Genre             : T_Genre;
      Date_De_Naissance : T_Date;
      Lieu_De_Naissance : Sb.Bounded_String;

      Correct  : Boolean;
      Date_Lue : Integer;
      Genre_Lu : Character;
   begin
      Put ("Nom usuel : ");
      Nom_Usuel := Get_Line;
      Put ("Nom Complet : ");
      Nom_Complet := Get_Line;
      Put ("Sexe [F pour féminin, M pour masculin, A pour autre] : ");
      Get (Genre_Lu);
      Skip_Line;
      case Genre_Lu is
         when 'f' | 'F' =>
            Genre := Feminin;
         when 'm' | 'M' =>
            Genre := Masculin;
         when others =>
            Genre := Autre;
      end case;

      Correct := False; -- La date entrée est correcte ?
      while not Correct loop
         Put ("Date de naissance [au format JJMMAAAA] : ");
         begin
            Get (Date_Lue);
            Date_De_Naissance :=
              Creer_Date
                (Date_Lue / 1000000, (Date_Lue / 10000) mod 100,
                 Date_Lue mod 10000);
            Correct := True;
         exception
            when Ada.Io_Exceptions.Data_Error | Date_Incorrecte =>
               Correct := False;
         end;
         Skip_Line;
         if not Correct then
            Put_Line ("Date incorrecte.");
         end if;
      end loop;

      Put ("Lieu de naissance [au format Ville, Pays] : ");
      Lieu_De_Naissance := Get_Line;
      New_Line;

      Personne :=
        (Nom_Usuel, Nom_Complet, Genre, Date_De_Naissance, Lieu_De_Naissance);
   end Saisir_Personne;

   -- Affiche un menu pour ajouter une personne au registre.
   procedure Afficher_Menu_Registre_Ajout (Etat : in out T_Etat) is
      Cle      : Integer;
      Personne : T_Personne;

      Choix : Character;
   begin
      Put_Line ("* Ajouter une personne au registre *");
      New_Line;
      Put_Line
        ("Informations requises : nom usuel, nom complet, sexe, date et lieu de naissance.");
      New_Line;
      Saisir_Personne (Personne);

      Put ("Confirmer l'ajout [O pour oui, autre pour non] : ");
      Get (Choix);
      Skip_Line;

      if Choix = 'o' or Choix = 'O' then
         Generer_Cle (Etat.Arbre, Cle);
         Attribuer_Registre (Etat.Arbre, Cle, Personne);
         Put ("Personne ajoutée avec la clé : ");
         Put (Cle, 0);
      else
         Put ("Ajout annulé.");
      end if;
      New_Line;
      New_Line;

      Etat.Menu := Menu_Registre;

   end Afficher_Menu_Registre_Ajout;

   procedure Afficher_Menu_Registre_Modification (Etat : in out T_Etat) is
      Personne : T_Personne;
      Choix    : Character;
   begin
      Put_Line ("* Modification d'une personne du registre *");
      New_Line;
      Put_Line ("Informations actuelles : ");
      Personne := Acceder_Personne (Etat.Arbre, Etat.Cle);
      Afficher_Personne (Etat.Cle, Personne);
      New_Line;
      Saisir_Personne (Personne);
      New_Line;
      Put ("Confirmer la modification [O pour oui, autre pour non] : ");
      Get (Choix);
      Skip_Line;

      if Choix = 'o' or Choix = 'O' then
         Attribuer_Registre (Etat.Arbre, Etat.Cle, Personne);
         Put_Line ("Personne modifiée avec succès.");
      else
         Put_Line ("Modification annulée.");
      end if;
      New_Line;

      Etat.Menu := Menu_Registre;
   end Afficher_Menu_Registre_Modification;

   -- Affiche le menu correspondant a l'état du programme.
   procedure Afficher_Menu (Etat : in out T_Etat) is
   begin
      case Etat.Menu is
         when Menu_Principal =>
            Afficher_Menu_Principal (Etat);
         when Menu_Registre =>
            Afficher_Menu_Registre (Etat);
         when Menu_Registre_Consultation_Selection =>
            Afficher_Menu_Registre_Consultation_Selection (Etat);
         when Menu_Registre_Consultation_Personne =>
            Afficher_Menu_Registre_Consultation_Personne (Etat);
         when Menu_Registre_Ajout =>
            Afficher_Menu_Registre_Ajout (Etat);
         when Menu_Registre_Modification =>
            Afficher_Menu_Registre_Modification (Etat);
         when others =>
            Etat.Menu := Quitter;
      end case;
   end Afficher_Menu;

   Etat : T_Etat;

begin

   Initialiser (Etat.Arbre);
   Etat.Menu := Menu_Principal;

   while Etat.Menu /= Quitter loop
      Afficher_Menu (Etat);
   end loop;

end Main;
