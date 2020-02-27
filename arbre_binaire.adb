with Ada.Integer_Text_IO;  use Ada.Integer_Text_IO;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Unchecked_Deallocation;

package body Arbre_Binaire is
   
       
    procedure free is
	new Ada.Unchecked_Deallocation (Object => T_Noeud, Name => T_Arbre_Binaire);


----------------------------------------------------------------------------------------------------------------------
    
    function Est_Present (Abr :in T_Arbre_Binaire ; Cle : in T_Cle) return boolean is

    begin
	if Abr = Null then
	   return false;
	elsif Abr.all.Cle = Cle then
	    return True;
	else 
	    return Est_Present(abr.all.Sous_Arbre_Gauche,Cle) or Est_Present(Abr.all.Sous_Arbre_Droit,Cle);
	end if;
	
    end Est_Present;
    
----------------------------------------------------------------------------------------------------------------------

    procedure creer_arbre_minimal_binaire (Abr :out T_Arbre_Binaire ; Cle : in T_Cle) is
    begin
	Abr := new T_Noeud'(Cle, Null , Null); 	
    end ;

----------------------------------------------------------------------------------------------------------------------

    function Le_Noeud(Abr: in T_Arbre_Binaire ; Cle : in T_Cle) return T_Arbre_Binaire is
	arbre : T_Arbre_Binaire;
    begin

        if Est_Present(Abr,Cle) then
	    if Abr.all.Cle = Cle then
	          arbre := Abr;
	    
	    elsif Est_Present(Abr.all.Sous_Arbre_Gauche,Cle) then
		  arbre := Le_Noeud(Abr.all.Sous_Arbre_Gauche, Cle);

	    elsif Est_Present(Abr.all.Sous_Arbre_Droit,Cle) then 
	          arbre := Le_Noeud(Abr.all.Sous_Arbre_Droit, Cle);
	    end if;

	else 
	    raise Cle_absente;
	end if;

	return arbre;

   end Le_Noeud; 
	    
----------------------------------------------------------------------------------------------------------------------



    procedure Ajouter_fils_Gauche(Abr : in out T_Arbre_Binaire ; Cle : in  T_Cle ; Cle_fils_Gauche :in T_Cle) is
	
    begin
	    if Est_Present(Abr,Cle_fils_Gauche) then
		raise fils_Gauche_present;
	    elsif not Est_Present(Abr,Cle) then
		raise Cle_Absente;

	    else 

		if Abr.all.Cle = Cle then

		   if Abr.all.Sous_Arbre_Gauche /= Null then
		       raise fils_Gauche_Present;
		   else 
		       Abr.all.Sous_Arbre_Gauche := new T_Noeud'(Cle_fils_Gauche, Null , Null);
		   end if;

		elsif Est_Present(Abr.all.Sous_Arbre_Gauche , Cle) then
		   Ajouter_fils_Gauche(Abr.all.Sous_Arbre_Gauche, Cle , Cle_fils_Gauche);

		else 
                   Ajouter_fils_Gauche(Abr.all.Sous_Arbre_Droit , Cle , Cle_fils_Gauche); 

		end if;

	    end if;
	  
    end Ajouter_fils_Gauche;

----------------------------------------------------------------------------------------------------------------------


     procedure Ajouter_fils_Droit(Abr : in out T_Arbre_Binaire ; Cle : in  T_Cle ; Cle_fils_Droit :in T_Cle ) is
         
     begin
	    if Est_Present(Abr,Cle_fils_Droit) then
		raise fils_Droit_present ;
	    elsif not Est_Present(Abr,Cle) then
		raise Cle_Absente;

	    else 

		if Abr.all.Cle = Cle then

		   if Abr.all.Sous_Arbre_Droit /= Null then
		       raise fils_Droit_Present; 
		   else 
		       Abr.all.Sous_Arbre_Droit := new T_Noeud'(Cle_fils_Droit, Null , Null);
		   end if;

		elsif Est_Present(Abr.all.Sous_Arbre_Droit , Cle) then
		   Ajouter_fils_Droit(Abr.all.Sous_Arbre_Droit , Cle, Cle_fils_Droit);

		else 
                   Ajouter_fils_Droit(Abr.all.Sous_Arbre_Gauche , Cle , Cle_fils_Droit); 

		end if;

	    end if;
         
     end Ajouter_fils_Droit;


----------------------------------------------------------------------------------------------------------------------



     function obtenir_nombre_fils (Abr: in T_Arbre_Binaire ; Cle : in T_Cle) return Integer is
       n : integer ;
       begin
           n := Taille_Arbre(Le_noeud(Abr,Cle)) ;
           return n ;
       end ;



----------------------------------------------------------------------------------------------------------------------

    
     function max (a :in integer; b : in integer) return integer is 
     begin 
	 if a>=b then 
	     return a ;
	 else 
	     return b ;
         end if ;
     end ;

