with Graphe;
with Ada.Text_Io;         use Ada.Text_Io;
with Ada.Integer_Text_Io; use Ada.Integer_Text_Io;

procedure Scenario_Graphe is

   subtype T_Etiquette_Sommet is Integer;
   type T_Etiquette_Arete is
     (A_Pour_Parent, A_Pour_Enfant, A_Pour_Frere, A_Pour_Conjoint);

   package Graphe_Genealogique is new Graphe (T_Etiquette_Sommet, T_Etiquette_Arete);
   use Graphe_Genealogique;

   Graphe1   : T_Graphe;
   Adjacence : T_Liste_Adjacence;
   Arete     : T_Arete_Etiquetee;
   Sommet    : T_Etiquette_Sommet;

begin

   Initialiser (Graphe1);

   Ajouter_Sommet (Graphe1, 42);
   Ajouter_Sommet (Graphe1, 1337);
   Ajouter_Arete (Graphe1, 42, A_Pour_Parent, 1337);
   Ajouter_Arete (Graphe1, 1337, A_Pour_Enfant, 42);

   Ajouter_Sommet (Graphe1, 1);
   Ajouter_Sommet (Graphe1, 2);
   Ajouter_Sommet (Graphe1, 3);
   Ajouter_Arete (Graphe1, 42, A_Pour_Parent, 1);
   Ajouter_Arete (Graphe1, 1, A_Pour_Enfant, 42);
   Ajouter_Arete (Graphe1, 42, A_Pour_Frere, 2);
   Ajouter_Arete (Graphe1, 2, A_Pour_Frere, 42);
   Ajouter_Arete (Graphe1, 42, A_Pour_Conjoint, 3);
   Ajouter_Arete (Graphe1, 3, A_Pour_Conjoint, 42);

   Sommet := 42;
   --Get (Sommet);
   --Skip_Line;
   Chaine_Adjacence (Adjacence, Graphe1, Sommet);

   while Adjacence_Non_Vide (Adjacence) loop
      Arete_Suivante (Adjacence, Arete);
      Put (Sommet, 0);
      Put (" " & T_Etiquette_Arete'image(Arete.Etiquette) & " ");
      Put (Arete.Destination, 0);
      New_Line;
   end loop;

   Supprimer_Arete(Graphe1,42,A_Pour_Frere,2);
   New_Line;
   Sommet := 42;
   Chaine_Adjacence(Adjacence,Graphe1,Sommet);
   while Adjacence_Non_Vide (Adjacence) loop
	   Arete_Suivante(Adjacence,Arete);
	   Put(Sommet,0);
	   Put(" " & T_Etiquette_Arete'image(Arete.Etiquette) & " ");
	   Put(Arete.Destination,0);
	   New_Line;
   end loop;

   Detruire (Graphe1);

end Scenario_Graphe;
