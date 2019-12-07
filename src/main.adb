with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.IO_Exceptions;
with Ada.Text_IO.Bounded_IO;
with Arbre_Genealogique;  use Arbre_Genealogique;
with Date; use Date;
procedure Main is

   package Ada_Strings_IO is new Ada.Text_IO.Bounded_IO (Sb);
   use Ada_Strings_IO;

   Todo_Exception : exception;

   type T_Menu is
     (Menu_Principal, Menu_Registre, Menu_Registre_Consultation,
      Menu_Registre_Ajout, Menu_Registre_Modification, Quitter);

   type T_Etat is record
      Cle  : Integer;
      Menu : T_Menu;
   end record;

   Arbre : T_Arbre_Genealogique;

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
            when Ada.IO_Exceptions.Data_Error =>
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
            when Ada.IO_Exceptions.Data_Error =>
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
            Etat.Menu := Menu_Registre_Ajout;
         when 4 =>
            Etat.Menu := Menu_Principal;
         when others =>
            Etat.Menu := Quitter;
      end case;
      New_Line;
   end Afficher_Menu_Registre;

   procedure Afficher_Menu_Registre_Consultation (Etat : in out T_Etat) is
      Cle      : Integer;
      Personne : T_Personne;
      Choix    : Integer;
   begin
      Put_Line ("* Consultation du registre *");
      New_Line;
      Put_Line ("Entrez la clé de la personne que vous voulez consulter [0 pour retour].");
      Choisir_Cle (Cle);
      if Cle = 0 then
         Etat.Menu := Menu_Registre;
         return;
      elsif not Existe_Registre (Arbre, Cle) then
         Put_Line ("Clé inconnue");

      else
         Personne := Acceder_Personne (Arbre, Cle);
         Put_Line ("<" & Integer'Image (Cle) & ">");
         Put_Line (Sb.To_String (Personne.Nom_Usuel));
         Put (" * Nom complet : ");
         Put_Line (Sb.To_String (Personne.Nom_Complet));
         Put (" * Sexe : ");
         Put_Line(T_Genre'Image(Personne.Genre));
         Put_Line(" * Né le" & Integer'Image(Personne.Date_de_naissance.Jour) & " " & T_Mois'Image(Personne.Date_de_naissance.Mois) & Integer'Image(Personne.Date_de_naissance.Annee) & " à " & Sb.To_String (Personne.Lieu_de_naissance) );
         Put_Line ("Menu : ");
         Put_Line ("1. Consulter son arbre généalogique");
         Put_Line ("2. Modifier les informations");
         Put_Line ("3. Retour");
         Put ("Votre Choix [1, 2 ou 3] : ");
         Choisir (3,Choix);
         case Choix is
            when 1 =>
               raise Todo_Exception;
            when 2 =>
               Etat.Cle := Cle;
               Etat.Menu := Menu_Registre_Modification;
            when 3 =>
               Etat.Menu := Menu_Registre;
            when others =>
               null;
         end case;
      end if;
   end Afficher_Menu_Registre_Consultation;

   function Determiner_Jour(Datelue : in Integer) return Integer is
   begin
      return Datelue/1000000;
   end Determiner_Jour;

   function Determiner_Mois(Datelue : Integer) return T_Mois is
      Moislu : Integer;
   begin
      Moislu := Datelue/10000 mod 100;
      case Moislu is
         when 1 =>
            return JANVIER;
         when 2 =>
            return FEVRIER;
         when 3 =>
            return MARS;
         when 4 =>
            return AVRIL;
         when 5 =>
            return MAI;
         when 6 =>
            return JUIN;
         when 7 =>
            return JUILLET;
         when 8 =>
            return AOUT;
         when 9 =>
            return SEPTEMBRE;
         when 10 =>
            return OCTOBRE;
         when 11 =>
            return NOVEMBRE;
         when 12 =>
            return DECEMBRE;
         when others =>
            null;
      end case;
   end Determiner_Mois;

   function Determiner_Annee(Datelue : Integer) return Integer is
   begin
      return Datelue mod 10000;
   end Determiner_Annee;

   procedure Afficher_Menu_Registre_Ajout (Etat : in out T_Etat) is
      Nom_Complet : Sb.Bounded_String;
      Nom_Usuel   : Sb.Bounded_String;
      Date_de_naissance : T_Date;
      Datelue     : Integer;
      Lieu_de_naissance : Sb.Bounded_String;
      Genrelue    : Character;
      Genre       : T_Genre;
      Personne    : T_Personne;
      Choix       : Character;
      Cle         : Integer;
   begin
      Put_Line ("* Ajouter une personne au registre*");
      New_Line;
      Put_Line
        ("Informations requises : nom usuel, nom complet, sexe, date et lieu de naissance.");
      New_Line;
      Put ("Nom usuel : ");
      Nom_Usuel := Get_Line;
      Put ("Nom Complet : ");
      Nom_Complet := Get_Line;
      Put ("Sexe [F pour féminin, M pour masculin, A pour autre] : ");
      Get(Genrelue);
      case Genrelue is
         when 'F' =>
            Genre := Feminin;
         when 'M' =>
            Genre := Masculin;
         when others =>
            Genre := Autre;
      end case;
      Put("Date de naissance [au format JJMMAAAA] : ");
      Get(Datelue);
      Date_de_naissance := (Determiner_Jour(Datelue),Determiner_Mois(Datelue),Determiner_Annee(Datelue));
      Put("Lieu de naissance [au format Ville, Pays] : ");
      Skip_Line;
      Lieu_de_naissance := Get_Line;
      New_Line;
      Put ("Confirmer l'ajout [O pour oui, N pour non] : ");
      Get (Choix);
      --while Choix/='o' or Choix/= 'O' or Choix /= 'n' or Choix /= 'N' loop
      -- Put_Line("Choix incorrect");
      --Put("Confirmer l'ajout [O pour oui, N pour non] : ");
      --Get(Choix);
      --end loop;
      Personne := (Nom_Usuel, Nom_Complet,Genre,Date_de_naissance,Lieu_de_naissance);
      if Choix = 'o' or Choix = 'O' then
         Generer_Cle (Arbre, Cle);
         Attribuer_Registre (Arbre, Cle, Personne);
         Put ("Personne ajoutée avec la clé : ");
         Put_Line (Integer'Image (Cle));
      end if;
      Etat.Menu := Menu_Registre;
   end Afficher_Menu_Registre_Ajout;

   procedure Afficher_Menu_Registre_Modification(Etat : in out T_Etat) is
   Personne : T_Personne;
   Personne_Mod : T_Personne;
   Nom_Complet : Sb.Bounded_String;
   Nom_Usuel   : Sb.Bounded_String;
   Date_de_naissance : T_Date;
   Datelue     : Integer;
   Lieu_de_naissance : Sb.Bounded_String;
   Genrelue    : Character;
   Genre       : T_Genre;
   Choix       : Character;
   begin
      Put_Line("* Modification d'une personne du registre *");
      New_Line;
      Put_Line("Informations actuelles : ");
      Personne := Acceder_Personne (Arbre, Etat.Cle);
      Put_Line ("<" & Integer'Image (Etat.Cle) & ">");
      Put_Line (Sb.To_String (Personne.Nom_Usuel));
      Put (" * Nom complet : ");
      Put_Line (Sb.To_String (Personne.Nom_Complet));
      Put (" * Sexe : ");
      Put_Line(T_Genre'Image(Personne.Genre));
      Put_Line(" * Né le" & Integer'Image(Personne.Date_de_naissance.Jour) & " " & T_Mois'Image(Personne.Date_de_naissance.Mois) & Integer'Image(Personne.Date_de_naissance.Annee) & " à " & Sb.To_String (Personne.Lieu_de_naissance) );
      New_Line;
      Put ("Nom usuel : ");
      Nom_Usuel := Get_Line;
      Put ("Nom Complet : ");
      Nom_Complet := Get_Line;
      Put ("Sexe [F pour féminin, M pour masculin, A pour autre] : ");
      Get(Genrelue);
      case Genrelue is
         when 'F' =>
            Genre := Feminin;
         when 'M' =>
            Genre := Masculin;
         when others =>
            Genre := Autre;
      end case;
      Put("Date de naissance [au format JJMMAAAA] : ");
      Get(Datelue);
      Date_de_naissance := (Determiner_Jour(Datelue),Determiner_Mois(Datelue),Determiner_Annee(Datelue));
      Put("Lieu de naissance [au format Ville, Pays] : ");
      Skip_Line;
      Lieu_de_naissance := Get_Line;
      New_Line;
      Put ("Confirmer l'ajout [O pour oui, N pour non] : ");
      Get (Choix);
      --while Choix/='o' or Choix/= 'O' or Choix /= 'n' or Choix /= 'N' loop
      -- Put_Line("Choix incorrect");
      --Put("Confirmer l'ajout [O pour oui, N pour non] : ");
      --Get(Choix);
      --end loop;
      Personne_Mod := (Nom_Usuel, Nom_Complet,Genre,Date_de_naissance,Lieu_de_naissance);
      Attribuer_Registre (Arbre, Etat.Cle, Personne_Mod);
      Put_Line("Personne modifiée avec succès");
      New_Line;
      Etat.Cle := 0;
      Etat.Menu := Menu_Registre;
   end Afficher_Menu_Registre_Modification;
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
         when Menu_Registre_Modification =>
            Afficher_Menu_Registre_Modification (Etat);
         when others =>
            Etat.Menu := Quitter;
      end case;
   end Afficher_Menu;

   Etat : T_Etat := (Cle => 0, Menu => Menu_Principal);

begin
   Initialiser (Arbre);
   while Etat.Menu /= Quitter loop
      Afficher_Menu (Etat);
   end loop;

end Main;
