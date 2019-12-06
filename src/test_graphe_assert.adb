with Ada.Text_IO;
use Ada.Text_IO;
with Graphe;

procedure test_graphe_assert is 

    package Graphe_Test is new Graphe(Integer,Integer);
    use Graphe_Test;


    procedure Test_Initialiser is
        Graphe : T_Graphe; 
    begin
        Initialiser(Graphe);
        pragma assert(Graphe = Null);
        Detruire(Graphe);
    end Test_Initialiser;

    procedure Test_Ajouter_Sommet is
        Graphe : T_Graphe;
    begin
        Initialiser(Graphe);
        Ajouter_Sommet(Graphe,1);
        pragma assert(Indiquer_Sommet_Existe(Graphe,1));
        Detruire(Graphe);
    end Test_Ajouter_Sommet;

    procedure Test_Ajouter_Arete is 
        Graphe : T_Graphe;
        Liste : T_Liste_Adjacence;
    begin   
        Initialiser(Graphe);
        Ajouter_Sommet(Graphe,1);
        Ajouter_Sommet(Graphe,42);
        Ajouter_Arete(Graphe,1,2,42);
        Chaine_Adjacence(Liste,Graphe,1);
        pragma assert(Liste.all.Etiquette = 2);
        Detruire(Graphe);
    end Test_Ajouter_Arete;

    procedure Test_Supprimer_Arete is 
        Liste : T_Liste_Adjacence;
    begin
    Initialiser(Graphe);
        Ajouter_Sommet(Graphe,1);
        Ajouter_Sommet(Graphe,42);
        Ajouter_Arete(Graphe,1,2,42);
        Supprimer_Arete(Graphe,1,2,42);
        Chaine_Adjacence(Liste,Graphe,1);
        pragma assert(Liste = Null);
        Detruire(Graphe);
    end Test_Supprimer_Arete; 

begin
    Test_Initialiser;
    Test_Ajouter_Sommet;
    Test_Ajouter_Arete;
    Test_Supprimer_Arete;
    Put_Line("Module fonctionnel");
end test_graphe_assert;
