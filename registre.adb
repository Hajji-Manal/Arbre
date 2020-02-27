-- implantation du module registre.
with Ada.Text_IO;            use Ada.Text_IO;
with Ada.Integer_Text_IO;    use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded ;use Ada.Strings.Unbounded ;
with Ada.Unchecked_Deallocation;

package body registre is
     
    procedure Free is
	new Ada.Unchecked_Deallocation (T_Cellule, T_registre);


--------------------------------------------------------------------------------------------------------
   
    function Est_vide (reg : in T_registre) return boolean is 
    begin 
	return reg = Null ;
    end ;

--------------------------------------------------------------------------------------------------------

    procedure initialiser_registre (reg : out T_registre) is
    begin 
	reg := Null ;
    end ;

---------------------------------------------------------------------------------------------------------
    
    procedure ajouter (reg : in out T_registre ; identifiant : in integer ; info : T_Donnee ) is 
    begin
	if reg = Null then 
	    reg := new T_Cellule'(identifiant , info , Null , Null);
	elsif reg.all.identifiant > identifiant then
	    ajouter (reg.all.sous_arbre_gauche,identifiant,info);
	elsif reg.all.identifiant < identifiant then 
	    ajouter (reg.all.sous_arbre_droit,identifiant,info);
	else 
	    raise  identifiant_present ;
	end if ;
    end ;

---------------------------------------------------------------------------------------------------------

    -- retourne le noeud qui contient l'identifiant.

    function Chercher_Noeud ( reg: in T_registre ; identifiant : in integer ) return T_registre is
	begin
		if reg = Null then
			raise identifiant_absent;
		elsif reg.all.identifiant < identifiant then
			return Chercher_Noeud (reg.all.Sous_Arbre_Droit, identifiant);
		elsif identifiant < reg.all.identifiant then
			return Chercher_Noeud (reg.all.Sous_Arbre_Gauche, identifiant);
		else 
			return reg;
		end if;
	end Chercher_Noeud;

----------------------------- Modifier la Donnée d'un identifiant   ------------------------------------------------ 
    
    
    procedure modifier_nom (reg : in out T_registre ; identifiant: in integer ; nom : in unbounded_String) is
    begin
	Chercher_Noeud(reg,identifiant).all.Donnee.nom := nom ;
    end;

-----------------------------------------------------------------------------------------------------------

    procedure modifier_prenom(reg : in out T_registre ; identifiant: in integer ; prenom : in unbounded_String) is
    begin
	Chercher_Noeud(reg,identifiant).all.Donnee.prenom := prenom ;
    end;

-----------------------------------------------------------------------------------------------------------

    procedure modifier_sexe(reg : in out T_registre ; identifiant: in integer ; sexe : in Character) is
    begin
        Chercher_Noeud(reg,identifiant).all.Donnee.sexe := sexe;
    end;

-----------------------------------------------------------------------------------------------------------

    procedure modifier_date(reg : in out T_registre ; identifiant: in integer ; date : in T_Date) is
    begin
	Chercher_Noeud(reg,identifiant).all.Donnee.date_naissance := date;
    end;

-----------------------------------------------------------------------------------------------------------

    procedure modifier_lieu(reg : in out T_registre ; identifiant: in integer ; lieu : in unbounded_String) is
    begin
	Chercher_Noeud(reg,identifiant).all.Donnee.lieu_naissance := lieu ;
    end;

------------------------------------------------------------------------------------------------------------

    function ident_present ( reg : in T_registre ; identifiant : in Integer ) return boolean is 
    registre1 : T_registre ;
    begin 
	registre1 := Chercher_Noeud(reg,identifiant) ;
	return True ;
    exception 
	when identifiant_absent => return False ;

    end ;

------------------------------------------------------------------------------------------------------------


    function taille (reg : in T_registre ) return integer is
    begin 
        if reg = Null then
	    return 0 ;
	else 
	    return  1 + taille(reg.sous_arbre_gauche) + taille(reg.sous_arbre_droit) ;
	end if ;
    end ;

