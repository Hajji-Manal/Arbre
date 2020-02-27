with Ada.integer_text_IO ; use Ada.integer_text_IO ;
with Ada.text_IO ; use Ada.text_IO;
with registre ; use registre ;
with Ada.Strings.unbounded; use Ada.Strings.unbounded;



procedure test_registre is 

 
    
       Nbre_donnee : integer := 5 ;

    -- remplir un regitre par des donnees. 
    
    procedure remplir_registre (reg : out T_registre) is
	
        
	
	donnee1 : T_Donnee ;
	date1 : T_Date ;
	Jour : integer := 10 ;
	mois : T_mois := FEVRIER ; 
	annee : integer := 1956 ;
    sexe : character := 'M' ;
	lieu_naissance : string := "Toulouse";
	identifiant : integer := 1 ;
	nom : string := "nom" ;
	prenom : string := "prenom" ;

    begin
        
	initialiser_registre (reg);
	pragma assert ( Est_vide (reg) ) ;
	for i in 1..Nbre_donnee loop 
         	
	        creer_date (date1 ,jour ,mois , annee);
	        creer_donnee (donnee1, To_unbounded_string(nom) , To_unbounded_string(prenom) ,sexe , date1 , To_unbounded_string(lieu_naissance)) ;
	        ajouter (reg,identifiant,donnee1) ;
		pragma assert (ident_present(reg,identifiant)) ;
		identifiant := identifiant + 1 ;
		jour := jour + 1 ;
	    annee := annee + 1 ;
		pragma assert ( taille (reg) = i ) ;
		afficher_info(reg,i);
		New_line;
		New_line ; 
		New_line ;

	end loop;
	

    end remplir_registre;

  
  
    -- tester les procedures modifier et supprimer des éléments du registre 
    procedure manipuler_registre is

	date : T_Date ;
	jour : integer := 5 ;
	mois : T_mois := MARS ;
	annee : integer := 1986 ;
	reg : T_registre ;
	identifiant : integer := 3 ;
	nom : string := "nom87" ;
	prenom : string := "prenom87" ;
	sexe : character := 'F' ;
	Lieu : string := "Paris" ;




    begin 
	
	 remplir_registre(reg) ;
	 creer_date (date , jour , mois , annee);
	 
	 -- modifier la donnee correspondant à un identifiant. 
	
	 modifier_nom (reg , identifiant ,To_unbounded_string(nom) );
	 pragma assert (obtenir_nom ( reg , identifiant ) = "nom87");
	 modifier_prenom (reg , identifiant ,To_unbounded_string(prenom) );
	 pragma assert (obtenir_prenom ( reg , identifiant ) = "prenom87");
	 modifier_sexe (reg , identifiant, sexe ) ;
	 pragma assert (obtenir_sexe ( reg , identifiant ) = 'F');
	 modifier_date ( reg , identifiant, date) ;
	 pragma assert (obtenir_jour_naissance ( reg , identifiant ) = jour);
	 pragma assert (obtenir_mois_naissance ( reg , identifiant ) = MARS );
	 pragma assert (obtenir_annee_naissance ( reg , identifiant ) = annee);
	 modifier_lieu (reg,identifiant,To_unbounded_string(Lieu));
	 pragma assert (obtenir_lieu_naissance(reg,identifiant) = "Paris");
	 

	 	 
        -- supprimer les identifiants du registre.
	
	 for i in 1..Nbre_donnee loop
	     supprimer (reg ,i) ;
	     for j in 1..i loop
		 pragma assert (not ident_present(reg,j));
	     end loop ;
	     for j in i+1 .. Nbre_donnee loop
		 pragma assert (ident_present(reg,j));
	     end loop; 
	 end loop ;
	-- afficher_info(reg,1);
	 vider_reg (reg);


    end ;

	 -- tester les cas limites.
         
	 procedure cas_limites is 
	
	 reg : T_registre ;
	 donnee2 : T_Donnee ;
	 date : T_Date ;
	 jour : integer := 8 ;
	 mois : T_mois := JANVIER ;
	 annee : integer := 1999 ;

	 begin
	 
	     remplir_registre(reg) ;
             creer_date (date , jour , mois , annee);
	     creer_donnee (donnee2, To_unbounded_string("nom88") ,To_unbounded_string("prenom88") ,'F' , date , To_unbounded_string("MARSEILLE"));

	     --ajouter un identifiant déjà présent
	              -- ajouter(reg ,3,donnee2);                       à décommenter pour voir l'exception 
	     --supprimer un identifiant qui est absent
	              -- supprimer(reg,7);                              à décommenter pour voir l'exception
	     --modifier la donnee d'un identifiant absent 
	              -- modifier (reg , 8 , donnee2);                  à décommenter pour voir l'exception
	     vider_reg (reg) ;

	 
	 end cas_limites ;



    reg2 : T_registre ;


begin

    remplir_registre (reg2);
    pragma assert( taille(reg2) = 5 );
    manipuler_registre ;
    cas_limites ;

end ;
    


