with Ada.Text_IO;
use Ada.Text_IO;
with Arbre_Binaire;

procedure Test_Arbre_Binaire is

   package Arbre_BinaireI is
   new Arbre_Binaire (T_Identifiant => Integer);

   procedure Test_Initialiser is
   Arbre : T_Arbre_Binaire;
   begin
      Initialiser(Arbre,1);
      pragma assert(Est_Vide(Arbre));
   end Test_Initialiser;

   procedure Test_Ajouter is
   Arbre : T_Arbre_Binaire;
   begin
      Initialiser(Arbre,1);
      Ajouter(Arbre, 1,2);
      pragma assert(Est_Present(Arbre, 2));
      Detruire(Arbre);
   end Test_Ajouter;

   procedure Test_Nombre_De_Successeurs is
   Arbre : T_Arbre_Binaire;
   begin
      Initialiser(Arbre,1);
      Ajouter(Arbre,1,2);
      Ajouter(Arbre,1,3);
      pragma assert(Nombre_De_Successeurs(Arbre,1) = 2);
      Detruire(Arbre);
   end Test_Nombre_De_Successeurs;

   procedure Test_Liste_Des_Successeurs is
   Arbre : T_Arbre_Binaire;
   begin
      Initialiser(Arbre,1);
      Ajouter(Arbre,1,2);
      pragma assert(Liste_Des_Successeurs(Arbre,1).all.Valeur = 2);
      Detruire(Arbre);
   end Test_Liste_Des_Successeurs;

   procedure Test_Supprimer_Sous_Arbre is
   Arbre : T_Arbre_Binaire;
   begin
      Initialiser(Arbre,1);
      Ajouter(Arbre,1,2);
      Supprimer_Sous_Arbre(Arbre,1);
      pragma assert(not Est_Present(Arbre,2));
      Detruire(Arbre);
   end Test_Supprimer_Sous_Arbre;

   procedure Test_Noeuds_Possedant_N_Successeurs_Directs is
   Arbre : T_Arbre_Binaire;
   begin
      Initialiser(Arbre,1);
      Ajouter(Arbre,1,2);
      Ajouter(Arbre,1,3);
      Ajouter(Arbre,2,4);
      pragma assert(Noeuds_Possedant_N_Successeurs_Directs(Arbre,0) = 2);
      pragma assert(Noeuds_Possedant_N_Successeurs_Directs(Arbre,1) = 1);
      pragma assert(Noeuds_Possedant_N_Successeurs_Directs(Arbre,2) = 2);
      Detruire(Arbre);
   end Test_Noeuds_Possedant_N_Successeurs_Directs;

   begin
      Test_Initialiser;
      Put_Line("Initialiser vérifiée");
      Test_Ajouter;
      Put_Line("Ajouter vérifiée");
      Test_Nombre_De_Successeurs;
      Put_Line("Nombre_De_Successeurs vérifiée");
      Test_Liste_Des_Successeur;
      Put_Line("Liste_Des_Successeurs vérifiée");
      Test_Supprimer_Sous_Arbre;
      Put_Line("Supprimer_Sous_Arbre vérifiée");
      Test_Noeuds_Possedant_N_Successeurs_Directs;
      Put_Line("Noeuds_Possedant_N_Successeurs_Directs vérifiée");
      Put_Line("Module vérifié");
   end Test_Arbre_Binaire;









