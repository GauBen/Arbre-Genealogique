package body Arbre_Genealogique is

   procedure Initialiser (Arbre : out T_Arbre_Genealogique) is
   begin
      Initialiser (Arbre.Registre);
      Initialiser (Arbre.Graphe);
      Arbre.Auto_Increment := 1;
   end Initialiser;

   procedure Detruire (Arbre : in out T_Arbre_Genealogique) is
   begin
      Detruire (Arbre.Registre);
      Detruire (Arbre.Graphe);
   end Detruire;

   procedure Ajouter_Personne
     (Arbre : in out T_Arbre_Genealogique; Personne : in T_Personne;
      Cle   :    out Integer)
   is
   begin
      Cle := Arbre.Auto_Increment;
      Attribuer (Arbre.Registre, Cle, Personne);
      Ajouter_Sommet (Arbre.Graphe, Cle);
      Arbre.Auto_Increment := Arbre.Auto_Increment + 1;
   end Ajouter_Personne;

   function Lire_Registre
     (Arbre : T_Arbre_Genealogique; Cle : Integer) return T_Personne
   is
   begin
      return Acceder (Arbre.Registre, Cle);
   end Lire_Registre;

   procedure Ajouter_Relation
     (Arbre                : in out T_Arbre_Genealogique;
      Personne_Origine     : in     T_Etiquette_Sommet;
      Relation             : in     T_Etiquette_Arete;
      Personne_Destination : in     T_Etiquette_Sommet)
   is
      Chaine : T_Liste_Adjacence;
      Arete  : T_Arete_Etiquetee;
   begin
      if Personne_Destination = Personne_Origine then
         raise Relation_Existante;
      end if;
      Chaine_Adjacence (Chaine, Arbre.Graphe, Personne_Origine);
      while Adjacence_Non_Vide (Chaine) loop
         Arete_Suivante (Chaine, Arete);
         if Arete.Destination = Personne_Destination then
            raise Relation_Existante;
         end if;
      end loop;
      case Relation is
         when A_Pour_Parent =>
            Ajouter_Arete
              (Arbre.Graphe, Personne_Origine, A_Pour_Parent,
               Personne_Destination);
            Ajouter_Arete
              (Arbre.Graphe, Personne_Destination, A_Pour_Enfant,
               Personne_Origine);
         when A_Pour_Enfant =>
            Ajouter_Arete
              (Arbre.Graphe, Personne_Origine, A_Pour_Enfant,
               Personne_Destination);
            Ajouter_Arete
              (Arbre.Graphe, Personne_Destination, A_Pour_Parent,
               Personne_Origine);
         when others =>
            Ajouter_Arete
              (Arbre.Graphe, Personne_Origine, Relation, Personne_Destination);
            Ajouter_Arete
              (Arbre.Graphe, Personne_Destination, Relation, Personne_Origine);
      end case;
   end Ajouter_Relation;

   procedure Liste_Relations
     (Adjacence :    out T_Liste_Relations; Arbre : in T_Arbre_Genealogique;
      Origine   : in     T_Etiquette_Sommet)
   is
   begin
      Chaine_Adjacence (Adjacence, Arbre.Graphe, Origine);
   end Liste_Relations;

   function Liste_Non_Vide (Adjacence : T_Liste_Relations) return Boolean is
   begin
      return Adjacence_Non_Vide (Adjacence);
   end Liste_Non_Vide;

   procedure Relation_Suivante
     (Adjacence : in out T_Liste_Relations; Arete : out T_Arete_Etiquetee)
   is
   begin
      Arete_Suivante (Adjacence, Arete);
   end Relation_Suivante;

   procedure Supprimer_Relation
     (Arbre                : in out T_Arbre_Genealogique;
      Personne_Origine     : in     T_Etiquette_Sommet;
      Relation             : in     T_Etiquette_Arete;
      Personne_Destination : in     T_Etiquette_Sommet)
   is
   begin
      case Relation is
         when A_Pour_Parent =>
            Supprimer_Arete
              (Arbre.Graphe, Personne_Origine, A_Pour_Parent,
               Personne_Destination);
            Supprimer_Arete
              (Arbre.Graphe, Personne_Destination, A_Pour_Enfant,
               Personne_Origine);
         when A_Pour_Enfant =>
            Supprimer_Arete
              (Arbre.Graphe, Personne_Origine, A_Pour_Enfant,
               Personne_Destination);
            Supprimer_Arete
              (Arbre.Graphe, Personne_Destination, A_Pour_Parent,
               Personne_Origine);
         when others =>
            Supprimer_Arete
              (Arbre.Graphe, Personne_Origine, Relation, Personne_Destination);
            Supprimer_Arete
              (Arbre.Graphe, Personne_Destination, Relation, Personne_Origine);
      end case;
   end Supprimer_Relation;

   procedure Attribuer_Registre
     (Arbre   : in out T_Arbre_Genealogique; Cle : in Integer;
      Element : in     T_Personne)
   is
   begin
      Attribuer (Arbre.Registre, Cle, Element);
   end Attribuer_Registre;

   function Existe_Registre
     (Arbre : T_Arbre_Genealogique; Cle : Integer) return Boolean
   is
   begin
      return Existe (Arbre.Registre, Cle);
   end Existe_Registre;

   procedure Appliquer_Sur_Registre (Arbre : in out T_Arbre_Genealogique) is
      procedure Appliquer is new Appliquer_Sur_Tous (P);
   begin
      Appliquer (Arbre.Registre);
   end Appliquer_Sur_Registre;

   procedure Appliquer_Sur_Graphe (Arbre : in out T_Arbre_Genealogique) is
      procedure Appliquer is new Appliquer_Sur_Tous_Sommets (P);
   begin
      Appliquer (Arbre.Graphe);
   end Appliquer_Sur_Graphe;

end Arbre_Genealogique;
