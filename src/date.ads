package Date is

   type T_Mois is
     (Janvier, Fevrier, Mars, Avril, Mai, Juin, Juillet, Aout, Septembre,
      Octobre, Novembre, Decembre);
   type T_Date is record
      Jour  : Integer; -- {entre 1 et 31}
      Mois  : T_Mois;
      Annee : Integer; -- {positif}
   end record;

   Date_Incorrecte : exception;

   -- Retourne Vrai si D1 < D2.
   -- Paramètres :
   --    D1 : T_Date
   --    D2 : T_Date
   -- Assure :
   --    retourne Vrai si la relation est vraie et faux sinon.
   function D1_Inf_D2 (Date1 : T_Date; Date2 : T_Date) return Boolean;

   -- Retourne Vrai si D1 = D2.
   -- Paramètres :
   --    D1 : T_Date
   --    D2 : T_Date
   -- Assure :
   --    retourne Vrai si la relation est vraie et faux sinon.
   function D1_Egal_D2 (Date1 : T_Date; Date2 : T_Date) return Boolean;

   -- Crée une date correspondant aux entiers Jour, Mois et Annee donnés.
   function Creer_Date
     (Jour : Integer; Mois : Integer; Annee : Integer) return T_Date;

end Date;