----------------------------------------------------------------------------------------------------------------
    
     function hauteur(Abr: in T_Arbre_binaire) return integer is 
     begin

	 if Abr = Null then
	     return 0 ;
	 else
	     return 1 + max(hauteur(Abr.all.sous_arbre_gauche),hauteur(Abr.all.sous_arbre_droit)) ;
	 end if ;

     end ;


----------------------------------------------------------------------------------------------------------------------

     procedure obtenir_ensemble_fils_niveau (Abr: in T_Arbre_Binaire ; Cle : in T_Cle ; niveau : in Natural ) is
	 n : Integer;
	 Noeud : T_Arbre_Binaire;
     begin

	 if Est_Present(Abr,Cle) then
	     n:= niveau;
	     if n = 0 then
		 afficher_Cle(Cle);
		 put("  ") ;
		 
	     else
		 Noeud := Le_Noeud(Abr,Cle);
		 n := n-1;

		 if Noeud.all.Sous_Arbre_Droit /= Null then
		    obtenir_ensemble_fils_niveau(Abr, Noeud.all.Sous_Arbre_Droit.all.Cle, n);
		 end if;
		 
		 if Noeud.all.Sous_Arbre_Gauche /= Null then
		     obtenir_ensemble_fils_niveau(Abr, Noeud.all.Sous_Arbre_Gauche.all.Cle, n);
		 end if;
	     end if;

	 else
	     raise Cle_Absente;
	 end if;
		  
     end obtenir_ensemble_fils_niveau;
          
---------------------------------------------------------------------------------------------------------------------


     procedure Supprimer_Sous_Arbre (Abr : in out T_Arbre_Binaire ; Cle : in T_Cle) is
     begin
	    if not Est_present(Abr,Cle) then 
		raise Cle_absente ;
	    else
	        if Abr = Null then 
	           Null ;
	        elsif Abr.all.Cle = Cle then
	           vider_arbre(Abr);
	        else 
		   if Est_present(Abr.all.sous_arbre_gauche,Cle) then
		       Supprimer_Sous_Arbre (Abr.all.sous_arbre_gauche , Cle ) ;
		   else 
	               Supprimer_Sous_Arbre (Abr.all.sous_arbre_droit , Cle ) ;
		   end if ;
	        end if ;
	    end if ;
     end ;
  
----------------------------------------------------------------------------------------------------------------------

     function Est_vide (Abr : in T_Arbre_Binaire) return boolean is
	 vide : Boolean;
     begin
	 
	 if Abr = Null then
	     vide := True;
	 else
	     vide := False;
	 end if;
	 return vide;

     end Est_Vide;

-----------------------------------------------------------------------------------------------------------------------

   
     procedure vider_arbre(Abr: in out T_Arbre_Binaire) is
     begin
	 if Abr = Null then
	     Null ;
	 else
	     vider_arbre(Abr.all.sous_arbre_gauche);
	     vider_arbre(Abr.all.sous_arbre_droit);
	     free(Abr);	     
	 end if ;
     end;

        

-----------------------------------------------------------------------------------------------------------------------
    
     function nombre_fils(Abr : in T_Arbre_Binaire ; Cle : in T_Cle) return integer is
	 Noeud : T_Arbre_Binaire;
	 n : Integer;
     begin
	     n := 0;
	     Noeud := Le_Noeud(Abr,Cle);

	     if Noeud.all.Sous_Arbre_Gauche /= Null then
	         n := n + 1;
	     end if ;
	     
	     if Noeud.all.Sous_Arbre_Droit /= Null then 
	         n:= n + 1;
	     end if;

	     return n ;

     end nombre_fils;


------------------------------------------------------------------------------------------------------------------------     
      
     procedure obtenir_ensemble_1_fils (Abr : in T_Arbre_Binaire) is
     	 
     begin
	if Abr = Null then 
	    Null ;      
	else
	    if nombre_fils(Abr , Abr.All.Cle) = 1 then
	        Afficher_Cle(Abr.all.Cle);
		put(" ");
	    end if ;
	    obtenir_ensemble_1_fils (Abr.all.Sous_Arbre_Gauche);
	    obtenir_ensemble_1_fils (Abr.all.Sous_Arbre_Droit);
	end if;

     end obtenir_ensemble_1_fils;

-------------------------------------------------------------------------------------------------------------------------

     procedure obtenir_ensemble_2_fils (Abr : in T_Arbre_Binaire) is

     begin
	  
	if Abr = Null then
	    Null ;
	else 
	    if nombre_fils(Abr , Abr.All.Cle) = 2  then
	        Afficher_Cle(Abr.Cle);
		put(" ");
	    end if ;
	    obtenir_ensemble_2_fils (Abr.all.Sous_Arbre_Gauche);
	    obtenir_ensemble_2_fils (Abr.all.Sous_Arbre_Droit);
	 end if;

     end obtenir_ensemble_2_fils ;
