


{Jeu de l'oie : le jeu se joue seul. Le joueur est caractérisé par un nombre : place
(variable), avec des cases comprises entre 0 et 66, qui situe sa position sur le plateau.
Après un jet des 2 dés, on applique règles suivantes :
- On avance du nombre de cases indiquées par la somme des dés.
- Si on arrive pile sur la case 66, le jeu est terminé, sinon, on recule.
- Une oie toute les neuf cases, sauf en 63, double le déplacement en cours (le joueur
ne finira jamais son tour sur un multiple de 9).
- Une tête de mort à la case 58 renvoie à la position de départ case 0.

On s'efforcera d'utiliser au maximum l'emploie de constantes.
Production d'un algo et d'un programme lisible et clair (avec commentaires).
Vérifier que le jet de dé est valide.
Modulo pour test multiple de 9.

Modifs possibles :
-Randomn pour jets de dés. }

{ALGORITHME : Jeu_de_l_oie
// BUT : Réaliser un jeu de l'oie. Les règles et spécéficités du jeu sont écrites plus
//haut.
// ENTREES : L'utilisateur saisit ses valeurs aux jets de dés.
// SORTIES : L'avancement du personnage sur le plateau, un phrase qui affiche la victoire
//du joueur.

CONST

CASE_DEP <- 0 : ENTIER
OIE <- 9 : ENTIER
PAS_OIE <- 63 : ENTIER
MORT <- 58 : ENTIER
LANCER_MIN <- 2 : ENTIER
LANCER_MAX <- 12 : ENTIER
FIN <- 66 : ENTIER

VAR

place, lancer, resultat : ENTIER

DEBUT

	place <- 0 //initialisation de la variable

	REPETER
		ECRIRE "Saisir votre jet au premier dé :"
		LIRE lancer
		resultat <- lancer
		ECRIRE "Saisir votre jet au deuxième dé :"
		LIRE lancer
		resultat <- resultat + lancer
		ECRIRE "Votre résultat est", résultat
		SI ((resultat < LANCER_MIN) OU (resultat > LANCER_MAX)) ALORS
			ECRIRE "Petit tricheur, relance le dé !"
		SINON
			place <- place + resultat
			ECRIRE "Tu te déplaces de ", resultat, " cases."
			ECRIRE "Tu es sur la case ", place
		
			SI ((place MOD OIE = 0) ET (place <> PAS_OIE)) ALORS
				place <- place + resultat
				ECRIRE "Tu es sur une case oie ! Vous vous déplacez d'encore ", resultat,
				" cases."
				ECRIRE "Tu es sur la case ", place
			FIN SI
		
			SI (place = MORT) ALORS
				place <- CASE_DEP
				ECRIRE "Tu es sur la case mort ! Retour case départ !"
				ECRIRE "Tu es sur la case", CASE_DEP
			FIN SI

			SI (place > FIN) ALORS
				place <- place - ((place - FIN)*2)
				ECRIRE "Tu es sur une case supérieure à 66 ! Tu recules donc !"
				ECRIRE "Tu es sur la case", place
			FIN SI

			SI (place = FIN) ALORS
				ECRIRE "Tu as gagné !"
				ECRIRE "Tu es sur la case", place
			FIN SI
		FIN SI
	JUSQU'A (place = FIN)
FIN.
}

PROGRAM Jeu_de_l_oie;

USES crt;

// BUT : Réaliser un jeu de l'oie. Les règles et spécéficités du jeu sont écrites plus
//haut.
// ENTREES : L'utilisateur saisit n'importe quelle touche pour actionner un jet de dé.
// SORTIES : L'avancement du personnage sur le plateau, un phrase qui affiche la victoire
//du joueur.


//programme optimisé
CONST

CASE_DEP = 0;
OIE = 9;
PAS_OIE = 63;
MORT = 58;
FIN = 66;
LONG = 11;
LARG = 6;

VAR

place, lancer, tour, cpt, cpt2 : integer;

