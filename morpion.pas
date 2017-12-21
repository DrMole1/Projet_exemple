{
	ALGORITHME : Morpion
	// BUT : Deux joueurs s'affrontent au jeu du morpion. Un joueur gagne lorsqu'il a aligné trois symboles ( 'O' ou 'X' ) sur une grille de 9 cellules (3X3), que ce soit un alignement 
	// horizontal, vertical ou diagonal. Une partie se finit lorsqu'un joueur a gagné ou lorsque la grille est remplie par 9 symboles (sans qu'il y ait forcément un gagnant).
	// ENTREES : Chacun son tour, chaque joueur saisit la colonne et la ligne de l'emplacement de son symbole (soit 1, soit 2, soit 3). Si l'emplacement est déjà occupé, il doit
	// saisir un autre emplacement valide.
	// SORTIES : L'algorithme affiche un visuel de la grille après chaque tour de jeu. En fin de partie, l'algo renseigne les joueurs quel est le gagnant s'il y a un gagnant.
	// PRINCIPE : On utilisera trois chaînes de caractères qu'on manipulera (ce sont les lignes). On utilisera des concaténations pour gérer l'emplacement des symboles à chaque tour de 
	// jeu. On utilisera des extractions pour vérifier si la grille est remplie ou s'il y a un gagnant.

	VAR

		ligne1, ligne 2, ligne3 : CHAINE
		col, ligne, tour : ENTIER
		occupe, win, joueur : BOOLEEN

	DEBUT

		//on initialise nos variables
		//ce sont les trois lignes de notre grille de morpion
		ligne1 <- "1   "
		ligne2 <- "2   "
		ligne3 <- "3   "
		col <- 0
		ligne <- 0
		tour <- 0                              //compteur qui annonce si la grille est remplie (si rempli = 9, alors la partie est finie)
		win <- FAUX                            //booléen qui annonce si un joueur a gagné
		joueur <- VRAI                         //booléen qui gère les tours des joueurs (si joueur = VRAI, c'est au tour du joueur 1, si joueur = FAUX, c'est au tour du joueur 2)
		occupe <- FAUX                         //booléen qui annonce si une cellule de la grille est libre/valide ou déjà occupée par un symbole

		ECRIRE "Bienvenue dans le jeu du morpion !" 

		REPETER

			//on annonce quel joueur va jouer durant ce tour
			SI (joueur = VRAI) ALORS
				ECRIRE "<C'est le tour du joueur 1 !>"
			SINON
				ECRIRE "<C'est le tour du joueur 2 !>"
			FIN SI

			//boucle de saisie pour la colonne
			REPETER
				ECRIRE "Veuillez saisir le numéro de la colonne :"
				LIRE col
			JUSQU'A ((col > 0) ET (col < 4))

			//boucle de saisie pour la ligne
			REPETER
				ECRIRE "Veuillez saisir le numéro de la ligne :"
				LIRE ligne
			JUSQU'A ((ligne > 0) ET (ligne < 4))

			//traitement selon la ligne saisie
			SI (ligne = 1) ALORS
				SI (EXTRACTION (ligne1, col + 1) = ' ') ALORS
					SI (joueur = VRAI) ALORS                       //le symbole sera un 'X'
						ligne1 <- EXTRACTION (ligne1, 1, col) & 'X' & EXTRACTION (ligne1, col + 2, 4 - (col + 1))
					SINON                                          //le symbole sera un 'O'
						ligne1 <- EXTRACTION (ligne1, 1, col) & 'O' & EXTRACTION (ligne1, col + 2, 4 - (col + 1))
					FIN SI
					occupe <- FAUX                                 //la cellule n'est pas occupée, elle est donc valide
				SINON
					occupe <- VRAI                                 //la cellule est occupée !
				FIN SI
			SINON
				SI (ligne = 2) ALORS
					SI (EXTRACTION (ligne2, col + 1) = ' ') ALORS
						SI (joueur = VRAI) ALORS                       //le symbole sera un 'X'
							ligne2 <- EXTRACTION (ligne2, 1, col) & 'X' & EXTRACTION (ligne2, col + 2, 4 - (col + 1))
						SINON                                          //le symbole sera un 'O'
							ligne2 <- EXTRACTION (ligne2, 1, col) & 'O' & EXTRACTION (ligne2, col + 2, 4 - (col + 1))
						FIN SI
						occupe <- FAUX                                 //la cellule n'est pas occupée, elle est donc valide
					SINON
						occupe <- VRAI                                 //la cellule est occupée !
					FIN SI
				SINON
					SI (EXTRACTION (ligne3, col + 1) = ' ') ALORS
						SI (joueur = VRAI) ALORS                       //le symbole sera un 'X'
							ligne3 <- EXTRACTION (ligne3, 1, col) & 'X' & EXTRACTION (ligne3, col + 2, 4 - (col + 1))
						SINON                                          //le symbole sera un 'O'
							ligne3 <- EXTRACTION (ligne3, 1, col) & 'O' & EXTRACTION (ligne3, col + 2, 4 - (col + 1))
						FIN SI
						occupe <- FAUX                                 //la cellule n'est pas occupée, elle est donc valide
					SINON
						occupe <- VRAI                                 //la cellule est occupée !
					FIN SI
				FIN SI
			FIN SI
 
			SI (occupe = VRAI) ALORS                                   //si la cellule est déjà prise, le même joueur désigne une autre cellule
				ECRIRE "La cellule est déjà prise !"    
			SINON
				//on fait visualiser la grille
				//on va à la ligne entre chaque ECRIRE (aspect visuel -> on utilisera "writeln" en pascal)
				ECRIRE " 123"
				ECRIRE ligne1
				ECRIRE ligne2
				ECRIRE ligne3

				//condition de victoire (il y a 8 possibilités de gagner)
				SI (((EXTRACTION (ligne1, 2) = EXTRACTION (ligne2, 3)) ET (EXTRACTION (ligne2, 3) = EXTRACTION (ligne3, 4)) ET (EXTRACTION (ligne2, 3) <> '.')) OU
				((EXTRACTION (ligne1, 4) = EXTRACTION (ligne2, 3)) ET (EXTRACTION (ligne2, 3) = EXTRACTION (ligne3, 2)) ET (EXTRACTION (ligne2, 3) <> '.')) OU
				((EXTRACTION (ligne1, 2) = EXTRACTION (ligne2, 2)) ET (EXTRACTION (ligne2, 2) = EXTRACTION (ligne3, 2)) ET (EXTRACTION (ligne2, 2) <> '.')) OU
				((EXTRACTION (ligne1, 3) = EXTRACTION (ligne2, 3)) ET (EXTRACTION (ligne2, 3) = EXTRACTION (ligne3, 3)) ET (EXTRACTION (ligne2, 3) <> '.')) OU
				((EXTRACTION (ligne1, 4) = EXTRACTION (ligne2, 4)) ET (EXTRACTION (ligne2, 4) = EXTRACTION (ligne3, 4)) ET (EXTRACTION (ligne2, 4) <> '.')) OU
				((EXTRACTION (ligne1, 2) = EXTRACTION (ligne1, 3)) ET (EXTRACTION (ligne1, 3) = EXTRACTION (ligne1, 4)) ET (EXTRACTION (ligne1, 3) <> '.')) OU
				((EXTRACTION (ligne2, 2) = EXTRACTION (ligne2, 3)) ET (EXTRACTION (ligne2, 3) = EXTRACTION (ligne2, 4)) ET (EXTRACTION (ligne2, 3) <> '.')) OU
				((EXTRACTION (ligne3, 2) = EXTRACTION (ligne3, 3)) ET (EXTRACTION (ligne3, 3) = EXTRACTION (ligne3, 4)) ET (EXTRACTION (ligne3, 3) <> '.'))) ALORS
					win <- VRAI
				SINON
					tour <- tour + 1             //on augmente le nombre de tours passés de 1
					joueur <- NON joueur         //on change de joueurs
				FIN SI
			FIN SI
		JUSQU'A ((win = VRAI) OU (tour = 9))

		//resultat de la partie
		SI (win = FAUX) ALORS
			ECRIRE "La grille est remplie et personne n'a gagné !"
		SINON
			SI (joueur = VRAI) ALORS
				ECRIRE "Le joueur 1 gagne !"
			SINON
				ECRIRE "Le joueur 2 gagne !"
			FIN SI
		FIN SI
	FIN.

}

