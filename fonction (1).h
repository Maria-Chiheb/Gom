
// definition de l'enregistrement variable et cst
typedef struct 
	{
		char NomEntite[20];
		char CodeEntite[20];
		char TypeEntite[20];
        float valF ;
		int valI ;
	} TypeTS;


// definition de l'enregistrement seperateur et mot cle
typedef struct 
	{
		char NomS[20];
		char CodeS[20];	
	} elt;


// definition de la liste pour variable et cst
typedef struct Celll *Liste;
typedef struct Celll
    {
        TypeTS enre;
        Liste svt;

    }noeud;

// definition de la liste pour sep et mot cle
typedef struct Cell *ListeS;
typedef struct Cell
    {
        elt enreS;
        ListeS svt;

    }nod;



//initiation d'une liste qui va contenir les elements de la table de symbole variable et cst
Liste ts;

//initiation d'une liste qui va contenir les elements de la table de symbole sep et mot cle
ListeS tsS,tsM;

//le pointeur qui va parcourir la liste
Liste parc ;

//le pointeur qui va parcourir la liste sep cst
ListeS parcM ,parcS;

//pour sauvegarder l'element parcouru pour insere la novelle entite dans le saveparc->svt si parc= null 
Liste saveparc;

//pour sauvegarder l'element parcouru pour insere la nouvelle entite dans le saveparcS->svt si parcS= null sep cst
ListeS saveparcM,saveparcS;


// un compteur global pour la liste des symboles
//int CpTabSym=0;

// creation d'un nouveau noeud pour insere les la nouvel entite des var et cst
ListeS creer_noeudS()
{
    ListeS L ;
    L= (ListeS)malloc(sizeof(nod)) ; // L= (ListeS)malloc(sizeof(struct Cell)) ;
    if (L==NULL) 
    { 
        printf("erreur d’allocation\n") ;
        exit(-1) ;
    }
	else //printf("GOOD");
    //CpTabSym++; //incrementer le nombre d'entite 
    return(L) ;
}

// creation d'un nouveau noeud pour insere les la nouvel entite des sep et mot cle
Liste creer_noeud()
{
    Liste L ;
    L= (Liste)malloc(sizeof(noeud)) ; // L= (Liste)malloc(sizeof(struct Cell)) ;
    if (L==NULL) 
    { 
        printf("erreur d’allocation\n") ;
        exit(-1) ;
    }
	else //printf("GOOD");
    // CpTabSym++; //incrementer le nombre d'entite 
    return(L) ;
}

// affichage de la liste DONE 
void affiche_list()
{   
    parc = ts ;
    printf("\n/***************LIST des symboles idf cst var******************/\n");
    printf("_______________________________________________________________________________\n");
    printf("\t| NomEntite | CodeEntite |  TypeEntite   | ValEntiteF   | ValEntiteI\n");
    printf("_______________________________________________________________________________\n");
	if (ts==NULL) printf("la liste n'etait pas creer\n");
	if (parc==NULL) printf("le pointeur qui parcour la list = null\n");
	//printf("%d\n",CpTabSym);
    while(parc!=NULL)
    {
        printf("\t|%10s |%12s | %12s | %12f | %12d\n",parc->enre.NomEntite,parc->enre.CodeEntite,parc->enre.TypeEntite,parc->enre.valF,parc->enre.valI);
        parc=parc->svt;
    }

    parcM = tsM ;
    printf("\n/***************LIST des symboles Mot cle******************/\n");
    printf("___________________________________\n");
    printf("\t| NomEntite | CodeEntite\n");
    printf("___________________________________\n");
	if (tsM==NULL) printf("la liste n'etait pas creer\n");
	if (parcM==NULL) printf("le pointeur qui parcour la list = null\n");
	//printf("%d\n",CpTabSym);
    while(parcM!=NULL)
    {
        printf("\t|%10s |%12s\n",parcM->enreS.NomS,parcM->enreS.CodeS);
        parcM=parcM->svt;
    }

    parcS = tsS ;
    printf("\n/***************LIST des symboles Separateur******************/\n");
    printf("___________________________________\n");
    printf("\t| NomEntite | CodeEntite\n");
    printf("___________________________________\n");
	if (tsS==NULL) printf("la liste n'etait pas creer\n");
	if (parcS==NULL) printf("le pointeur qui parcour la list = null\n");
	//printf("%d\n",CpTabSym);
    while(parcS!=NULL)
    {
        printf("\t|%10s |%12s\n",parcS->enreS.NomS,parcS->enreS.CodeS);
        parcS=parcS->svt;
    }
}