------------------------------------------------------------------------------------------------------------

    -- afficher une information du registre à partir de l'identifiant

    procedure afficher_info (reg : in T_registre ; identifiant : in integer) is
    begin
	    put("nom : ");
	    put (obtenir_nom (reg, identifiant ));New_line ;
            put("prenom : ");
	    put (obtenir_prenom (reg, identifiant ));New_line;
	    put("sexe : ");
	    put (obtenir_sexe (reg, identifiant ));New_line;
	    put ("Date de naissance : ( ");
	    put (obtenir_Jour_naissance (reg, identifiant),1);put(" ");
	    put (T_Mois'Image(obtenir_Mois_naissance (reg, identifiant )));put(" ");
	    put (obtenir_annee_naissance (reg, identifiant ),1);
	    put(")"); New_line;
	    put("Lieu de naissance : ");
	    put (obtenir_lieu_naissance (reg, identifiant ));New_line;
    end ;


------------------------------------------------------------------------------------------------------------

    
    procedure Decrocher_Min (reg : in out T_registre; Min : out T_registre) with
		Pre  => reg /= Null,
		Post => Min /= Null
			and then Taille (Min) = 1		-- une feuille
			and then not (reg'Old.all.identifiant < Min.all.identifiant)	-- plus petite clé !
			and then Taille (reg) = Taille (reg'Old) - 1	-- un décroché
    is
    begin
	if reg.all.sous_arbre_gauche = Null then --  min trouvé
		Min := reg;
		reg := reg.all.sous_arbre_droit;
	else
		Decrocher_Min (reg.all.sous_arbre_gauche, Min);
	end if;
    end Decrocher_Min;

------------------------------------------------------------------------------------------------------------


    procedure Supprimer (reg : in out T_registre ; identifiant : in integer) is
		A_Detruire : T_registre;
    begin
	if reg = Null then
		raise identifiant_absent ;
	elsif reg.all.identifiant < identifiant then
	    Supprimer (reg.all.sous_arbre_droit, identifiant);
	elsif identifiant < reg.all.identifiant then
		Supprimer (reg.all.sous_arbre_gauche, identifiant);
	else 

	    A_Detruire := reg;
            if reg.all.sous_arbre_gauche = Null then
			reg := reg.all.sous_arbre_droit;
	    elsif reg.all.sous_arbre_droit = Null then
			reg := reg.all.sous_arbre_gauche;
	    else
			declare
			    Min: T_registre;
			begin
				Decrocher_Min (reg.all.sous_arbre_droit, Min);
				Min.all.sous_arbre_gauche := reg.all.sous_arbre_gauche;
				Min.all.sous_arbre_droit := reg.all.sous_arbre_droit;
				reg := Min;
			end;
	     end if;

		Free (A_Detruire);
	end if;
	
    end Supprimer;

------------------------------------ Obtenir la Donnée d'un identifiant  --------------------------------------------------

   
    function obtenir_nom (reg : in T_registre ; identifiant : in integer ) return String is 
    begin
	return to_String(Chercher_Noeud (reg,identifiant).all.donnee.nom) ;
    end ;


    function obtenir_prenom (reg : in T_registre ; identifiant : in integer ) return String is 
    begin
	return to_String(Chercher_Noeud (reg,identifiant).all.donnee.prenom) ;
    end ;



    function obtenir_sexe (reg : in T_registre ; identifiant : in integer ) return character is 
    begin
	return Chercher_Noeud (reg,identifiant).all.donnee.sexe ;
    end ;



    function obtenir_jour_naissance (reg : in T_registre ; identifiant : in integer ) return integer is 
    begin
	return Chercher_Noeud (reg,identifiant).all.donnee.date_naissance.Jour ;
    end ;



    function obtenir_mois_naissance (reg : in T_registre ; identifiant : in integer ) return T_Mois is 
    begin
	return Chercher_Noeud (reg,identifiant).all.donnee.date_naissance.Mois  ;
    end ;



    function obtenir_annee_naissance (reg : in T_registre ; identifiant : in integer ) return integer is 
    begin
	return Chercher_Noeud (reg,identifiant).all.donnee.date_naissance.Annee ;
    end ;



    function obtenir_lieu_naissance (reg : in T_registre ; identifiant : in integer ) return String is 
    begin
	return to_String(Chercher_Noeud (reg,identifiant).all.donnee.lieu_naissance) ;
    end ;

------------------------------------------------------------------------------------------------------------

    

    procedure creer_date (date : out T_Date ; jour : in integer ; mois : in T_Mois ; annee : in integer) is 
    begin
	date.Jour := jour ;
	date.Mois := mois ;
	date.Annee := annee ;
    end ;

------------------------------------------------------------------------------------------------------------


     procedure creer_donnee ( donnee : out T_Donnee ; nom : in unbounded_string ; prenom : in unbounded_string ; sexe : in character ;date_naissance : in T_Date ; lieu_naissance : in unbounded_string) is
    begin
	donnee.nom := nom ;
	donnee.prenom := prenom ;
	donnee.sexe := sexe ;
	donnee.date_naissance := date_naissance ;
	donnee.lieu_naissance := lieu_naissance ;
    end ;


------------------------------------------------------------------------------------------------------------
    

    procedure vider_reg (registre : in out T_registre ) is
    begin
	if registre = Null then 
	    Null ;
	else vider_reg(registre.all.sous_arbre_gauche) ;
	     vider_reg(registre.all.sous_arbre_droit);
	     free(registre);
	end if ;
    end ;


end registre ;
    


   







    
