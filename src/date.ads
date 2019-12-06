package Date is

type T_Mois is (JANVIER,FEVRIER,MARS,AVRIL,MAI,JUIN,JUILLET,AOUT,SEPTEMBRE,OCTOBRE,NOVEMBRE,DECEMBRE);
   type T_Date is record
      Jour : Integer;
      Mois : T_Mois;
      Annee: Integer;
   end record;

-- Retourne Vrai si D1 < D2.
-- Paramètres :
--    D1 : T_Date
--    D2 : T_Date
-- Assure :
--    retourne Vrai si la relation est vraie et faux sinon.
function D1_Inf_D2
(Date1 : T_Date; Date2 : T_Date) return Boolean;


-- Retourne Vrai si D1 = D2.
-- Paramètres :
--    D1 : T_Date
--    D2 : T_Date
-- Assure :
--    retourne Vrai si la relation est vraie et faux sinon.
function  D1_Egal_D2
(Date1 : T_Date; Date2 : T_Date) return Boolean;
end Date;