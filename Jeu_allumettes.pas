{
	ALGORITHME : Jeu_allumettes_v1
	//BUT : Deux joueurs s'affrontent au jeu de Nim. Chaque joueur doit essayer de laisser un nombre multiple de 4 plus une allumettes dans un tas de 21 allumettes au départ. Chaque 
	joueur, durant son tour, peut retirer une, deux ou trois allumettes.
	// ENTREES : L'utilisateur saisit un nombre d'allumettes à retirer. Il va au préalable choisir un pseudo (spécificité).
	// SORTIES : L'algorithme renvoie le nombre d'allumettes restantes, puis le nom du gagnant.
	// PRINCIPES : L'algoritme se répète jusqu'à ce qu'il reste un nombre multiple de 4 plus une allumettes. Il envoie à la fin le nom du gagnant.
	// NOTE : Pour plus de lisibilité, les play-tests seront affichés avec comme en-tête "//$". 

	CONST :

	MULTI4 <- 4 : ENTIER

	VAR :

	j1, j2 : CHAINE      //les joueurs saisiront un pseudo (petite spécificité)
	allum_rest, allum_retir : ENTIER
	tour_joueur, win : BOOLEEN

	DEBUT :

		//initialisation de nos variables
		j1 <- "joueur1"
		j2 <- "joueur2"
		allum_rest <- 21
		allum_retir <- 0
		tour_joueur <- VRAI
		win <- FAUX
		
		//on explique les règles aux utilisateurs : user friendly
		ECRIRE "Bienvenue au jeu des allumettes, pour deux joueurs !"
		//on saute plusieurs lignes pour plus de clarté
		ECRIRE "Vous débutez avec un tas de 21 allumettes ! Chacun votre tour, vous devrez enlever soit 1, soit 2, soit 3 allumettes du tas. Si à la fin de votre tour, il reste un 
		nombre d'allumettes égal à un multiple de 4 + 1 allumette, vous gagnez !"
		ECRIRE "Appuyez sur une touche pour continuer :"

		//l'algorithme demande un pseudo à chaque joueur (petite spécificité)
		REPETER
			ECRIRE "Joueur 1 : saisissez votre pseudo (champs obligatoire):"                              //$ Le joueur 1 saisit Gérard
			LIRE j1
		JUSQU'A (LONGUEUR(j1) > 0)
		REPETER
			ECRIRE "Joueur 2 : saisissez votre pseudo (champs obligatoire) :"                              //$ Le joueur 2 saisit Nicolas
			LIRE j2
		JUSQU'A (LONGUEUR(j2) > 0)

		
		//boucle de traitement du jeu
		REPETER
			
			//gestion du tour du joueur
			SI (tour_joueur = VRAI) ALORS
				ECRIRE "<Tour de ", j1, " !>"
			SINON 
				ECRIRE "<Tour de ", j2, " !>"
			FIN SI
			
			//traitement des allumettes
			ECRIRE "Il reste ", allum_rest, " allumettes."
			ECRIRE "Combien d'allumettes voulez-vous retirer ?"
			LIRE allum_retir                                                                                                                                //$ Gérard saisit 2
			SI ((allum_retir >= 1) ET (allum_retir <= 3)) ALORS                           //pour que l'utilisateur ne retire pas plus de 3 allumettes       //$ Gérard ne commet pas d'erreur
				ECRIRE "Vous avez retiré ", allum_retir, " allumettes."                   //on informe le joueur
				allum_rest <- allum_rest - allum_retir                                    //calcul du nouveau tas                                           //$ 21 - 2 = 19
				ECRIRE "Il reste maintenant ", allum_rest, "allumettes."                  //on informe le joueur
				win <- allum_rest MOD MULTI4 = 1                                          //condition de victoire                                           //$ 19 MOD 4 = 3 et pas 1
				tour_joueur <- NON(tour_joueur)                                            //on change de joueur lorsqu'on recommence la boucle              //$ Nico jouera le prochain tour
			SINON 
				ECRIRE "Votre nombre d'allumettes à retirer est faux !"
			FIN SI
		JUSQU'A (win = VRAI)                                                              //$ Imaginons que Nico tombe sur 17 allumettes, il remplit la condition de victoire

		//sortie informative de la victoire
		SI (tour_joueur = FAUX) ALORS
			ECRIRE j1, "a gagné !"
		SINON
			ECRIRE j2, "a gagné !"                                                        //$ tour_joueur sera égal à VRAI, donc Nico aura gagné
		FIN SI

	FIN.




	ALGORITHME : Jeu_allumettes_v2
	//BUT : Un joueur et une IA s'affrontent au jeu de Nim. Le joueur doit essayer de laisser un nombre multiple de 4 plus une allumettes dans un tas de 21 allumettes au départ. 
	Le joueur et l'IA, durant leur tour, peut retirer une, deux ou trois allumettes.
	// ENTREES : L'utilisateur saisit un nombre d'allumettes à retirer. 
	// SORTIES : L'algorithme renvoie le nombre d'allumettes restantes, puis renseigne le joueur s'il a gagné ou pas.
	// PRINCIPES : L'algoritme se répète jusqu'à ce qu'il reste un nombre multiple de 4 plus une allumettes. Il envoie à la fin le nom du gagnant.

	CONST :

	MULTI4 <- 4 : ENTIER

	VAR :

	allum_rest, allum_retir : ENTIER
	tour_joueur, win : BOOLEEN

	DEBUT :

		//initialisation de nos variables
		allum_rest <- 21
		allum_retir <- 0
		tour_joueur <- VRAI
		win <- FAUX
		
		//on explique les règles aux utilisateurs : user friendly
		ECRIRE "Bienvenue au jeu des allumettes !"
		//on saute plusieurs lignes pour plus de clarté
		ECRIRE "Vous débutez avec un tas de 21 allumettes ! Durant votre tour, vous devrez enlever soit 1, soit 2, soit 3 allumettes du tas. Si à la fin de votre tour, il reste un 
		nombre d'allumettes égal à un multiple de 4 + 1 allumette, vous gagnez !"
		ECRIRE "Appuyez sur une touche pour continuer :"
		
		//boucle de traitement du jeu
		REPETER
			ECRIRE "Combien d'allumettes voulez-vous retirer ?"
			LIRE allum_retir                                                                                                                           //$ Nico décide de retirer 1 allumette
			SI ((allum_retir >= 1) ET (allum_retir <= 3)) ALORS                           //pour que l'utilisateur ne retire pas plus de 3 allumettes  //$ Ici, Nico respecte la loi
				ECRIRE "Vous avez retiré ", allum_retir, " allumettes."                   //on informe le joueur
				allum_rest <- allum_rest - allum_retir                                    //calcul du nouveau tas                                      //$ 21 - 1 = 20 
				ECRIRE "Il reste maintenant ", allum_rest, "allumettes."                  //on informe le joueur
				win <- allum_rest MOD MULTI4 = 1                                          //condition de victoire                                      //$ 20 MOD 4 = 0 et pas 1
				tour_joueur <- NON tour_joueur                                            //on change de joueur lorsqu'on recommence la boucle         //$ au tour de l'IA, si Nico n'a pas gagné
				SI (win = FAUX) ALORS
					SI (allum_rest MOD multi4 = 0) ALORS                                  //$ 20 MOD 4 = 0 donc la condition est respectée
						allum_rest <- allum_rest - 3                                      //$ 17 <- 20 - 3
					SINON
						//on affecte à allum_retir de manière aléatoire 1 ou 2
						allum_rest <- allum_rest - allum_retir
					FIN SI
					ECRIRE "Après le tour d'IA, il reste ", allum_rest, " allumettes."
					win <- allum_rest MOD MULTI4 = 1                                      //$ 17 MOD 4 = 1        
					tour_joueur <- NON tour_joueur   
				SINON                                                                     
					ECRIRE "Et le gagnant est..."                          
				FIN SI
			SINON 
				ECRIRE "Votre nombre d'allumettes à retirer est faux !"
			FIN SI
		JUSQU'A (win = VRAI)


		//sortie informative de la victoire
		SI (tour_joueur = FAUX) ALORS
			ECRIRE "Vous avez gagné !"
		SINON
			ECRIRE "Vous avez perdu !"                                                   //$ Nico a donc perdu ! Comme c'est dommage !
		FIN SI

	FIN.





	ALGORITHME : Jeu_allumettes_v3
	//BUT : Un joueur et une IA s'affrontent au jeu de Nim. Le joueur doit essayer de laisser un nombre multiple de 4 plus une allumettes dans un tas de 16 allumettes au départ. 
	Le joueur et l'IA, durant leur tour, peut retirer une, deux ou trois allumettes. Dans cette variante, le joueur ne peut retirer que sur une ligne de 7, de 5, de 3 ou de 1 allumettes.
	// ENTREES : L'utilisateur saisit un nombre d'allumettes à retirer. 
	// SORTIES : L'algorithme renvoie le nombre d'allumettes restantes, puis renseigne le joueur s'il a gagné ou pas.
	// PRINCIPES : L'algoritme se répète jusqu'à ce qu'il reste un nombre multiple de 4 plus une allumettes. Il envoie à la fin le nom du gagnant. Ici le joueur doit sélectionner la
	ligne où il doit retirer les allumettes.

	CONST :

	MULTI4 <- 4 : ENTIER

	VAR :

	allum_rest, allum_retir, ligne1, ligne2, ligne3, ligne4, ligne5, ligne6, tas : ENTIER
	tour_joueur, win, erreur : BOOLEEN

	DEBUT :

		//initialisation de nos variables
		allum_rest <- 21
		allum_retir <- 0
		tas <- 0
		tour_joueur <- VRAI
		win <- FAUX
		erreur <- FAUX
		ligne1 <- 1
		ligne2 <- 2
		ligne3 <- 3
		ligne4 <- 4
		ligne5 <- 5
		ligne6 <- 6
		
		//on explique les règles aux utilisateurs : user friendly
		ECRIRE "Bienvenue au jeu des allumettes !"
		//on saute plusieurs lignes pour plus de clarté
		ECRIRE "Vous débutez avec un tas de 21 allumettes ! Durant votre tour, vous devrez enlever soit 1, soit 2, soit 3 allumettes d'une ligne. Si à la fin de votre tour, il reste un 
		nombre d'allumettes égal à un multiple de 4 + 1 allumette, vous gagnez !"
		ECRIRE "Le tas 1 contient 1 allumette, le tas 2 contient 2 allumettes, les tas 3 contient 3 allumettes, le tas 4 contient 4 allumettes, etc..."
		ECRIRE "Appuyez sur une touche pour continuer :"
		
		//boucle de traitement du jeu
		REPETER
			erreur <- FAUX                                                         //on réinitialise la variable d'erreur
			ECRIRE "De quel tas voulez vous retirer vos allumettes ?"
			LIRE tas                                                                                                                             //$ Nico saisit le tas 2
			ECRIRE "Combien d'allumettes voulez-vous retirer ?"
			LIRE allum_retir                                                                                                                     //$ Nico saisit 2 allumettes

			SI (tas = 1) ALORS
				SI (allum_retir >= 1) ET (allum_retir <= 3) ET (allum_retir <= ligne1) ALORS                           
					ECRIRE "Vous avez retiré ", allum_retir, " allumettes dans le tas", tas.                   
					allum_rest <- allum_rest - allum_retir  
					ligne1 <- ligne1 - allum_retir                                  
					ECRIRE "Il reste maintenant ", ligne1, "allumettes dans le tas", tas.
					ECRIRE "Il reste maintenant ", allum_rest, "allumettes en tout."
				SINON
					erreur <- VRAI
				FIN SI
			FIN SI

			SI (tas = 2) ALORS
				SI (allum_retir >= 1) ET (allum_retir <= 3) ET (allum_retir <= ligne2) ALORS                                            //$ La condition est respectée ! Bravo Nico             
					ECRIRE "Vous avez retiré ", allum_retir, " allumettes dans le tas", tas.                   
					allum_rest <- allum_rest - allum_retir                                                                                           //$ 19 <- 21 - 2
					ligne2 <- ligne2 - allum_retir                                                                                                   //$ 0 <- 2 - 2                              
					ECRIRE "Il reste maintenant ", ligne2, "allumettes dans le tas", tas.                                                            //$ Le tas est maintenant vide !
					ECRIRE "Il reste maintenant ", allum_rest, "allumettes en tout."
				SINON
					erreur <- VRAI
				FIN SI
			FIN SI

			SI (tas = 3) ALORS
				SI (allum_retir >= 1) ET (allum_retir <= 3) ET (allum_retir <= ligne3) ALORS                         
					ECRIRE "Vous avez retiré ", allum_retir, " allumettes dans le tas", tas.                   
					allum_rest <- allum_rest - allum_retir  
					ligne3 <- ligne3 - allum_retir                                  
					ECRIRE "Il reste maintenant ", ligne3, "allumettes dans le tas", tas.
					ECRIRE "Il reste maintenant ", allum_rest, "allumettes en tout."
				SINON
					erreur <- VRAI
				FIN SI
			FIN SI

			SI (tas = 4) ALORS
				SI (allum_retir >= 1) ET (allum_retir <= 3) ET (allum_retir <= ligne4) ALORS                           
					ECRIRE "Vous avez retiré ", allum_retir, " allumettes dans le tas", tas.                   
					allum_rest <- allum_rest - allum_retir  
					ligne4 <- ligne4 - allum_retir                                  
					ECRIRE "Il reste maintenant ", ligne4, "allumettes dans le tas", tas.
					ECRIRE "Il reste maintenant ", allum_rest, "allumettes en tout."
				SINON
					erreur <- VRAI
				FIN SI
			FIN SI

			SI (tas = 5) ALORS
				SI (allum_retir >= 1) ET (allum_retir <= 3) ET (allum_retir <= ligne5) ALORS                           
					ECRIRE "Vous avez retiré ", allum_retir, " allumettes dans le tas", tas.                   
					allum_rest <- allum_rest - allum_retir  
					ligne5 <- ligne5 - allum_retir                                  
					ECRIRE "Il reste maintenant ", ligne5, "allumettes dans le tas", tas.
					ECRIRE "Il reste maintenant ", allum_rest, "allumettes en tout."
				SINON
					erreur <- VRAI
				FIN SI
			FIN SI

			SI (tas = 6) ALORS
				SI (allum_retir >= 1) ET (allum_retir <= 3) ET (allum_retir <= ligne6) ALORS                           
					ECRIRE "Vous avez retiré ", allum_retir, " allumettes dans le tas", tas.                   
					allum_rest <- allum_rest - allum_retir  
					ligne6 <- ligne6 - allum_retir                                  
					ECRIRE "Il reste maintenant ", ligne6, "allumettes dans le tas", tas.
					ECRIRE "Il reste maintenant ", allum_rest, "allumettes en tout."
				SINON
					erreur <- VRAI
				FIN SI
			FIN SI

			SI ((tas < 1) OU (tas > 6)) ALORS                                                                                           //$ Si Nico aurait fait le malin et saisit un tas 7,
				erreur <- VRAI                                                                                                          //$ erreur serait changée en VRAI.
			FIN SI
								
			
			SI (erreur = VRAI) ALORS
				ECRIRE "Veuillez recommencer, erreur !"
			SINON
				win <- allum_rest MOD MULTI4 = 1                                                                                 //$ 19 MOD 4 = 3 et pas 1                                    
				tour_joueur <- NON tour_joueur                                                                                   //$ c'est donc au tour de l'IA                                
				SI (win = FAUX) ALORS
					SI (ligne1 > 0) ALORS                                                                                                               //$ il reste 1 allumette sur la ligne 1
						// on affecte à la variable allum_retir une valeur aléatoire comprise entre 1 et la valeur de la variable ligne1                //$ dans ce cas, allum_rest <- 1
						ECRIRE "L'IA a retiré", allum_retir, "allumettes du tas 1"
						ligne1 <- ligne1 - allum_retir                                                                                                  //$ 0 <- 1 - 1
						allum_rest <- allum_rest - allum_retir                                                                                          //$ 18 <- 19 - 1
						ECRIRE "Il reste dans le tas 1", ligne1, "allumettes".
					SINON
						SI (ligne2 > 0) ALORS
							// on affecte à la variable allum_retir une valeur aléatoire comprise entre 1 et la valeur de la variable ligne2
							ECRIRE "L'IA a retiré", allum_retir, "allumettes du tas 2"
							ligne2 <- ligne2 - allum_retir
							allum_rest <- allum_rest - allum_retir
							ECRIRE "Il reste dans le tas 2", ligne2, "allumettes".
						SINON
							SI (ligne3 > 0) ALORS
								// on affecte à la variable allum_retir une valeur aléatoire comprise entre 1 et la valeur de la variable ligne3
								ECRIRE "L'IA a retiré", allum_retir, "allumettes du tas 1"
								ligne3 <- ligne3 - allum_retir
								allum_rest <- allum_rest - allum_retir
								ECRIRE "Il reste dans le tas 3", ligne3, "allumettes".
							SINON
								SI (ligne4 > 0) ALORS
									SI (ligne4 > 3) ALORS
										// on affecte à la variable allum_retir une valeur aléatoire comprise entre 1 et la valeur de la variable ligne4 - 1
									SINON
										// on affecte à la variable allum_retir une valeur aléatoire comprise entre 1 et la valeur de la variable ligne4
									FIN SI
									ECRIRE "L'IA a retiré", allum_retir, "allumettes du tas 4"
									ligne4 <- ligne4 - allum_retir
									allum_rest <- allum_rest - allum_retir
									ECRIRE "Il reste dans le tas 4", ligne4, "allumettes".
								SINON
									SI (ligne5 > 0) ALORS
										SI (ligne5 > 3) ALORS
											// on affecte à la variable allum_retir une valeur aléatoire comprise entre 1 et la valeur de la variable ligne5 - 2
										SINON
											// on affecte à la variable allum_retir une valeur aléatoire comprise entre 1 et la valeur de la variable ligne5
										FIN SI
										ECRIRE "L'IA a retiré", allum_retir, "allumettes du tas 5"
										ligne5 <- ligne5 - allum_retir
										allum_rest <- allum_rest - allum_retir
										ECRIRE "Il reste dans le tas 5", ligne5, "allumettes".
									SINON
										SI (ligne6 > 0) ALORS
											SI (ligne6 > 3) ALORS
												// on affecte à la variable allum_retir une valeur aléatoire comprise entre 1 et la valeur de la variable ligne6 - 3
											SINON
												// on affecte à la variable allum_retir une valeur aléatoire comprise entre 1 et la valeur de la variable ligne6
											FIN SI
											ECRIRE "L'IA a retiré", allum_retir, "allumettes du tas 6"
											ligne6 <- ligne6 - allum_retir
											allum_rest <- allum_rest - allum_retir
											ECRIRE "Il reste dans le tas 6", ligne6, "allumettes".
										FIN SI
									FIN SI
								FIN SI
							FIN SI
						FIN SI
					FIN SI
					ECRIRE "Après le tour d'IA, il reste ", allum_rest, " allumettes."
					win <- allum_rest MOD MULTI4 = 1                                                         //$ 18 MOD 4 = 2 et pas 1                             
					tour_joueur <- NON tour_joueur                                                           //$ donc c'est de nouveau au tour de Nico
				SINON
					ECRIRE "Et le gagnant est..."
				FIN SI
			FIN SI
		JUSQU'A (win = VRAI)


		//sortie informative de la victoire
		SI (tour_joueur = FAUX) ALORS
			ECRIRE "Vous avez gagné !"
		SINON
			ECRIRE "Vous avez perdu !"
		FIN SI

	FIN.

}



