--Spécification du module Registre
with Ada.Strings.Unbounded ;
use Ada.Strings.Unbounded ;
package Registre is

   
    identifiant_present : exception ; -- si l'identifiant est présent.
    identifiant_absent : exception ; -- si l'identifiant est absent.


    
    type T_registre is private ;

    type T_Donnee is private ;

    type T_Mois is (JANVIER, FEVRIER, MARS, AVRIL, MAI, JUIN, JUILLET,
                    AOUT, SEPTEMBRE, OCTOBRE, NOVEMBRE, DECEMBRE);


    type T_Date is private ;

    
    
        -- savoir si un registre est vide.
	--
	-- Paramètres :
	--    reg : le registre en question.

        function Est_vide (reg : in T_registre) return boolean ;

  
--------------------------------------------------------------------------------------------------------------

        -- créer un registre vide.
	--
	-- Paramètres : 
	--      reg : le registre à initialiser.
	--
	-- Assure :
	--    Est_vide(reg).


    procedure initialiser_registre (reg : out T_registre) with
	post => Est_vide (reg) ;

--------------------------------------------------------------------------------------------------------------

	-- ajouter un identifiant et une donnée dans un registre.
	--
	-- Paramètres :
	--    reg : le registre en question.
	--    identifiant : l'identifiant à ajouter.
	--    info : l'information à joindre à l'identifiant.
	--    
        --
	-- Assure :
	--    id_present (reg,identifiant).
	

    procedure ajouter (reg : in out T_registre ; identifiant : in integer ; info : in T_Donnee) with
            post => ident_present (reg , identifiant) ;

---------------------------------------------------------------------------------------------------------------

	-- modifier le nom  correspondant à un identifiant.
	--
	--
	-- Paramètres :
	--    reg : le registre en question.
	--    identifiant : l'identifiant en question.
	--    nom : le nouveau nom .
         

		        
    procedure modifier_nom ( reg : in out T_registre ; identifiant : in integer ; nom : in unbounded_String) ;

----------------------------------------------------------------------------------------------------------------

	-- modifier le prénom  correspondant à un identifiant.
	--
	-- Paramètres :
	--    reg : le registre en question.
	--    identifiant : l'identifiant en question.
	--    prenom : le nouveau prénom .



    procedure modifier_prenom( reg : in out T_registre ; identifiant : in integer ; prenom : in unbounded_String);

----------------------------------------------------------------------------------------------------------------

	-- modifier le sexe  correspondant à un identifiant.
	--
	-- Paramètres :
	--    reg : le registre en question.
	--    identifiant : l'identifiant en question.
	--    sexe : le nouveau sexe .



    procedure modifier_sexe(reg : in out T_registre ; identifiant : in integer ; sexe : in character);

----------------------------------------------------------------------------------------------------------------

	-- modifier la date correspondante à un identifiant.
	--
	-- Paramètres :
	--    reg : le registre en question.
	--    identifiant : l'identifiant en question.
	--    date : la nouvelle date .



    procedure modifier_date(reg : in out T_registre ; identifiant : in integer ; date : in T_Date);

-----------------------------------------------------------------------------------------------------------------

	-- modifier le lieu  correspondant à un identifiant.
	--
	--
	-- Paramètres :
	--    reg : le registre en question.
	--    identifiant : l'identifiant en question.
	--    lieu : le nouveau lieu .
    


    procedure modifier_lieu(reg : in out T_registre ; identifiant : in integer ; lieu : in unbounded_string);


----------------------------------------------------------------------------------------------------------------
      
    -- vérifier si un identifiant est présent dans le registre.
    --
    -- Paramètres :
    --     reg : le registre en question.
    --     identifiant : l'identifiant en question.
    --


    function ident_present ( reg : in T_registre ; identifiant : in Integer ) return boolean;

-----------------------------------------------------------------------------------------------------------------    
        
        -- supprimer un identifiant d'un registre.
	--
	--Paramètres :
	--    reg : le registre en question.
	--    identifiant : l'identifiant à supprimer.
	--
	--Assure :
	--    not id_present (reg,identifiant).



    procedure supprimer ( reg : in out T_registre ; identifiant : in integer ) with 
         post => not ident_present(reg,identifiant);

------------------------------------------------------------------------------------------------------------------
	
	--obtenir la taille d'un regsitre.
	--
	--Paramètres :
	--    reg : le registre en question.
        --
        -- Assure :
        --    taille(reg) >= 0.



    function taille ( reg : in T_registre ) return integer with
	post => taille'result >= 0;

