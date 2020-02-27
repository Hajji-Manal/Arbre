-- Implémentation du Module Arbre Généalogique .
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO;  use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded ; use Ada.Strings.Unbounded ;
with registre ; use registre ;
with Arbre_Binaire ;


package body Arbre_Genealogique is 

    procedure afficher_cle (cle : in integer) is 
    begin
	put(cle,1);
    end ;

---------------------------------------------------------------------------------------------------------------------------------

    function Est_individu_present (Abr : in T_Arbre_genealogique ; id : in integer) return boolean is
    begin 
	return Est_Present (Abr , id);
    end ;


---------------------------------------------------------------------------------------------------------------------------------


    
    procedure Creer_Arbre_minimal (Abr : out T_Arbre_genealogique ; id : in integer) is 
    begin 
         creer_arbre_minimal_binaire (Abr,id) ;
    end ;

---------------------------------------------------------------------------------------------------------------------------------

    procedure Ajouter_pere (Abr : in out T_Arbre_genealogique ; id_fils : in integer ; id_pere : in integer)is
    begin
	Ajouter_fils_Gauche(Abr, id_fils , id_pere);
    exception
	   when fils_Gauche_present => raise pere_present ;
	   when Cle_Absente => raise id_absent ;
	   when Cle_presente => raise id_present ;
    end ;

---------------------------------------------------------------------------------------------------------------------------------


    procedure Ajouter_mere (Abr : in out T_Arbre_genealogique ; id_fils : in integer ; id_mere : in integer)is
    begin
	Ajouter_fils_Droit(Abr, id_fils , id_mere);
   
    exception
	when fils_Droit_present => raise mere_presente ;
	when Cle_Absente => raise id_absent ;
        when Cle_presente => raise id_present ;
    end ;

---------------------------------------------------------------------------------------------------------------------------------


    function Obtenir_nombre_ancetre (Abr : in T_Arbre_genealogique ; id : in integer ) return integer is
    begin
	return obtenir_nombre_fils(Abr,id);
    exception
	when Cle_Absente => raise id_absent ;
    end ;

---------------------------------------------------------------------------------------------------------------------------------



    procedure obtenir_ensemble_ancetre_generation (Abr : in T_Arbre_genealogique ; id : in integer ; Generation : in Natural) is 
    begin
        obtenir_ensemble_fils_niveau(Abr,id,Generation) ;
    exception
	when Cle_Absente => raise id_absent ;
    end ;

    
---------------------------------------------------------------------------------------------------------------------------------
    


    procedure afficher_arbre_entier( Abr : in T_Arbre_genealogique) is 
    begin
	afficher_Tous_arbre (Abr ) ;
    end ;


---------------------------------------------------------------------------------------------------------------------------------
    

     procedure afficher_arbre_genealogique (Abr : in T_Arbre_genealogique ; id : in integer ) is
     begin
	afficher_arbre(Abr,id);
     exception
	when Cle_Absente => raise id_absent ;
     end ;


---------------------------------------------------------------------------------------------------------------------------------
     


      procedure supprimer_sous_arbre_genealogique (Abr : in out T_Arbre_genealogique ; id : in integer) is
      begin
	 Supprimer_Sous_Arbre(Abr,id);
      exception
	 when Cle_Absente => raise id_absent ;
      end ;


---------------------------------------------------------------------------------------------------------------------------------



      procedure obtenir_ensemble_1_parent ( Abr : in T_Arbre_genealogique) is
      begin
	  obtenir_ensemble_1_fils(Abr);
      end ;


---------------------------------------------------------------------------------------------------------------------------------
      

      procedure obtenir_ensemble_2_parent ( Abr : in T_Arbre_genealogique) is
      begin
	 obtenir_ensemble_2_fils(Abr);
      end ;


---------------------------------------------------------------------------------------------------------------------------------


      procedure obtenir_ensemble_0_parent ( Abr : in T_Arbre_genealogique) is
      begin
	 obtenir_ensemble_0_fils(Abr);
      end ;

---------------------------------------------------------------------------------------------------------------------------------


      
       procedure identifier_ancetre_n_generation ( Abr : in T_Arbre_genealogique ; id : in integer ; n : Natural ) is
       begin 
	   identifier_fils_n_niveau( Abr, id ,n );
       exception
	     when Cle_Absente => raise id_absent ;
       end ;

        
-------------------------------------------------------------------------------------------------------------------------------------------------------------------   
    
       function ancetre_homonymes (Abr : in T_Arbre_genealogique ; registre : in T_registre ; individu_1 : in integer ; individu_2 : in integer ) return boolean is 
	  
---------------------------------------------------------------------------------------------------------------------------------------------------------------
	procedure comparer_donnee ( id : in integer ; Abr : in T_Arbre_genealogique ; reg : in T_registre ; Res : out boolean )is 
	begin
	    if Est_vide(Abr)  then
                Null;
	    else
                if obtenir_nom (reg , id ) = obtenir_nom (reg, obtenir_cle(Abr)) and obtenir_prenom (reg , id ) = obtenir_prenom (reg, obtenir_cle(Abr)) then
                    Res := True;
                else
		    comparer_donnee (id , obtenir_arbre_gauche (Abr), reg, Res);
                    comparer_donnee (id, obtenir_arbre_droit (Abr), reg, Res);
                end if;
            end if;
	end ;


        procedure recherche_homonyme (Ab1 , Ab2 : in T_Arbre_genealogique ; reg : in T_Registre ; Res : out Boolean) is
        begin
            if Est_vide(Ab1)  then
                Null;
            else
                comparer_donnee (obtenir_cle (Ab1) , Ab2, reg , Res);
                recherche_homonyme (obtenir_arbre_gauche (Ab1), Ab2, reg, Res);
                recherche_homonyme (obtenir_arbre_droit (Ab1), Ab2, reg, Res);
            end if;
        end recherche_homonyme ;

---------------------------------------------------------------------------------------------------------------------------------------------------------------
        Ab1, Ab2 : T_Arbre_genealogique;
        Res : Boolean;

       begin 
	   if Est_vide (Abr) then
            raise id_absent;
        elsif not Est_present (Abr, individu_1) or not Est_present (Abr, individu_2) then
            Raise id_absent;
        else
            Res := False;
	    Ab1:= Le_Noeud(Abr, individu_1);
	    Ab2:= Le_Noeud(Abr, individu_2);
            recherche_homonyme (Ab1, Ab2, registre , Res);
            return Res;
        end if;
    end ;



-------------------------------------------------------------------------------------------------------------------------------------------------------------------


	 function taille (Abr : in T_Arbre_Genealogique) return Integer is 
	 begin
	     return Taille_Arbre(Abr) ;
	 end ;


---------------------------------------------------------------------------------------------------------------------------------

	 

	  procedure vider(Abr : in out T_Arbre_Genealogique) is 
	  begin
	      vider_arbre(Abr);
	  end ;

---------------------------------------------------------------------------------------------------------------------------------


	  function Est_arbre_vide(Abr : in T_Arbre_Genealogique) return boolean is
	  begin
	     return Est_vide(Abr) ;
	  end ;


end Arbre_Genealogique ;