//VERSION 1 DU JEU DES ALLUMETTES !
//SUPPRIMEZ LES ACCOLADES POUR FAIRE FONCTIONNER ! 


PROGRAM Jeu_allumettes_v1;
//BUT : Deux joueurs s'affrontent au jeu de Nim. Chaque joueur doit essayer de laisser un nombre multiple de 4 plus une allumettes dans un tas de 21 allumettes au départ. Chaque 
// joueur, durant son tour, peut retirer une, deux ou trois allumettes.
// ENTREES : L'utilisateur saisit un nombre d'allumettes à retirer. Il va au préalable choisir un pseudo (spécificité).
// SORTIES : Le programme renvoie le nombre d'allumettes restantes, puis le nom du gagnant.
// PRINCIPES : Le programme se répète jusqu'à ce qu'il reste un nombre multiple de 4 plus une allumettes. Il envoie à la fin le nom du gagnant.

USES crt;

CONST 

MULTI4 = 4;

VAR

j1, j2 : string;      //les joueurs saisiront un pseudo (petite spécificité)
allum_rest, allum_retir : integer;
tour_joueur, win : boolean;

BEGIN 

	//initialisation de nos variables
	j1 := 'joueur1';
	j2 := 'joueur2';
	allum_rest := 21;
	allum_retir := 0;
	tour_joueur := TRUE;
	win := FALSE;

	clrscr; 
		
	//on explique les règles aux utilisateurs : user friendly
	writeln ('Bienvenue au jeu des allumettes, pour deux joueurs !');
	//on saute plusieurs lignes pour plus de clarté
	writeln;
	writeln;
	writeln ('Vous debutez avec un tas de 21 allumettes ! Chacun votre tour, vous devrez enlever soit 1, soit 2, soit 3 allumettes du tas.');
	writeln ('Si a la fin de votre tour, il reste un nombre d allumettes egal à un multiple de 4 + 1 allumette, vous gagnez !');
	writeln ('Appuyez sur une touche pour continuer :');

	//le programme demande un pseudo à chaque joueur (petite spécificité)
	Repeat
		begin
		writeln ('Joueur 1 : saisissez votre pseudo (champs obligatoire):');                              //$ Le joueur 1 saisit Gérard
		readln (j1);
		end;
	until length(j1) > 0;
	repeat
		begin
		writeln ('Joueur 2 : saisissez votre pseudo (champs obligatoire) :');                              //$ Le joueur 2 saisit Nicolas
		readln (j2);
		end;
	until length(j2) > 0;

		
	//boucle de traitement du jeu
	repeat
		begin
			
		//gestion du tour du joueur
		if (tour_joueur = TRUE) then
			writeln ('<Tour de ', j1, ' !>')
		else 
			writeln ('<Tour de ', j2, ' !>');
			
		//traitement des allumettes
		writeln ('Il reste ', allum_rest, ' allumettes.');
		writeln ('Combien d allumettes voulez-vous retirer ?');
		readln (allum_retir);                                                                                                                               
		if ((allum_retir >= 1) and (allum_retir <= 3)) then           //vérification du tirage d'allumettes (respecté ou non)
			begin                          
			writeln ('Vous avez retire ', allum_retir, ' allumettes.');                 
			allum_rest := allum_rest - allum_retir;                                   
			writeln ('Il reste maintenant ', allum_rest, ' allumettes.');                 
			win := (allum_rest MOD MULTI4 = 1);                                         
			tour_joueur := NOT(tour_joueur)
			end                                            
		else 
			writeln ('Votre nombre d allumettes a retirer est faux !')
		end;

	until win = TRUE;                                                             

	//sortie informative de la victoire
	if (tour_joueur = FALSE) then
		writeln (j1, ' gagne !')
	else
		writeln (j2, ' gagne !');    

	readln;                                                   

