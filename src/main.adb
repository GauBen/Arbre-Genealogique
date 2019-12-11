with Ada.Text_Io;         use Ada.Text_Io;
with Ada.Integer_Text_Io; use Ada.Integer_Text_Io;
with Ada.Io_Exceptions;
with Ada.Text_Io.Bounded_Io;
with Arbre_Genealogique;  use Arbre_Genealogique;
with Date;                use Date;

procedure Main is

   package Ada_Strings_Io is new Ada.Text_Io.Bounded_Io (Sb);
   use Ada_Strings_Io;

   type T_Menu is
     (Menu_Principal, Menu_Registre, Menu_Registre_Consultation_Selection,
      Menu_Registre_Consultation_Personne,
      Menu_Registre_Consultation_Recherche, Menu_Registre_Ajout,
      Menu_Registre_Modification, Menu_Arbre_Selection,
      Menu_Arbre_Consultation, Menu_Arbre_Ajouter_Relation,
      Menu_Arbre_Supprimer_Relation, Menu_Arbre_Parente, Quitter);

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
            Etat.Menu := Menu_Arbre_Selection;
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
            Etat.Menu := Menu_Registre_Consultation_Recherche;
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

   procedure Afficher_Nom_Usuel (Etat : in T_Etat; Cle : in Integer) is
      Personne : T_Personne;
   begin
      Personne := Lire_Registre (Etat.Arbre, Cle);
      Put (Personne.Nom_Usuel);
      Put (" <");
      Put (Cle, 0);
      Put (">");
   end Afficher_Nom_Usuel;

   -- Affiche le menu qui permet de choisir une personne a consulter dans le registre.
   procedure Afficher_Menu_Registre_Consultation_Selection
     (Etat : in out T_Etat)
   is
      Cle     : Integer;
      Correct : Boolean;
   begin
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
      New_Line;
      if Cle = 0 then
         Etat.Menu := Menu_Registre;
      else
         Etat.Cle  := Cle;
         Etat.Menu := Menu_Registre_Consultation_Personne;
      end if;
   end Afficher_Menu_Registre_Consultation_Selection;

   -- Affiche les résultats de la recherche.
   procedure Afficher_Resultats (Etat : in out T_Etat; Recherche : in String)
   is
      Nombre_Resultats : Integer := 0;

      procedure Tester_Personne (Cle : in Integer; Personne : in T_Personne) is
      begin
         if Sb.Index (Personne.Nom_Usuel, Recherche) > 0
           or else Sb.Index (Personne.Nom_Complet, Recherche) > 0
         then
            Nombre_Resultats := Nombre_Resultats + 1;
            Put (" * ");
            Put (Personne.Nom_Usuel);
            Put (" <");
            Put (Cle, 0);
            Put (">");
            New_Line;
         end if;
      end Tester_Personne;
      procedure Rechercher is new Appliquer_Sur_Registre (Tester_Personne);
   begin
      Put_Line ("Résultats de la recherche :");
      Rechercher (Etat.Arbre);
      if Nombre_Resultats = 0 then
         Put_Line ("Aucun résultat.");
         Etat.Menu := Menu_Registre;
      else
         Etat.Menu := Menu_Registre_Consultation_Selection;
      end if;
      New_Line;
   end Afficher_Resultats;

   -- Affiche le menu qui permet de rechercher dans le registre.
   procedure Afficher_Menu_Registre_Consultation_Recherche
     (Etat : in out T_Etat)
   is
      Recherche : Sb.Bounded_String;
   begin
      Put_Line ("* Recherche dans le registre *");
      New_Line;
      Put ("Nom a rechercher : ");
      Recherche := Get_Line;
      New_Line;
      Afficher_Resultats (Etat, Sb.To_String (Recherche));
   end Afficher_Menu_Registre_Consultation_Recherche;

   -- Affiche le menu des possibilités pour une personne du registre.
   procedure Afficher_Menu_Registre_Consultation_Personne
     (Etat : in out T_Etat)
   is
      Personne : T_Personne;
      Choix    : Integer;
   begin
      Personne := Lire_Registre (Etat.Arbre, Etat.Cle);
      Afficher_Personne (Etat.Cle, Personne);
      New_Line;
      Put_Line ("Menu : ");
      Put_Line ("1. Consulter son arbre généalogique");
      Put_Line ("2. Modifier les informations");
      Put_Line ("3. Retour");
      New_Line;
      Choisir (3, Choix);
      New_Line;
      case Choix is
         when 1 =>
            Etat.Menu := Menu_Arbre_Consultation;
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
         Ajouter_Personne (Etat.Arbre, Personne, Cle);
         Put ("Personne ajoutée avec la clé : ");
         Put (Cle, 0);
      else
         Put ("Ajout annulé.");
      end if;
      New_Line;
      New_Line;

      Etat.Menu := Menu_Registre;

   end Afficher_Menu_Registre_Ajout;

   -- Permet de modifier une personne enregistrée.
   procedure Afficher_Menu_Registre_Modification (Etat : in out T_Etat) is
      Personne : T_Personne;
      Choix    : Character;
   begin
      Put_Line ("* Modification d'une personne du registre *");
      New_Line;
      Put_Line ("Informations actuelles : ");
      Personne := Lire_Registre (Etat.Arbre, Etat.Cle);
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

   -- Demande une clé pour afficher les relations d'une personne.
   procedure Afficher_Menu_Arbre_Selection (Etat : in out T_Etat) is
      Cle     : Integer;
      Correct : Boolean;
   begin
      Put_Line ("* Arbre généalogique *");
      New_Line;
      Correct := False;
      while not Correct loop
         Put_Line
           ("Entrez la clé de la personne dont vous voulez consulter l'arbre [0 pour retour].");
         Choisir_Cle (Cle);
         Correct := Cle = 0 or else Existe_Registre (Etat.Arbre, Cle);
         if not Correct then
            Put_Line ("Clé inconnue.");
            New_Line;
         end if;
      end loop;
      New_Line;
      if Cle = 0 then
         Etat.Menu := Menu_Principal;
      else
         Etat.Cle  := Cle;
         Etat.Menu := Menu_Arbre_Consultation;
      end if;
   end Afficher_Menu_Arbre_Selection;

   -- Affiche les relations d'une personne.
   procedure Afficher_Menu_Arbre_Consultation (Etat : in out T_Etat) is

      -- Groupe toutes les relations de même étiquette ensemble.
      procedure Afficher_Relations_Groupees
        (Etat : in T_Etat; Etiquette : in T_Etiquette_Arete; Titre : in String)
      is
         Liste         : T_Liste_Relations;
         Relation      : T_Arete_Etiquetee;
         Titre_Affiche : Boolean := False;
      begin
         Liste_Relations (Liste, Etat.Arbre, Etat.Cle);
         while Liste_Non_Vide (Liste) loop
            Relation_Suivante (Liste, Relation);
            if Relation.Etiquette = Etiquette then
               if not Titre_Affiche then
                  Put_Line (Titre);
                  Titre_Affiche := True;
               end if;
               Put (" * ");
               Afficher_Nom_Usuel (Etat, Relation.Destination);
               New_Line;
            end if;
         end loop;
      end Afficher_Relations_Groupees;

      Liste : T_Liste_Relations;
      Choix : Integer;
   begin
      Afficher_Nom_Usuel (Etat, Etat.Cle);
      New_Line;
      New_Line;
      Liste_Relations (Liste, Etat.Arbre, Etat.Cle);
      if not Liste_Non_Vide (Liste) then
         Put_Line ("Aucune relation.");
      else
         Afficher_Relations_Groupees (Etat, A_Pour_Parent, "Parent(s) :");
         Afficher_Relations_Groupees (Etat, A_Pour_Enfant, "Enfant(s) :");
         Afficher_Relations_Groupees (Etat, A_Pour_Conjoint, "Conjoint(e) :");
      end if;
      New_Line;
      Put_Line ("Menu :");
      Put_Line ("1. Consulter dans le registre");
      Put_Line ("2. Consulter une autre personne");
      Put_Line ("3. Ajouter une relation");
      Put_Line ("4. Supprimer une relation");
      Put_Line ("5. Afficher un arbre de parenté");
      Put_Line ("6. Retour");
      New_Line;
      Choisir (6, Choix);
      New_Line;
      case Choix is
         when 1 =>
            Etat.Menu := Menu_Registre_Consultation_Personne;
         when 2 =>
            Etat.Menu := Menu_Arbre_Selection;
         when 3 =>
            Etat.Menu := Menu_Arbre_Ajouter_Relation;
         when 4 =>
            Etat.Menu := Menu_Arbre_Supprimer_Relation;
         when 5 =>
            Etat.Menu := Menu_Arbre_Parente;
         when 6 =>
            Etat.Menu := Menu_Principal;
         when others =>
            Etat.Menu := Quitter;
      end case;
   end Afficher_Menu_Arbre_Consultation;

   -- Permet d'ajouter une relation.
   procedure Afficher_Menu_Arbre_Ajouter_Relation (Etat : in out T_Etat) is
      Dates_Incompatibles : exception;

      Personne_Origine     : T_Personne;
      Personne_Destination : T_Personne;

      Cle_Destination : Integer;
      Relation_Lue    : Integer;
      Correct         : Boolean;
   begin
      Put_Line ("Ajouter une relation :");
      Put_Line ("1. Ajouter un parent");
      Put_Line ("2. Ajouter un enfant");
      Put_Line ("3. Ajouter un conjoint");
      New_Line;
      Choisir (3, Relation_Lue);
      New_Line;

      Correct := False;
      while not Correct loop
         Put_Line ("Entrez la clé de la personne a lier [0 pour retour].");
         Choisir_Cle (Cle_Destination);
         Correct :=
           Cle_Destination = 0
           or else Existe_Registre (Etat.Arbre, Cle_Destination);
         if not Correct then
            Put_Line ("Clé inconnue.");
            New_Line;
         end if;
      end loop;

      if Cle_Destination = 0 then
         Put_Line ("Ajout annulé.");
      else
         Personne_Origine     := Lire_Registre (Etat.Arbre, Etat.Cle);
         Personne_Destination := Lire_Registre (Etat.Arbre, Cle_Destination);
         begin
            case Relation_Lue is
               when 1 =>
                  if D1_Inf_D2
                      (Personne_Origine.Date_De_Naissance,
                       Personne_Destination.Date_De_Naissance)
                  then
                     raise Dates_Incompatibles;
                  end if;
                  Ajouter_Relation
                    (Etat.Arbre, Etat.Cle, A_Pour_Parent, Cle_Destination);
               when 2 =>
                  if D1_Inf_D2
                      (Personne_Destination.Date_De_Naissance,
                       Personne_Origine.Date_De_Naissance)
                  then
                     raise Dates_Incompatibles;
                  end if;
                  Ajouter_Relation
                    (Etat.Arbre, Etat.Cle, A_Pour_Enfant, Cle_Destination);
               when 3 =>
                  Ajouter_Relation
                    (Etat.Arbre, Etat.Cle, A_Pour_Conjoint, Cle_Destination);
               when others =>
                  null;
            end case;
            Put_Line ("Relation ajoutée.");
         exception
            when Dates_Incompatibles =>
               Put_Line ("Un parent doit etre plus agé que son enfant.");
            when Relation_Existante =>
               Put_Line
                 ("Une relation entre ces deux personnes existe déja.");
         end;
      end if;
      New_Line;
      Etat.Menu := Menu_Arbre_Consultation;
   end Afficher_Menu_Arbre_Ajouter_Relation;

   -- Supprime les relations avec une personne.
   procedure Afficher_Menu_Arbre_Supprimer_Relation (Etat : in out T_Etat) is
      Cle_Destination : Integer;
      Correct         : Boolean;
   begin
      Correct := False;
      while not Correct loop
         Put_Line ("Entrez la clé de la personne a delier [0 pour retour].");
         Choisir_Cle (Cle_Destination);
         Correct :=
           Cle_Destination = 0
           or else Existe_Registre (Etat.Arbre, Cle_Destination);
         if not Correct then
            Put_Line ("Clé inconnue.");
            New_Line;
         end if;
      end loop;

      if Cle_Destination = 0 then
         Put_Line ("Suppression annulée.");
         Etat.Menu := Menu_Arbre_Consultation;
      else
         Supprimer_Relation
           (Etat.Arbre, Etat.Cle, A_Pour_Parent, Cle_Destination);
         Supprimer_Relation
           (Etat.Arbre, Etat.Cle, A_Pour_Enfant, Cle_Destination);
         Supprimer_Relation
           (Etat.Arbre, Etat.Cle, A_Pour_Conjoint, Cle_Destination);
         Put_Line ("Suppression effectuée.");
      end if;
      New_Line;
      Etat.Menu := Menu_Arbre_Consultation;
   end Afficher_Menu_Arbre_Supprimer_Relation;

   procedure Afficher_Menu_Arbre_Parente (Etat : in out T_Etat) is

      procedure Afficher_Bandeau (Nombre_Generations : in Integer) is
      begin
         for I in 0 .. Nombre_Generations loop
            Put (I, 2);
            Put ("  ");
         end loop;
         Put_Line (" génération");
         for I in 1 .. (Nombre_Generations * 4 + 15) loop
            Put ("=");
         end loop;
         New_Line;
      end Afficher_Bandeau;

      procedure Afficher_Parente
        (Etat : in T_Etat; Cle : in Integer; Etiquette : in T_Etiquette_Arete;
         Nombre_Generations : in Integer; Indentation : in String)
      is
         Liste    : T_Liste_Relations;
         Relation : T_Arete_Etiquetee;
      begin
         Put (Indentation);
         Put ("-- ");
         Afficher_Nom_Usuel (Etat, Cle);
         New_Line;
         if Nombre_Generations <= 0 then
            return;
         end if;
         Liste_Relations (Liste, Etat.Arbre, Cle);
         while Liste_Non_Vide (Liste) loop
            Relation_Suivante (Liste, Relation);
            if Relation.Etiquette = Etiquette then
               Afficher_Parente
                 (Etat, Relation.Destination, Etiquette,
                  Nombre_Generations - 1, Indentation & "    ");
            end if;
         end loop;
      end Afficher_Parente;

      Nombre_Generations : Integer;
      Correct            : Boolean;
   begin
      Correct := False;
      while not Correct loop
         begin
            Put_Line
              ("Nombre de générations a afficher [> 0 pour les parents,");
            Put ("< 0 pour les enfants, 0 pour retour] : ");
            Get (Nombre_Generations);
            Correct := True;
         exception
            when Ada.Io_Exceptions.Data_Error =>
               Correct := False;
         end;
         Skip_Line;
      end loop;
      New_Line;
      if Nombre_Generations > 0 then
         Afficher_Bandeau (Nombre_Generations);
         Afficher_Parente
           (Etat, Etat.Cle, A_Pour_Parent, Nombre_Generations, "");
         New_Line;
      elsif Nombre_Generations < 0 then
         Afficher_Bandeau (-Nombre_Generations);
         Afficher_Parente
           (Etat, Etat.Cle, A_Pour_Enfant, -Nombre_Generations, "");
         New_Line;
      end if;
      Etat.Menu := Menu_Arbre_Consultation;
   end Afficher_Menu_Arbre_Parente;

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
         when Menu_Registre_Consultation_Recherche =>
            Afficher_Menu_Registre_Consultation_Recherche (Etat);
         when Menu_Registre_Ajout =>
            Afficher_Menu_Registre_Ajout (Etat);
         when Menu_Registre_Modification =>
            Afficher_Menu_Registre_Modification (Etat);
         when Menu_Arbre_Selection =>
            Afficher_Menu_Arbre_Selection (Etat);
         when Menu_Arbre_Consultation =>
            Afficher_Menu_Arbre_Consultation (Etat);
         when Menu_Arbre_Ajouter_Relation =>
            Afficher_Menu_Arbre_Ajouter_Relation (Etat);
         when Menu_Arbre_Supprimer_Relation =>
            Afficher_Menu_Arbre_Supprimer_Relation (Etat);
         when Menu_Arbre_Parente =>
            Afficher_Menu_Arbre_Parente (Etat);
         when others =>
            Etat.Menu := Quitter;
      end case;
   end Afficher_Menu;

   Etat : T_Etat;

   Cle : Integer;

begin

   Initialiser (Etat.Arbre);
   Etat.Menu := Menu_Principal;

   Ajouter_Personne
     (Etat.Arbre,
      (Sb.To_Bounded_String ("Jean Bon"),
       Sb.To_Bounded_String ("Jean, Eude Bon"), Masculin,
       Creer_Date (31, 1, 1960), Sb.To_Bounded_String ("Paris, France")),
      Cle);

   Ajouter_Personne
     (Etat.Arbre,
      (Sb.To_Bounded_String ("Kevin Bon"),
       Sb.To_Bounded_String ("Kevin, Junior Bon"), Masculin,
       Creer_Date (1, 4, 1999), Sb.To_Bounded_String ("Toulouse, France")),
      Cle);

   while Etat.Menu /= Quitter loop
      Afficher_Menu (Etat);
   end loop;

end Main;
