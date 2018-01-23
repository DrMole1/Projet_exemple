{
	ALGORITHME : Pendu
	// BUT : Le joueur 1 saisit un mot et ne joue plus. Le joueur 2 propose ensuite une lettre par une lettre jusqu'à deviner le mot. Au bout de 15 fautes, il perd (un pendu se dessine progressivement). 
	// ENTREES : Le joueur 1 saisit un mot (chaine de caractères) et le joueur 2 saisit des caractères.
	// SORTIES : L'algo renvoie des booléens en cas d'erreurs ou de victoire et renvoie la chaîne de caractères (dont les caractères non trouvés représentent des cunderscores).
	// PRINCIPE : On mesure la longueur du mot à deviner. On présentera à chaque tour un mot masqué constitué d'autant d'underscores que de lettres ainsi qu'un début de pendu en cas de fautes. Les lettres 
	précédement trouvées seront affichées. On utilisera pour cela des extractions dans une nouvelle boucle incrémentée dans la première. L'algo se finit si le joueur 2 devine le mot ou s'il commet 15 fautes.

	CONST

		FAUTEMAX <- 15 : ENTIER

	VAR

		mot_Masque, mot_Adeviner : CHAINE
		car_Rech : CARACTERE
		cpt, lghchaine, faute : ENTIER
		erreur : BOOLEEN

	DEBUT

		//on initialise nos varibales
		mot_Masque <- ""
		mot_Adeviner <- ""
		car_Rech <- ''
		lgchaine <- 0
		cpt <- 1
		faute <- 0
		erreur <- VRAI    //erreur deviendra FAUX si une lettre est trouvée

		//explication du jeu du pendu
		ECRIRE "Bienvenue au jeu du pendu !"
		ECRIRE "Le joueur saisit un mot, puis le joueur 2 devra le trouver en proposant des lettres. A 15 fautes, il perd !"

		//boucle de saisie du mot à deviner pour le joueur 1
		REPETER
			ECRIRE "Joueur 1 : veuillez saisir le mot à deviner."                                                                           //$ J1 saisit "BOBY"
			LIRE mot_Adeviner
		JUSQU'A (LONGUEUR(mot_Adeviner)>0)                                                                                                  //$ LONGUEUR(BOBY) > 0

		//création du mot masqué
		lgchaine <- LONGUEUR (mot_Adeviner)
		POUR cpt DE 1 A lgchaine FAIRE
			mot_Masque <- mot_Masque & '_'                                                                                                  //$ mot_Masque = "____" car "BOBY" contient 4 caractères
		FIN POUR

		//boucle de traitement pour la recherche de lettres du joueur 2
		REPETER
			ECRIRE "Joueur 2, veuillez saisir une lettre :"
			LIRE car_Rech                                                                                                                   //$1 J2 saisit d'abord la lettre A      //$2 J2 saisit ensuite B
			SI (LONGUEUR (car_Rech) = 1) ALORS
				cpt <- 1
				erreur <- VRAI
				POUR cpt DE 1 à lgchaine FAIRE                                                                                              //$1 BOBY ne contient pas A             //$2 BOBY contient 2 fois B
					SI (EXTRACTION (mot_Adeviner, cpt) = car_Rech) ALORS
						mot_Masque <- EXTRACTION (mot_Masque, 1, cpt-1) & car_Rech & EXTRACTION (mot_Masque, cpt + 1, lgchaine - cpt)                                               //$2 mot_Masque = "B_B_"
						erreur <- FAUX
					FIN SI
				FIN POUR
				
				//on regarde s'il y a faute ou pas                                                                                          //$1 faute = 1 car erreur = VRAI        //$2 erreur = FAUX donc faute reste à 1
				SI (erreur = VRAI) ALORS
					faute <- faute + 1
				FIN SI
				
				//représentation du pendu
				SI (faute >= 8) ALORS
					ECRIRE "________"  //écrire à la ligne
				FIN SI
				SI (faute >= 7) ALORS
					ECRIRE " !"  //écrire à la ligne
				FIN SI
				SI (faute >= 9) ALORS
					ECRIRE "    !"  
				FIN SI
				SI (faute >= 6) ALORS
					ECRIRE " !"  //écrire à la ligne
				FIN SI
				SI (faute >= 10) ALORS
					ECRIRE "    O"  
				FIN SI
				SI (faute >= 5) ALORS
					ECRIRE " !"  //écrire à la ligne
				FIN SI
				SI (faute >= 11) ALORS
					ECRIRE "   /"  
				FIN SI
				SI (faute >= 12) ALORS
					ECRIRE "!"  
				FIN SI
				SI (faute >= 13) ALORS
					ECRIRE "\"  
				FIN SI
				SI (faute >= 4) ALORS
					ECRIRE " !"  //écrire à la ligne
				FIN SI
				SI (faute >= 14) ALORS
					ECRIRE "   /"  
				FIN SI
				SI (faute >= 15) ALORS
					ECRIRE " \"  
				FIN SI
				SI (faute >= 1) ALORS                                                                                                      //$1 Un morceau de pendu s'affiche
					ECRIRE "_"  //écrire à la ligne
				FIN SI
				SI (faute >= 2) ALORS
					ECRIRE "!"  
				FIN SI
				SI (faute >= 3) ALORS
					ECRIRE "_"  
				FIN SI
				
				ECRIRE mot_Masque
				ECRIRE "Vous êtes à", faute, "fautes !"
			SINON
				ECRIRE "Erreur !"
			FIN SI
		JUSQU'A ((faute = FAUTEMAX) OU (mot_Adeviner = mot_Masque))                                                                        //$3 J2 donnera ensuite O et Y donc mot_Adeviner = mot_Masque

		//résultat
		SI (faute = FAUTEMAX) ALORS                                                                                                        //$3 faute = 1 =/= 15
			ECRIRE "Vous avez perdu !"
		SINON 
			ECRIRE "Vous avez gagné !"                                                                                                     //$3 donc J2 gagne !
		FIN SI
	FIN.


}

