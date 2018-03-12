{
ALGO : Bataille navale
// BUT : Il s'agit de mettre en place le jeu de la bataille navale en compétition 1V1 player. Les joueurs s'affronteront sur une grille de 10 par 10, avec 2 bateaux de 4 cellules, 3 bateaux de 3 cellules et 4 bateaux de 
// 2 cellules. Le premier joueur qui coule la flotte du joueur adverse (soit ses 9 bateaux, soit 25 cellules) gagne. 
// PRINCIPE : Au lieu d’utiliser un tableau à 2 dimensions pour représenter la grille de jeu, utiliser structure cellule (par enregistrements) pour décrire les cases occupées par les bateaux. 
// Un bateau sera décrit par un ensemble de cases et la flotte de bateau à couler sera représentée par un ensemble de bateaux.
// 1)	Ecrire la structure case composée de 2 champs (ligne et colonne des entiers).
// 2)	Ecrire la structure bateau composée d’un ensemble de n cases. Vecteur autorisé dans structure !
// 3)	Ecrire la structure flotte composée d’un ensemble de bateaux. 
// 4)	Ecrire une fonction/procédure de création d’une case. Elle prend en paramètre la ligne et la colonne de la case. 
// 5)	Ecrire une fonction de comparaison de 2 cases. Cette fonction renverra vraie ou faux selon le cas
// 6)	Ecrire une fonction de création de bateau. Elle renverra une structure bateau complètement remplie. 
// 7)	Ecrire une fonction qui vérifie qu’une case appartient à un bateau. Fonction renverra vraie ou faux selon le cas. Cette fonction de vérification utilisera la fonction de comparaison de case.
// 8)	Ecrire une fonction qui vérifie qu’une case appartient à une flotte de bateau. Cette fonction devra utiliser la fonction de vérification pour un bateau. 
// 9)	Le gameplay est libre. Ecrire le jeu de la bataille navale au complet. 
// ENTREES : L'utilisateur devra placer ses bateaux en initialisant leurs cellules. Ensuite, il devra donner les coordonnées de ses tirs sur la grille adverse pour couler les bateaux ennemis. 
// SORTIES : Des phrases d'explications, de consignes ou descriptives des conséquences dans le but de renseigner le joueur.  

TYPE cellule = ENREGISTREMENT
	x : ENTIER
	y : ENTIER
FIN ENREGISTREMENT

TYPE sorte1 = ENREGISTREMENT
	V1 : TABLEAU [1..4] de cellule //V pour vecteur
FIN ENREGISTREMENT

TYPE sorte2 = ENREGISTREMENT
	V2 : TABLEAU [1..3] de cellule 
FIN ENREGISTREMENT

TYPE sorte3 = ENREGISTREMENT
	V3 : TABLEAU [1..2] de cellule 
FIN ENREGISTREMENT

TYPE flotte = ENREGISTREMENT
	bateau1 : sorte1
	bateau2 : sorte1
	bateau3 : sorte2
	bateau4 : sorte2
	bateau5 : sorte2
	bateau6 : sorte3
	bateau7 : sorte3
	bateau8 : sorte3
	bateau9 : sorte3
FIN ENREGISTREMENT

PROCEDURE setCell (VAR var_Cell : cellule) //on passe les paramètres par variable car on va les réutiliser par la suite dans le bloc principal
	VAR
		x, y : ENTIER
	DEBUT
		//boucle de saisie pour l'absisse
		REPETER
			ECRIRE 'Saisir votre x :'
			LIRE x
		JUSQU'A ((x > 0) ET (x < 11))

		var_Cell.x <- x

		//boucle de saisie pour l'ordonnée
		REPETER
			ECRIRE 'Saisir votre y :'
			LIRE y
		JUSQU'A ((y > 0) ET (y < 11))

		var_Cell.y <- y

	FIN PROCEDURE

FONCTION comparCell (var_Cell : cellule, flotteA : flotte) : BOOLEAN   //fonction pour le joueur A, il y en aura une pour le joueur B
	VAR
		varinter : BOOLEEN  //création d'une variable intermédiaire qui va après être affectée à la fonction 
		cpt : ENTIER    
	DEBUT
		REPETER
			varinter <- (var_Cell.x <> flotteA.bateau1.V1[cpt].x) ET (var_Cell.y <> flotteA.bateau1.V1[cpt].y) ET (var_Cell.x <> flotteA.bateau2.V1[cpt].x) ET (var_Cell.y <> flotteA.bateau2.V1[cpt].y) 
			SI ((cpt <= 3) ET (varinter)) ALORS
				varinter <- (var_Cell.x <> flotteA.bateau3.V2[cpt].x) ET (var_Cell.y <> flotteA.bateau3.V2[cpt].y) ET (var_Cell.x <> flotteA.bateau4.V2[cpt].x) ET (var_Cell.y <> flotteA.bateau4.V2[cpt].y) ET
				(var_Cell.x <> flotteA.bateau5.V2[cpt].x) ET (var_Cell.y <> flotteA.bateau5.V2[cpt].y)
			SI ((cpt <= 2) ET (varinter)) ALORS
				varinter <- (var_Cell.x <> flotteA.bateau6.V3[cpt].x) ET (var_Cell.y <> flotteA.bateau6.V3[cpt].y) ET (var_Cell.x <> flotteA.bateau7.V3[cpt].x) ET (var_Cell.y <> flotteA.bateau7.V3[cpt].y) 
				ET (var_Cell.x <> flotteA.bateau8.V3[cpt].x) ET (var_Cell.y <> flotteA.bateau8.V3[cpt].y) ET (var_Cell.x <> flotteA.bateau9.V3[cpt].x) ET (var_Cell.y <> flotteA.bateau9.V3[cpt].y)
			cpt <- cpt + 1
		JUSQU'A ((cpt = 4) OU (varinter = FAUX))
		
		comparCell <- varinter
		//comparCell renverra vraie si la cellule n'est pas occupée (elle est donc libre)
	FIN FONCTION

PROCEDURE setBateau (VAR flotteA : flotte, var_Cell : cellule, sens, nb_Bateau : ENTIER)  //fonction pour le joueur A, il y en aura une pour le joueur B
	VAR
		cpt : ENTIER
	DEBUT
		SI (nb_Bateau = 1) ALORS
			SI (sens = 1) ALORS
				POUR cpt DE 1 A 4 FAIRE
					flotteA.bateau1.V1[cpt].x <- var_Cell.x + (cpt-1)
					flotteA.bateau1.V1[cpt].y <- var_Cell.y 
				FIN POUR
			SINON
				POUR cpt DE 1 A 4 FAIRE
					flotteA.bateau1.V1[cpt].y <- var_Cell.y + (cpt-1)
					flotteA.bateau1.V1[cpt].x <- var_Cell.x
				FIN POUR
			FIN SI
		SINON
			SI (nb_Bateau = 2) ALORS
				SI (sens = 1) ALORS
					POUR cpt DE 1 A 4 FAIRE
						flotteA.bateau2.V1[cpt].x <- var_Cell.x + (cpt-1)
						flotteA.bateau2.V1[cpt].y <- var_Cell.y 
					FIN POUR
				SINON
					POUR cpt DE 1 A 4 FAIRE
						flotteA.bateau2.V1[cpt].y <- var_Cell.y + (cpt-1)
						flotteA.bateau2.V1[cpt].x <- var_Cell.x
					FIN POUR
				FIN SI
			SINON
				SI (nb_Bateau = 3) ALORS
					SI (sens = 1) ALORS
						POUR cpt DE 1 A 3 FAIRE
							flotteA.bateau3.V2[cpt].x <- var_Cell.x + (cpt-1)
							flotteA.bateau3.V2[cpt].y <- var_Cell.y 
						FIN POUR
					SINON
						POUR cpt DE 1 A 3 FAIRE
							flotteA.bateau3.V2[cpt].y <- var_Cell.y + (cpt-1)
							flotteA.bateau3.V2[cpt].x <- var_Cell.x
						FIN POUR
					FIN SI
				SINON
					SI (nb_Bateau = 4) ALORS
						SI (sens = 1) ALORS
							POUR cpt DE 1 A 3 FAIRE
								flotteA.bateau4.V2[cpt].x <- var_Cell.x + (cpt-1)
								flotteA.bateau4.V2[cpt].y <- var_Cell.y 
							FIN POUR
						SINON
							POUR cpt DE 1 A 3 FAIRE
								flotteA.bateau4.V2[cpt].y <- var_Cell.y + (cpt-1)
								flotteA.bateau4.V2[cpt].x <- var_Cell.x
							FIN POUR
						FIN SI
					SINON
						SI (nb_Bateau = 5) ALORS
							SI (sens = 1) ALORS
								POUR cpt DE 1 A 3 FAIRE
									flotteA.bateau5.V2[cpt].x <- var_Cell.x + (cpt-1)
									flotteA.bateau5.V2[cpt].y <- var_Cell.y 
								FIN POUR
							SINON
								POUR cpt DE 1 A 3 FAIRE
									flotteA.bateau5.V2[cpt].y <- var_Cell.y + (cpt-1)
									flotteA.bateau5.V2[cpt].x <- var_Cell.x
								FIN POUR
							FIN SI
						SINON
							SI (nb_Bateau = 6) ALORS
								SI (sens = 1) ALORS
									POUR cpt DE 1 A 2 FAIRE
										flotteA.bateau6.V3[cpt].x <- var_Cell.x + (cpt-1)
										flotteA.bateau6.V3[cpt].y <- var_Cell.y 
									FIN POUR
								SINON
									POUR cpt DE 1 A 2 FAIRE
										flotteA.bateau6.V3[cpt].y <- var_Cell.y + (cpt-1)
										flotteA.bateau6.V3[cpt].x <- var_Cell.x
									FIN POUR
								FIN SI
							SINON
								SI (nb_Bateau = 7) ALORS
									SI (sens = 1) ALORS
										POUR cpt DE 1 A 2 FAIRE
											flotteA.bateau7.V3[cpt].x <- var_Cell.x + (cpt-1)
											flotteA.bateau7.V3[cpt].y <- var_Cell.y 
										FIN POUR
									SINON
										POUR cpt DE 1 A 2 FAIRE
											flotteA.bateau7.V3[cpt].y <- var_Cell.y + (cpt-1)
											flotteA.bateau7.V3[cpt].x <- var_Cell.x
										FIN POUR
									FIN SI
								SINON
									SI (nb_Bateau = 8) ALORS
										SI (sens = 1) ALORS
											POUR cpt DE 1 A 2 FAIRE
												flotteA.bateau8.V3[cpt].x <- var_Cell.x + (cpt-1)
												flotteA.bateau8.V3[cpt].y <- var_Cell.y 
											FIN POUR
										SINON
											POUR cpt DE 1 A 2 FAIRE
												flotteA.bateau8.V3[cpt].y <- var_Cell.y + (cpt-1)
												flotteA.bateau8.V3[cpt].x <- var_Cell.x
											FIN POUR
										FIN SI
									SINON
										SI (sens = 9) ALORS
											POUR cpt DE 1 A 2 FAIRE
												flotteA.bateau9.V3[cpt].x <- var_Cell.x + (cpt-1)
												flotteA.bateau9.V3[cpt].y <- var_Cell.y 
											FIN POUR
										SINON
											POUR cpt DE 1 A 2 FAIRE
												flotteA.bateau9.V3[cpt].y <- var_Cell.y + (cpt-1)
												flotteA.bateau9.V3[cpt].x <- var_Cell.x
											FIN POUR
										FIN SI
									FIN SI
								FIN SI
							FIN SI
						FIN SI
					FIN SI
				FIN SI
			FIN SI
		FIN SI









VAR
	pdvA, pdvB, sens, nb_Bateau, cpt : ENTIER
	flotteA, flotteB : flotte
	var_Cell : cellule
	verif : BOOLEEN


DEBUT //bloc principal (MAIN)
	
	//pose des bateaux pour le joueur A
	ECRIRE 'Joueur A, veuillez poser vos bateaux'

	POUR nb_Bateau DE 1 A 9 FAIRE
		ECRIRE 'Placez votre bateau n° ', cpt
		REPETER
			ECRIRE 'Tapez 1 pour placer votre bateau vers la droite. Tapez 2 pour placer votre bateau vers le bas.'
			LIRE sens
		JUSQU'A ((sens = 1) OU (sens = 2))

		
		SI (nb_Bateau <= 2) ALORS
			REPETER
				cpt <- 1
				verif <- FAUX
				ECRIRE 'Saisissez votre cellule d'origine :'
				setCell(var_Cell)   //appel de la procédure création de cellule
				REPETER
					verif <- comparCell(var_Cell, flotteA)
					SI (sens = 1) alors
						var_Cell.x <- var_Cell.x + 1
					SINON
						var_Cell.y <- var_Cell.y + 1
					FIN SI
					cpt <- cpt +1
				JUSQU'A ((verif = FAUX) OU (cpt = 4))
			JUSQU'A (verif = VRAI)
		SINON
			SI ((nb_Bateau >= 3) ET (nb_Bateau <= 5)) ALORS
				REPETER
					cpt <- 1
					verif <- FAUX
					ECRIRE 'Saisissez votre cellule d'origine :'
					setCell(var_Cell)   //appel de la procédure création de cellule
					REPETER
						verif <- comparCell(var_Cell, flotteA)
						SI (sens = 1) alors
							var_Cell.x <- var_Cell.x + 1
						SINON
							var_Cell.y <- var_Cell.y + 1
						FIN SI
						cpt <- cpt +1
					JUSQU'A ((verif = FAUX) OU (cpt = 3))
				JUSQU'A (verif = VRAI)
			SINON
				REPETER
					cpt <- 1
					verif <- FAUX
					ECRIRE 'Saisissez votre cellule d'origine :'
					setCell(var_Cell)   //appel de la procédure création de cellule
					REPETER
						verif <- comparCell(var_Cell, flotteA)
						SI (sens = 1) alors
							var_Cell.x <- var_Cell.x + 1
						SINON
							var_Cell.y <- var_Cell.y + 1
						FIN SI
						cpt <- cpt +1
					JUSQU'A ((verif = FAUX) OU (cpt = 2))
				JUSQU'A (verif = VRAI)	
			FIN SI
		FIN SI
		
		SI (sens = 1) alors
			var_Cell.x <- var_Cell.x - (cpt-1)
		SINON
			var_Cell.y <- var_Cell.y - (cpt-1)
		FIN SI
		setBateau(flotteA, var_Cell, sens, nb_Bateau)   //appel de la procédure création de bateau

		FIN.
}


