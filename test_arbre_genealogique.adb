with Ada.Text_IO;          use Ada.Text_IO;
with Ada.Integer_Text_IO;  use Ada.Integer_Text_IO;
with Arbre_Genealogique;   use Arbre_Genealogique;
with Arbre_Binaire;


procedure Test_Arbre_Genealogique is
    
    
    function id_Utilise (Abr : in T_arbre_Genealogique ; id : in Integer) return boolean is
	     n: Integer;
    begin
	n := obtenir_nombre_ancetre (Abr,id); --la fonction obtenir_nombre_ancetre lève une exception 
	                                      --si id n'existe pas dans l'arbre (exception id_absent).
	return True;
    exception
	when id_absent => return False;
    end  id_Utilise;


    -- Créer l'arbre des entiers de 1 à 7 , en partant de gauche à droite, avec la clé racine '1',
    -- Vérifier la présence des éléments.
    -- Vérifier la taille de l'arbre.
    
    procedure Creer_Arbre_entiers (Abr : out T_Arbre_Genealogique) is
    begin
	      
	      creer_arbre_minimal( Abr , 1);
	      pragma Assert (Not Est_arbre_vide(Abr));

	      Ajouter_pere (Abr, 1 , 2);


	 --     Ajouter_pere (Abr, 1 , 11); à décommenter pour voir l'exception


	      Ajouter_mere (Abr,1 , 3);


	      Ajouter_pere (Abr, 2 , 4);


	      Ajouter_mere (Abr, 2 , 5);


	      Ajouter_pere (Abr,3,6);



	      Ajouter_mere (Abr,3,7);


        --     Ajouter_mere (Abr,3 , 15); à décommenter pour voir l'exception


    end Creer_Arbre_entiers;


    -- Tester la procedure identifier_ancetre_n_generation 
    
    
    procedure tester_identifier_ancetre_n_generation   is 
	Abr : T_Arbre_Genealogique ;
    begin
	put("------------ Tester l'ensemble des ancêtres sur n generations ---------------"); 
	new_line ;
	new_line ;
	New_line ;
	Creer_Arbre_entiers(Abr);
	put("------------ les parents de l'individu 1 sur 1 generation  ---------------");
	New_line ;
	identifier_ancetre_n_generation ( Abr ,1 , 1) ;
	New_line ;
	put("------------ les parents de l'individu sur 2 generations  ---------------");
	New_line ;
        identifier_ancetre_n_generation  (Abr ,1, 2) ;
	New_line ;
	put("------------ les ancêtres de l'individu 1 sur 4 generations  ---------------");
	New_line ;
	identifier_ancetre_n_generation  (Abr ,1 , 4) ;
	new_line ;
	put("------------ les ancêtres de l'individu 2 sur 1 generation  ---------------");
        New_line ;
	identifier_ancetre_n_generation (Abr ,2, 1) ;
	new_line ;
        put("------------ les ancêtres de l'individu 3 sur 1 generation ---------------");
        New_line ;
	identifier_ancetre_n_generation (Abr ,3, 1) ;
	new_line ;
	New_line ;
	new_line ;

    end ;
	



    -- Tester la procedure obtenir_ensemble_ancetre_generation      
    
    procedure tester_obtenir_ensemble_ancetre_generation is 
	Abr : T_Arbre_Genealogique ;
    begin
	put("------------ Tester l'ensemble des ancêtres dans une génération ---------------"); 
	new_line ;
	new_line ;
	New_line ;
	Creer_Arbre_entiers(Abr);
        put("------------ les ancêtres de l'individu 1 dans la 1ere génération ---------------");
	New_line ;
	obtenir_ensemble_ancetre_generation (Abr ,1, 1) ;
	New_line ;
	put("------------ les ancêtres de l'individu 1 dans la 2eme generation  ---------------");
	New_line ;
	obtenir_ensemble_ancetre_generation (Abr ,1, 2) ;
	New_line ;
	put("------------ les ancêtres de l'individu 1 dans la 4eme generation  ---------------");
	New_line ;
	obtenir_ensemble_ancetre_generation (Abr ,1, 4) ;
	new_line ;
	put("------------ les ancêtres de l'individu 2 dans la 1ere generation  ---------------");
        New_line ;
	obtenir_ensemble_ancetre_generation (Abr ,2, 1) ;
	new_line ;
        put("------------ les ancêtres de l'individu 3 dans la 1ere generation  ---------------");
        New_line ;
	obtenir_ensemble_ancetre_generation (Abr ,3, 1) ;
	new_line ;
	New_line ;
	new_line ;	

    end ;




    -- Vider l'arbres des caractères après son utilsation

    procedure Tester_Vider is
	Abr : T_Arbre_Genealogique;
    begin

	Creer_Arbre_entiers(Abr);
	vider(Abr);
	pragma Assert (Est_arbre_vide(Abr));

    end Tester_Vider;



    -- Tester la supression des sous-arbres à partir d'une clé donnée.

    procedure Tester_Suppression is
	Abr : T_Arbre_Genealogique;
    begin
        
	Put_Line ( "_____Tester la suppression d'un sous arbre____");
	Put_Line ( "_____Creer un arbre des entiers_____");
	Creer_Arbre_entiers(Abr);
	afficher_arbre_genealogique(Abr,1);
	New_Line;
	New_Line;

	Supprimer_Sous_Arbre_Genealogique(Abr,5);
	pragma Assert (Not Est_arbre_vide(Abr));
	afficher_arbre_genealogique(Abr,1);
	New_Line;
	New_Line;

	Supprimer_Sous_Arbre_Genealogique(Abr,2);
	pragma Assert (Not Est_arbre_vide(Abr));
	afficher_arbre_genealogique(Abr,1);
	New_Line;
	New_Line;

 
    end Tester_Suppression;



    -- Tester le nombre de fils appartenant à un niveau n d'une clé donnée.
    
    procedure nombre_ancetre is
	Abr : T_Arbre_Genealogique;
    begin

        Put_Line(" _____Creer un autre arbre des entiers_____");
	Creer_Arbre_entiers(Abr);

	Put_Line("_____Obtenir le nombre de fils de 1 , 2 et 4 _____");
	pragma Assert ( 7 = Obtenir_nombre_ancetre (Abr ,1));
	Put_Line ( " Le nombre de fils de 1, lui compris, est 7");

	pragma Assert ( 3 = Obtenir_nombre_ancetre (Abr ,2));
	Put_Line ( " Le nombre de fils de 2 ,lui compris, est 3");

	pragma Assert ( 1 = Obtenir_nombre_ancetre (Abr ,4));
	Put_Line ( " Le nombre de fils de 4, lui compris, est 1");
  
    end nombre_ancetre;


begin

    tester_identifier_ancetre_n_generation ;
    tester_obtenir_ensemble_ancetre_generation ;
    Tester_Vider;
    Tester_Suppression;
    nombre_ancetre;

end Test_Arbre_Genealogique ;