PROGRAM Pendu;
// BUT : Le joueur 1 saisit un mot et ne joue plus. Le joueur 2 propose ensuite une lettre par une lettre jusqu'à deviner le mot. Au bout de 15 fautes, il perd (un pendu se dessine progressivement). 
// ENTREES : Le joueur 1 saisit un mot (chaine de caractères) et le joueur 2 saisit des caractères.
// SORTIES : Le progrmme renvoie des booléens en cas d'erreurs ou de victoire et renvoie la chaîne de caractères (dont les caractères non trouvés représentent des cunderscores).
// PRINCIPE : On mesure la longueur du mot à deviner. On présentera à chaque tour un mot masqué constitué d'autant d'underscores que de lettres ainsi qu'un début de pendu en cas de fautes. Les lettres 
// précédement trouvées seront affichées. On utilisera pour cela des extractions dans une nouvelle boucle incrémentée dans la première. L'algo se finit si le joueur 2 devine le mot ou s'il commet 15 fautes.

USES crt;

CONST

	FAUTEMAX = 15;

VAR

	mot_Masque, mot_Adeviner : string;
	car_Rech : char;
	cpt, lgchaine, faute : integer;
	erreur : boolean;

BEGIN

	clrscr; //supression du flux inutile

	//on initialise nos varibales
	mot_Masque := '';
	mot_Adeviner := '';
	lgchaine := 0;
	cpt := 1;
	faute := 0;
	erreur := TRUE;    //erreur deviendra FAUX si une lettre est trouvée

	//explication du jeu du pendu
	writeln ('Bienvenue au jeu du pendu !');
	writeln ('Le joueur saisit un mot, puis le joueur 2 devra le trouver en proposant des lettres. A 15 fautes, il perd !');
	readln;

	//boucle de saisie du mot à deviner pour le joueur 1
	repeat
		writeln ('Joueur 1 : veuillez saisir le mot à deviner.');
		readln (mot_Adeviner);
	until Length(mot_Adeviner)>0;

	//création du mot masqué
	lgchaine := Length (mot_Adeviner);
	FOR cpt:= 1 TO lgchaine DO
		begin
		mot_Masque := (mot_Masque) + '_';
		end;

	//boucle de traitement pour la recherche de lettres du joueur 2
	repeat
		begin
		clrscr;
		writeln ('Joueur 2, veuillez saisir une lettre :');
		readln (car_Rech);
		if (Length (car_Rech) = 1) then
			begin
			erreur := TRUE;
			FOR cpt:=1 TO lgchaine DO
				begin
				if (Copy (mot_Adeviner, cpt, 1) = car_Rech) then
					begin
					mot_Masque := (Copy (mot_Masque, 1, cpt-1)) + (car_Rech) + (Copy (mot_Masque, cpt + 1, lgchaine - cpt));
					erreur := FALSE
					end;
				end;
				
			//on regarde s'il y a faute ou pas
			if (erreur = TRUE) then
				faute := faute + 1;

			//représentation du pendu
			writeln;
			if (faute >= 8) then
				writeln ('________');  //écrire à la ligne
			if (faute >= 7) then
				write (' !');  //écrire à la ligne
			if (faute >= 9) then
				writeln ('    !');  
			if (faute >= 6) then
				write (' !');  //écrire à la ligne
			if (faute >= 10) then
				writeln ('    O');  
			if (faute >= 5) then
				write (' !');  //écrire à la ligne
			if (faute >= 11) then
				write ('   /');  
			if (faute >= 12) then
				write ('!');  
			if (faute >= 13) then
				writeln ('\');  
			if (faute >= 4) then
				write (' !');  //écrire à la ligne
			if (faute >= 14) then
				write ('   /');  
			if (faute >= 15) then
				writeln (' \');  
			if (faute >= 1) then
				write ('_');  //écrire à la ligne
			if (faute >= 2) then
				write ('!');  
			if (faute >= 3) then
				write ('_');  
			
			writeln;
			writeln;	
			writeln (mot_Masque);
			writeln ('Vous etes à ', faute, ' fautes !');
			readln
			end
		else
			begin
			writeln ('Erreur !');
			readln
			end;
		end;
	until (faute = FAUTEMAX) OR (mot_Adeviner = mot_Masque);

	//résultat
	if (faute = FAUTEMAX) then
		writeln ('Vous avez perdu !')
	else
		writeln ('Vous avez gagne !');



	readln;
END.
	