{
	ALGORITHME : MorpionV2
	// BUT : Deux joueurs s'affrontent au jeu du morpion. Chacun son tour, les joueurs doivent compléter une grille 3X3 avec les symboles X et O. Si un joueur aligne trois de ses symboles, il gagne la manche. Si personne
	// ne gagne la manche, la grille se réinitialise quand même. Pour gagner le jeu, un joueur doit gagner 5 manches.
	// ENTREES : Les utilisateurs doivent saisir leurs pseudos ainsi que la cellule de la grille qu'ils veulent remplir (X ou O).
	// SORTIES : Le tableau de caractères représentant la grille de morpion, ainsi que les explications sous forme de phrases pour renseigner le joueur.
	// PRINCIPE : 1) Joueur + tour 2) Init grille et affichage grille 3) Procédures jouer 4) FctLibre <- Tab_Car[3,3] = ' ' 5)Fonction aligner

	CONST //const ayant une portée globale
		MAX <- 3 : ENTIER
		MANCHEMAX <- 5 : ENTIER

	PROCEDURE setName (VAR J1, J2 : CHAINE) //passage par adresse car réutilisable
		DEBUT
			//boucle de saisie pour le pseudo J1
			REPETER
				ECRIRE "Saisir un pseudo pour J1 :"
				LIRE J1
			JUSQU'A (LONGUEUR (J1) > 0)
			ECRIRE "Bonjour ", J1, " vous aurez le symbole X !"

			//boucle de saisie pour le pseudo J2
			REPETER
				ECRIRE "Saisir un pseudo pour J2 :"
				LIRE J2
			JUSQU'A (LONGUEUR (J2) > 0)
			ECRIRE "Bonjour ", J2, " vous aurez le symbole O !"
		FIN PROCEDURE

	PROCEDURE aleaTour (VAR tourJ : BOOLEEN) //passage par adresse car réutilisable
		VAR
			nbalea : ENTIER  //variable locale
		DEBUT
			//on simule une fonction aléatoire qui stocke dans la variable locale une valeur entière comprise entre 1 et 2
			SI (nbalea = 1) ALORS
				tourJ <- VRAI
			SINON //si nbalea = 2
				tourJ <- FAUX
			FIN SI
		FIN PROCEDURE

	PROCEDURE initTab (VAR TabCar : TABLEAU [1..MAX,1..MAX] de CAR) //passage par adresse car réutilisable
		VAR
			cpt1, cpt2 : ENTIER  //variables locales pour boucle
		DEBUT
			POUR cpt1 DE 1 A MAX FAIRE
				POUR cpt2 DE 1 A MAX FAIRE
					TabCar [cpt1, cpt2] <- ' ' //affectation d'espace dans les différentes cellules du tab
				FIN POUR
			FIN POUR
		FIN PROCEDURE

	PROCEDURE jouer (VAR TabCar : TABLEAU [1..MAX, 1..MAX] de CAR, col, lign : ENTIER, tourJ : BOOLEEN) //seul le tableau est réutilisé donc passage par adresse
		DEBUT
			//affectation du symbole pour la colonne et la ligne voulue
			SI (tourJ) ALORS
				TabCar [lign, col] <- 'X'
			SINON
				TabCar [lign, col] <- 'O'
			FIN SI
		FIN PROCEDURE

	FONCTION libre (TabCar : TABLEAU [1..MAX, 1..MAX] de CAR; col, lign : ENTIER) : BOOLEEN
		DEBUT
			libre <- TabCar [lign, col] = ' '  //si la cellule contient un espace
		FIN FONCTION

	PROCEDURE showTab (TabCar : TABLEAU [1..MAX,1..MAX] de CAR)
		VAR
			cpt1, cpt2 : ENTIER
		DEBUT
			POUR cpt1 DE 1 A MAX FAIRE
				POUR cpt2 DE 1 A MAX FAIRE
					ECRIRE TabCar [cpt1, cpt2]
					SI (cpt2 <> MAX) ALORS
						ECRIRE '/' //pour l'esthétique et séparer les colonnes
					FIN SI
				FIN POUR
				//aller à la ligne
				SI (cpt1 <> MAX) ALORS
					ECRIRE "_____"   //pour l'esthétique et séparer les lignes
				FIN SI
				//aller à la ligne
			FIN POUR
		FIN PROCEDURE

	FONCTION align (TabCar : TABLEAU [1..MAX,1..MAX] de CAR) : BOOLEEN
		VAR
			var_align : BOOLEEN
			cpt1 : ENTIER
		DEBUT
			//initialisation des variables
			var_align <- FAUX
			cpt1 <- 1

			//si la 2e colonne est vide, rien ne sert de vérifier les hozitaux
			SI ((TabCar [2,1] <> ' ') OU (TabCar [2,2] <> ' ') OU (TabCar [2,3] <> ' ')) ALORS
				REPETER
					var_align <- ((TabCar[1,cpt1] = TabCar [2,cpt1]) ET (TabCar[1,cpt1] = TabCar [3,cpt1]) ET (TabCar[1,cpt1] <> ' '))
					cpt1 <- cpt1 + 1
				JUSQU'A ((cpt1 = 4) OU (var_align))
				cpt1 <- 1 //réinitialisation du compteur
			FIN SI

			//si la 2e ligne est vide, rien ne sert de vérifier les verticaux
			SI ((TabCar [1,2] <> ' ') OU (TabCar [2,2] <> ' ') OU (TabCar [3,2] <> ' ')) ALORS
				REPETER
					var_align <- ((TabCar[cpt1,1] = TabCar [cpt1,2]) ET (TabCar[cpt1,1] = TabCar [cpt1,3]) ET (TabCar[cpt1,1] <> ' '))
					cpt1 <- cpt1 + 1
				JUSQU'A ((cpt1 = 4) OU (var_align))
				cpt1 <- 1 //réinitialisation du compteur
			FIN SI

			//vérification des diagonales
			//rien ne sert des vérifier les diagonales si la cellule du millieu est vide
			SI (TabCar[2,2] <> ' ') ALORS
				SI ((TabCar[1,1] = TabCar [2,2]) ET (TabCar[1,1] = TabCar [3,3])) ALORS
					var_align <- VRAI
				SINON
					SI ((TabCar[1,3] = TabCar [2,2]) ET (TabCar[1,3] = TabCar [3,1])) ALORS
						var_align <- VRAI
					FIN SI
				FIN SI
			FIN SI

			align <- var_align //affectation à align une seule fois pour éviter bug de récursivité
		FIN FONCTION

	VAR  //variables locales au corps principal (main)
		J1, J2 : CHAINE
		Manche1, Manche2, nbtour, col, lign : ENTIER
		tourJ : BOOLEEN
		TabCar : TABLEAU [1..MAX,1..MAX] de CAR

	DEBUT //bloc principal (main)
		//initialisation des variables 
		J1 <- ""
		J2 <- ""
		Manche1 <- 0
		Manche2 <- 0
		nbtour <- 0
		tourJ <- VRAI
		col <- 0
		lign <- 0

		setName(J1, J2) //appel de procédure pour set les pseudos des joueurs        //$ J1 s'appelle Bob et J2 s'appelle Toto

		REPETER   //début de la manche
			initTab(TabCar)  //appel de procédure pour réinitialiser le tableau
			aleaTour(tourJ)  //appel de procédure pour savoir quel joueur va commencer     //$ Bob commence

			REPETER   //début du tour de jeu
				SI (tourJ) ALORS  //annonce du tour de jeu
					ECRIRE "C'est à ", J1, " de jouer !"        //$ Cette phrase va donc etre affichée
				SINON
					ECRIRE "C'est à ", J2, " de jouer !"
				FIN SI

				REPETER

					//boucle de saisie de la colonne
					REPETER
						ECRIRE "Saisir votre colonne :"
						LIRE col
					JUSQU'A ((col > 0) ET (col < 4))        //$ Bob saisit 2

					//boucle de saisie de la ligne
					REPETER
						ECRIRE "Saisir votre ligne :"
						LIRE lign
					JUSQU'A ((lign > 0) ET (lign < 4))     //$ Bob saisit 2

				JUSQU'A (libre(col,lign))  //appel de la fonction pour savoir si la cellule voulue ne contient pas déjà un symbole      //$ cette cellule est libre car Bob est le premier à jouer

				jouer(TabCar,col,lign,tourJ)  //appel de la procédure pour mettre un symbole dans la grille     //$ Un X est dessiné dans la cellule du milieu

				showTab(TabCar)  //appel de la procédure pour afficher le tableau

				nbtour <- nbtour + 1
				tourJ <- NON(tourJ)  //on passe à l'autre joueur      //$ On passe à Toto

				SI (nbtour >= 5) ALORS   //seulement à partir du 5e tour
					SI (align(TabCar)) ALORS    //appel de la fonction pour savoir si 3 symboles sont alignés
						SI (tourJ = FAUX) ALORS
							ECRIRE J1, " gagne !"
							Manche1 <- Manche1 + 1
						SINON
							ECRIRE J2, " gagne !"
							Manche2 <- Manche2 + 1
						FIN SI
					FIN SI
				FIN SI

			JUSQU'A ((nbtour = 9) ou (align(TabCar))
		JUSQU'A ((Manche1 = MANCHEMAX) OU (Manche2 = MANCHEMAX))

		SI (Manche1 = MANCHEMAX) ALORS
			ECRIRE J1, " gagne le jeu !"
		SINON
			ECRIRE J2, " gagne le jeu !"
		FIN SI

	FIN.   //EZ
}


