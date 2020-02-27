with arbre_genealogique; use arbre_genealogique ;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded ;use Ada.Strings.Unbounded ;
with registre; use registre ;
with Ada.Characters.Latin_1; use Ada.Characters.Latin_1;


procedure programme_principal is

    nom ,nom_p ,nom_m ,prenom , prenom_p : unbounded_String;
    prenom_m , prenom_r,prenom_d, nom_r, nom_d : unbounded_String;
    sexe, sexe_r, sexe_d: Character;
    date, date_p , date_m , date_r, date_d : T_Date; 
    donnee, donnee_p , donnee_m, donnee_r :  T_Donnee;
    Jour , Jour_p, Jour_m, jour_r, jour_d: Integer ;
    annee , annee_p , annee_m, annee_r, annee_d: Integer; 
    mois, mois_p , mois_m, mois_r, mois_d: T_Mois;
    lieu, lieu_p , lieu_m, lieu_r, lieu_d: unbounded_string;
    choix, choix_6, reponse : character;
    choix_2, choix_3 , choix_4, choix_5 : Integer;
    choix_10, choix_11 , choix_12 , choix_13 ,choix_14 : Integer ;
    id_f1 , id_f2 , id_p , id_m : Integer;
    id ,id1 , id2 , id3 , id4 , id5 , id6 , id7, id8, id9 , id10: Integer;
    id11, id12 , id13: Integer;
    n , nb: Integer;
    g : Natural;
    Abr: T_Arbre_Genealogique;
    reg: T_registre;
    