PROGRAM Bataille_Navale;

///////////////////////////////////////////////////////////
// NOTE : Le programme compile correctement, mais ne fonctionne pas totalement bien. Je pense qu'il y a un problème au niveau de la fonction comparCell. En effet, lors de la pose d'un deuxième bateau,
// celui-ci ne se place pas aux environs du premier. 
///////////////////////////////////////////////////////////

USES crt;

CONST 
	MIN = 0;
	MAX1 = 4;
	MAX2 = 3;
	MAX3 = 2;
	MAXCOORD = 11;
	MAXCOORD1 = 7;
	MAXCOORD2 = 8;
	MAXCOORD3 = 9;
	DROITE = 1;
	BAS = 2;
	MAXPDV = 25;

TYPE cellule = record
	x : integer;
	y : integer;
	mort : boolean;   //de base, free pascal initialise ce champ à faux.
end;

//il y a 3 types de bateaux : ceux à 4 cases de long, ceux à 3 cases de long et ceux à 2 cases de long
TYPE sorte1 = record
	V1 : array [1..MAX1] of cellule; //V pour vecteur
end;

TYPE sorte2 = record
	V2 : array [1..MAX2] of cellule;
end;

TYPE sorte3 = record
	V3 : array [1..MAX3] of cellule; 
end;

