{ALGORITHME : Palindrome
//BUT : L'algorithme affiche un booléen par rapport à si une chaine de caractère est un 
// palindrome ou non.
//ENTREES : Une chaine de caractères.
//SORTIES : Un booléen.
//PRINCIPE : Calculer la longueur puis mettre un booléen avec des extractions dans une 
//boucle répéter jusqu'à.

VAR

mot : CHAINE
palindrome : BOOLEEN
cpt, lgchaine : ENTIER

DEBUT 

palindrome <- TRUE //on initialise nos variables
cpt <- 1
ECRIRE "Saisir un mot :"
LIRE mot
lgchaine <- LONGUEUR (mot)

REPETER 
	palindrome <- EXTRACTION (mot, cpt) = EXTRACTION (mot, lgchaine - cpt + 1)
	cpt <- cpt + 1
JUSQU'A (cpt = lgchaine DIV 2) OU (palindrome = FALSE)
//On répète la boucle jusqu'à ce que tous les caractères soient analysés OU jusqu'à 
//ce que l'algorithme ait déterminé qu'il ne s'agit pas d'un palindrome

ECRIRE "Ce mot est un palindrome", palindrome
FIN}

PROGRAM Palindome;
//BUT : Le programme affiche un booléen par rapport à si une chaine de caractère est un 
// palindrome ou non.
//ENTREES : Une chaine de caractères.
//SORTIES : Un booléen.
//PRINCIPE : Calculer la longueur puis mettre un booléen avec des extractions dans une 
//boucle répéter jusqu'à.

USES crt;

VAR

mot : string;
palindrome : boolean;
cpt, lgchaine : integer;

BEGIN

	clrscr; //on supprime le flux inutile
	palindrome := TRUE; //on initialise nos variables
	cpt := 1;
	writeln ('Saisir un mot :');
	readln (mot);
	lgchaine := Length (mot);
	REPEAT 
		BEGIN
		palindrome := Copy(mot, cpt, 1) = Copy(mot, lgchaine - cpt + 1, 1);
		cpt := cpt + 1;
		end;
	until (cpt = lgchaine DIV 2) OR (palindrome = FALSE);
//On répète la boucle jusqu'à ce que tous les caractères soient analysés OU jusqu'à 
//ce que l'algorithme ait déterminé qu'il ne s'agit pas d'un palindrome
	writeln ('Ce mot est un palindrome', palindrome);
	readln;
END. 




