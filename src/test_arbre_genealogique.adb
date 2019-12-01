with Arbre_Genealogique; use Arbre_Genealogique;
with Ada.Text_Io;        use Ada.Text_Io;

procedure Test_Arbre_Genealogique is

   Arbre    : T_Arbre_Genealogique;
   Personne : T_Personne;
   Cle      : Integer;

begin

   Initialiser (Arbre);

   Personne :=
     (Sb.To_Bounded_String ("Jean Bon"),
      Sb.To_Bounded_String ("Jean Bon Blanc"));

   Ajouter_Personne (Arbre, Personne, Cle);

   Put (Sb.To_String (Lire_Registre (Arbre, Cle).Nom_Usuel));
   -- ajouter_relation(truc, cle1, cle2, relation);

   Detruire (Arbre);

   Pouet;

end Test_Arbre_Genealogique;