------------------------------------------------------------------------------------------------------------------


	-- afficher l'information correspondant à un identifiant.
	--
	--Paramètres :
	--    reg : le registre en question.
        --    identifiant : l'identifiant.



    procedure afficher_info ( reg : in T_registre ; identifiant : in integer ) ;

-------------------------------------------------------------------------------------------------------------------


        -- Obtenir le nom correspondant à un identifiant.
	--
	-- Paramètres :
	--    reg : le registre en question .
        --    identifiant : l'identifiant . 


    function obtenir_nom ( reg : in T_registre ; identifiant : in integer ) return string ;

-------------------------------------------------------------------------------------------------------------------

        -- Obtenir le prenom correspondant à un identifiant.
	--
	--Paramètres :
	--    reg : le registre en question .
        --    identifiant : l'identifiant .


    
    function obtenir_prenom ( reg : in T_registre ; identifiant : in integer ) return string ;

-------------------------------------------------------------------------------------------------------------------
       
        -- Obtenir le sexe correspondant à un identifiant.
	--
	--Paramètres :
	--    reg : le registre en question .
        --    identifiant : l'identifiant .


    function obtenir_sexe ( reg : in T_registre ; identifiant : in integer ) return character;

-------------------------------------------------------------------------------------------------------------------


        -- Obtenir le jour de naissance correspondant à un identifiant.
	--
     
	--Paramètres :
	--    reg : le registre en question .
        --    identifiant : l'identifiant .



    function obtenir_jour_naissance ( reg : in T_registre ; identifiant : in integer ) return integer ;

-------------------------------------------------------------------------------------------------------------------

        -- Obtenir le mois de naissance correspondant à un identifiant.
	--
	--Paramètres :
	--    reg : le registre en question .
        --    identifiant : l'identifiant .



    function obtenir_mois_naissance ( reg : in T_registre ; identifiant : in integer ) return T_Mois ;

-------------------------------------------------------------------------------------------------------------------

        -- Obtenir l'annee de naissance correspondant à un identifiant.
	--
	--Paramètres :
	--    reg : le registre en question .
        --    identifiant : l'identifiant .


    function obtenir_annee_naissance ( reg : in T_registre ; identifiant : in integer ) return integer  ;

-------------------------------------------------------------------------------------------------------------------
       
        -- Obtenir le lieu de naissance correspondant à un identifiant.
	--
	--Paramètres :
	--    reg : le registre en question .
        --    identifiant : l'identifiant .


    function obtenir_lieu_naissance ( reg : in T_registre ; identifiant : in integer ) return string  ;

-------------------------------------------------------------------------------------------------------------------

     -- creer la date à partir du jour , mois et l'annee.
     --
     -- Paramètres :
     --        date : la date .
     --        jour : le jour .
     --        mois : le mois .
     --        annee : l'annee .


    procedure creer_date ( date : out T_Date ; jour : in integer ; mois : in T_Mois ; annee : in integer ) ;

-------------------------------------------------------------------------------------------------------------------
    
     -- creer la donnee à partir du nom , prenom , sexe, date de naissance ,lieu de naissance .
     --
     -- Paramètres :
     --        donnee : la donnée
     --         nom : le nom
     --         prenom : le prenom
     --         sexe : le sexe
     --         date_naissance : la date de naissance 
     --         lieu_naissance : le lieu de naissance 
     --
    
    procedure creer_donnee ( donnee : out T_Donnee ; nom : in unbounded_string ; prenom : in unbounded_string ; sexe : in character ;date_naissance : in T_Date ; lieu_naissance : in unbounded_string) ; 

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    -- Vider le registre
    --
    -- Paramètres :
    -- 		registre : le registre à vider .
    --
    
    procedure vider_reg ( registre : in out T_registre ) with
	post => Est_vide (registre);

--------------------------------------------------------------------------------------------------------------------  

private 
     
    
     type T_Date is
        record
            Jour : Integer;
            Mois : T_Mois;
            Annee : Integer;
            -- Invariant
            --    Annee > 0
            --    Jour >= 1
            --    Jour <= Nombre_Jours (Mois, Annee)
        end record;

     type T_Donnee is 
	 record 
	     nom : unbounded_string ;
	     prenom : unbounded_string ;
	     sexe : character ;
	     date_naissance : T_Date ;
	     lieu_naissance : unbounded_string ;
	 end record ;
     
     type T_Cellule ;
     type T_registre is access T_Cellule ;
     type T_Cellule is 
	 record 
	     identifiant : integer ;
	     donnee : T_Donnee ;
	     sous_arbre_gauche : T_registre ;
	     sous_arbre_droit : T_registre ;
	 end record ;


end registre ;







       