//une flotte est constituée de 2 bateaux de 4 cases, de 3 bateaux de 3 cases et de 4 bateaux de 2 cases
TYPE flotte = record
	bateau1 : sorte1;
	bateau2 : sorte1;
	bateau3 : sorte2;
	bateau4 : sorte2;
	bateau5 : sorte2;
	bateau6 : sorte3;
	bateau7 : sorte3;
	bateau8 : sorte3;
	bateau9 : sorte3;
end;

PROCEDURE setCell (VAR var_Cell : cellule; sens, nb_Bateau : integer); //on passe le paramètre var_Cell par variable car on va le réutiliser par la suite dans le bloc principal
	VAR
		x, y : integer;
	begin

		// pour les 2 bateaux de 4 cases
		if ((nb_Bateau = 1) or (nb_Bateau = 2)) then
		begin
			if (sens = DROITE) then
			begin
				//boucle de saisie pour l'absisse
				repeat
					writeln ('Saisir votre x :');
					readln (x);
				until (x > MIN) and (x < MAXCOORD1);      // x inférieur à 7 car le bateau fait 4 cases et doit rentrer dans la grille de 10X10 ! 

				var_Cell.x := x;

				//boucle de saisie pour l'ordonnée
				repeat
					writeln ('Saisir votre y :');
					readln (y);
				until (y > MIN) and (y < MAXCOORD);

				var_Cell.y := y
			end
			else
			begin
				//boucle de saisie pour l'absisse
				repeat
					writeln ('Saisir votre x :');
					readln (x);
				until (x > MIN) and (x < MAXCOORD);

				var_Cell.x := x;

				//boucle de saisie pour l'ordonnée
				repeat
					writeln ('Saisir votre y :');
					readln (y);
				until (y > MIN) and (y < MAXCOORD1);    //ici, c'est y qui est inférieur à 7, car sens = 2 donc le bateau est aligné vers le bas

				var_Cell.y := y;
			end
		end
		//pour les 3 bateaux de 3 cases
		else if ((nb_Bateau > 2) or (nb_Bateau < 6)) then
		begin
			if (sens = 1) then
			begin
				//boucle de saisie pour l'absisse
				repeat
					writeln ('Saisir votre x :');
					readln (x);
				until (x > MIN) and (x < MAXCOORD2);      // x inférieur à 8 car le bateau fait 4 cases et doit rentrer dans la grille de 10X10 ! 

				var_Cell.x := x;

				//boucle de saisie pour l'ordonnée
				repeat
					writeln ('Saisir votre y :');
					readln (y);
				until (y > MIN) and (y < MAXCOORD);

				var_Cell.y := y
			end
			else
			begin
				//boucle de saisie pour l'absisse
				repeat
					writeln ('Saisir votre x :');
					readln (x);
				until (x > MIN) and (x < MAXCOORD);

				var_Cell.x := x;

				//boucle de saisie pour l'ordonnée
				repeat
					writeln ('Saisir votre y :');
					readln (y);
				until (y > MIN) and (y < MAXCOORD2);    //ici, c'est y qui est inférieur à 8, car sens = 2 donc le bateau est aligné vers le bas

				var_Cell.y := y;
			end
		end
		//pour les autres bateaux de 2 cases
		else 
		begin
			if (sens = 1) then
			begin
				//boucle de saisie pour l'absisse
				repeat
					writeln ('Saisir votre x :');
					readln (x);
				until (x > MIN) and (x < MAXCOORD3);      // x inférieur à 9 car le bateau fait 4 cases et doit rentrer dans la grille de 10X10 ! 

				var_Cell.x := x;

				//boucle de saisie pour l'ordonnée
				repeat
					writeln ('Saisir votre y :');
					readln (y);
				until (y > MIN) and (y < MAXCOORD);

				var_Cell.y := y
			end
			else
			begin
				//boucle de saisie pour l'absisse
				repeat
					writeln ('Saisir votre x :');
					readln (x);
				until (x > MIN) and (x < MAXCOORD);

				var_Cell.x := x;

				//boucle de saisie pour l'ordonnée
				repeat
					writeln ('Saisir votre y :');
					readln (y);
				until (y > MIN) and (y < MAXCOORD3);    //ici, c'est y qui est inférieur à 9, car sens = 2 donc le bateau est aligné vers le bas

				var_Cell.y := y;
			end;
		end;

	end;

