Program Bataille_Navale;
USES crt;

// GAMEPLAY - QUESTION 9 :
// Chaque joueur reçoit une grille de jeu avec deux bateaux (nombre modifiable dans le code) posés aléatoirement. Tour à tour, les joueurs déterminent une cellule avec des paramètres ligne 
// et colonne. Le but du jeu est de toucher toutes les cellules comportant un bateau, et de détruire ces deux bateaux.

CONST

	NB_BATEAU = 2;  //à modifier pour augmenter le nombre de bateaux par flotte
	MAX_CASE = 5;
	MIN_L = 1;
	MAX_L = 10;
	MIN_C = 1;
	MAX_C = 10;

type etatBateau = (operationnel, toucher);

type etatFlotte = (aflot, sombrer);

type cellule = record
	ligne : integer;
	colonne : integer;
	etat : etatBateau;
end;

type bateau = record
	nCase : array [1..MAX_CASE] of cellule;
	etat : etatFlotte;
end;

type flotte = record 
	nBateau : array [1..NB_BATEAU] of bateau;
end;

type bool = (VRAI, FAUX);

type posBateau = (ligne, colonne, diagonale);

type etatJoueur = (gagner, perdu);

procedure creaCellule (ligne,colonne : integer; var nCel : cellule);
//procédure de création de cellule
	begin
		nCel.ligne := ligne;
		nCel.colonne := colonne;
	end;

function cmpCellule (nCel, tCel : cellule) : boolean;
//procédure de comparaison de cellules
	begin
		if ((nCel.ligne = tCel.ligne) and (nCel.colonne = tCel.colonne)) then
			cmpCellule := TRUE
		else
			cmpCellule := FALSE;
	end;

function creaBateau (var pdv : integer; nCel : cellule; taille : integer) : bateau;
//fonction pour créer un bateau
	var
		tmpBateau : bateau;
		pos : integer;
		i : integer;
		pBateau : posBateau;
	begin
		randomize;
		pos := random(2)+1;
		pBateau := posBateau(pos);
		for i:=1 to MAX_CASE do
		begin
			pdv := pdv +1;
			if (i<taille) then
			begin
				tmpBateau.nCase[i].ligne := nCel.ligne;
				tmpBateau.nCase[i].colonne := nCel.colonne
			end
			else
			begin
				tmpBateau.nCase[i].ligne := 0;
				tmpBateau.nCase[i].colonne := 0;
			end;

			if (pBateau = ligne) then
				nCel.colonne := nCel.colonne +1
			else if (pBateau = colonne) then
				nCel.ligne := nCel.ligne +1
			else if (pBateau = diagonale) then
			begin
				nCel.colonne := nCel.colonne +1;
				nCel.ligne := nCel.ligne +1;
			end;
		end;

		creaBateau := tmpBateau;
	end;

function verifCellule (nBat : bateau; nCel : cellule; var j : integer) : boolean;
//fonction qui détermine si une cellule comporte un bateau ou non
	var
		cpt : integer;
		test : boolean;
	begin
		test := FALSE;
		for cpt:=1 to MAX_CASE do
		begin
			if (cmpCellule(nBat.nCase[cpt], nCel)) then
			begin
				test := TRUE;
			end;
		end;
		j := cpt;
		verifCellule := test;
	end;

function verifFlotte (f : flotte; nCel : cellule; var i, j : integer) : boolean;
//fonction qui détermine si une cellule comporte une flotte ou non
	var
		cpt : integer;
		test : boolean;
	begin
		test := FALSE;
		for cpt:=1 to NB_BATEAU do
		begin
			if (verifCellule(f.nBateau[cpt], nCel, j)) then
			begin
				test := TRUE;
			end;
		end;
		verifFlotte := test;
		i:=cpt;
	end;

procedure flotteJoueur (var pdv : integer; var nCel : cellule; var f : flotte);
//création de flotte par un aléatoire pour le joueur !
	var 
		i, valposligne, valposcolonne, valtaillebat, cpt : integer;
	begin
		for i:=1 to NB_BATEAU do
		begin
			randomize;
			valposligne := random(MAX_L-1)+1;
			valposcolonne := random(MAX_C-1)+1;
			valtaillebat := random(MAX_CASE-1)+1;
			creaCellule(valposligne, valposcolonne, nCel);
			f.nBateau[i] := creaBateau (pdv, nCel, valtaillebat);
		end;

		//on modifie l'état de chaque composant des bateaux
		for i:=1 to NB_BATEAU do
		begin
			for cpt:=1 to MAX_CASE do
			begin
				f.nBateau[i].nCase[cpt].etat := etatBateau(1); //chaque composant de bateau devient "opérationnel"
			end;
		end;
	end;






