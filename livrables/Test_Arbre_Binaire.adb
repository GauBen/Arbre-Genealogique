with Ada.Text_IO;
use Ada.Text_IO;
with Arbre_Binaire;

procedure T_Arbre_Binaire is 

   package Arbre_BinaireI is
   new Arbre_Binaire (T_Identifiant => Integer);

   procedure Test_Initialiser( Abr : out T_AB