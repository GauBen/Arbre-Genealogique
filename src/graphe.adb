with Ada.Unchecked_Deallocation;

package body Graphe is

   procedure Initialiser (Graphe : out T_Graphe) is
   begin
      Graphe := null;
   end Initialiser;

   procedure Desallouer_Sommet is new Ada.Unchecked_Deallocation (T_Sommet,
      T_Graphe);
   procedure Desallouer_Arete is new Ada.Unchecked_Deallocation (T_Arete,
      T_Liste_Adjacence);

   procedure Detruire_Arete (Adjacence : in out T_Liste_Adjacence) is
   begin
      if Adjacence /= null then
         Detruire_Arete (Adjacence.all.Suivante);
      end if;
      Desallouer_Arete (Adjacence);
   end Detruire_Arete;

   procedure Detruire (Graphe : in out T_Graphe) is
   begin
      if Graphe /= null then
         Detruire_Arete (Graphe.all.Arete);
         Detruire (Graphe.all.Suivant);
      end if;
      Desallouer_Sommet (Graphe);
   end Detruire;

   -- ? Exception lorsque le sommet existe déj�  ?
   procedure Ajouter_Sommet
     (Graphe : in out T_Graphe; Etiquette : T_Etiquette_Sommet)
   is
      Nouveau_Graphe : T_Graphe;
   begin
      Nouveau_Graphe     := new T_Sommet;
      Nouveau_Graphe.all := (Etiquette, null, Graphe);
      Graphe             := Nouveau_Graphe;
   end Ajouter_Sommet;

   function Trouver_Pointeur_Sommet
     (Graphe : T_Graphe; Etiquette : T_Etiquette_Sommet) return T_Graphe
   is
   begin
      if Graphe = null then
         raise Sommet_Non_Trouve;
      elsif Graphe.all.Etiquette = Etiquette then
         return Graphe;
      else
         return Trouver_Pointeur_Sommet (Graphe.all.Suivant, Etiquette);
      end if;
   end Trouver_Pointeur_Sommet;

   function Indiquer_Sommet_Existe
     (Graphe : T_Graphe; Etiquette : T_Etiquette_Sommet) return Boolean
   is
   begin
      if Graphe = null then
         return False;
      elsif Graphe.all.Etiquette = Etiquette then
         return True;
      else
         return Indiquer_Sommet_Existe (Graphe.all.Suivant, Etiquette);
      end if;
   end Indiquer_Sommet_Existe;

   function Est_Vide (Graphe : T_Graphe) return Boolean is
   begin
      return Graphe = null;
   end Est_Vide;

   procedure Ajouter_Arete
     (Graphe    : in out T_Graphe; Origine : in T_Etiquette_Sommet;
      Etiquette : in T_Etiquette_Arete; Destination : in T_Etiquette_Sommet)
   is
      Pointeur_Origine     : T_Graphe;
      Pointeur_Destination : T_Graphe;
      Nouvelle_Arete       : T_Liste_Adjacence;
   begin
      Pointeur_Origine     := Trouver_Pointeur_Sommet (Graphe, Origine);
      Pointeur_Destination := Trouver_Pointeur_Sommet (Graphe, Destination);

      Nouvelle_Arete     := new T_Arete;
      Nouvelle_Arete.all :=
        (Etiquette, Pointeur_Destination, Pointeur_Origine.all.Arete);

      Pointeur_Origine.all.Arete := Nouvelle_Arete;
   end Ajouter_Arete;

   procedure Chaine_Adjacence
     (Adjacence :    out T_Liste_Adjacence; Graphe : in T_Graphe;
      Origine   : in     T_Etiquette_Sommet)
   is
   begin
      Adjacence := Trouver_Pointeur_Sommet (Graphe, Origine).all.Arete;
   end Chaine_Adjacence;

   function Adjacence_Non_Vide (Adjacence : T_Liste_Adjacence) return Boolean
   is
   begin
      return Adjacence /= null;
   end Adjacence_Non_Vide;

   procedure Arete_Suivante
     (Adjacence : in out T_Liste_Adjacence; Arete : out T_Arete_Etiquetee)
   is
   begin
      if Adjacence = null then
         raise Vide;
      end if;
      Arete :=
        (Adjacence.all.Etiquette, Adjacence.all.Destination.all.Etiquette);
      Adjacence := Adjacence.all.Suivante;
   end Arete_Suivante;

   procedure Supprimer_Arete
     (Graphe          : in T_Graphe; Origine : in T_Etiquette_Sommet;
      Etiquette_Arete : in T_Etiquette_Arete;
      Destination     : in T_Etiquette_Sommet)
   is
      A_Detruire     : T_Liste_Adjacence;
      Pointeur       : T_Graphe;
      Pointeur_Arete : T_Liste_Adjacence;
   begin
      Pointeur       := Trouver_Pointeur_Sommet (Graphe, Origine);
      Pointeur_Arete := Pointeur.all.Arete;
      if Pointeur_Arete = null then
         return;
      end if;
      if Pointeur_Arete.all.Etiquette = Etiquette_Arete and
        Pointeur_Arete.all.Destination.all.Etiquette = Destination
      then
         A_Detruire         := Pointeur_Arete;
         Pointeur.all.Arete := Pointeur_Arete.all.Suivante;
         Detruire_Arete (A_Detruire);
         return;
      end if;
      while Pointeur_Arete.all.Suivante /= null loop
         if Pointeur_Arete.all.Suivante.all.Etiquette = Etiquette_Arete and
           Pointeur_Arete.all.Suivante.all.Destination.all.Etiquette =
             Destination
         then
            A_Detruire                  := Pointeur_Arete.all.Suivante;
            Pointeur_Arete.all.Suivante :=
              Pointeur_Arete.all.Suivante.all.Suivante;
            Desallouer_Arete (A_Detruire);
            return;
         end if;
         Pointeur_Arete := Pointeur_Arete.all.Suivante;
      end loop;
   end Supprimer_Arete;

   procedure Appliquer_Sur_Tous_Sommets (Graphe : in T_Graphe) is
   begin
      if Graphe /= null then
         P (Graphe.all.Etiquette, Graphe.all.Arete);
         Appliquer_Sur_Tous_Sommets (Graphe.all.Suivant);
      end if;
   end Appliquer_Sur_Tous_Sommets;

end Graphe;
