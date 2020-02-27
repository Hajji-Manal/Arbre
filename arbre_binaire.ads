--spécifications du module arbre_binaire

generic 
   type T_Cle is private ;
   with procedure afficher_cle ( cle : in T_Cle );

 
Package Arbre_Binaire is
     

    Cle_Presente : exception;
    Cle_Absente : exception;
    fils_Gauche_present : exception;
    fils_Droit_present : exception;

    

    type T_Arbre_Binaire is private ;

-----------------------------------------------------------------------------------------------------------

    
        --savoir si une cle est présente ou pas dans un arbre.
	--
	--Paramètres :
	--    Abr : l'arbre en question.
	--    Cle : la Cle.


    function Est_Present (Abr : T_Arbre_Binaire ; Cle : T_Cle) return Boolean ;

-----------------------------------------------------------------------------------------------------------

        -- créer un arbre dont la racine est Cle .
	--
	-- Paramètres : 
	--      Abr : l'arbre .
        --      Cle : la cle à insérer.
	--
	-- Assure :
	--    Est_Present(Abr,Cle) and Taille_Arbre_Binaire(Abr) = 1 ;


    procedure creer_arbre_minimal_binaire (Abr :out T_Arbre_Binaire ; Cle : in T_Cle) with 
	post => Est_Present(Abr,Cle) and Taille_Arbre(Abr) = 1 ;


-----------------------------------------------------------------------------------------------------------
	-- Obtenir le noeud correspondant à une Cle d'un arbre binaire .
	--
	-- Paramètres :
	--      Abr : l'arbre
	--      Cle : La CLe
	
    function Le_Noeud(Abr: in T_Arbre_Binaire ; Cle : in T_Cle) return T_Arbre_Binaire ;

-----------------------------------------------------------------------------------------------------------


        -- ajouter le fils gauche à un noeud sachant sa Cle.
	--
	--Paramètres :
	--   Abr : l'arbre en question.
	--   Cle : la Cle du noeud.
	--   Cle_fils_Gauche : la Cle du fils gauche
	--
	--Assure :
	--    Est_present (Abr,Cle_fils_Gauche).


    procedure Ajouter_fils_Gauche(Abr : in out T_Arbre_Binaire ; Cle : in  T_Cle ; Cle_fils_Gauche :in T_Cle) with
	post => Est_Present(Abr, Cle_fils_Gauche) ;


	
-----------------------------------------------------------------------------------------------------------
	
	
	
	-- ajouter le fils droit à un noeud sachant sa Cle.
	--
	--Paramètres :
	--   Abr : l'arbre en question.
	--   Cle : la Cle du noeud.
	--   Cle_fils_Droit : la Cle du fils Droit
	--
	--Assure :
	--    Est_present (Abr,Cle_fils_Droit).


    procedure Ajouter_fils_Droit(Abr : in out T_Arbre_Binaire ; Cle : in  T_Cle ; Cle_fils_Droit :in T_Cle ) with
	post => Est_Present(Abr, Cle_fils_Droit) ; 



-----------------------------------------------------------------------------------------------------------



	-- obtenir le nombre de fils à partir d'un noeud sachant sa Cle.
	--
	-- Paramètres :
	--    Abr : l'arbre en question.
	--    Cle : la cle du noeud.
	--
	-- Assure :
	--    obtenir_nombre_fils'result >= 1.


    function obtenir_nombre_fils (Abr: in T_Arbre_Binaire ; Cle : in T_Cle) return Integer with
	post => obtenir_nombre_fils'result >= 1 ;



-----------------------------------------------------------------------------------------------------------


        -- obtenir le nombre de niveau d'un arbre .
	--
	-- Paramètres :
	--    Abr : l'arbre en question.
	--
	-- Assure :
	--    hauteur'result >=0 and hauteur'result <= Taille_Arbre(Abr) .


    function hauteur(Abr: in T_Arbre_binaire) return integer with 
	post => hauteur'result >=0 and hauteur'result <= Taille_Arbre(Abr) ;



-----------------------------------------------------------------------------------------------------------



        -- obtenir l'ensemble de fils appartenant à une génération d'un noeud sachant sa Cle.
	--
	-- Paramètres :
	--    Abr : l'arbre en question.
	--    Cle : la cle du noeud.
	--    niveau : le niveau concerné.  
	

    procedure obtenir_ensemble_fils_niveau (Abr: in T_Arbre_Binaire ; Cle : in T_Cle ; niveau : in Natural );



