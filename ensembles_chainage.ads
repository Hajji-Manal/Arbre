generic
    type T_Element is private ; -- type des éléments de l'ensemble

package Ensembles_Chainage is

    
     type T_Cellule ;
     
     type T_Ensemble is access T_Cellule;  
      
     type T_cellule is 
	  record 
	      element : T_Element;
	      suivant : T_Ensemble;
	   end record ;


	--créer un ensemble vide.
	--
	--Paramètres : 
	--      Ens : l'ensemble à initialiser.
	--
	--Assure :
	--    Est_vide(Ens).
	    
	procedure initialiser_Ens (Ens : out T_Ensemble) with 
	    post => Est_Ens_vide (Ens);

	--détruire un ensemble.
	--
	--Paramètres :
	--    Ens : l'ensemble à détruire.
	--
	--Assure :
	--    Est_vide(Ens).
	
	procedure detruire_Ens (Ens : in out T_Ensemble) with 
	    post => Est_Ens_vide(Ens);

	
	-- savoir si un ensemble est vide.
	--
	--Paramètres :
	--    Ens : l'ensemble en question.
	
	function Est_Ens_vide (Ens : in T_Ensemble) return Boolean ;



	--savoir si un élément est présent ou pas.
	--
	--Paramètres :
	--    Ens : l'ensemble en question.
	--    elt : l'élément.
	
	function Est_elt_present (Ens : in T_Ensemble ; elt : in T_Element) return Boolean ;


	--ajouter un élément dans un ensemble.
	--
	--Paramètres :
	--    Ens : l'ensemble en question.
	--    elt : l'élément à ajouter.
	--
	--Assure :
	--    Est_present (Ens,elt).
	
	procedure ajouter_elt (Ens : in out T_Ensemble ; elt : in T_Element) with
	    post => Est_elt_present (Ens,elt);



	--supprimer un élément d'un ensemble.
	--
	--Paramètres :
	--    Ens : l'ensemble en question
	--    elt : l'élément à supprimer
	--
	--Assure :
	--    not Est_present (Ens,elt)

	procedure supprimer_elt (Ens : in out T_Ensemble ; elt : in T_Element) with
	    post => not Est_elt_present (Ens,elt) ;

	  


	function obtenir_suivant (Ens : in T_Ensemble) return T_Ensemble ;




        function rassembler (Ens1 : in out T_Ensemble ; Ens2 : in T_Ensemble) return T_Ensemble ;
       



	function rassembler_1 (elt :in T_Element ; Ens1:in out T_Ensemble ; Ens2 :in T_Ensemble ) return T_Ensemble ;



	    
	generic 
	     with procedure operation (elt : in T_Element);
	procedure Appliquer_Sur_Tous (Ens: in T_Ensemble);

	
	
     

end Ensembles_Chainage;
