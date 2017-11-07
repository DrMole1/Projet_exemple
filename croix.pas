{ALGORITHME : Croix_de_caractères
BUT : L'algorithme envoie une "croix" constitué de plusieurs caractères identiques selon 
une taille tous deux choisis par l'utilisateur.
ENTREE : L'utilisateur saisit un caractère et une taille.
SORTIE : L'algorithme envoie une croix correspondant aux critères saisis par 
l'utilisateur.
PRINCIPE : On instaure une boucle dont la taille saisie sera le nombre d'itérations.
La taille déterminera aussi l'emplacement du caractère selon le modèle de croix.

VAR

x : CARACTERE
taille, cpt, cpt2 : ENTIER

DEBUT

ECRIRE "Saisir un caractère :"
LIRE x
ECRIRE "Saisir une taille :"
LIRE taille

POUR cpt DE 1 A taille FAIRE
	POUR cpt2 DE 1 A taille FAIRE
		SI (cpt=cpt2) OU (cpt+cpt2=taille+1) ALORS
			ECRIRE x
		SINON
			ECRIRE ' '
		FIN SI
	FIN POUR
	//il faut trouver un moyen pour revenir à la ligne
FIN POUR
	
}

PROGRAM Croix_de_caracteres;

USES crt;

VAR

x : char;
taille, cpt, cpt2 : integer;

BEGIN

	clrscr; //on supprime le flux inutile
	cpt := 1;
	cpt2 := 1; //on initialise les deux compteurs à 1
	writeln ('Saisir un caractere :');
	readln (x);
	writeln ('Saisir une taille :');
	readln (taille);    //l'utilisateur saisit ses entrées

	//Le premier programme suit le principe des deux boucles FOR.

	{for cpt:=1 to taille do
    begin
        for cpt2:=1 to taille do
        begin
            if (cpt = cpt2) OR (cpt + cpt2 = taille + 1) then
			    write (x)  
	        else
				write (' ');
        end;
            writeln;
        end;}


    //Le même but mais pas avec le même principe.
    //On utilise maintenant une boucle FOR et une boucle while.

	while cpt <= taille do
        begin
            for cpt2:=1 to taille do
        	begin
           		if (cpt = cpt2) OR (cpt + cpt2 = taille + 1) then
			    	write (x)  
	        	else
					write (' ');
        	end; 
            cpt:=cpt+1;
            writeln; //on va à la ligne
        end;
	

    readln;
END.