-----------------------------------------------------------------------------------------------------------



	--supprimer un Sous-arbre d'un arbre à partir d'un noeud sachant sa Cle.
	--
	--Paramètres :
	--    Abr : l'arbre en question.
	--    Cle : la cle du noeud.
	--
	--Assure :
	--    not Est_present (Abr,Cle).


    procedure Supprimer_Sous_Arbre (Abr : in out T_Arbre_Binaire ; Cle : in T_Cle) with
	post => not Est_Present (Abr,Cle);


-----------------------------------------------------------------------------------------------------------




        -- Vérifier si un arbre est vide.
	--
	-- Paramètres :
	--      Abr : l'arbre binaire en question
	--
	

    function Est_vide(Abr : in T_Arbre_Binaire) return boolean;



-----------------------------------------------------------------------------------------------------------




        -- Vider un arbre  
	-- 
	-- Paramètres :
	--      Abr : l'arbre binaire en question.
	-- Assure :
	--    Est_vide (Abr).
	

    procedure vider_arbre (Abr : in out T_Arbre_Binaire) with
	post => Est_vide(Abr);



-----------------------------------------------------------------------------------------------------------




	-- Obtenir l'ensemble des noeuds ayant un seul fils.
	--
	-- Paramètres :
	--    Abr : l'arbre en question.
	--
	

    procedure obtenir_ensemble_1_fils (Abr : in T_Arbre_Binaire) ;



-----------------------------------------------------------------------------------------------------------




        -- Obtenir l'ensemble des noeuds ayant deux fils.
	--
	-- Paramètres :
	--    Abr : l'arbre en question.


    procedure obtenir_ensemble_2_fils (Abr : in T_Arbre_Binaire) ;

 

-----------------------------------------------------------------------------------------------------------



    
        -- Obtenir l'ensemble des noeuds n'ayant aucun fils.
	--
	-- Paramètres :
	--    Abr : l'arbre en question.


    procedure obtenir_ensemble_0_fils (Abr : in T_Arbre_Binaire) ;
       
  

-----------------------------------------------------------------------------------------------------------




        -- Obtenir l'ensemble des fils d'un noeud sachant sa cle sur n générations.
	--
	-- Paramètres :
	--    Abr : l'arbre en question.
        --    Cle : la Cle du noeud.
        --    n : le nombre de niveaux.


    procedure identifier_fils_n_niveau ( Abr : in T_Arbre_Binaire ; Cle : in T_Cle ; n : Natural);



-----------------------------------------------------------------------------------------------------------


        --obtenir la taille d'un arbre binaire.
	--
	--Paramètres :
	--    Abr : l'arbre en question.
        --
        --Assure :
        --  taille_Arbre_Binaire'result >= 1 .


    function Taille_Arbre ( Abr : in T_Arbre_Binaire ) return integer with
	post => taille_Arbre'result >= 0 ;



-----------------------------------------------------------------------------------------------------------
	


        --afficher les éléments d'un arbre .
	--
	--Paramètres :
	--   Abr : l'arbre en question.


    procedure afficher_Tous_arbre (Abr : in T_Arbre_Binaire ) ; 



-----------------------------------------------------------------------------------------------------------
    

	--afficher les éléments d'un arbre à partir d'une clé.
	--
	--Paramètres :
	--   Abr : l'arbre en question.
	--   Cle : la Cle

    procedure afficher_arbre ( Abr : in T_Arbre_Binaire ; cle : in T_Cle );



-----------------------------------------------------------------------------------------------------------



    -- Obtenir la cle de la racine d'un arbre .
    --
    -- Paramètres :
    --       Abr : L'arbre .
    --

    function obtenir_cle (Abr : T_Arbre_Binaire) return T_Cle ;


-----------------------------------------------------------------------------------------------------------


    -- Obtenir le sous_arbre_gauche d'un arbre .
    --
    -- Paramètres :
    --       Abr : L'arbre .
    --


    function obtenir_arbre_gauche (Abr : T_Arbre_Binaire) return T_Arbre_Binaire ;



-----------------------------------------------------------------------------------------------------------



    -- Obtenir le sous arbre droit d'un arbre .
    --
    -- Paramètres :
    --       Abr : L'arbre .
    --
    
    function obtenir_arbre_droit (Abr : T_Arbre_Binaire) return T_Arbre_Binaire ;


-----------------------------------------------------------------------------------------------------------

  


private
    type T_Noeud ;
    
    type T_Arbre_Binaire is access T_Noeud ;
    
    type T_Noeud is 
	record 
	    Cle : T_Cle ;
	    Sous_Arbre_Droit : T_Arbre_Binaire ;
	    Sous_Arbre_Gauche : T_Arbre_Binaire ;
	end record ;
    

end Arbre_binaire ;