function comparCell (var_Cell : cellule; flotte : flotte) : boolean;   //aucun paramètres passés par variable car non réutilisés
	VAR
		varinter : boolean;  //création d'une variable intermédiaire qui va après être affectée à la fonction (afin d'éviter bug de récursivité)
		cpt : integer;    
	begin
		cpt := 1;
		repeat
			varinter := ((var_Cell.x <> flotte.bateau1.V1[cpt].x) and (var_Cell.y <> flotte.bateau1.V1[cpt].y)) and ((var_Cell.x <> flotte.bateau2.V1[cpt].x) and (var_Cell.y <> flotte.bateau2.V1[cpt].y)); 

			if (cpt <= 3) and (varinter)then
			begin
				varinter := ((var_Cell.x <> flotte.bateau3.V2[cpt].x) and (var_Cell.y <> flotte.bateau3.V2[cpt].y)) and ((var_Cell.x <> flotte.bateau4.V2[cpt].x) and (var_Cell.y <> flotte.bateau4.V2[cpt].y)) and
				((var_Cell.x <> flotte.bateau5.V2[cpt].x) and (var_Cell.y <> flotte.bateau5.V2[cpt].y));
			end;

			if (cpt <= 2) and (varinter)then
			begin
				varinter := ((var_Cell.x <> flotte.bateau6.V3[cpt].x) and (var_Cell.y <> flotte.bateau6.V3[cpt].y)) and ((var_Cell.x <> flotte.bateau7.V3[cpt].x) and (var_Cell.y <> flotte.bateau7.V3[cpt].y)) 
				and ((var_Cell.x <> flotte.bateau8.V3[cpt].x) and (var_Cell.y <> flotte.bateau8.V3[cpt].y)) and ((var_Cell.x <> flotte.bateau9.V3[cpt].x) and (var_Cell.y <> flotte.bateau9.V3[cpt].y));
			end;

			cpt := cpt + 1;
		until (cpt = 4) OR (varinter = FALSE);
		
		comparCell := varinter;
		//comparCell renverra vraie si la cellule n'est pas occupée (elle est donc libre)
	end;
 