// insersion de la nouvelle entite in the beginig for the compiler to see

void inserer(char entite[],char code[],float valF,int valI ,Liste saveparc,ListeS saveparcS,int y)
{
	Liste nouv;
	ListeS nouvs;
    switch(y)
    {
        case 0 : 
        nouv=creer_noeud ( ) ;
        if(nouv==NULL) printf("on a pas pu creer le nouveau noeud \n");
        strcpy(nouv->enre.NomEntite,entite) ; 
        strcpy(nouv->enre.CodeEntite,code);
        nouv->enre.valF=valF;
		nouv->enre.valI=valI;
        nouv->svt = NULL;
        if(ts==NULL) ts = nouv;
        else saveparc->svt=nouv;
        break;

        case 1 :
        nouvs=creer_noeudS ( ) ;  
        if(nouvs==NULL) printf("on a pas pu creer le nouveau noeud \n");
        strcpy(nouvs->enreS.NomS,entite) ;
        strcpy(nouvs->enreS.CodeS,code);
        nouvs->svt = NULL;
        if(tsM==NULL) tsM = nouvs;
        else saveparcM->svt=nouvs;
        break;

        case 2 :
        nouvs=creer_noeudS ( ) ;  
        if(nouvs==NULL) printf("on a pas pu creer le nouveau noeud \n");
        strcpy(nouvs->enreS.NomS,entite) ;
        strcpy(nouvs->enreS.CodeS,code);
        nouvs->svt = NULL;  
        if(tsS==NULL) tsS = nouvs;
        else saveparcS->svt=nouvs;
        break;

    }

}

// definition de la fonction recherche 


void recherche(char entite[],char code[],float valF,int valI,int y) 
{
	
    parc = ts ;
    parcM =tsM ;
    parcS =tsS ;
    switch(y)
    {
        case 0 : //verifier si l entite existe dans la table des idf et cst ou pas sinon on va l'inserer 
            while(parc!=NULL)
            {
                if (strcmp(entite,parc->enre.NomEntite)==0) break;
                saveparc=parc;
                parc=parc->svt;
            }
            if (parc==NULL) inserer(entite,code,valF,valI,saveparc,NULL,0);
        break;

        case 1 : //verifier si l entite existe dans la table des mot cle
            while(parcM!=NULL)
                {
                    if (strcmp(entite,parcM->enreS.NomS)==0) break;
                    saveparcM=parcM;
                    parcM=parcM->svt;
                }
                if (parcM==NULL) inserer(entite,code,valF,valI,NULL,saveparcM,1);
        break;

        case 2 : //verifier si l entite existe dans la table des sep
            while(parcS!=NULL)
                {
                    if (strcmp(entite,parcS->enreS.NomS)==0) break;
                    saveparcS=parcS;
                    parcS=parcS->svt;
                }
                if (parcS==NULL) inserer(entite,code,valF,valI,NULL,saveparcS,2);
        break;
    }
       
}



Liste rechercheEntite(char entite[]) 
{
	
    parc = ts ;
    while(parc!=NULL)
    {
        if (strcmp(entite,parc->enre.NomEntite)==0) 
		{
			return parc;
		} 
        saveparc=parc;
        parc=parc->svt;
    }

    return NULL ; // parc == null
}

void insererTYPE(char entite[], char type[])
{
    Liste pos;
    pos = rechercheEntite(entite);
    if(pos!=NULL)
	   strcpy(pos->enre.TypeEntite,type);
    else printf ("ERREURR\n");
    
}













