with Ada.Text_IO;          use Ada.Text_IO;
with Ada.Integer_Text_IO;  use Ada.Integer_Text_IO;
with Arbre_Binaire;



procedure Test_Arbre_Binaire is

    
    procedure afficher_cle (cle : in character) is 
    begin
	put(cle);
    end ;

    
    package Arbre_Binaire_caracteres is 
	new Arbre_Binaire(Character,afficher_cle);
    use Arbre_Binaire_caracteres;



    function Cle_Utilisee (Abr : in T_Arbre_Binaire ; Cle : in Character) return boolean is
    n: Integer;
    begin
	n := obtenir_nombre_fils(Abr,Cle);
	return True;
    exception
	when Cle_Absente => return False;
    end  Cle_Utilisee;


    -- Créer l'arbre des caractères de A à G , en partant de gauche à droite, avec la clé racine 'A',
    -- Vérifier la présence des éléments.
    -- Vérifier la taille de l'arbre.
    
    procedure Creer_Arbre_caracteres (Abr : out T_Arbre_Binaire) is
    begin
	      
	      creer_arbre_minimal_binaire( Abr , 'A');
	      pragma Assert (Not Est_vide(Abr));
	      pragma Assert (taille_Arbre ( Abr) = 1);
	      pragma Assert (Est_Present(Abr , 'A'));

	      Ajouter_fils_Gauche (Abr,'A' , 'B');
	      pragma Assert (Est_Present(Abr , 'B'));
	      pragma Assert (taille_Arbre ( Abr) = 2);

	   --  Ajouter_fils_Gauche (Abr, 'A' , 'Z');         à décommenter pour voir l'exeption
	   --  pragma Assert (Not Est_Present(Abr, 'Z'));
	   --  pragma Assert (taille_Arbre ( Abr) = 2);


	      Ajouter_fils_Droit (Abr,'A' , 'C');
	      pragma Assert (Est_Present(Abr , 'C'));
	      pragma Assert (taille_Arbre ( Abr) = 3);


	      Ajouter_fils_Gauche (Abr,'B' , 'D');
	      pragma Assert (Est_Present(Abr , 'D'));
	      pragma Assert (taille_Arbre ( Abr) = 4);


	      Ajouter_fils_Droit (Abr,'B' , 'E');
	      pragma Assert (Est_Present(Abr , 'E'));
	      pragma Assert (taille_Arbre ( Abr) = 5);


	      Ajouter_fils_Gauche (Abr,'C' , 'F');
	      pragma Assert (Est_Present(Abr , 'F'));
	      pragma Assert (taille_Arbre ( Abr) = 6);


	      Ajouter_fils_Droit (Abr,'C' , 'G');
	      pragma Assert (Est_Present(Abr , 'G'));
	      pragma Assert (taille_Arbre ( Abr) = 7);
	      
	      pragma assert (obtenir_nombre_fils (Abr ,'B')= 3 );
              pragma assert (obtenir_nombre_fils (Abr ,'A')= 7 );
	      pragma assert (obtenir_nombre_fils (Abr ,'C') = 3 );
	      pragma assert (obtenir_nombre_fils (Abr ,'D' )= 1 );
	      pragma assert (obtenir_nombre_fils (Abr ,'E')= 1 );



	  --    Ajouter_fils_Droit (Abr,'C' , 'T');
	  --    pragma Assert (Not Est_Present(Abr , 'T'));    à décommenter pour voir l'exeption
	  --   pragma Assert (taille_Arbre ( Abr) = 7);


    end Creer_Arbre_caracteres;



    -- Tester la procedure identifier_fils_n_niveau
    
    
    procedure tester_identifier_fils_n_niveaux is 
	Abr : T_Arbre_Binaire ;
    begin
	put("------------ Tester l'ensemble des fils sur n niveaux ---------------"); 
	new_line ;
	new_line ;
	New_line ;
	Creer_Arbre_caracteres (Abr);
	put("------------ les fils de la cle A sur 1 niveau  ---------------");
	New_line ;
	identifier_fils_n_niveau ( Abr , 'A', 1) ;
	New_line ;
	put("------------ les fils de la cle A sur 2 niveaux  ---------------");
	New_line ;
	identifier_fils_n_niveau (Abr ,'A', 2) ;
	New_line ;
	put("------------ les fils de la cle A sur 4 niveaux  ---------------");
	New_line ;
	identifier_fils_n_niveau (Abr ,'A', 4) ;
	new_line ;
	put("------------ les fils de la cle B sur 1 niveau  ---------------");
        New_line ;
	identifier_fils_n_niveau (Abr ,'B', 1) ;
	new_line ;
        put("------------ les fils de la cle C sur 1 niveau  ---------------");
        New_line ;
	identifier_fils_n_niveau (Abr ,'C', 1) ;
	new_line ;
	New_line ;
	new_line ;

    end ;
	



    -- Tester la procedure obtenir_ensemble_fils_niveau 
     
    
    procedure tester_ensemble_fils_niveau is 
	Abr : T_Arbre_Binaire ;
    begin
	put("------------ Tester l'ensemble des fils dans un niveau ---------------"); 
	new_line ;
	new_line ;
	New_line ;
	Creer_Arbre_caracteres (Abr);
        put("------------ les fils de la cle A dans le 1er niveau  ---------------");
	New_line ;
	obtenir_ensemble_fils_niveau (Abr ,'A', 1) ;
	New_line ;
	put("------------ les fils de la cle A dans le 2eme niveau  ---------------");
	New_line ;
	obtenir_ensemble_fils_niveau (Abr ,'A', 2) ;
	New_line ;
	put("------------ les fils de la cle A dans le 4eme niveau  ---------------");
	New_line ;
	obtenir_ensemble_fils_niveau (Abr ,'A', 4) ;
	new_line ;
	put("------------ les fils de la cle B dans le 1er niveau  ---------------");
        New_line ;
	obtenir_ensemble_fils_niveau (Abr ,'B', 1) ;
	new_line ;
        put("------------ les fils de la cle C dans le 1er niveau  ---------------");
        New_line ;
	obtenir_ensemble_fils_niveau (Abr ,'C', 1) ;
	new_line ;
	New_line ;
	new_line ;	

    end ;




    
    
    -- Vider l'arbres des caractères après son utilsation

    procedure Tester_Vider is
	Abr : T_Arbre_Binaire;
    begin

	Creer_Arbre_caracteres (Abr);
	vider_arbre (Abr);
	pragma Assert (Est_vide(Abr));
	pragma Assert ( Taille_Arbre(Abr) = 0);

    end Tester_Vider;

    -- Tester la supression des sous-arbres à partir d'une clé donnée.

    procedure Tester_Suppression is
	Abr : T_Arbre_Binaire;
    begin

        New_Line;
	Put_Line ( "_____Creer un arbre de caracteres_____");
	New_line ;
	Creer_Arbre_caracteres(Abr);
	afficher_arbre(Abr,'A');
	New_line ;
	Put_Line ( "_____Tester la suppression d'un sous arbre____");
	New_line;
	put_line ("_____ Affichage de l'arbre apres suppression de E _____");
        New_Line;
	New_Line;
	Supprimer_Sous_Arbre(Abr,'E');
	pragma Assert (Not Est_vide(Abr));
	pragma Assert (Not Est_Present(Abr ,'E'));
	pragma Assert (taille_Arbre (Abr) = 6 );
	afficher_arbre(Abr,'A');
	New_Line;
	New_Line;

        put_line ("_____ Affichage de l'arbre apres suppression de B et D _____");
	New_Line;
	New_Line;

        Supprimer_Sous_Arbre(Abr,'B');
	pragma Assert (Not Est_vide(Abr));
	pragma Assert (Not Est_Present(Abr ,'B'));
	pragma Assert (Not Est_Present(Abr ,'D'));
	pragma Assert (Est_Present(Abr ,'F'));
	pragma Assert (taille_Arbre ( Abr) = 4);
	afficher_arbre(Abr,'A');
	New_Line;
	New_Line;

 
    end Tester_Suppression;



    -- Tester le nombre de fils appartenant à un niveau n d'une clé donnée.
    
    procedure nombre_fils is
	Abr : T_Arbre_Binaire;
    begin

        Put_Line(" _____Creer un autre arbre de caracteres_____");
	New_Line;
	Creer_Arbre_caracteres(Abr);
	afficher_arbre(Abr,'A');
	New_Line;

	Put_Line("_____Obtenir le nombre de fils de 'A' , 'B' et 'D'_____");
	New_Line;
	pragma Assert ( 7 = obtenir_nombre_fils (Abr ,'A'));
	Put_Line ( " Le nombre de fils de A, lui compris, est 7");

	pragma Assert ( 3 = obtenir_nombre_fils (Abr ,'B'));
	Put_Line ( " Le nombre de fils de B ,lui compris, est 3");

	pragma Assert ( 1 = obtenir_nombre_fils (Abr ,'D'));
	Put_Line ( " Le nombre de fils de D, lui compris, est 1");

	obtenir_ensemble_1_fils(Abr) ;

  
    end nombre_fils;


begin
 
    tester_identifier_fils_n_niveaux ;
    tester_ensemble_fils_niveau ;
    Tester_Vider;
    tester_Suppression;
    nombre_fils;


end Test_Arbre_Binaire ;