PROCEDURE setBateau (VAR flotte : flotte; var_Cell : cellule; sens, nb_Bateau : integer);  //seule la flotte est passée par variable car réutilisée
	VAR
		cpt : integer;

	begin
		cpt := 1;

		if (nb_Bateau = 1) then    // si le bateau demandé est le numéro 1
		begin
			if (sens = DROITE) then    // si il est aligné vers la droite
			begin
				for cpt:=1 to 4 do
				begin
					flotte.bateau1.V1[cpt].x := var_Cell.x + (cpt-1);   // alors on affecte à chaque cellule du bateau la cellule demandée à l'utilisateur (celle ci est incrémentée dans la boucle POUR)
					flotte.bateau1.V1[cpt].y := var_Cell.y;   // ici le y n'est pas incrémenté car le sens est vers la droite (et non vers le bas !)
				end
			end				
			else
			begin
				for cpt:=1 to 4 do
				begin
					flotte.bateau1.V1[cpt].y := var_Cell.y + (cpt-1);
					flotte.bateau1.V1[cpt].x := var_Cell.x;
				end;
			end
		end
		else
		begin
			if (nb_Bateau = 2) then
			begin
				if (sens = DROITE) then
				begin
					for cpt:=1 to 4 do
					begin
						flotte.bateau2.V1[cpt].x := var_Cell.x + (cpt-1);
						flotte.bateau2.V1[cpt].y := var_Cell.y; 
					end
				end
				else
				begin
					for cpt:=1 to 4 do
					begin
						flotte.bateau2.V1[cpt].y := var_Cell.y + (cpt-1);
						flotte.bateau2.V1[cpt].x := var_Cell.x;
					end;
				end
			end
			else
			begin
				if (nb_Bateau = 3) then
				begin
					if (sens = DROITE) then
					begin
						for cpt:=1 to 3 do
						begin
							flotte.bateau3.V2[cpt].x := var_Cell.x + (cpt-1);
							flotte.bateau3.V2[cpt].y := var_Cell.y; 
						end
					end
					else
					begin
						for cpt:=1 to 3 do
						begin
							flotte.bateau3.V2[cpt].y := var_Cell.y + (cpt-1);
							flotte.bateau3.V2[cpt].x := var_Cell.x;
						end;
					end
				end
				else
				begin
					if (nb_Bateau = 4) then
					begin
						if (sens = DROITE) then
						begin
							for cpt:=1 to 3 do
							begin
								flotte.bateau4.V2[cpt].x := var_Cell.x + (cpt-1);
								flotte.bateau4.V2[cpt].y := var_Cell.y;
							end
						end
						else
						begin
							for cpt:=1 to 3 do
							begin
								flotte.bateau4.V2[cpt].y := var_Cell.y + (cpt-1);
								flotte.bateau4.V2[cpt].x := var_Cell.x;
							end;
						end
					end
					else
					begin
						if (nb_Bateau = 5) then
						begin
							if (sens = DROITE) then
							begin
								for cpt:=1 to 3 do
								begin
									flotte.bateau5.V2[cpt].x := var_Cell.x + (cpt-1);
									flotte.bateau5.V2[cpt].y := var_Cell.y; 
								end
							end
							else
							begin
								for cpt:=1 to 3 do
								begin
									flotte.bateau5.V2[cpt].y := var_Cell.y + (cpt-1);
									flotte.bateau5.V2[cpt].x := var_Cell.x;
								end;
							end
						end
						else
						begin
							if (nb_Bateau = 6) then
							begin
								if (sens = DROITE) then
								begin
									for cpt:=1 to 2 do
									begin
										flotte.bateau6.V3[cpt].x := var_Cell.x + (cpt-1);
										flotte.bateau6.V3[cpt].y := var_Cell.y; 
									end
								end
								else
								begin
									for cpt:=1 to 2 do
									begin
										flotte.bateau6.V3[cpt].y := var_Cell.y + (cpt-1);
										flotte.bateau6.V3[cpt].x := var_Cell.x;
									end;
								end
							end
							else
							begin
								if (nb_Bateau = 7) then
								begin
									if (sens = DROITE) then
									begin
										for cpt:=1 to 2 do
										begin
											flotte.bateau7.V3[cpt].x := var_Cell.x + (cpt-1);
											flotte.bateau7.V3[cpt].y := var_Cell.y; 
										end
									end
									else
									begin
										for cpt:=1 to 2 do
										begin
											flotte.bateau7.V3[cpt].y := var_Cell.y + (cpt-1);
											flotte.bateau7.V3[cpt].x := var_Cell.x;
										end;
									end
								end
								else
								begin
									if (nb_Bateau = 8) then
									begin
										if (sens = DROITE) then
										begin
											for cpt:=1 to 2 do
											begin
												flotte.bateau8.V3[cpt].x := var_Cell.x + (cpt-1);
												flotte.bateau8.V3[cpt].y := var_Cell.y; 
											end
										end
										else
										begin
											for cpt:=1 to 2 do
											begin
												flotte.bateau8.V3[cpt].y := var_Cell.y + (cpt-1);
												flotte.bateau8.V3[cpt].x := var_Cell.x;
											end;
										end
									end
									else
									begin
										if (sens = DROITE) then
										begin
											for cpt:=1 to 2 do
											begin
												flotte.bateau9.V3[cpt].x := var_Cell.x + (cpt-1);
												flotte.bateau9.V3[cpt].y := var_Cell.y; 
											end
										end
										else
										begin
											for cpt:=1 to 2 do
											begin
												flotte.bateau9.V3[cpt].y := var_Cell.y + (cpt-1);
												flotte.bateau9.V3[cpt].x := var_Cell.x;
											end;
										end;
									end;
								end;
							end;
						end;
					end;
				end;
			end;
		end;

	end;