var
	lign, colonn, taille, i, j, pdvA, pdvB : integer;
	nCel : cellule;
	nBat : bateau;
	fA, fB : flotte;
	tourJ : boolean;

begin //bloc principal (main)

	clrscr;  //suppression du flux inutile
	//initialisation des points de vie
	pdvA := 0;
	pdvB := 0;

	//création des flottes aléatoires pour le joueur A puis pour le joueur B (ainsi que le score de points de vie)
	flotteJoueur(pdvA, nCel, fA);
	readln;   //!!!!!! on ajoute un temps de latence entre les créations de flotte pour ne pas faire bugguer le programme !!!!!!!!
	readln;
	flotteJoueur(pdvB, nCel, fB);
	readln;

	{//test pour afficher les origines du premier bateau de chaque flotte, désactivez les accolades pour faire fonctionner
	writeln (fA.nBateau[1].nCase[1].ligne);  
	writeln (fA.nBateau[1].nCase[1].colonne);
	writeln (fB.nBateau[1].nCase[1].ligne);
	writeln (fB.nBateau[1].nCase[1].colonne);
	//test pour afficher les points de vie de chaque joueur
	writeln (pdvA, ' ', pdvB);}

	//déroulement des tours de jeu
	tourJ := FALSE;  //variable pour déterminer le tour de chaque joueur
	repeat
		
		tourJ:= NOT tourJ; //on change le tour du joueur en cours
		if tourJ then
			writeln ('Joueur A, c est votre tour !')
		else
			writeln ('Joueur B, c est votre tour !');


		//boucle de saisie des cellules
		repeat 
			writeln ('Saisir votre colonne (entre 1 et ', MAX_C,') :');
			readln (colonn);
			writeln ('Saisir votre ligne (entre 1 et ', MAX_L,') :');
			readln (lign);
			if ((colonn < MIN_C) or (colonn > MAX_C) or (lign < MIN_L) or (lign > MAX_L)) then  //en cas de faute de saisie, nous avisons l'utilisateur de faire attention à la saisie
			begin
				writeln ('Position non existante ! Veuillez resaisir une nouvelle colonne et ligne :');
				writeln;
			end
		until (colonn >= MIN_C) and (colonn <= MAX_C) and (lign >= MIN_L) and (lign <= MAX_L);


		//on détermine si cette cellule contient un bateau et une flotte
		if (tourJ) then
		begin
			if (verifFlotte(fB, nCel,i, j)) then //si le joueur touche une partie de bateau
			begin
				if (fB.nBateau[i].nCase[j].etat = etatBateau(1)) then  // et si cette partie de bateau n'a pas encore été touchée
				begin
					fB.nBateau[i].nCase[j].etat := etatBateau(2);  // on change l'état de cette partie de bateau en "toucher"
					writeln ('Toucher !');  //et on renseigne l'utilisateur
					pdvB := pdvB -1
				end
				else
				begin
					writeln ('Vous avez deja toucher cette partie de bateau !');
				end;
			end
			else
			begin
				writeln ('Louper !');
			end
		end
		else
		begin
			if (verifFlotte(fA, nCel,i, j)) then //si le joueur touche une partie de bateau
			begin
				if (fA.nBateau[i].nCase[j].etat = etatBateau(1)) then  // et si cette partie de bateau n'a pas encore été touchée
				begin
					fA.nBateau[i].nCase[j].etat := etatBateau(2);  // on change l'état de cette partie de bateau en "toucher"
					writeln ('Toucher !');  //et on renseigne l'utilisateur
					pdvA := pdvA -1
				end
				else
				begin
					writeln ('Vous avez deja toucher cette partie de bateau !');
				end;
			end
			else
			begin
				writeln ('Louper !');
			end
		end
		

	until (pdvA = 0) or (pdvB = 0);

	if (pdvA = 0) then   //message de victoire
		writeln ('Le joueur B gagne !')
	else
		writeln ('Le joueur A gagne !');












	readln;
end.

