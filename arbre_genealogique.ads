--Spécification Module Arbre Généalogique.
with registre ; use registre ;
with Ada.Integer_Text_IO;  use Ada.Integer_Text_IO;
with Arbre_Binaire ; 

package Arbre_Genealogique is

    id_present : exception;
    id_absent : exception;
    pere_present : exception;
    mere_presente : exception;
    
    procedure afficher_cle (cle : in integer) ;

    
    type T_Arbre_genealogique is private;
    
   
-------------------------------------------------------------------------------------------------------------
    

        -- créer un arbre dont la racine est Cle .
	--
	--Paramètres : 
	--      Abr : l'arbre .
        --      id : l'identifiant à insérer.
	 
   procedure Creer_Arbre_minimal (Abr : out T_Arbre_genealogique ; id : in integer);



-----------------------------------------------------------------------------------------------------------------------------------


        -- ajouter le père à un noeud sachant son identifiant.
	--
	--Paramètres :
	--   Abr : l'arbre en question.
	--   id_fils : l'identifiant du fils.
	--   id_pere : l'identifiant du pere.

   procedure Ajouter_pere (Abr : in out T_Arbre_genealogique ; id_fils : in integer ; id_pere : in integer);

  
-----------------------------------------------------------------------------------------------------------------------------------


        -- ajouter la mère à un noeud sachant son identifiant.
	--
	-- Paramètres :
	--   Abr : l'arbre en question.
	--   id_fils : l'identifiant du fils.
	--   id_mere : l'identifiant de la mere.

   procedure Ajouter_mere (Abr : in out T_Arbre_genealogique ; id_fils : in integer ; id_mere : in integer);


-----------------------------------------------------------------------------------------------------------------------------------
   
   
 
        -- obtenir le nombre d'ancêtres à partir d'un fils sachant son identifiant.
	--
	-- Paramètres :
	--    Abr : l'arbre en question.
	--    id : l'identifiant du fils.

   function Obtenir_nombre_ancetre (Abr : in T_Arbre_genealogique ; id : in integer ) return integer ;
 
   

----------------------------------------------------------------------------------------------------------------------------------   


        -- obtenir l'ensemble d'ancêtres appartenant à une génération d'un fils sachant son identifiant.
	--
	-- Paramètres :
	--    Abr : l'arbre en question.
	--    id : l'identifiant du fils .
	--    Generation : la generation concernée. 

   procedure obtenir_ensemble_ancetre_generation (Abr : in T_Arbre_genealogique ; id : in integer ; Generation : in Natural) ;

   

-----------------------------------------------------------------------------------------------------------------------------------
   
        -- afficher un arbre Tout entier
        --
        -- Paramètres :
        --    Abr : l'arbre en question.
      

   procedure afficher_arbre_entier( Abr : in T_Arbre_genealogique);
 


-----------------------------------------------------------------------------------------------------------------------------------
 
        
        
        -- afficher un arbre à partir d'un identifiant
        --
        -- Paramètres :
        --    Abr : l'arbre en question.
        --    id : l'identifiant.

   procedure afficher_arbre_genealogique (Abr : in T_Arbre_genealogique ; id : in integer ) ;
   


-----------------------------------------------------------------------------------------------------------------------------------



        --supprimer un Sous-arbre d'un arbre à partir d'un fils sachant son identifiant.
	--
	--Paramètres :
	--    Abr : l'arbre en question.
	--    id: lidentifiant du fils.
	--

   procedure supprimer_sous_arbre_genealogique (Abr : in out T_Arbre_genealogique ; id : in integer) ;



-----------------------------------------------------------------------------------------------------------------------------------


        -- Obtenir l'ensemble des fils ayant un seul parent.
	--
	-- Paramètres :
	--    Abr : l'arbre en question.

   procedure obtenir_ensemble_1_parent ( Abr : in T_Arbre_genealogique) ;



-----------------------------------------------------------------------------------------------------------------------------------


        -- Obtenir l'ensemble des fils ayant deux parents.
	--
	-- Paramètres :
	--    Abr : l'arbre en question.

   procedure obtenir_ensemble_2_parent ( Abr : in T_Arbre_genealogique) ;



-----------------------------------------------------------------------------------------------------------------------------------



        -- Obtenir l'ensemble des fils n'ayant aucun parents.
	--
	-- Paramètres :
	--    Abr : l'arbre en question.

   procedure obtenir_ensemble_0_parent ( Abr : in T_Arbre_genealogique);


-----------------------------------------------------------------------------------------------------------------------------------



        -- Obtenir l'ensemble des ancêtres d'un noeud sachant son identifiant sur n générations.
	--
	-- Paramètres :
	--    Abr : l'arbre en question.
        --    id : l'identifiant du fils.
        --    n : le nombre de générations.

   procedure identifier_ancetre_n_generation ( Abr : in T_Arbre_genealogique ; id : in integer ; n : Natural ) ;



-----------------------------------------------------------------------------------------------------------------------------------


        -- Savoir si deux ancêtres sont homonymes
	--
	-- Paramètres :
	--    Abr : l'arbre en question.
        --    individu_1 : l'identifiant du 1 er individu.
        --    individu_2 : l'identifiant du 2 eme individu.


   function ancetre_homonymes (Abr : in T_Arbre_genealogique; registre : in T_registre  ; individu_1 : in integer ; individu_2 : in integer ) return boolean ;


-----------------------------------------------------------------------------------------------------------------------------------



       -- Vider un arbre généalogique de ses éléments
       --
       -- Paramètres :
       --    Abr: l'arbre généalogique 
       -- 
       -- Assure :
       --    Est_arbre_vide(Abr).
       
   procedure vider (Abr : in out T_Arbre_Genealogique) with
       post => Est_arbre_vide (Abr);


-----------------------------------------------------------------------------------------------------------------------------------
       

      -- Savoir si un arbre généalogique est vide
      --
      -- Paramètres :
      --    Abr: l'arbre généalogique 
      -- 

   function Est_arbre_vide(Abr : in T_Arbre_Genealogique) return boolean;


-----------------------------------------------------------------------------------------------------------------------------------
   



private 
    

    package Arb_Genealogique is 
	new  Arbre_Binaire (Integer,afficher_cle);
    use Arb_Genealogique;

    type T_Arbre_genealogique is new T_Arbre_Binaire ;


end Arbre_Genealogique ;













       


