with Arbre_Genealogique;  use Arbre_Genealogique;
with Ada.Text_Io;         use Ada.Text_Io;
with Ada.Integer_Text_Io; use Ada.Integer_Text_Io;

procedure Test_Arbre_Genealogique is

   Arbre     : T_Arbre_Genealogique;
   Personne  : T_Personne;
   Personne2 : T_Personne;
   Cle       : Integer;
   Cle2      : Integer;
   Liste     : T_Liste_Relations;
   Arete     : T_Arete_Etiquetee;

begin

   Initialiser (Arbre);

   Personne :=
     (Sb.To_Bounded_String ("Jean Bon"),
      Sb.To_Bounded_String ("Jean Bon Blanc"));

   Personne2 :=
     (Sb.To_Bounded_String ("Kevin Bon"),
      Sb.To_Bounded_String ("Kevin Bon Chocolat"));

   Ajouter_Personne (Arbre, Personne, Cle);
   Ajouter_Personne (Arbre, Personne2, Cle2);
   Ajouter_Relation (Arbre, Cle, A_Pour_Enfant, Cle2);
   Put (Sb.To_String (Lire_Registre (Arbre, Cle).Nom_Usuel));
   Put (Sb.To_String (Lire_Registre (Arbre, Cle2).Nom_Usuel));
   Liste_Relations (Liste, Arbre, Cle2);
   while Liste_Non_Vide (Liste) loop
      Relation_Suivante (Liste, Arete);
      Put (Cle2, 0);
      Put (" " & T_Etiquette_Arete'Image (Arete.Etiquette) & " ");
      Put (Arete.Destination, 0);
      New_Line;
   end loop;
   -- ajouter_relation(truc, cle1, cle2, relation);

   Detruire (Arbre);

   Pouet;

end Test_Arbre_Genealogique;
