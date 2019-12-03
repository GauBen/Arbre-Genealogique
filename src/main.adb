with Ada.Text_Io;         use Ada.Text_Io;
with Ada.Integer_Text_Io; use Ada.Integer_Text_Io;
with Ada.Io_Exceptions;
with Date;	          use Date;
with Arbre_Genealogique;  use Arbre_Genealogique;
procedure Main is

   Todo_Exception : exception;

   type T_Menu is
     (Menu_Principal, Menu_Registre, Menu_Registre_Consultation, Menu_Registre_Ajout, Quitter);

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
            Etat.Menu := Menu_Registre_Ajout;
         when 4 =>
            Etat.Menu := Menu_Principal;
         when others =>
            Etat.Menu := Quitter;
      end case;
      New_Line;
   end Afficher_Menu_Registre;

   procedure Afficher_Menu_Registre_Consultation (Etat : in out T_Etat; Registre : in T_Registre) is
      Cle : Integer;
      Personne : T_Personne;
      Choix : Integer;
   begin
      Put_Line ("* Consultation du registre *");
      New_Line;
      Put_Line ("Entrez la clé de la personne que vous voulez consulter.");
      Choisir_Cle (Cle);
      if Cle = 0 then
         Etat.Menu := Menu_Registre;
         return;
      end if;
      Personne := Acceder_Personne(Arbre.Registre,Cle);
      Put_Line(Cle);
      Put_Line(Personne.Nom_Usuel);
      Put_Line("* Nom complet : " & Personne.Nom_Complet);
      Put_Line("* Né le " & Integer'Image(Personne.Date_de_naissance.Jour) & "/" & T_Mois'Image(Personne.Date_de_naissance.Mois) & "/" & Integer'image(Personne.Date_de_naissance.annee) & " à " & Personne.Lieu_de_naissance.Ville & ", " & Personne.Lieu_de_naissance.Pays );
      Put_Line("* " &  T_Genre'Image(Personne.Genre));
      if Personne.Vivant then
	      Put_Line("Vivant");
      else
	      Put_Line("Mort");
      end if;
      New_Line;
      Put_Line("Menu : ");
      Put_Line("1. Consulter son arbre généalogique");
      Put_Line("2. Modifier les informations");
      Put_Line("3. Retour");
      Choisir(3,Choix);
      case Choix is 
	      when 1  => raise Todo_Exception;
	      when 2  => raise Todo_Exception;
	      when 3  => Etat.Menu := Menu_Registre_Consultation ;
	      when others => Etat.Menu := Quitter;
      end case;
      New_Line;
   end Afficher_Menu_Registre_Consultation;

   procedure Determiner_Jour (Date_Lue : in Sb.Bounded_String; Jour : out Integer) is
   begin
	  Jour := Date_Lue/100000;
	  Jour:=Jour mod 100;
   end Determiner_Jour;

  procedure Determiner_Mois(Date_Lue : in Integer; Mois : out T_Mois) is
	  Mois1 : Integer;
  begin 
	Mois1:= Date_Lue/1000;
	Mois1:=Mois1 mod 100;
	case Mois1 is
		when 1 => Mois := JANVIER;
		when 2 => Mois := FEVRIER;
		when 3 => Mois := MARS;
		when 4 => Mois := AVRIL;
		when 5 => Mois := MAI;
		when 6 => Mois := JUIN;
		when 7 => Mois := JUILLET;
		when 8 => Mois := AOUT;
		when 9 => Mois := SEPTEMBRE;
		when 10 => Mois:= OCTOBRE;
		when 11 => Mois := NOVEMBRE;
		when 12 => Mois := DECEMBRE;
	end case;
  end Determiner_Mois;

  procedure Determiner_Annee(Date_Lue : in Integer;Annee : out Integer) is 
  begin
	  Annee := Date_Lue mod 10000
  end Determiner_Annee;

   procedure Afficher_Menu_Registre_Ajout (Etat : in out T_Etat; Registre : in out T_Registre) is 
	   Personne          : T_Personne;
	   Nom_Usuel   	     : Sb.Bounded_String;
	   Nom_Complet	     : Sb.Bounded_String;
	   Genre      	     : T_Genre;
	   Date_de_naissance : T_Date;
	   Date_Lue	     : Integer;
	   Jour 	     : Integer;
	   Mois		     : T_Mois;
	   Annee	     : Integer;
	   Lieu_de_naissance : T_Lieu;
	   Ville	     : Sb.Bounded_String;
	   Pays		     : Sb.Bounded_String;
	   Vivant_Lu	     : Character;
	   Vivant	     : Boolean;
	   Valide 	     : Boolean;
	   Choix 	     : Character;
	   Valide2	     : Boolean;
   begin 
	Put_Line("* Ajout d'une personne au registre*");
	Put_Line("Entrez le nom usuel de la personne");
	Get(Nom_Usuel);
	Put_Line("Entrez le nom complet de la personne");
	Get(Nom_Complet);
	Put_Line("Entrez le genre de la personne (Homme/Femme/Autre)");
	Get(Genre);
	Put_Line("Entrez la date de naissance de la personne (JJMMAAAA)");
	Get(Date_Lue);
	Determiner_Jour(Date_Lue,Jour);
	Determiner_Mois(Date_Lue,Mois);
	Determiner_Annee(Date_Lue,Annee);
	Date_De_naissance := (Jour,Mois,Annee);
	Put_Line("Entrez le lieu de naissance de la personne");
	Put("Ville : ");
	Get(Ville);
	New_Line;
	Put("Pays : ");
	Get(Pays);
	Lieu_de_naissance := (Ville,Pays);
	Put_Line("Est ce que la personne est vivante [O pour oui,N pour non) ?");
	loop
	   Get(Vivant_Lu);
	   case Vivant_Lu is 
	    	when 'o' | 'O' => Vivant := True;
		when 'n' | 'N' => Vivant := False;
		when others => Valide:= False;
	   end case;
	exit when Valide; 
	end loop;
	Put_Line("Confirmer l'ajout [O pour oui, N pour non] : ");
	Get(Choix);
	loop
		case Choix is 
			when 'O' | 'o' => Personne := (Nom_Usuel,Nom_Complet,Genre,Date_de_naissance,Lieu_de_naissance,Vivant);
		                       	Attribuer(Arbre.Registre,Arbre.Auto_Increment,Personne);
					Put_Line("Personne ajoutée avec la clé : " & Integer'Image(Arbre.Auto_Increment);
					Arbre.Auto_increment := Arbre.Auto_Increment+1;
					Valide2 := true;
			when 'n' | 'N' => Valide2 := true;
			when others => Put_Line("Choix incorrect");
				       Valide2:=False;
		end case;
		exit when Valide2;
	end loop;
	Etat.Menu := Menu_Registre;
   end Afficher_Menu_Registre_Ajout;

   procedure Afficher_Menu (Etat : in out T_Etat) is
   begin
      case Etat.Menu is
         when Menu_Principal =>
            Afficher_Menu_Principal (Etat);
         when Menu_Registre =>
            Afficher_Menu_Registre (Etat);
         when Menu_Registre_Consultation =>
            Afficher_Menu_Registre_Consultation (Etat,Arbre.Registre);
	 when Menu_Registre_Ajout => 
	    Afficher_Menu_Registre_Ajout (Etat,Arbre.Registre);
         when others =>
            Etat.Menu := Quitter;
      end case;
   end Afficher_Menu;

   Etat : T_Etat := (Cle => 0, Menu => Menu_Principal);

begin
   Initialiser(Arbre);
   while Etat.Menu /= Quitter loop
      Afficher_Menu (Etat);
   end loop;

end Main;