END.




//VERSION 2 DU JEU DES ALLUMETTES !
//SUPPRIMEZ LES ACCOLADES POUR FAIRE FONCTIONNER ! 

{
PROGRAM Jeu_allumettes_v2;

//BUT : Un joueur et une IA s'affrontent au jeu de Nim. Le joueur doit essayer de laisser un nombre multiple de 4 plus une allumettes dans un tas de 21 allumettes au départ. 
// Le joueur et l'IA, durant leur tour, peut retirer une, deux ou trois allumettes.
// ENTREES : L'utilisateur saisit un nombre d'allumettes à retirer. 
// SORTIES : Le programme renvoie le nombre d'allumettes restantes, puis renseigne le joueur s'il a gagné ou pas.
// PRINCIPES : Le programme se répète jusqu'à ce qu'il reste un nombre multiple de 4 plus une allumettes. Il envoie à la fin le nom du gagnant.

USES crt;

CONST 

MULTI4 = 4;

VAR 

allum_rest, allum_retir : integer;
tour_joueur, win : boolean;

BEGIN 

	//initialisation de nos variables
	allum_rest := 21;
	allum_retir := 0;
	tour_joueur := TRUE;
	win := FALSE;

	clrscr;
		
	//on explique les règles aux utilisateurs : user friendly
	writeln ('Bienvenue au jeu des allumettes !');
	//on saute plusieurs lignes pour plus de clarté
	writeln ('Vous debutez avec un tas de 21 allumettes ! Durant votre tour, vous devrez enlever soit 1, soit 2, soit 3 allumettes du tas.'); 
	writeln ('Si à la fin de votre tour, il reste un nombre d allumettes egal à un multiple de 4 + 1 allumette, vous gagnez !');
	writeln ('Appuyez sur une touche pour continuer :');

	//boucle de traitement du jeu
	repeat
		begin
		writeln ('Combien d allumettes voulez-vous retirer ?');
		readln (allum_retir);                                                                                                                         
		if ((allum_retir >= 1) and (allum_retir <= 3)) then     //vérification du tirage d'allumettes (respecté ou non)
			begin                        
			writeln ('Vous avez retire ', allum_retir, ' allumettes.');                 
			allum_rest := allum_rest - allum_retir;                                                      
			writeln ('Il reste maintenant ', allum_rest, ' allumettes.');              
			win := (allum_rest MOD MULTI4 = 1);                                         
			tour_joueur := NOT (tour_joueur);                                          
			if (win = FALSE) then
				begin				
				//on affecte à allum_retir de manière aléatoire 1 ou 2
				Randomize;
				allum_retir := random(3) + 1; 
				allum_rest := allum_rest - allum_retir;
				writeln ('Apres le tour d IA, il reste ', allum_rest, ' allumettes.');
				win := (allum_rest MOD MULTI4 = 1);                                   
				tour_joueur := NOT (tour_joueur);  
				end;            
			end
		else
			writeln ('Votre nombre d allumettes a retirer est faux !');
		end;
	until win = TRUE;


	//sortie informative de la victoire
	if (tour_joueur = FALSE) then
		writeln ('Vous avez gagne !')
	else
		writeln ('Vous avez perdu !');                                                   

	readln;
END.
}