procedure rule;   //pour renseigner le joueur sur les règles du jeu
	begin
		writeln ('Bienvenue au jeu de la bataille navale !');
		readln;
		writeln ('Le but du jeu est de détruire les 9 bateaux du joueur adverse !');
		writeln ('Cela necessite d abord de placer ces bateaux : 2 bateaux de 4 cases, 3 bateaux de 3 cases et 4 bateaux de 2 cases.');
		readln;
		writeln ('La grille mesure 10 cases sur 10 cases.');
		writeln ('Le x represente l axe des absisse et le y represente l axe des ordonnees');
		writeln ('Pendant votre tour de jeu, vous devrez indiquer sur quelle cellule vous voulez tirer un boulet');
		readln;
		writeln ('Mais avant, placez vos bateaux !');
		readln;
	end;

function caseBateau (var_Cell : cellule; VAR flotte : flotte) : integer;
// Ecrire une fonction qui vérifie qu’une case appartient à un bateau. Fonction renverra le numéro du bateau touché
	var
		varinter, cpt : integer;

	begin
		varinter := MIN; //initialisation de la variable locale à la fonction
		cpt := 1;

		repeat
			if ((var_Cell.x = flotte.bateau1.V1[cpt].x) and (var_Cell.y = flotte.bateau1.V1[cpt].y) and (flotte.bateau1.V1[cpt].mort = FALSE)) then 
			begin
				varinter := 1;
				flotte.bateau1.V1[cpt].mort := TRUE;
			end;
			cpt := cpt + 1;
		until (varinter <> MIN) or (cpt = 4);

		if (varinter = MIN) then 
		cpt := 1;
		begin
			repeat
				if ((var_Cell.x = flotte.bateau2.V1[cpt].x) and (var_Cell.y = flotte.bateau2.V1[cpt].y) and (flotte.bateau2.V1[cpt].mort = FALSE)) then 
				begin
					varinter := 2;
					flotte.bateau2.V1[cpt].mort := TRUE;
				end;
				cpt := cpt + 1;
			until (varinter <> MIN) or (cpt = 4);
		end;

		if (varinter = MIN) then 
		cpt := 1;
		begin
			repeat
				if ((var_Cell.x = flotte.bateau3.V2[cpt].x) and (var_Cell.y = flotte.bateau3.V2[cpt].y) and (flotte.bateau3.V2[cpt].mort = FALSE)) then 
				begin
					varinter := 3;
					flotte.bateau3.V2[cpt].mort := TRUE;
				end;
				cpt := cpt + 1;
			until (varinter <> MIN) or (cpt = 3);
		end;

		if (varinter = MIN) then 
		cpt := 1;
		begin
			repeat
				if ((var_Cell.x = flotte.bateau4.V2[cpt].x) and (var_Cell.y = flotte.bateau4.V2[cpt].y) and (flotte.bateau4.V2[cpt].mort = FALSE)) then 
				begin
					varinter := 4;
					flotte.bateau4.V2[cpt].mort := TRUE;
				end;
				cpt := cpt + 1;
			until (varinter <> MIN) or (cpt = 3);
		end;

		if (varinter = MIN) then 
		cpt := 1;
		begin
			repeat
				if ((var_Cell.x = flotte.bateau5.V2[cpt].x) and (var_Cell.y = flotte.bateau5.V2[cpt].y) and (flotte.bateau5.V2[cpt].mort = FALSE)) then 
				begin
					varinter := 5;
					flotte.bateau5.V2[cpt].mort := TRUE;
				end;
				cpt := cpt + 1;
			until (varinter <> MIN) or (cpt = 3);
		end;

		if (varinter = MIN) then 
		cpt := 1;
		begin
			repeat
				if ((var_Cell.x = flotte.bateau6.V3[cpt].x) and (var_Cell.y = flotte.bateau6.V3[cpt].y) and (flotte.bateau6.V3[cpt].mort = FALSE)) then 
				begin
					varinter := 6;
					flotte.bateau6.V3[cpt].mort := TRUE;
				end;
				cpt := cpt + 1;
			until (varinter <> MIN) or (cpt = 2);
		end;

		if (varinter = MIN) then 
		cpt := 1;
		begin
			repeat
				if ((var_Cell.x = flotte.bateau7.V3[cpt].x) and (var_Cell.y = flotte.bateau7.V3[cpt].y) and (flotte.bateau7.V3[cpt].mort = FALSE)) then 
				begin
					varinter := 7;
					flotte.bateau7.V3[cpt].mort := TRUE;
				end;
				cpt := cpt + 1;
			until (varinter <> MIN) or (cpt = 2);
		end;

		if (varinter = MIN) then 
		cpt := 1;
		begin
			repeat
				if ((var_Cell.x = flotte.bateau8.V3[cpt].x) and (var_Cell.y = flotte.bateau8.V3[cpt].y) and (flotte.bateau8.V3[cpt].mort = FALSE)) then 
				begin
					varinter := 8;
					flotte.bateau8.V3[cpt].mort := TRUE;
				end;
				cpt := cpt + 1;
			until (varinter <> MIN) or (cpt = 2);
		end;

		if (varinter = MIN) then 
		cpt := 1;
		begin
			repeat
				if ((var_Cell.x = flotte.bateau9.V3[cpt].x) and (var_Cell.y = flotte.bateau9.V3[cpt].y) and (flotte.bateau9.V3[cpt].mort = FALSE)) then 
				begin
					varinter := 9;
					flotte.bateau9.V3[cpt].mort := TRUE;
				end;
				cpt := cpt + 1;
			until (varinter <> MIN) or (cpt = 2);
		end;

		caseBateau := varinter;

	end;


