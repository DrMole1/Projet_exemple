//BUT : Cr�er un carr� magique, tableau d'entiers de 5 par 5 ou 7 par 7, incr�ment� par des valeurs de 1 � 25 ou 1 � 49.
//PRINCIPE : Le premier entier 1 se trouve au nord du milieu de la table
//On place les chiffres de fa�on croissante en allant au nord est de la position courante, une seule fois
//Si la place est d�j� prise, on se d�place au nord-ouest jusqu'� trouver cette place libre
//La grille est consid�r�e comme sph�rique
//Cr�er algo du carr� magique en tableau � 2 DIM qui mat�rialisera la grille
//Structure enregistrement contenant les positions x et y
//Fonctionne pour 5 par 5 ou 7 par 7
//Fonctions initialiser, avancer gauche, avancer droite, avancer corriger (donc enclencher avancer gauche), rechercher, placer, afficher,
//ENTREES : Aucune entr�e
//SORTIE : Le carr� magique


#include <stdio.h>
#include <stdlib.h>

#define COTE 5
#define SUP 6
#define CMIN 1
#define CSMIN 0
#define CMAX 5
#define CSMAX 6

//on d�finit la structure Position
typedef struct Position
{
    int x;
    int y;

}Position;



int initialiser(int pointofCarre[COTE][COTE], Position *pointofJeton) //on r�cup�re les pointeurs (donc les adresses des variables)
// !! PAS DE POINTEUR POUR UN TABLEAU !!
//m�thode pour initialiser le tableau et le jeton
{
    //d�claration des variables locales � la m�thode
    int cpt=0, cpt2=0;

    //boucles imbriqu�es de traitement pour assigner � chaque cellule la valeur 0
    for (cpt=1 ; cpt < SUP ; cpt++)
    {
        for (cpt2=1 ; cpt2 < SUP ; cpt2++)
        {
            pointofCarre[cpt][cpt2] = 0;
        }
    }

    //Initialisation des propri�t�s du Jeton
    pointofJeton->x = 3;  // Convention pour passer une valeur dans un pointeur dans une structure !
    pointofJeton->y = 2;

    return 0;
}


int afficher(int pointofCarre[COTE][COTE])
//m�thode pour afficher un tableau
{
    //d�claration des variables locales � la m�thode
    int cpt=0, cpt2=0;

    //boucles imbriqu�es pour afficher la grille
    for (cpt=1 ; cpt < SUP ; cpt++)
    {
        printf("\n");  //retour chariot
        for (cpt2=1 ; cpt2 < SUP ; cpt2++)
        {
            printf("%d ", pointofCarre[cpt][cpt2]);
        }
    }

    return 0;
}


int avancer_droite (Position *pointofJeton, int Carre[COTE][COTE], int pointofCpt)
{

    pointofJeton->x = pointofJeton->x - 1;
    pointofJeton->y = pointofJeton->y + 1;

    return 0;
}



int avancer_gauche(Position *pointofJeton, int Carre[COTE][COTE], int *pointofCpt)
{

    pointofJeton->x = pointofJeton->x - 1;
    pointofJeton->y = pointofJeton->y - 1;

    return 0;
}


int rechercher_vide(Position *pointofJeton, int Carre[COTE][COTE], int *pointofCpt, int *pointofVide)
{
    if (Carre[pointofJeton->x][pointofJeton->y] == 0)
    {
        // Si la valeur de la grille est 0, on appellera la proc�dure placer dans le programme principal
        *pointofVide = 1;
    }
    else
    {
        //sinon, nous corrigeons la trajectoire du cheminement dans la programme principal
        *pointofVide = 0;
    }

    return 0;
}


/*
int corriger (Position *pointofJeton, int Carre[COTE][COTE], int *pointofCpt)
{
    avancer_gauche(&pointofJeton, Carre, &pointofCpt);

    return 0;
}
*/


int avancer(Position *pointofJeton, int Carre[COTE][COTE], int *pointofCpt)
{
    if (pointofJeton->x == CSMIN)
    {
        //on le fait revenir en WRAP � droite de la grille
        pointofJeton->x = CMAX;
    }
    else if (pointofJeton->x == CSMAX)
    {
        pointofJeton->x = CMIN;
        //on le fait revenir en WRAP � gauche de la grille
    }

    if (pointofJeton->y == CSMIN)
    {
        pointofJeton->y = CMAX;
        //on le fait revenir en WRAP en bas de la grille
    }
    else if (pointofJeton->y == CSMAX)
    {
        pointofJeton->y = CMIN;
        //on le fait revenir en WRAP en haut de la grille
    }

    return 0;
}


int placer(Position *pointofJeton, int Carre[COTE][COTE], int *pointofCpt)
{
    //on affecte la valeur dans la cellule
    Carre[pointofJeton->x][pointofJeton->y] = *pointofCpt;

    return 0;
}







int main()  //programme principal MAIN
{
    //d�claration des variables locales au main
    int Carre[COTE][COTE];
    int cpt=1, vide=0, gauche =0, debug=0;
    Position Jeton;

    /*
    //d�claration des pointeurs
    //on affecte l'adresse des variables aux pointeurs
    int *pointofCarre = &Carre[COTE][COTE] , *pointofCpt = &cpt , *pointofJeton = &Jeton;
    */

    initialiser(Carre, &Jeton); //on envoie l'adresse de la variable Jeton, mais pas l'adresse d'un tableau !
    //printf("%d", Jeton.x); //cette fois ci la valeur a �t� chang�e



    //boucle de traitement principal
    for (cpt = 1 ; cpt<COTE*COTE +1 ; cpt++)
    {
        avancer_droite (&Jeton, Carre, &cpt);
        avancer(&Jeton, Carre, &cpt);
        rechercher_vide (&Jeton, Carre, &cpt, &vide);
        if (vide == 0)
        {
            avancer_gauche(&Jeton, Carre, &cpt);
            avancer(&Jeton, Carre, &cpt);
            rechercher_vide (&Jeton, Carre, &cpt, &vide);
            placer (&Jeton, Carre, &cpt);
        }
        else
        {
            placer (&Jeton, Carre, &cpt);
        }


    }


    //affichage du Carre � l'�cran
    afficher(Carre);

    return 0;
}