begin

     loop
	 New_line ;
	 New_line ;
	 put_line(ESC & "[91m" & "------------------------- Bienvenue dans votre espace Répértoire généalogique ------------------------------" & ESC & "[0m"); 
	 New_line ;
	 put("Entrer l'identifiant de la personne : ");
	 get(id);
	 New_line ;
	 New_line ;
	 put_line(ESC & "[92m" & "Veuillez entrer les informations suivantes :" & ESC & "[0m");
	 New_line ;
	 put("Nom : ");
	 skip_line ;
	 nom := To_unbounded_String(get_line);
	 put("Prénom : "); 
	 prenom := To_unbounded_String(get_line);
	 loop
	    put("Sexe (M/F) : ");
	    get(sexe);
	    if sexe /= 'm' and sexe /= 'M' and sexe /= 'f' and sexe /= 'F' then
		put_line("Veuillez saisir M ou F");
	    end if ;
	    exit when sexe = 'm' or sexe = 'M' or sexe = 'f' or sexe = 'F';
	 end loop;
	 put_line("Date de naissance :");
	 put("   Jour : "); -- Il faut boucler
	 get(Jour);
	 put("   Mois : ");
	 loop
	             New_line;
		     put_line(ESC & "[93m"&"         Saisissez un chiffre :"& ESC & "[0m") ;
	             Put_line("    1) Janvier ");
	             Put_line("    2) Fevrier ");
	             Put_line("    3) Mars");
	             Put_line("    4) Avril");
	             Put_line("    5) Mai");
	             Put_Line("    6) Juin");
	             Put_Line("    7) Juillet");
	             Put_Line("    8) août");
	             Put_Line("    9) Septembre");
	             Put_Line("    10) Octobre");
	             Put_Line("    11) Novembre");
	             Put_Line("    12) Decembre") ;
		     New_line ;
		     put(ESC & "[93m"&"  Votre Choix :"& ESC & "[0m") ; 
		     get(choix_10);
		     if choix_10 < 1 or choix_10 >12 then
			 put_line (ESC & "[93m""Veuillez saisir un nombre entre 1 et 12"& ESC & "[0m");
		     end if ;
		     exit when choix_10 < 13 and choix_10 > 0;
         end loop;
     
	 mois := T_Mois'Val(choix_10 - 1);
	 New_Line;
	 put("   Annee : ");
	 get(annee);
	 New_line ;
	 creer_date(date,Jour,mois,annee);
	 put ("Lieu de naissance : ");
	 skip_line ;
	 lieu := To_unbounded_String(get_line);
    	 Creer_Arbre_minimal(Abr,id);
	 initialiser_registre(reg);
	 creer_donnee(donnee,nom,prenom,sexe,date,lieu);
	 ajouter(reg,id,donnee);
	 New_Line;
	 New_line;
	 Put_line(ESC & "[92m" & "-------------------- Merci , vous avez rempli toutes les informations -------------------------"& ESC & "[0m");
	 New_line ;
	 New_line ;
	 loop 

	     loop
		new_line;
		new_line;
	        Put("      Si vous voulez accéder à votre");
		Put(ESC & "[91m"& " arbre généalogique"& ESC & "[0m");
		Put(", tapez");
		Put(ESC & "[91m"&" A ."& ESC & "[0m");
		New_Line;
	        Put("      Si vous voulez accéder au ");
		Put(ESC & "[91m"&"registre"& ESC & "[0m");
		put(", tapez ");
		put(ESC & "[91m"&"R ."& ESC & "[0m");
		New_Line;
		Put("      Si vous voulez ");
		put(ESC & "[91m"&"quitter"& ESC & "[0m");
		put(", tapez ");
		put(ESC & "[91m"&"Q ."& ESC & "[0m");
		New_Line;
	        put ("      Votre choix : ");
		get(choix);
		New_Line;
	        exit when choix = 'Q' or choix = 'q' or choix = 'a' or choix = 'A' or choix = 'r' or choix = 'R';
	     end loop;



	     if choix = 'a' or choix = 'A' then
	        New_line;
	        New_line;
	        Put_Line( ESC & "[91m"&" ---------------------- Bienvenue dans votre arbre généalogique ------------------------ "& ESC & "[0m");
		loop
	          New_line;
		  New_line;
		  
		  loop
	             Put_line( ESC & "[92m"&" Voici les fonctionnalités que vous pouvez utiliser : "& ESC & "[0m");
	             New_line;
	             Put_line("    1) Ajouter un père ");
	             Put_line("    2) Ajouter une mère ");
	             Put_line("    3) Obtenir le nombre d'ancetres d'un individu , lui compris");
	             Put_line("    4) Obtenir l'ensemble d'ancetres appartenant à une génération d'un individu");
	             Put_line("    5) Afficher l'arbre Tout entier ");
		     Put_line("    6) Afficher l'arbre à partir d'un individu ") ;
	             Put_Line("    7) Supprimer un sous arbre");
	             Put_Line("    8) Obtenir l'ensemble des individus ayant un seul parent");
	             Put_Line("    9) Obtenir l'ensemble des individus ayant deux parents");
	             Put_Line("    10) Obtenir l'ensemble des individus n'ayant aucun parent");
	             Put_Line("    11) Obtenir l'ensemble des ancetres d'un individu sur un nombre de générations");
	             Put_Line("    12) Vérifier si deux individus ont un ou plusieurs ancetres homonymes");
	             Put_Line("    13) Vider l'arbre" ) ;
	             Put_Line("    14) Retourner au menu") ;
		     put (ESC & "[92m"&" Votre choix : "& ESC & "[0m");
		     get(choix_2) ;
		     New_line;
		     exit when choix_2 < 15 and choix_2 > 0 ;
		  end loop;
		  case choix_2 is

		      when 1 =>
			  begin
			  Put_line(ESC & "[93m"&"     Vous avez choisi d'ajouter un père "& ESC & "[0m");
			  New_Line;
			  Put("Veuillez entrer l'identifiant du fils : ");-- il faut vérifier que l'utilisateur entre bien un entier;
			  Get(id_f1); --exeption si le fils n'existe pas ou s'il a deja un pere .
			  Put("Veuillez entrer l'identifiant du père : ");
			  Get(id_p);  -- exeption si l'identifiant existe deja .
			  Ajouter_pere (Abr,id_f1,id_p);
            	          put_line( ESC & "[92m"&"Veuillez entrer les informations suivantes :"& ESC & "[0m");
	                  New_line ;
	                  put ("Nom du père : ");
			  skip_line ;
			  nom_p := To_unbounded_String(get_line);
	                  put ("Prénom du père : ");
	                  prenom_p := To_unbounded_String(get_line);
	                  loop
			      put_line("Date de naissance du père: ");
	                      put("   Jour : "); -- Il faut boucler
	                      get(Jour_p);
	                      put_line("   Mois : ");
			      loop
			         put( ESC & "[93m"&"Saisissez un chiffre "& ESC & "[0m");
	                         New_line;
	                         Put_line("    1) Janvier ");
	                         Put_line("    2) Fevrier ");
	                         Put_line("    3) Mars");
	                         Put_line("    4) Avril");
	                         Put_line("    5) Mai");
	                         Put_Line("    6) Juin");
	                         Put_Line("    7) Juillet");
	                         Put_Line("    8) août");
	                         Put_Line("    9) Septembre");
	                         Put_Line("    10) Octobre");
	                         Put_Line("    11) Novembre");
	                         Put_Line("    12) Decembre") ;
			         put (ESC & "[93m"&"Votre choix : "& ESC & "[0m");
		                 get(choix_11);
				 New_Line;
		                 exit when choix_11 < 13 and choix_11 > 0;
                              end loop;
	                  
			      mois_p := T_Mois'Val(choix_11 - 1);

	                      put ("   Annee : ");
	                      get(annee_p);  -- il faut verifier que l'annee est superieur à celui du fils
			      if obtenir_annee_naissance (reg , id_f1 ) <= annee_p then
				  New_line ;
				  New_line ;
				  put_line( ESC & "[91m"&" ATTENTION !! Le père doit être plus âgé que le fils."& ESC & "[0m");
				  put_line(" Veuillez Resaisir la date de naissance du père :");
				  New_line ;
			      end if ;
			      exit when obtenir_annee_naissance(reg , id_f1) > annee_p ;
			  end loop ;

	                  creer_date(date_p,Jour_p,mois_p,annee_p);
	                  put ("Lieu de naissance du père: ");
			  skip_line ;
	                  lieu_p := To_unbounded_String(get_line);
	                  creer_donnee(donnee_p,nom_p,prenom_p,'M',date_p,lieu_p);
	                  New_Line;
	                  Put_line( ESC & "[92m""------------------------ Merci , vous avez rempli toutes les informations du père ------------------------"& ESC & "[0m");
	                  New_line;
			  New_line;
			  New_line;
			  Put_Line(ESC & "[93m"&"Ajout en cours..."& ESC & "[0m");
			  New_line ;
			  New_line ;
                          ajouter(reg,id_p,donnee_p);
			  Put_Line(ESC & "[0m"&"l'ajout du père est effectué avec succès"& ESC & "[0m");
			  New_line;
                          exception
			      when id_absent  => put_line( ESC & "[91m"&" ERREUR !! Le fils n'est pas présent ."& ESC & "[0m");
			      when id_present => put_line(ESC & "[91m"&" ATTENTION !! l'identifiant du père est déjà utilisé ."& ESC & "[0m");
			      when pere_present => put_line(ESC & "[91m"&" ERREUR !! Ce fils possède déjà un père ."& ESC & "[0m");
			      when identifiant_present => put(ESC & "[91m"&" ATTENTION !! le père est déjà présent dans le registre !! "& ESC & "[0m") ;New_line;put_line (" Si vous souhaitez Modifier ces données Veuillez taper 14 puis Q puis 2") ;
			  end ;


		      when 2 =>
			  begin
			  Put_Line( ESC & "[93m"&"    Vous avez choisi d'ajouter une mère"& ESC & "[0m");
			  New_line;
			  Put("Veuillez entrer l'identifiant du fils : ");-- il faut vérifier que l'utilisateur entre bien un entier;
			  Get(id_f2);-- Exeption si l'identifiant n'existe pas ou si il a deja une mere 
			  Put("Veuillez entrer l'identifiant de la mère : ");
			  Get(id_m);   
			  Ajouter_mere(Abr,id_f2,id_m);
            	          put_line(ESC & "[92m"&"Veuillez entrer les informations suivantes :"& ESC & "[0m");
	                  New_line;
	                  put("Nom mère : ");
			  skip_line;
	                  nom_m := To_unbounded_String(get_line);
	                  put ("Prénom mère : ");
	                  prenom_m := To_unbounded_String(get_line);
	                  loop
			     put ("Date de naissance mère :");
	                     New_line;
	                     put ("   Jour : "); -- Il faut boucler
	                     get(Jour_m);
	                     put ("   Mois : ");
	                     loop
	                        New_line;
			        put_line( ESC & "[93m"&"Saisissez un chiffre "& ESC & "[0m");
	                        Put_line("    1) Janvier ");
	                        Put_line("    2) Fevrier ");
	                        Put_line("    3) Mars");
	                        Put_line("    4) Avril");
	                        Put_line("    5) Mai");
	                        Put_Line("    6) Juin");
	                        Put_Line("    7) Juillet");
	                        Put_Line("    8) août");
	                        Put_Line("    9) Septembre");
	                        Put_Line("    10) Octobre");
	                        Put_Line("    11) Novembre");
	                        Put_Line("    12) Decembre") ;
			        put (ESC & "[93m"&"Votre choix : "& ESC & "[0m");
		                get(choix_12);
				New_line;
		                exit when choix_12 < 13 and choix_12 > 0;
                             end loop;

	                     mois_m := T_Mois'Val(choix_12 - 1) ;
	                     put ("   Annee : "); -- exeption si l'annee est inférieur a celle du fils
	                     get(annee_m);
			     if obtenir_annee_naissance (reg , id_f2 ) <= annee_m then
				  New_line ;
				  New_line;
				  put_line(ESC & "[91m"&" ATTENTION !! Le mère doit être plus âgé que le fils."& ESC & "[0m");
				  put_line(ESC & "[91m"&" Veuillez Resaisir la date de naissance du mère :"& ESC & "[0m");
				  New_line ;
			     end if ;
			     exit when obtenir_annee_naissance(reg , id_f2) > annee_m ;
			  end loop ;

	                  creer_date(date_m,Jour_m,mois_m,annee_m);
	                  put("Lieu de naissance de la mère : ");
			  Skip_line ;
	                  lieu_m := To_unbounded_String(get_line);
			  creer_donnee(donnee_m,nom_m,prenom_m,'F',date_m,lieu_m);
	                  New_Line;
	                  Put_line(ESC & "[92m"&"    Merci , vous avez rempli toutes les informations de la mère "& ESC & "[0m");
			  New_line ;
			  new_line ;
			  new_line ; 
	                  Put_Line(ESC & "[93m""  Ajout en cours..."& ESC & "[0m");
			  New_line ;
			  New_line ;
                          ajouter(reg,id_m,donnee_m); 
			  Put_Line(ESC & "[93m"&"  l'ajout de la mère est effectué avec succès "& ESC & "[0m");
			  New_line;
			  exception
			      when id_absent  => put_line( ESC & "[91m"&" ERREUR !! Le fils n'est pas présent ."& ESC & "[0m");
			      when id_present => put_line(ESC & "[91m"&" ATTENTION !! l'identifiant de la mère est déjà utilisé ."& ESC & "[0m");
			      when pere_present => put_line( ESC & "[91m"&" ERREUR !! Ce fils possède déjà un père ."& ESC & "[0m");
			      when identifiant_present => put( ESC & "[91m"&" ATTENTION !! la mère est déjà présente dans le registre !!!"& ESC & "[0m");New_line; put_line (" Si vous souhaitez Modifier ces données Veuillez taper 14 puis Q puis 2") ;
			  end ;

		      when 3 =>
			  begin
	         	  Put_line( ESC & "[93m"&" Vous avez choisi d'obtenir le nombre d'ancêtres d'un individu , lui compris :"& ESC & "[0m");
			  New_line;
			  Put (" Veuillez entrer l'identifiant de l'individu : ");
			  get(id1); --exeption si l identifiant n'est pas present
			  n := Obtenir_nombre_ancetre(Abr,id1);
			  Put_Line(" Le nombre des ancetres, lui compris est : "&Integer'Image(n));
			  New_Line;
			  exception
			      when id_absent  => put_line( ESC & "[91m"&" ERREUR !! L'individu n'est pas présent !!!  L'orération a échoué !!!!"& ESC & "[0m");
			  end ;

		      when 4 =>
			  begin
			  Put_line( ESC & "[93m"&" Vous avez choisi d'obtenir l'ensemble d'ancetres appartenant à une génération d'un individu"& ESC & "[0m");
			  New_Line;
			  Put(" Veuillez entrer l'identifiant de l'individu : ");
			  Get(id2); --exeption si l identifiant n'est pas present
			  Put(" Veuillez entrer la génération souhaitée : ");
			  get(g);
			  New_Line;
			  put_line("L'ensemble des ancetres appartenant à la"&integer'image(g)&"eme génération est : ");
			  New_line ;
			  put_line( ESC & "[93m"&"Patientez ...."& ESC & "[0m");
			  New_line ;
			  obtenir_ensemble_ancetre_generation(Abr,id2,g);
			  New_Line;
			  New_line;
			  exception
			      when id_absent  => put_line( ESC & "[91m"&" ERREUR !! L'individu n'est pas présent !!!! l'operation a échoué !!!"& ESC & "[0m");
			  end ;
		     when 5 =>
			 
			 Put_line( ESC & "[93m"&"Vous Avez Choisi d'afficher l'arbre Tout entier "& ESC & "[0m");
			 New_line;
			 New_line;
			 afficher_arbre_entier(Abr) ;
			 New_line ;
			 New_line ;

		      when 6 =>
			  begin
			  Put_Line( ESC & "[93m"&"Vous avez choisi d'afficher l'arbre généalogique à partir d'un individu ."& ESC & "[0m");
                	  New_Line;
			  Put("Veuillez entrer l'identifiant de l'individu concerné :");
			  get(id3);-- doit etre present
			  New_Line;
			  afficher_arbre_genealogique(Abr,id3);
			  New_Line;
			  exception
			      when id_absent  => put_line(ESC & "[91m"&" ERREUR !! L'individu n'est pas présent !!! L'opération a échoué !!!"& ESC & "[0m");
			  end ;

		      when 7 =>
			  begin
			  put_Line(ESC & "[93m"&"Vous avez choisi de supprimer un sous arbre"& ESC & "[0m");
			  New_Line;
			  New_line;
			  Put("Veuillez entrer l'identifiant de l'individu que vous voulez supprimer son arbre :");
			  get(id4); -- doit etre present
			  New_line ;
			  New_line ;
			  Put_Line(ESC & "[93m"&"Suppression en cours ..."& ESC & "[0m");
			  New_line;
			  New_line;
			  supprimer_sous_arbre_genealogique(Abr,id4);
			  New_Line;
			  Put_Line( ESC & "[0m"&"la suppression est effectuée avec succès"& ESC & "[0m");
			  New_Line;
			  exception
			      when id_absent  => put_line( ESC & "[91m"&" ERREUR !! L'individu n'est pas présent dans l'arbre !! "& ESC & "[0m");
			  end ;

		      when 8 =>
			  Put_line(ESC & "[93m"&"Vous avez choisi d'obtenir l'ensemble des fils ayant un seul parent :"& ESC & "[0m");
			  New_Line ;
			  New_line ;
			  Put_Line(ESC & "[92m"&" Patientez..."& ESC & "[0m");
			  new_Line ;
			  obtenir_ensemble_1_parent(Abr);
			  new_Line;

		      when 9 =>
			  Put_line( ESC & "[93m"&"Vous avez choisi d'obtenir l'ensemble des fils ayant deux parents :"& ESC & "[0m");
			  New_Line ;
			  Put_Line(ESC & "[92m"&" Patientez..."& ESC & "[0m");
			  new_Line ;
			  obtenir_ensemble_2_parent(Abr);
			  new_Line;

		      when 10 =>
			  Put_line(ESC & "[93m"&"Vous avez choisi d'obtenir l'ensemble des fils ayant aucun parent :"& ESC & "[0m");
			  New_Line;
			  Put_Line( ESC & "[92m"&" Patientez..."& ESC & "[0m");
			  new_Line;
			  obtenir_ensemble_0_parent(Abr);
			  new_Line;

		      when 11 =>
			  begin
			  Put_Line( ESC & "[93m"&"Vous avez choisi d'obtenir l'ensemble des ancetres d'un individu sur un nombre de générations"& ESC & "[0m");
			  New_Line;
			  Put ("veuillez entrer l'identifiant de l'individu : ");
			  get(id5); -- doit etre present
			  New_line ;
			  Put("Veuillez entrer le nombre des générations desiré : ");
			  get(nb);
			  New_Line;
			  identifier_ancetre_n_generation(Abr,id5,nb);
			  New_Line;
			  exception
			      when id_absent  => put_line( ESC & "[91m"&" ERREUR !! L'individu n'est pas présent !! l'opération a échoué !!"& ESC & "[0m");
			  end ;

		      when 12 =>
			  begin
			  Put_Line( ESC & "[93m"&"Vous avez choisi de vérifier si deux individus ont un ou plusieurs ancetres homonymes"& ESC & "[0m");
			  New_Line;
			  Put ("Veuillez entrer l'identifiant du premier individu: ");
			  get(id6); -- doit etre present
			  New_line ;
			  Put ("Veuillez entrer l'identifiant du deuxième individu: ");
			  get(id7); -- doit etre present
                          if ancetre_homonymes (Abr,reg,id6,id7) then
			      new_line;
			      Put_Line( ESC & "[92m"&"Les deux individus que vous avez entré ont au moins deux ancetres homonymes."& ESC & "[0m");
			  else
			      New_line;
			      Put_Line(ESC & "[92m"&"Les deux individus que vous avez entré n'ont pas d'ancetres homonymes."& ESC & "[0m");
			  end if;
			  New_Line;
			  end ;


		      when 13 =>
			  Put_Line( ESC & "[93m"&"Vous avez choisi de vider l'arbre généalogique."& ESC & "[0m");
			  New_Line;
			  Put_Line( ESC & "[92m"&"Vidage en cours ..."& ESC & "[0m");
			  vider(Abr);

	 		  Put_Line( ESC & "[92m"&"l'arbre est vidé avec succès"& ESC & "[0m");
			  New_Line;

		      when others => 
		          Null;

		  end case;
		  exit when choix_2 = 14 ;
		end loop;



	     elsif choix = 'r' or choix = 'R' then
		Put_Line( ESC & "[91m"&"-------------------- Bienvenue dans votre registre -----------------------------------"& ESC & "[0m");
		loop
	          New_line;
		  New_line;

		  loop
	             Put_line( ESC & "[92m"&"    Voici les fonctionnalités que vous pouvez utiliser :  "& ESC & "[0m");
	             New_line;
		     Put_line("    1) Ajouter un individu au registre ");
		     Put_Line("    2) Modifier les informations de l'individu");
		     Put_Line("    3) Vérifier si un individu est présent dans le registre");
		     Put_Line("    4) Supprimer un individu du registre");
		     Put_Line("    5) Obtenir le nombre d'individus dans le registre");
		     Put_Line("    6) Afficher les informations d'un individu");
		     Put_Line("    7) Obtenir une information sur un individu");
		     Put_Line("    8) Vider le regisre");
		     Put_Line("    9) Retourner au menu");
		     put( ESC & "[92m"&"Votre choix : "& ESC & "[0m") ;
		     get(choix_3);
		     New_Line;
		     exit when choix_3 < 10 and choix_3 > 0 ;
		  end loop;

		  case choix_3 is

		      when 1 =>
			  begin
			  Put_Line(ESC & "[93m"&"Vous avez choisi d'ajouter un individu :"& ESC & "[0m");
			  New_line;
			  Put_Line("Veuillez remplir les informations suivantes :");
			  New_Line;
			  Put("Entrer l'identifiant de l'individu : ");
			  get(id8); -- identifiant ne doit pas etre present
			  Put ("Nom : ");
			  Skip_line ;
			  nom_r := To_unbounded_String(get_line);
			  put ("Prenom : ");
			  prenom_r := To_unbounded_String(get_line);
			  loop
			    Put("Sexe (M/F) : ");
			    get(sexe_r);
			     if sexe_r /= 'm' and sexe_r /= 'M' and sexe_r /= 'f' and sexe_r /= 'F' then
		                  put_line("Veuillez saisir M ou F");
	                     end if ;
			    exit when sexe_r = 'm' or sexe_r ='M' or sexe_r = 'f' or sexe_r = 'F';
			  end loop;
			  Put_line("Date de naissance :");
			  Put ("   Jour : ");
			  get(jour_r);
			  Put_Line("   Mois : ");
			  loop
	                     New_line;
			     put_line(ESC & "[93m"&"Saisissez un chiffre "& ESC & "[0m");
	                     Put_line("    1) Janvier ");
	                     Put_line("    2) Fevrier ");
	                     Put_line("    3) Mars");
	                     Put_line("    4) Avril");
	                     Put_line("    5) Mai");
	                     Put_Line("    6) Juin");
	                     Put_Line("    7) Juillet");
	                     Put_Line("    8) août");
	                     Put_Line("    9) Septembre");
	                     Put_Line("    10) Octobre");
	                     Put_Line("    11) Novembre");
	                     Put_Line("    12) Decembre") ;
			     put ( ESC & "[93m"&"Votre Choix : "& ESC & "[0m");
		             get(choix_13);
		             exit when choix_13 < 13 and choix_13 > 0;
                          end loop;

	                  mois_r := T_Mois'Val(choix_13 - 1);

			  Put ("   Année : ");
			  get(annee_r);
			  creer_date(date_r,jour_r,mois_r,annee_r);
			  Put ("Lieu de naissance : ");
			  Skip_line;
			  lieu_r := To_unbounded_String(get_line);
			  creer_donnee(donnee_r , nom_r , prenom_r , sexe_r , date_r , lieu_r );
			  New_line;
			  New_line;
			  Put_line(ESC & "[92m"&"Ajout en cours ..."& ESC & "[0m");
			  New_line;
			  NEw_line;
			  ajouter(reg,id8,donnee_r);
                          Put_Line(ESC & "[92m"&"Ajout effectué avec succès "& ESC & "[0m");
			  New_line;
                          exception
			      when identifiant_present => put(ESC & "[91m"&" ATTENTION !! l'individu est déjà présent dans le registre !!!"& ESC & "[0m");New_line; put_line ("Si vous voulez Modifier ces données Veuillez taper 2") ;
			  end ;
	

		      when 2 => 
			  Put_Line( ESC & "[93m"&"Vous avez choisi de modifier des informations d'un individu "& ESC & "[0m");
			  New_Line;
			  loop 
			     Put("Veuillez entrer son identifiant : ");
			     get(id9); -- identifiant doit etre present 
			     if not ident_present (reg , id9) then
			        put_line(ESC & "[91m""ATTENTION !! l'identifiant n'est pas présent !! Veuillez saisir un identifiant correct"& ESC & "[0m");
			     end if ;
			     exit when ident_present(reg,id9);
		          end loop;


			  loop

			      loop
			        Put_Line( ESC & "[92m"&" Choisissez ce que vous souhaitez modifier "& ESC & "[0m"); 
			        Put_Line("    1) Le nom ");
			        Put_line("    2) Le prénom ");
			        Put_Line("    3) Le sexe ");
			        Put_Line("    4) la date de naissance");
			        Put_Line("    5) Le lieu de naissance");
			        Put_Line("    6) Modification finie ");
				put( ESC & "[93m"&"Votre choix :"& ESC & "[0m");
			        get(choix_4);
				New_line;
				exit when choix_4 < 8 and choix_4 > 0 ;
			      end loop;

			      case choix_4 is
				  when 1 =>
				      Put("Veuillez entrer le nouveau nom : ");
				      skip_line;
				      nom_d := To_unbounded_String(get_line);
				      modifier_nom(reg, id9, nom_d);
				      Put_Line("...");
				      New_line;
				      New_line;
				      Put_Line( ESC & "[92m"&"Le nom est bien modifié"& ESC & "[0m");

				  when 2 =>
				      Put ("Veuillez entrer le nouveau prénom : ");
				      skip_line ;
				      prenom_d := To_unbounded_String(get_line);
				      modifier_prenom(reg,id9,prenom_d);
				      Put_line(ESC & "[92m"&"Le prénom est bien modifié"& ESC & "[0m");

				  when 3 =>

				      loop
				        Put(" Veuillez entrer le sexe (M/F) : ");
					get(sexe_d);
					modifier_sexe(reg,id9,sexe_d);
					Put_Line("...");
					Put_line( ESC & "[92m"&"Le sexe est bien modifié"& ESC & "[0m");
					exit when sexe_d = 'm' or sexe_d ='M' or sexe_d = 'f' or sexe_d = 'F';
				      end loop;

				  when 4 =>
				      Put_Line( ESC & "[92m"&"Pour modifier la date de naissance, veuillez entrer : "& ESC & "[0m");
				      Put ("   Jour : ");
				      get(jour_d);
				      Put_Line("   Mois : ");
				      loop
	                                   New_line;
					   put( ESC & "[93m"&"Saisissez un chiffre "& ESC & "[0m");
	                                   Put_line("    1) Janvier ");
	                                   Put_line("    2) Fevrier ");
	                                   Put_line("    3) Mars");
	                                   Put_line("    4) Avril");
	                                   Put_line("    5) Mai");
	                                   Put_Line("    6) Juin");
	                                   Put_Line("    7) Juillet");
	                                   Put_Line("    8) août");
	                                   Put_Line("    9) Septembre");
	                                   Put_Line("    10) Octobre");
	                                   Put_Line("    11) Novembre");
	                                   Put_Line("    12) Decembre") ;
					   put (ESC & "[93m"&"Votre Choix : "& ESC & "[0m");
		                           get(choix_14);
					   New_line;
		                           exit when choix_14 < 13 and choix_14 > 0;
                                      end loop;
	                              mois_d := T_Mois'Val(choix_14 - 1);

				      Put ("   Année : ");
				      get(annee_d);
				      creer_date(date_d,jour_d,mois_d,annee_d);
				      modifier_date(reg,id9,date_r);
				      Put_Line("...");
				      new_line ;
				      Put_line(ESC & "[92m"&" la date de naissance est bien modifiée ."& ESC & "[0m");

				  when 5 =>
				      Put("Veuillez entrer le lieu de naissance : ");
				      skip_line ;
				      lieu_r := To_unbounded_String(get_line);
				      modifier_lieu(reg,id9,lieu_r);
				      Put_Line("...");
				      Put_Line(ESC & "[92m"&"Le lieu de naissance est bien modifié ."& ESC & "[0m");
				  
				  when others =>
				      Null ;				  
			      
			      end case ;
			      
			      exit when choix_4 = 6;
			  end loop;

		      when 3 =>
			  Put_line ( ESC & "[93m"&"Vous cherchez un individu dans le registre :"& ESC & "[0m");
			  New_line ;
			  Put("Veuillez entrer l'identifiant de l'individu que vous chercher :");
			  get(id10);

			  if ident_present(reg,id10) then
			      Put_Line("l'individu est présent dans le registre .");
			  else
			      Put_Line("l'individu n'existe pas dans le registre .");
			  end if;
			  New_Line;

		      when 4 =>
			  begin
			  Put_Line(ESC & "[93m"&"Vous avez choisi de supprimer un individu du registre"& ESC & "[0m");
			  Put("veuillez entrer son identifiant : ");
			  get(id11); -- etre present
			  Put_Line( ESC & "[92m"&"Suppression en cours..."& ESC & "[0m");
			  New_line ;
			  supprimer(reg,id11);
			  Put_Line( ESC & "[92m"&"La suppression est effectuée avec succès"& ESC & "[0m");
			  New_Line;
                          exception
			      when identifiant_absent => put_line (ESC & "[91m"&"ATTENTION !! l'individu n'était pas present dans le registre"& ESC & "[0m");
			  end ;

		      when 5 =>
			  Put_line(ESC & "[93m"&"Vous avez choisi d'obtenir le nombre d'individus dans le registre :"& ESC & "[0m");
			  Put_Line("Patientez...");
			  Put_Line("Le nombre d'individus présents dans le registre est : "&Integer'Image(Taille(reg)));
			  New_Line;

		      when 6 => 
			  begin
			  Put_Line( ESC & "[93m"&"Vous voulez afficher les informations d'un individu"& ESC & "[0m");
			  New_Line;
			  put ("Veuillez entrer son identifiant :");
			  get(id13); -- etre present
			  New_Line;
			  put_line("Patientez ...");
			  New_line ;
			  afficher_info(reg,id13);
			  New_Line;
			  New_Line;
                          exception
			      when identifiant_absent => put_line(ESC & "[91m"&"ERREUR !! l'individu n'est pas present !! l'opération a échoué !!"& ESC & "[0m");
			  end ;


		      when 7 =>
			  Put_Line(ESC & "[93m"&"Vous avez choisi d'obtenir une information sur un individu"& ESC & "[0m");
			  New_line;
			  loop 
			     Put("Veuillez entrer son identifiant : ");
			     get(id12); -- identifiant doit etre present 
			     if not ident_present (reg , id12) then
			        put_line( ESC & "[91m"&"ATTENTION !! l'identifiant n'est pas présent !! Veuillez saisir un identifiant correct"& ESC & "[0m");
			     end if ;
			     exit when ident_present(reg,id12);
		          end loop;


			  loop

			      loop
			         Put_line(ESC & "[92m"&"Choisissez quelle information vous voulez obtenir :");
			         Put_Line("      1) Nom");
			         put_Line("      2) Prénom");
			         Put_Line("      3) Sexe");
			         Put_Line("      4) Date de naissance");
			         Put_Line("      5) Lieu de naissance");
			         put_line("      6) retour");
				 put(ESC & "[92m"&"Votre Choix :"& ESC & "[0m");
			         get(choix_5);
				 New_Line;
				 exit when choix_5 < 7 and choix_5 > 0 ;
			      end loop;
			      
			      case choix_5 is

				  when 1 =>
				      Put("le nom est : ");
				      Put(obtenir_nom(reg,id12));
				      New_Line;

				  when 2 =>
				      Put("le prénom est : ");
				      Put(obtenir_prenom(reg,id12));
				      New_Line;

				  when 3 =>
				      Put("le sexe est : ");
				      Put(obtenir_sexe(reg,id12));
				      New_Line;

				  when 4 =>
				      Put_Line("la date de naissance est : ");
				      Put_Line("jour : " &Integer'Image(obtenir_jour_naissance(reg,id12)));
				      Put("mois : ");
				      Put(T_Mois'Image(obtenir_mois_naissance(reg,id12)));
				      New_Line;
				      Put_Line("année : " &Integer'Image(obtenir_annee_naissance(reg,id12)));

				  when 5 =>
				      Put("le lieu de naissance est : ") ;
				      Put(obtenir_lieu_naissance(reg,id12));
				      New_Line;

				  when others =>
				      Null;

			      end case;

			      exit when choix_5 = 6;
			  end loop;

		      when 8 =>  
			  Put_Line( ESC & "[93m"&" Vous avez choisi de vider le registre"& ESC & "[0m");
			  new_Line;
			  Put_Line(ESC & "[91m"&"Attention, vous risquez de vider votre arbre aussi"& ESC & "[0m");
			  Put_Line("Voulez vous continuer ? ");
			  Put_Line("Tapez o pour continuer sinon tapez n'importe quel caractère :");
			  get(reponse);
			  if reponse = 'o' then
			     Put_Line("Patientez...");
			     new_line ;
			     vider_reg(reg);
			     vider(Abr);
			     Put_Line("Vidage complété");
			     New_Line;
			  else
			     Put_Line("Vidage échoué");
			  end if;

	              when others =>
			      Null;
		      
		      end case;
		  
		  exit when choix_3 = 9;
		end loop;

	     end if;

	     exit when choix = 'Q' or choix = 'q';   
	     end loop;
	     Put_Line( ESC & "[91m"&"-------------------Voulez vous quitter votre espace ? (o/n) : ----------------------- "& ESC & "[0m");
	     Get(Choix_6);
	     exit when choix_6 = 'o' or choix_6 = 'O';
	 end loop;

end programme_principal ;
     
	     



	 
	     

	 


	  





















