VAR
	sens, nb_Bateau, cpt, pdvA, pdvB : integer;
	flotteA, flotteB : flotte;
	var_Cell : cellule;
	verif, tourJ : boolean;


begin //bloc principal (MAIN)
	clrscr;  //suppression du flux inutile
	
	rule;  //procedure d'affichage des règles

	//pose des bateaux pour le joueur A
	writeln ('Joueur A, veuillez poser vos bateaux :');

	//il a 9 bateaux à poser
	for nb_Bateau:=1 to 9 do
	begin
		writeln ('Placez votre bateau numero ', nb_Bateau);
		//boucle de saisie pour le sens
		repeat
			writeln ('Tapez 1 pour placer votre bateau vers la droite. Tapez 2 pour placer votre bateau vers le bas.');   // il n'y a que 2 sens
			readln (sens);
		until (sens = DROITE) OR (sens = BAS);

		// pour les 2 bateaux de 4 cases
		if (nb_Bateau <= 2) then
		begin
			repeat
				//initialisation des variables
				cpt := 1;
				verif := FALSE;
				writeln ('Saisissez votre cellule d origine :');
				setCell(var_Cell, sens, nb_Bateau);   //appel de la procédure création de cellule
				repeat
					verif := comparCell(var_Cell, flotteA);  //on vérifie si la cellule demandée est libre
					if (sens = DROITE) then
					begin
						var_Cell.x := var_Cell.x + 1
					end
					else
					begin
						var_Cell.y := var_Cell.y + 1;
					end;
					cpt := cpt +1;
					if (verif = FALSE) then
					writeln ('Cette place est prise !');
				until (verif = FALSE) OR (cpt = 4);
			until (verif);
		end
		else
		begin
			// pour les 3 bateaux de 3 cases
			if ((nb_Bateau >= 3) and (nb_Bateau <= 5)) then
			begin
				repeat
					cpt := 1;
					verif := FALSE;
					writeln ('Saisissez votre cellule d origine :');
					setCell(var_Cell, sens, nb_Bateau);   //appel de la procédure création de cellule
					repeat
						verif := comparCell(var_Cell, flotteA);
						if (sens = DROITE) then
						begin
							var_Cell.x := var_Cell.x + 1
						end
						else
						begin
							var_Cell.y := var_Cell.y + 1;
						end;
						cpt := cpt +1;
					until (verif = FALSE) OR (cpt = 3);
				until (verif);
			end
			else
			begin
				repeat
					cpt := 1;
					verif := FALSE;
					writeln ('Saisissez votre cellule d origine :');
					setCell(var_Cell, sens, nb_Bateau);   //appel de la procédure création de cellule
					repeat
						verif := comparCell(var_Cell, flotteA);
						if (sens = DROITE) then
						begin
							var_Cell.x := var_Cell.x + 1
						end
						else
						begin
							var_Cell.y := var_Cell.y + 1;
						end;
						cpt := cpt +1;
					until (verif = FALSE) OR (cpt = 2);
				until (verif);
			end;
		end;
		
		// on récupère la cellule d'origine de départ
		if (sens = DROITE) then
		begin
			var_Cell.x := var_Cell.x - (cpt-1)
		end
		else
		begin
			var_Cell.y := var_Cell.y - (cpt-1);
		end;
		setBateau(flotteA, var_Cell, sens, nb_Bateau);   //appel de la procédure création de bateau
	end;

	//pose des bateaux pour le joueur B
	writeln ('Joueur B, veuillez poser vos bateaux :');

	for nb_Bateau:=1 to 9 do
	begin
		writeln ('Placez votre bateau n° ', nb_Bateau);
		repeat
			writeln ('Tapez 1 pour placer votre bateau vers la droite. Tapez 2 pour placer votre bateau vers le bas.');
			readln (sens);
		until (sens = DROITE) OR (sens = BAS);

		
		if (nb_Bateau <= 2) then
		begin
			repeat
				cpt := 1;
				verif := FALSE;
				writeln ('Saisissez votre cellule d origine :');
				setCell(var_Cell, sens, nb_Bateau);   //appel de la procédure création de cellule
				repeat
					verif := comparCell(var_Cell, flotteB);
					if (sens = DROITE) then
					begin
						var_Cell.x := var_Cell.x + 1
					end
					else
					begin
						var_Cell.y := var_Cell.y + 1;
					end;
					cpt := cpt +1;
				until (verif = FALSE) OR (cpt = 4);
			until (verif);
		end
		else
		begin
			if ((nb_Bateau >= 3) and (nb_Bateau <= 5)) then
			begin
				repeat
					cpt := 1;
					verif := FALSE;
					writeln ('Saisissez votre cellule d origine :');
					setCell(var_Cell, sens, nb_Bateau);   //appel de la procédure création de cellule
					repeat
						verif := comparCell(var_Cell, flotteB);
						if (sens = DROITE) then
						begin
							var_Cell.x := var_Cell.x + 1
						end
						else
						begin
							var_Cell.y := var_Cell.y + 1;
						end;
						cpt := cpt +1;
					until (verif = FALSE) OR (cpt = 3);
				until (verif);
			end
			else
			begin
				repeat
					cpt := 1;
					verif := FALSE;
					writeln ('Saisissez votre cellule d origine :');
					setCell(var_Cell, sens, nb_Bateau);   //appel de la procédure création de cellule
					repeat
						verif := comparCell(var_Cell, flotteB);
						if (sens = DROITE) then
						begin
							var_Cell.x := var_Cell.x + 1
						end
						else
						begin
							var_Cell.y := var_Cell.y + 1;
						end;
						cpt := cpt +1;
					until (verif = FALSE) OR (cpt = 2);
				until (verif);
			end;
		end;
		
		if (sens = DROITE) then
		begin
			var_Cell.x := var_Cell.x - (cpt-1)
		end
		else
		begin
			var_Cell.y := var_Cell.y - (cpt-1);
		end;
		setBateau(flotteB, var_Cell, sens, nb_Bateau);   //appel de la procédure création de bateau
	end;

	//initialisation de certaines variables avant le lancement de la boucle de traitement principale du jeu
	tourJ := TRUE; //si tourJ = true, alors c'est au joueur A de jouer. Sinon, c'est au joueur B
	pdvA := MAXPDV;
	pdvB := MAXPDV;

	repeat 
		if (tourJ) then
			writeln ('Le joueur A joue !')
		else
			writeln ('Le joueur B joue !');

		//boucle de saisie du x
		repeat
			writeln ('Veuillez saisir le x de la cellule a bombarder !');
			readln (var_Cell.x);
		until (var_Cell.x < MAXCOORD) and (var_Cell.x > MIN);

		//boucle de saisie du y
		repeat
			writeln ('Veuillez saisir le y de la cellule a bombarder !');
			readln (var_Cell.y);
		until (var_Cell.y < MAXCOORD) and (var_Cell.y > MIN);

		if (tourJ) then   // si c'est le tour du joueur A
		begin
			if (comparCell(var_Cell, flotteB)) then   // et que la cellule demandée correspond à une cellule de la flotte du joueur B
			begin
				writeln ('Vous avez touche le bateau numero ', caseBateau(var_Cell, flotteB));    // alors on regarde quel bateau il a touché
				pdvB := pdvB - 1;
			end
		end
		else    // pareil pour le joueur B
		begin
			if (comparCell(var_Cell, flotteA)) then
			begin
				writeln ('Vous avez touche le bateau numero ', caseBateau(var_Cell, flotteA));    // alors on regarde quel bateau il a touché
				pdvA := pdvA - 1;
			end;
		end;
	







	until (pdvA = MIN) or (pdvB = MIN);


	// pour renseigner le joueur sur le gagnant !
	if (pdvA = MIN) then
		writeln ('Le joueur B gagne !')
	else
		writeln ('Le joueur A gagne !');


	readln;

end.
		