-------------------------------------------------------------------------------------------------------------------------

     procedure obtenir_ensemble_0_fils (Abr : in T_Arbre_Binaire) is
     	 
     begin

	if Abr = Null then
	    Null ;
	else
	    if nombre_fils (Abr , Abr.All.Cle) = 0 then
	        Afficher_Cle(Abr.all.Cle);
		put(" ");
	    end if ;
	    obtenir_ensemble_0_fils (Abr.all.Sous_Arbre_Gauche);
	    obtenir_ensemble_0_fils (Abr.all.Sous_Arbre_Droit);
	 end if;

     end obtenir_ensemble_0_fils ;

---------------------------------------------------------------------------------------------------------------------------

     procedure identifier_fils_n_niveau ( Abr : in T_Arbre_Binaire ; Cle : in T_Cle ; n : in Natural ) is
	 Noeud : T_Arbre_Binaire;  
	 niveau : Integer ; 
     begin
	  
	  Noeud := Le_Noeud(Abr,Cle);
	  afficher_Cle(Cle);
	  put("  ");
	  niveau := n;
	  For i in 1..niveau loop
	      niveau := niveau - 1;
	      if Noeud.all.Sous_Arbre_Gauche /= Null then 
	         obtenir_ensemble_fils_niveau(Abr, Noeud.all.Sous_Arbre_Gauche.all.Cle, niveau);
	      end if ;
	      if Noeud.all.Sous_Arbre_Droit /= Null then 
	          obtenir_ensemble_fils_niveau(Abr, Noeud.all.Sous_Arbre_Droit.all.Cle, niveau);
	      end if ;
	  end loop;

     end identifier_fils_n_niveau;

-------------------------------------------------------------------------------------------------------------------------------  


      function Taille_Arbre (Abr : in T_Arbre_Binaire) return Integer is
     	begin
  		if Abr = Null then
			return 0;
		else
                	return 1 + Taille_Arbre (Abr.all.Sous_Arbre_Gauche) + Taille_Arbre (Abr.all.Sous_Arbre_Droit);
		end if;
	end Taille_Arbre;


-------------------------------------------------------------------------------------------------------------------------------     
       procedure afficher_Tous_arbre (Abr : in T_Arbre_Binaire ) is
       begin
	   if Abr = Null then 
	       Null ;
	   else
	       Afficher_arbre (Abr,Abr.all.cle) ;
	   end if ;
       end ;
-------------------------------------------------------------------------------------------------------------------------------	
        procedure Afficher_arbre (Abr : in T_Arbre_binaire ; Cle : T_Cle ) is

              ------------------------------------------------------------------------- 

	        procedure Indenter (Decalage : in Integer) is
		begin
			for I in 1..Decalage loop
				Put (' ');
			end loop;
		end Indenter;

	        procedure Afficher_Profondeur (Abr : in T_Arbre_binaire ; Profondeur : in Integer ; Cote : in string) is
		begin
		       if Abr = Null then
				Null;
			else
				Indenter (Profondeur * 4);
				Put (Cote);
				afficher_cle(Abr.all.Cle);
				New_Line;

				Afficher_Profondeur (Abr.all.Sous_Arbre_Gauche, Profondeur + 1, "-- pere : ");
				Afficher_Profondeur (Abr.all.Sous_Arbre_Droit, Profondeur + 1, "-- mere : ");
			end if;
		end Afficher_Profondeur;

		-------------------------------------------------------------------

        courant : T_Arbre_binaire ;
	generation : integer ;

	begin
	    
	    generation := hauteur(Abr);
	    for i in 0..generation-1 loop
		put(i,1);
		put("  ");
	    end loop ;

	    put("generation"); 
	    New_line ;
	    put("---------------------");
	    New_line ;
	    courant := Le_Noeud(Abr,Cle) ;
	    Afficher_Profondeur (courant, 0," ");

	end Afficher_arbre;


------------------------------------------------------------------------------------------------------------------------------
	
      function obtenir_cle (Abr : T_Arbre_Binaire) return T_Cle is
      begin
	  if Abr = Null then
	      raise Cle_absente ;
	  else 
	      return Abr.all.Cle ;
	  end if ;
      end ;

-----------------------------------------------------------------------------------------------------------------------------

    function obtenir_arbre_droit (Abr : T_Arbre_Binaire) return T_Arbre_Binaire is
    begin
	if Abr = Null then 
	    return Abr ;
	else 
	    return Abr.all.Sous_Arbre_Droit ;
	end if ; 
    end ;
-----------------------------------------------------------------------------------------------------------------------------
        
    function obtenir_arbre_gauche (Abr : T_Arbre_Binaire) return T_Arbre_Binaire is
    begin
	if Abr = Null then 
	    return Abr ;
	else 
	    return Abr.all.Sous_Arbre_gauche ;
	end if ; 
    end ;

    
end Arbre_Binaire;