PROGRAM MorpionV2;
	// BUT : Deux joueurs s'affrontent au jeu du morpion. Chacun son tour, les joueurs doivent compléter une grille 3X3 avec les symboles X et O. Si un joueur aligne trois de ses symboles, il gagne la manche. Si personne
	// ne gagne la manche, la grille se réinitialise quand même. Pour gagner le jeu, un joueur doit gagner 5 manches.
	// ENTREES : Les utilisateurs doivent saisir leurs pseudos ainsi que la cellule de la grille qu'ils veulent remplir (X ou O).
	// SORTIES : Le tableau de caractères représentant la grille de morpion, ainsi que les explications sous forme de phrases pour renseigner le joueur.
	// PRINCIPE : 1) Joueur + tour 2) Init grille et affichage grille 3) Procédures jouer 4) FctLibre <- Tab_Car[3,3] = ' ' 5)Fonction aligner

	USES crt;

	CONST //const ayant une portée globale
		MAX = 3;
		MANCHEMAX = 5;

	VAR
		TabCar : array [1..MAX,1..MAX] of string;  //je me permets de mettre le tableau en variable globale, car une erreur apparaissait : "Error: Incompatible type for arg no. arg1: Got ”arg2”, expected ”arg3”"
		//je ne savais pas comment la résoudre, donc après une petite heure de recherche, je me résouds à corriger cette erreur de cette façon peu optimisée


	PROCEDURE setName (VAR J1, J2 : string); //passage par adresse car réutilisable
		begin
			//boucle de saisie pour le pseudo J1
			repeat
				writeln ('Saisir un pseudo pour J1 :');
				readln (J1);
			until (Length(J1) > 0);
			writeln ('Bonjour ', J1, ' vous aurez le symbole X !');

			//boucle de saisie pour le pseudo J2
			repeat
				writeln ('Saisir un pseudo pour J2 :');
				readln (J2);
			until (Length (J2) > 0);
			writeln ('Bonjour ', J2, ' vous aurez le symbole O !');
			writeln;
			writeln;
		end;

	PROCEDURE aleaTour (VAR tourJ : boolean); //passage par adresse car réutilisable
		VAR
			nbalea : integer;  //variable locale
		begin
			//on simule une fonction aléatoire qui stocke dans la variable locale une valeur entière comprise entre 0 et 1
			Randomize;
			nbalea:=random(2);
			if (nbalea = 0) then
				tourJ := TRUE
			else //si nbalea = 1
				tourJ := FALSE;
		end;

	PROCEDURE initTab; //passage par adresse car réutilisable
		VAR
			cpt1, cpt2 : integer;  //variables locales pour boucle
		begin
			for cpt1:=1 to MAX do
			begin
				for cpt2:= 1 to MAX do
				begin
					TabCar[cpt1,cpt2] := ' '; //affectation d'espace dans les différentes cellules du tab
				end;
			end;
		end;


	PROCEDURE jouer (col, lign : integer; tourJ : boolean); //seul le tableau est réutilisé donc passage par adresse
		begin
			//affectation du symbole pour la colonne et la ligne voulue
			if (tourJ) then
				TabCar [lign, col] := 'X'
			else
				TabCar [lign, col] := 'O';
		end;

	FUNCTION libre (col, lign : integer) : boolean;
		begin
			libre := TabCar [lign, col] = ' ';  //si la cellule contient un espace
		end;

	PROCEDURE showTab;
		VAR
			cpt1, cpt2 : integer;
		begin
			for cpt1:=1 to MAX do
			begin
				for cpt2:=1 to MAX do
				begin
					write (TabCar [cpt1, cpt2]);
					if (cpt2 <> MAX) then
						write ('/'); //pour l'esthétique et séparer les colonnes
				end;
				//aller à la ligne
				writeln;
				if (cpt1 <> MAX) then
					write ('_____');   //pour l'esthétique et séparer les lignes
				writeln;
			end;
		end;

	FUNCTION align : boolean;
		VAR
			var_align : boolean;
			cpt1 : integer;
		begin
			//initialisation des variables
			var_align := FALSE;
			cpt1 := 1;

			//si la 2e colonne est vide, rien ne sert de vérifier les hozitaux
			if ((TabCar [2,1] <> ' ') or (TabCar [2,2] <> ' ') or (TabCar [2,3] <> ' ')) then
			begin
				repeat
					var_align := ((TabCar[1, cpt1] = TabCar [2,cpt1]) and (TabCar[1,cpt1] = TabCar [3,cpt1]) and (TabCar[1,cpt1] <> ' '));
					cpt1 := cpt1 + 1;
				until (cpt1 = 4) or (var_align);
				cpt1 := 1; //réinitialisation du compteur
			end;

			//si la 2e ligne est vide, rien ne sert de vérifier les verticaux
			if ((TabCar [1,2] <> ' ') or (TabCar [2,2] <> ' ') or (TabCar [3,2] <> ' ')) then
			begin
				repeat
					var_align := ((TabCar[cpt1,1] = TabCar [cpt1,2]) and (TabCar[cpt1,1] = TabCar [cpt1,3]) and (TabCar[cpt1,1] <> ' '));
					cpt1 := cpt1 + 1;
				until (cpt1 = 4) or (var_align);
				cpt1 := 1; //réinitialisation du compteur
			end;

			//vérification des diagonales
			//rien ne sert des vérifier les diagonales si la cellule du millieu est vide
			if (TabCar[2,2] <> ' ') then
			begin
				if ((TabCar[1,1] = TabCar [2,2]) and (TabCar[1,1] = TabCar [3,3])) then
				begin
					var_align := true;
				end
				else if ((TabCar[1,3] = TabCar [2,2]) and (TabCar[1,3] = TabCar [3,1])) then
				begin
					var_align := true;
				end
			end;

			align := var_align; //affectation à align une seule fois pour éviter bug de récursivité
		end;

	VAR  //variables locales au corps principal (main)
		J1, J2 : string;
		Manche1, Manche2, nbtour, col, lign : integer;
		tourJ : boolean;

	BEGIN //bloc principal (main)
		//initialisation des variables 
		J1 := '';
		J2 := '';
		Manche1 := 0;
		Manche2 := 0;
		nbtour := 0;
		tourJ := TRUE;
		col := 0;
		lign := 0;

		clrscr; //supprime flux inutile

		setName(J1, J2); //appel de procédure pour set les pseudos des joueurs

		repeat   //début de la manche
			initTab;  //appel de procédure pour réinitialiser le tableau
			aleaTour(tourJ);  //appel de procédure pour savoir quel joueur va commencer

			repeat   //début du tour de jeu
				if (tourJ) then  //annonce du tour de jeu
					writeln ('C est a ', J1, ' de jouer !')
				else
					writeln ('C est a ', J2, ' de jouer !');

				repeat

					//boucle de saisie de la colonne
					repeat
						writeln ('Saisir votre colonne :');
						readln (col);
					until (col > 0) and (col < 4);

					//boucle de saisie de la ligne
					repeat
						writeln ('Saisir votre ligne :');
						readln (lign);
					until (lign > 0) and (lign < 4);

				until libre(col,lign);  //appel de la fonction pour savoir si la cellule voulue ne contient pas déjà un symbole

				jouer(col,lign,tourJ);  //appel de la procédure pour mettre un symbole dans la grille

				showTab;  //appel de la procédure pour afficher le tableau

				nbtour := nbtour + 1; 
				tourJ := NOT tourJ;

				if (nbtour >= 5) then   //seulement à partir du 5e tour
				begin
					if (align) then    //appel de la fonction pour savoir si 3 symboles sont alignés
					begin
						if (tourJ = FALSE) then
						begin
							writeln (J1, ' gagne !');
							Manche1 := Manche1 + 1
						end
						else
						begin
							writeln (J2, ' gagne !');
							Manche2 := Manche2 + 1
						end;
						readln;
					end;
				end;
			until (nbtour = 9) or (align);
		until (Manche1 = MANCHEMAX) or (Manche2 = MANCHEMAX);

		if (Manche1 = MANCHEMAX) then
			writeln (J1, ' gagne le jeu !')
		else
			writeln (J2, ' gagne le jeu !');

		readln;

	END.   //EZ
