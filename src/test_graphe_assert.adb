with Ada.Text_IO; use Ada.Text_IO;
with Graphe;

procedure test_graphe_assert is

   package Graphe_Test is new Graphe (Integer, Integer);
   use Graphe_Test;

   procedure Test_Initialiser is
      Graphe1 : T_Graphe;
   begin
      Initialiser (Graphe1);
      pragma Assert (Est_Vide (Graphe1));
      Detruire (Graphe1);
   end Test_Initialiser;

   procedure Test_Ajouter_Sommet is
      Graphe1 : T_Graphe;
   begin
      Initialiser (Graphe1);
      Ajouter_Sommet (Graphe1, 1);
      pragma Assert (Indiquer_Sommet_Existe (Graphe1, 1));
      Detruire (Graphe1);
   end Test_Ajouter_Sommet;

   procedure Test_Ajouter_Arete is
      Graphe1 : T_Graphe;
      Liste   : T_Liste_Adjacence;
      Arete   : T_Arete_Etiquetee;
   begin
      Initialiser (Graphe1);
      Ajouter_Sommet (Graphe1, 1);
      Ajouter_Sommet (Graphe1, 42);
      Ajouter_Arete (Graphe1, 1, 2, 42);
      Chaine_Adjacence (Liste, Graphe1, 1);
      Arete_Suivante (Liste, Arete);
      pragma Assert (Arete.Etiquette = 2);
      Detruire (Graphe1);
   end Test_Ajouter_Arete;

   procedure Test_Supprimer_Arete is
      Liste   : T_Liste_Adjacence;
      Graphe1 : T_Graphe;
      Arete   : T_Arete_Etiquetee;
   begin
      Initialiser (Graphe1);
      Ajouter_Sommet (Graphe1, 1);
      Ajouter_Sommet (Graphe1, 42);
      Ajouter_Arete (Graphe1, 1, 2, 42);
      Supprimer_Arete (Graphe1, 1, 2, 42);
      Chaine_Adjacence (Liste, Graphe1, 1);
      Arete_Suivante (Liste, Arete);
   exception  -- Arete_suivante lève une exception si l'arete est vide.
      when Vide =>
         Put_Line ("Supprimer_Arete est fonctionnel");
      when others =>
         null;
         Detruire (Graphe1);
   end Test_Supprimer_Arete;

begin
   Test_Initialiser;
   Test_Ajouter_Sommet;
   Test_Ajouter_Arete;
   Test_Supprimer_Arete;
   Put_Line ("Module fonctionnel");
end test_graphe_assert;
