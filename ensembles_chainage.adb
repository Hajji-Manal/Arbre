with Ensembles_Chainage ;
with  Ada.Unchecked_Deallocation ;


package body Ensembles_Chainage is


    procedure free is 
	new Ada.Unchecked_Deallocation(T_Cellule, T_Ensemble);


    procedure initialiser_Ens (Ens : out T_Ensemble) is
    begin
	
	Ens := Null ;

    end initialiser_Ens;


    procedure detruire_Ens (Ens : in out T_Ensemble) is
    begin
	if Ens = Null then
	    Null ;
	else 
	    detruire_Ens (Ens.all.suivant);
	    free(Ens);
	end if;
    end detruire_Ens;



    function Est_Ens_vide (Ens : in T_Ensemble) return Boolean is 
    begin
	return Ens=Null;
    end;




    function Est_elt_present (Ens :in T_Ensemble ;elt :in T_Element) return boolean is 
    begin
	if Ens=Null then
	    return False ;
	elsif Ens.all.element=elt then 
	    return True ;
	else  
	    return Est_elt_present(Ens.all.suivant,elt);
	end if ;
    end;



    procedure ajouter_elt( Ens : in out T_Ensemble; elt : in T_Element) is 
	nv_cellule : T_Ensemble ;
    begin
	if not Est_elt_present(Ens,elt) then
	     nv_cellule := new T_Cellule'(elt , Ens); 
	     Ens := nv_cellule;
	else Null;
	end if ;
    end ;



    procedure supprimer_elt (Ens: in out T_Ensemble ; elt : in T_Element ) is
	A_detruire : T_Ensemble;
    
    begin
	if Est_elt_present(Ens,elt) then
	   if Ens.all.element = elt then
	     A_detruire := Ens;
	     Ens := Ens.all.suivant;
	     free(A_detruire);
	   else 
	     supprimer_elt(Ens.all.suivant,elt);
 	   end if ;
	else Null;
	end if ;
    end ;



    function obtenir_suivant (Ens : in T_Ensemble) return T_Ensemble is 
    begin 
	if Ens = Null then
	    return Ens ;
	else 
	  return Ens.all.suivant ;
	end if ;
    end ;

    

    function rassembler (Ens1: in out T_Ensemble ; Ens2 : in T_Ensemble ) return T_Ensemble is 
    courant : T_Ensemble ;
    Ens : T_Ensemble ;
    begin 
	courant := Ens1 ;
        
	if Ens1 = Null then
	    Ens1 := Ens2 ;  
	    return Ens1 ;
	else
	     Ens := rassembler (Ens1.all.suivant,Ens2);
	end if ;
	return courant ;
    end ;

    

    function rassembler_1(elt : in T_Element ; Ens1: in out T_Ensemble ; Ens2 :in T_Ensemble ) return T_Ensemble is 
    Ens : T_Ensemble ;
    begin
	Ens := rassembler(Ens1,Ens2) ;
	ajouter_elt(Ens,elt);
	return Ens ;	
    end ;




    procedure Appliquer_Sur_Tous (Ens :in T_Ensemble) is 
    begin
	if Ens=Null then 
	    Null ;
	else
	    Appliquer_Sur_Tous(Ens.all.suivant);
	    operation(Ens.all.element);
	end if ;
    end ;
	    



end Ensembles_Chainage;