BEGIN
	clrscr; //on supprime le flux inutile
	//on initialise nos variables
	place := 0;
	lancer := 0;
	tour := 1;
	// on explique les règles du jeu car il faut être user friendly
	writeln ('Bienvenue sur le jeu de l oie. Ici, on s amuse.');
	writeln ('La regle est simple : il faut atteindre la case 66 tout pile en moins de tours possibles.');
	writeln ('Tu avanceras du nombre de cases que t indiquera tes des. Si tu depasses la case 66, tu recules.');
	writeln ('Il y a une case oie toutes les 9 cases (sauf la case 63), ce qui te permet de doubler ton deplacement en cours.');
	writeln ('La case 58 est une case MORT, si tu tombes dessus, tu reviens a la case depart.');
	writeln ('Appuie sur une touche, puis bonne chance mon ami !');
	readln;
	writeln;
	writeln;
	writeln;
	writeln;
	writeln ('Voici un appercu du plateau de jeu :');
	writeln;
	writeln;

	//on affiche le plateau de jeu pour donner une idée visuelle à l'utilisateur
	writeln (' [ X ] ');
	for cpt:=1 to LONG do
    begin
        for cpt2:=1 to LARG do
        begin

            if ((((cpt - 1)* LARG)+ cpt2) <> MORT) AND ((((cpt - 1)* LARG)+ cpt2) MOD OIE <> 0) OR ((((cpt - 1)* LARG)+ cpt2) = PAS_OIE) then
			    write (' [ ', (((cpt - 1)* LARG)+ cpt2), ' ] ')
	        else
	        	if ((((cpt - 1)* LARG)+ cpt2) = MORT) then
					write (' [MORT] ')
				else
					if ((((cpt - 1)* LARG)+ cpt2) MOD OIE = 0) AND ((((cpt - 1)* LARG)+ cpt2) <> PAS_OIE) then
						write (' [OIE!] ')				
       	end;
            writeln;
    	end;

    writeln;
    writeln;
    writeln ('Le symbole [ X ] represente ton emplacement. Ici tu es sur la case 0.');
    writeln ('Les nombres correspondent au numero de la case.');
    writeln ('Le mot [MORT] represente la case MORT.');
    writeln ('Le mot [OIE!] represente la case OIE.');

	REPEAT

		writeln;
		//on demande au joueur de jeter son dé
		writeln ('< Tour ', tour,' Appuie sur une touche pour lancer le de ! >');
		readln;
		//introduction d'une fonction aléatoire : randomize
		Randomize;
		lancer:=random(6) + random(6) + 2;
		writeln('Votre jet est de ', lancer);
		
		//la place change d'après le résultat puis on avertit l'utilisateur de son résultat
		place := place + lancer;
		writeln ('Tu te deplaces de ', lancer, ' cases');
		writeln ('Tu es sur la case ', place);

		//conditions des cases oie
		if (place MOD OIE = 0) AND (place <> PAS_OIE) then
		BEGIN
			place := place + lancer;
			writeln;
			writeln ('Tu es sur une case oie ! Tu te deplaces d encore ', lancer, ' cases.');
				writeln ('Tu es sur la case ', place);
		END;	
	
		//condition de la case mort
		if (place = MORT) then
		BEGIN
			place := CASE_DEP;
			writeln;
			writeln ('Tu es sur la case Mort ! Retour case départ !');
			writeln ('Tu es sur la case ', place);
		END;

		//condition si la case est supérieure à 66
		if (place > FIN) then
		BEGIN
			place := place - ((place - FIN)*2);
			writeln;
			writeln ('Tu es sur une case superieure a 66 ! Tu recules donc ! Allez Hop hop hop !');
			writeln ('Tu es sur la case ', place);
		END;
		tour := tour + 1; //on incrémente le tour
		writeln;

		//on affiche le tableau avec l'avancée du joueur selon sa place
		for cpt:=1 to LONG do
    	begin
    	    for cpt2:=1 to LARG do
    	    begin
    	    	if ((((cpt - 1)* LARG)+ cpt2) = place) then
    	    		write (' [ X ] ')
    	    	else
            		if ((((cpt - 1)* LARG)+ cpt2) <> MORT) AND ((((cpt - 1)* LARG)+ cpt2) MOD OIE <> 0) OR ((((cpt - 1)* LARG)+ cpt2) = PAS_OIE) then
			 		   write (' [ ', (((cpt - 1)* LARG)+ cpt2), ' ] ')
	       			else
	        			if ((((cpt - 1)* LARG)+ cpt2) = MORT) then
							write (' [MORT] ')
						else
							if ((((cpt - 1)* LARG)+ cpt2) MOD OIE = 0) AND ((((cpt - 1)* LARG)+ cpt2) <> PAS_OIE) then
								write (' [OIE!] ')				
       	end;
            writeln;
    	end;
	
	until (place = FIN);
	writeln;
	//on annonce le résultat final à l'utilisateur
	writeln ('Bravo champion ! Tu as gagne en ', tour, ' tours !');
	readln;
