with Ada.Text_IO;
use Ada.Text_IO;
with Arbre_Binaire;

procedure T_Arbre_Binaire is 

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
   Initialiser(Arbre);
   Ajouter(Arbre, 1);
   pragma assert(Est_Present(Arbre, 1));
   Detruire(Arbre);
   end Test_Ajouter;

   procedure Nombre_de_

