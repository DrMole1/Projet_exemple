PROGRAM Calcul_prixTTC;

USES crt;

VAR

Prix,PrixTTC : REAL;

BEGIN
	clrscr;
	writeln ('Saisir le prix :');
	readln (Prix);
	PrixTTC := Prix*1.2;
	writeln ('Votre prix total est :', PrixTTC);
	readln;
END.