END.

{
//programme de base sans optimisation
CONST

CASE_DEP = 0;
OIE = 9;
PAS_OIE = 63;
MORT = 58;
LANCER_MIN = 2;
LANCER_MAX = 12; 
FIN = 66;

VAR

place, lancer, tour, resultat : integer;

BEGIN
	clrscr; //on supprime le flux inutile
	//on initialise nos variables
	place := 0;
	lancer := 0;
	tour := 1;
	// on explique les règles du jeu car il faut être user friendly
	writeln ('Bienvenue sur le jeu de l oie. Ici, on s amuse.');
	writeln ('La regle est simple : il faut atteindre la case 66 tout pile en moins de tours possibles.');
	writeln ('Tu avanceras du nombre de cases que t indiquera tes des. Si tu depasses la case 66, tu recules.');
	writeln ('Il y a une case oie toutes les 9 cases (sauf la case 63), ce qui te permet de doubler ton deplacement en cours.');
	writeln ('La case 58 est une case MORT, si tu tombes dessus, tu reviens a la case depart.');
	writeln ('Appuie sur une touche, puis bonne chance mon ami !');
	readln;

	REPEAT

		//si l'on veut demander le jet de dé à l'utilisateur
		writeln ('Saisir votre jet au premier de :');
		readln (lancer);
		resultat := lancer;
		writeln ('Saisir votre jet au deuxieme de :');
		readln (lancer);
		resultat := resultat + lancer;
		writeln ('Votre resultat est :', resultat);
		If ((resultat < LANCER_MIN) OR (resultat > LANCER_MAX)) then
			writeln ('Relance le de, petit tricheur !')
		else
		
			lancer := resultat;
			//la place change d'après le résultat puis on avertit l'utilisateur de son résultat
			place := place + lancer;
			writeln ('Tu te deplaces de ', lancer, ' cases');
			writeln ('Tu es sur la case ', place);

			//conditions des cases oie
			if (place MOD OIE = 0) AND (place <> PAS_OIE) then
			BEGIN
				place := place + lancer;
				writeln;
				writeln ('Tu es sur une case oie ! Tu te deplaces d encore ', lancer, ' cases.');
				writeln ('Tu es sur la case ', place);
			END;	
	
			//condition de la case mort
			if (place = MORT) then
			BEGIN
				place := CASE_DEP;
				writeln;
				writeln ('Tu es sur la case Mort ! Retour case départ !');
				writeln ('Tu es sur la case ', place);
			END;

			//condition si la case est supérieure à 66
			if (place > FIN) then
			BEGIN
				place := place - ((place - FIN)*2);
				writeln;
				writeln ('Tu es sur une case superieure a 66 ! Tu recules donc ! Allez Hop hop hop !');
				writeln ('Tu es sur la case ', place);
			END;
			tour := tour + 1; //on incrémente le tour
			writeln;
	
	until (place = FIN);
	writeln;
	//on annonce le résultat final à l'utilisateur
	writeln ('Bravo champion ! Tu as gagne en ', tour, ' tours !');
	readln;
END.}
