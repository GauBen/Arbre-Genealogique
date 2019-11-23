with Graphe;

procedure Test_Graphe is

   subtype T_Somment is Integer;
   type T_Arete is
     (A_Pour_Parent, A_Pour_Enfant, A_Pour_Frere, A_Pour_Conjoint);

   package Graphe_Genealogique is new Graphe (T_Somment, T_Arete);
   use Graphe_Genealogique;

   Graphe1 : T_Graphe;

begin

   Initialiser (Graphe1);

   Ajouter_Sommet(Graphe1, 42);
   Ajouter_Sommet(Graphe1, 1337);
   Ajouter_Arete(Graphe1, 42, A_Pour_Parent, 1337);
   Ajouter_Arete(Graphe1, 1337, A_Pour_Enfant, 42);

   Detruire (Graphe1);

   Pouet;

end Test_Graphe;