PROGRAM Morpion;

// BUT : Deux joueurs s'affrontent au jeu du morpion. Un joueur gagne lorsqu'il a aligné trois symboles ( 'O' ou 'X' ) sur une grille de 9 cellules (3X3), que ce soit un alignement 
// horizontal, vertical ou diagonal. Une partie se finit lorsqu'un joueur a gagné ou lorsque la grille est remplie par 9 symboles (sans qu'il y ait forcément un gagnant).
// ENTREES : Chacun son tour, chaque joueur saisit la colonne et la ligne de l'emplacement de son symbole (soit 1, soit 2, soit 3). Si l'emplacement est déjà occupé, il doit
// saisir un autre emplacement valide.
// SORTIES : Le programme affiche un visuel de la grille après chaque tour de jeu. En fin de partie, le programme renseigne les joueurs quel est le gagnant s'il y a un gagnant.
// PRINCIPE : On utilisera trois chaînes de caractères qu'on manipulera (ce sont les lignes). On utilisera des concaténations pour gérer l'emplacement des symboles à chaque tour de 
// jeu. On utilisera des extractions pour vérifier si la grille est remplie ou s'il y a un gagnant.

USES crt;

VAR
	
ligne1, ligne2, ligne3 : string;
col, ligne, tour : integer;
occupe, win, joueur : boolean;