//VERSION 3 DU JEU DES ALLUMETTES !
//SUPPRIMEZ LES ACCOLADES POUR FAIRE FONCTIONNER ! 

{
PROGRAM Jeu_allumettes_v3;
// BUT : Un joueur et une IA s'affrontent au jeu de Nim. Le joueur doit essayer de laisser un nombre multiple de 4 plus une allumettes dans un tas de 16 allumettes au départ. 
// Le joueur et l'IA, durant leur tour, peut retirer une, deux ou trois allumettes. Dans cette variante, le joueur ne peut retirer que sur une ligne de 7, de 5, de 3 ou de 1 allumettes.
// ENTREES : L'utilisateur saisit un nombre d'allumettes à retirer. 
// SORTIES : L'algorithme renvoie le nombre d'allumettes restantes, puis renseigne le joueur s'il a gagné ou pas.
// PRINCIPES : L'algoritme se répète jusqu'à ce qu'il reste un nombre multiple de 4 plus une allumettes. Il envoie à la fin le nom du gagnant. Ici le joueur doit sélectionner la
// ligne où il doit retirer les allumettes.

USES crt;

CONST 

MULTI4 = 4;

VAR 

allum_rest, allum_retir, ligne1, ligne2, ligne3, ligne4, ligne5, ligne6, tas : integer;
tour_joueur, win, erreur : boolean;

begin 

	clrscr;
	//initialisation de nos variables
	allum_rest := 21;
	allum_retir := 0;
	tas := 0;
	tour_joueur := TRUE;
	win := FALSE;
	erreur := FALSE;
	ligne1 := 1;
	ligne2 := 2;
	ligne3 := 3;
	ligne4 := 4;
	ligne5 := 5;
	ligne6 := 6;
		
	//on explique les règles aux utilisateurs : user friendly
	writeln ('Bienvenue au jeu des allumettes !');
	//on saute plusieurs lignes pour plus de clarté
	writeln ('Vous debutez avec un tas de 21 allumettes ! Durant votre tour, vous devrez enlever soit 1, soit 2, soit 3 allumettes d une ligne.');
	writeln ('Si à la fin de votre tour, il reste un nombre d allumettes égal à un multiple de 4 + 1 allumette, vous gagnez !');
	writeln ('Le tas 1 contient 1 allumette, le tas 2 contient 2 allumettes, les tas 3 contient 3 allumettes, le tas 4 contient 4 allumettes, etc...');
	writeln ('Appuyez sur une touche pour continuer :');
	readln;
	writeln;
	writeln;
	
	//boucle de traitement du jeu
	repeat
		begin
		erreur := FALSE;                                                      
		writeln ('De quel tas voulez vous retirer vos allumettes ?');
		readln (tas);                                                                                                                             
		writeln ('Combien d allumettes voulez-vous retirer ?');
		readln (allum_retir);                                                                                                                     

		if (tas = 1) then 
			if (allum_retir >= 1) and (allum_retir <= 3) and (allum_retir <= ligne1) then         //test de vérification du tirage d'allumettes pour le tas 1                    
				begin
				writeln ('Vous avez retire ', allum_retir, ' allumettes dans le tas ', tas);                   
				allum_rest := allum_rest - allum_retir;
				ligne1 := ligne1 - allum_retir;                               
				writeln ('Il reste maintenant ', ligne1, ' allumettes dans le tas ', tas);
				writeln ('Il reste maintenant ', allum_rest, ' allumettes en tout.')
				end
			else
				erreur := TRUE;

		if (tas = 2) then 
			if (allum_retir >= 1) and (allum_retir <= 3) and (allum_retir <= ligne2) then        //test de vérification du tirage d'allumettes pour le tas 2
				begin                          
				writeln ('Vous avez retire ', allum_retir, ' allumettes dans le tas', tas);                   
				allum_rest := allum_rest - allum_retir;
				ligne2 := ligne2 - allum_retir;                               
				writeln ('Il reste maintenant ', ligne2, ' allumettes dans le tas', tas);
				writeln ('Il reste maintenant ', allum_rest, ' allumettes en tout.')
				end
			else
				erreur := TRUE;

		if (tas = 3) then 
			if (allum_retir >= 1) and (allum_retir <= 3) and (allum_retir <= ligne3) then        //etc... pour le tas 3
				begin                       
				writeln ('Vous avez retire ', allum_retir, ' allumettes dans le tas ', tas);                   
				allum_rest := allum_rest - allum_retir;
				ligne3 := ligne3 - allum_retir;                               
				writeln ('Il reste maintenant ', ligne3, ' allumettes dans le tas ', tas);
				writeln ('Il reste maintenant ', allum_rest, ' allumettes en tout.')
				end
			else
				erreur := TRUE;

		if (tas = 4) then 
			if (allum_retir >= 1) and (allum_retir <= 3) and (allum_retir <= ligne4) then
				begin                           
				writeln ('Vous avez retire ', allum_retir, ' allumettes dans le tas', tas);                   
				allum_rest := allum_rest - allum_retir;
				ligne4 := ligne4 - allum_retir;                               
				writeln ('Il reste maintenant ', ligne4, ' allumettes dans le tas ', tas);
				writeln ('Il reste maintenant ', allum_rest, ' allumettes en tout.')
				end
			else
				erreur := TRUE;

		if (tas = 5) then 
			if (allum_retir >= 1) and (allum_retir <= 3) and (allum_retir <= ligne5) then
				begin                           
				writeln ('Vous avez retire ', allum_retir, ' allumettes dans le tas ', tas);                   
				allum_rest := allum_rest - allum_retir;
				ligne5 := ligne5 - allum_retir;                               
				writeln ('Il reste maintenant ', ligne5, ' allumettes dans le tas ', tas);
				writeln ('Il reste maintenant ', allum_rest, ' allumettes en tout.')
				end
			else
				erreur := TRUE;

		if (tas = 6) then 
			if (allum_retir >= 1) and (allum_retir <= 3) and (allum_retir <= ligne6) then  
				begin                         
				writeln ('Vous avez retire ', allum_retir, ' allumettes dans le tas ', tas);                   
				allum_rest := allum_rest - allum_retir;
				ligne6 := ligne6 - allum_retir;                               
				writeln ('Il reste maintenant ', ligne6, ' allumettes dans le tas ', tas);
				writeln ('Il reste maintenant ', allum_rest, 'allumettes en tout.')
				end
			else
				erreur := TRUE;

		if ((tas < 1) or (tas > 6)) then                  //si jamais l'utilisateur saisit un tas inexistant                                                                           
			erreur := TRUE;                                                                                                       
		
		if (erreur = TRUE) then
			begin
			writeln ('Veuillez recommencer, erreur !')
			end
		else
			begin
			win := (allum_rest MOD MULTI4 = 1);                                                                                                                
			tour_joueur := NOT (tour_joueur);                                                                                                                  
			if (win = FALSE) then
				begin
				if (ligne1 > 0) then
					begin                                                                                                              
					// on affecte à la variable allum_retir une valeur aléatoire comprise entre 1 et la valeur de la variable ligne1
					Randomize;
					allum_retir := random(ligne1) + 1;              
					writeln ('L IA a retire ', allum_retir, ' allumettes du tas 1');
					ligne1 := ligne1 - allum_retir;                                                                                                
					allum_rest := allum_rest - allum_retir;                                                                                        
					writeln ('Il reste dans le tas 1, ', ligne1, ' allumettes')
					end
				else if (ligne2 > 0) then
					begin
					// on affecte à la variable allum_retir une valeur aléatoire comprise entre 1 et la valeur de la variable ligne2
					Randomize;
					allum_retir := random(ligne2) + 1;
					writeln ('L IA a retire ', allum_retir, ' allumettes du tas 2');
					ligne2 := ligne2 - allum_retir;
					allum_rest := allum_rest - allum_retir;
					writeln ('Il reste dans le tas 2, ', ligne2, ' allumettes')
					end
				else if (ligne3 > 0) then
					begin
					// on affecte à la variable allum_retir une valeur aléatoire comprise entre 1 et la valeur de la variable ligne3
					Randomize;
					allum_retir := random(ligne3) + 1;
					writeln ('L IA a retire ', allum_retir, ' allumettes du tas 3');
					ligne3 := ligne3 - allum_retir;
					allum_rest := allum_rest - allum_retir;
					writeln ('Il reste dans le tas 3, ', ligne3, ' allumettes')
					end
				else if (ligne4 > 0) then
					begin
					if (ligne4 > 3) then
						begin
						// on affecte à la variable allum_retir une valeur aléatoire comprise entre 1 et la valeur de la variable ligne4 - 1
						Randomize;
						allum_retir := random(ligne4-1) + 1
						end
					else
						begin
						// on affecte à la variable allum_retir une valeur aléatoire comprise entre 1 et la valeur de la variable ligne4
						Randomize;
						allum_retir := random(ligne4) + 1
						end;
					writeln ('L IA a retire ', allum_retir, ' allumettes du tas 4');
					ligne4 := ligne4 - allum_retir;
					allum_rest := allum_rest - allum_retir;
					writeln ('Il reste dans le tas 4, ', ligne4, ' allumettes')
					end
				else if (ligne5 > 0) then
					begin
					if (ligne5 > 3) then
						begin
						// on affecte à la variable allum_retir une valeur aléatoire comprise entre 1 et la valeur de la variable ligne5 - 2
						Randomize;
						allum_retir := random(ligne5-2) + 1
						end
					else
						begin
						// on affecte à la variable allum_retir une valeur aléatoire comprise entre 1 et la valeur de la variable ligne5
						Randomize;
						allum_retir := random(ligne5) + 1
						end;
					writeln ('L IA a retire ', allum_retir, ' allumettes du tas 5');
					ligne5 := ligne5 - allum_retir;
					allum_rest := allum_rest - allum_retir;
					writeln ('Il reste dans le tas 5, ', ligne5, ' allumettes')
					end
				else if (ligne6 > 0) then
					begin
					if (ligne6 > 3) then
						begin
						// on affecte à la variable allum_retir une valeur aléatoire comprise entre 1 et la valeur de la variable ligne6 - 3
						Randomize;
						allum_retir := random(ligne6-3) + 1
						end
					else
						begin
						// on affecte à la variable allum_retir une valeur aléatoire comprise entre 1 et la valeur de la variable ligne6
						Randomize;
						allum_retir := random(ligne6) + 1
						end;
					writeln ('L IA a retire ', allum_retir, ' allumettes du tas 6');
					ligne6 := ligne6 - allum_retir;
					allum_rest := allum_rest - allum_retir;
					writeln ('Il reste dans le tas 6, ', ligne6, ' allumettes')
					end;
				
				writeln ('Apres le tour d IA, il reste ', allum_rest, ' allumettes.');
				win := (allum_rest MOD MULTI4 = 1);                                                                                      
				tour_joueur := NOT (tour_joueur)
				end                                                         
			else
				begin
				writeln ('Et le gagnant est...');
				end
			end;
		end;
	until win = TRUE;


	//sortie informative de la victoire
	if (tour_joueur = FALSE) then
		writeln ('Vous avez gagne !')
	else
		writeln ('Vous avez perdu !');

	readln;

END.
}