BEGIN

	clrscr; //on supprime le flux inutile
	//on initialise nos variables
	//ce sont les trois lignes de notre grille de morpion
	ligne1 := '1...';
	ligne2 := '2...';
	ligne3 := '3...';
	col := 0;
	ligne := 0;
	tour := 0;                               //compteur qui annonce si la grille est remplie (si rempli = 9, alors la partie est finie)
	win := FALSE;                            //booléen qui annonce si un joueur a gagné
	joueur := TRUE;                          //booléen qui gère les tours des joueurs (si joueur = VRAI, c'est au tour du joueur 1, si joueur = FAUX, c'est au tour du joueur 2)
	occupe := FALSE;                         //booléen qui annonce si une cellule de la grille est libre/valide ou déjà occupée par un symbole

	writeln ('Bienvenue dans le jeu du morpion !');

	repeat
		BEGIN
		//on annonce quel joueur va jouer durant ce tour
		if (joueur = TRUE) then
			writeln ('<C est le tour du joueur 1 !>')
		else
			writeln ('<C est le tour du joueur 2 !>');

		//boucle de saisie pour la colonne
		repeat
			begin
			writeln ('Veuillez saisir le numero de la colonne :');
			readln (col);
			end;
		until (col > 0) and (col < 4);

		//boucle de saisie pour la ligne
		repeat
			begin
			writeln ('Veuillez saisir le numero de la ligne :');
			readln (ligne);
			end;
		until (ligne > 0) AND (ligne < 4);

		//traitement selon la ligne saisie
		if (ligne = 1) then
			begin
			if (Copy(ligne1,col+1, 1) = '.') then
				begin
				occupe := FALSE;
				if (joueur = TRUE) then
					begin                                          //le symbole sera un 'X'
					ligne1 := copy (ligne1, 1, col) + 'X' + copy (ligne1, col + 2, 4 - (col + 1))
					end
				else
					begin                                          //le symbole sera un 'O'
					ligne1 := copy (ligne1, 1, col) + 'O' + copy (ligne1, col + 2, 4 - (col + 1))
					end
				end                                                //la cellule n'est pas occupée, elle est donc valide
			else
				begin
				occupe := TRUE
				end;
			end                                                    //la cellule est occupée !
		else
			begin
			if (ligne = 2) then
				begin
				if (copy (ligne2, col + 1, 1) = '.') then
					begin
					occupe := FALSE;
					if (joueur = TRUE) then
						begin                                     //le symbole sera un 'X'
						ligne2 := copy (ligne2, 1, col) + 'X' + copy (ligne2, col + 2, 4 - (col + 1))
						end
					else
						begin                                     //le symbole sera un 'O'
						ligne2 := copy (ligne2, 1, col) + 'O' + copy (ligne2, col + 2, 4 - (col + 1))
						end;
					end                                           //la cellule n'est pas occupée, elle est donc valide
				else
					begin
					occupe := TRUE
					end;
				end                                              //la cellule est occupée !
			else
				begin
				if (copy (ligne3, col + 1, 1) = '.') then
					begin
					occupe := FALSE;
					if (joueur = TRUE) then
						begin                                   //le symbole sera un 'X'
						ligne3 := copy (ligne3, 1, col) + 'X' + copy (ligne3, col + 2, 4 - (col + 1))
						end
					else  
						begin                                   //le symbole sera un 'O'
						ligne3 := copy (ligne3, 1, col) + 'O' + copy (ligne3, col + 2, 4 - (col + 1))
						end; 
					end                                         //la cellule n'est pas occupée, elle est donc valide
				else
					begin
					occupe := TRUE
					end;                                        //la cellule est occupée !
				end;
			end;

		if (occupe = TRUE) then
			begin                                 //si la cellule est déjà prise, le même joueur désigne une autre cellule
			writeln ('La cellule est deja prise !')
			end    
		else
			//on fait visualiser la grille
			begin
			clrscr; //on supprime le flux inutile
			writeln (' 123');
			writeln (ligne1);
			writeln (ligne2);
			writeln (ligne3);
			writeln; //saut de ligne pour lisibilité

			//condition de victoire (il y a 8 possibilités de gagner)
			if (((Copy (ligne1, 2, 1) = Copy (ligne2, 3, 1)) and (Copy (ligne2, 3, 1) = Copy (ligne3, 4, 1)) and (Copy (ligne2, 3, 1) <> '.')) or
			((Copy (ligne1, 4, 1) = Copy (ligne2, 3, 1)) and (Copy (ligne2, 3, 1) = Copy (ligne3, 2, 1)) and (Copy (ligne2, 3, 1) <> '.')) or
			((Copy (ligne1, 2, 1) = Copy (ligne2, 2, 1)) and (Copy (ligne2, 2, 1) = Copy (ligne3, 2, 1)) and (Copy (ligne2, 2, 1) <> '.')) or
			((Copy (ligne1, 3, 1) = Copy (ligne2, 3, 1)) and (Copy (ligne2, 3, 1) = Copy (ligne3, 3, 1)) and (Copy (ligne2, 3, 1) <> '.')) or
			((Copy (ligne1, 4, 1) = Copy (ligne2, 4, 1)) and (Copy (ligne2, 4, 1) = Copy (ligne3, 4, 1)) and (Copy (ligne2, 4, 1) <> '.')) or
			((Copy (ligne1, 2, 1) = Copy (ligne1, 3, 1)) and (Copy (ligne1, 3, 1) = Copy (ligne1, 4, 1)) and (Copy (ligne1, 3, 1) <> '.')) or
			((Copy (ligne2, 2, 1) = Copy (ligne2, 3, 1)) and (Copy (ligne2, 3, 1) = Copy (ligne2, 4, 1)) and (Copy (ligne2, 3, 1) <> '.')) or
			((Copy (ligne3, 2, 1) = Copy (ligne3, 3, 1)) and (Copy (ligne3, 3, 1) = Copy (ligne3, 4, 1)) and (Copy (ligne3, 3, 1) <> '.'))) then
				begin
				win := TRUE
				end
			else
				begin
				tour := tour + 1;             //on augmente le nombre de tours passés de 1
				joueur := not joueur          //on change de joueurs
				end;
			end;

		end;
	until (win = TRUE) OR (tour = 9);

	//resultat de la partie
		if (win = FALSE) then
			begin
			writeln ('La grille est remplie et personne ne gagne !');
			end
		else
			if (joueur = TRUE) then
				begin
				writeln ('Le joueur 1 gagne !')
				end
			else
				begin
				writeln ('Le joueur 2 gagne !');
				end;

	readln;

END.
