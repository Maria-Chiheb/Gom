%{
#include "synta.tab.h" 
#include "fonction.h"

extern nb_ligne;
extern col;
extern YYSTYPE yylval ;
extern name;

%}
lettre[a-zA-Z]
chiffre[0-9]
cstint [-+]?{chiffre}+
cstreel [-+]?{chiffre}+\.{chiffre}+
idf {lettre}({lettre}|{chiffre})*
charas \"{lettre}*[a-zA-Z0-9 ]*[:|.]?\"    
boole ("TRUE"|"FALSE")
comment ("%"(.)*)

%%
DIMENSION {
	ECHO;
	recherche(yytext,"Mot cle",0,0,1); 	
	return mc_dimension;
	col=col+strlen(yytext);	
	}
ROUTINE	{
	ECHO;
	recherche(yytext,"Mot cle",0,0,1); 
    return mc_routine;	
	col=col+strlen(yytext);
	}
ENDR	{ 
    ECHO;
    recherche(yytext,"Mot cle",0,0,1); 
    return mc_endr; 
	col=col+strlen(yytext);
	}
LOGICAL {
	ECHO;
	recherche(yytext,"Mot cle",0,0,1); 
	yylval.str=strdup(yytext);
	return mc_logical;
	col=col+strlen(yytext); 
	}
INTEGER {
	ECHO;
	recherche(yytext,"Mot cle",0,0,1);
	yylval.str=strdup(yytext);
	return mc_integer;
	col=col+strlen(yytext); 
	}
REAL 	{
	ECHO;
	recherche(yytext,"Mot cle",0,0,1);
	yylval.str=strdup(yytext);
	return mc_reel;
	col=col+strlen(yytext);
	}
CHARACTER	{
	ECHO;
	recherche(yytext,"Mot cle",0,0,1);
	yylval.str=strdup(yytext);
	return mc_character;
	col=col+strlen(yytext);
	}
PROGRAM {
	ECHO;
	recherche(yytext,"Mot cle",0,0,1); 
	return mc_program;
	col=col+strlen(yytext); 
	}
END 	{
	ECHO;
	recherche(yytext,"Mot cle",0,0,1); 
	return mc_end;
	col=col+strlen(yytext);
	}
READ 	{
	ECHO;
	recherche(yytext,"Mot cle",0,0,1); 
	return mc_read;
	col=col+strlen(yytext);
	}
WRITE {
	ECHO;
	recherche(yytext,"Mot cle",0,0,1);
	return mc_write;
	col=col+strlen(yytext);	
	
	}
IF 	    {
	ECHO;
	recherche(yytext,"Mot cle",0,0,1);
    col=col+strlen(yytext);	
	return mc_if;
	}
ELSE 	{
	ECHO;
	recherche(yytext,"Mot cle",0,0,1); 
	return mc_else;
	}
ENDIF 	{
	ECHO;
	recherche(yytext,"Mot cle",0,0,1); 
	col=col+strlen(yytext);
	return mc_endif;
	}
DOWHILE {
	ECHO;
	recherche(yytext,"Mot cle",0,0,1); 
	col=col+strlen(yytext);
	return mc_dowhile;
	}
ENDDO 	{
	ECHO;
	recherche(yytext,"Mot cle",0,0,1); 
	col=col+strlen(yytext);
	return mc_enddo;
	}
CALL 	{
	ECHO;
	recherche(yytext,"Mot cle",0,0,1); 
	col=col+strlen(yytext);
	return mc_call;
	}
THEN 	{
	ECHO;
	recherche(yytext,"Mot cle",0,0,1); 
	col=col+strlen(yytext);
	return mc_then;
	}
EQUIVALENCE {
	ECHO;
	recherche(yytext,"Mot cle",0,0,1); 
	col=col+strlen(yytext);
	return mc_equivalence;
	}
"="   {
	ECHO;
	recherche(yytext,"sep",0,0,2);
	col=col+strlen(yytext); 
	return aff; 
	}
";"	{
	ECHO;
	recherche(yytext,"sep",0,0,2);
	return pvg;
	col=col+strlen(yytext); 
	 
	}
","		{
	ECHO;
	recherche(yytext,"sep",0,0,2); 
	return comma;
	col=col+strlen(yytext);
	}
"(" 	{
	ECHO;
	recherche(yytext,"sep",0,0,2);
	return paouv;
	col=col+strlen(yytext);
		}
")" 	{
	ECHO;
	recherche(yytext,"sep",0,0,2);
	return pafer; 
	col=col+strlen(yytext);
	}
"OR" 	{
	ECHO;
	recherche(yytext,"sep",0,0,2);
	col=col+strlen(yytext); 
	return ou;
	}
"AND" 	{
	ECHO;
	recherche(yytext,"sep",0,0,2);
	col=col+strlen(yytext); 
	return et;
	}
"GT" 	{
	ECHO;
	recherche(yytext,"sep",0,0,2); 
	return gt;
	col=col+strlen(yytext);
	}
		
"GE" 	{
	ECHO;
	recherche(yytext,"sep",0,0,2);
	col=col+strlen(yytext); 
	return ge;
	}
		
"EQ" 	{
	ECHO;
	recherche(yytext,"sep",0,0,2);
	col=col+strlen(yytext);
	return eq; 
	}
		
"NE" 	{
	ECHO;
	recherche(yytext,"sep",0,0,2);
	col=col+strlen(yytext);
	return ne; 
	}
		
"LE" 	{
	ECHO;
	recherche(yytext,"sep",0,0,2);	
	col=col+strlen(yytext);
	return le; 
	}
		
"LT" 	{
	ECHO;
	recherche(yytext,"sep",0,0,2);
	col=col+strlen(yytext); 
	return lt;
	}
"+" 	{
	ECHO;
    recherche(yytext,"sep",0,0,2);
	col=col+strlen(yytext); 
	return plus;
	}
"-" 	{
	ECHO;
	recherche(yytext,"sep",0,0,2);
	col=col+strlen(yytext); 
	return minus;
	}
 "*" 	{
	 ECHO;
	recherche(yytext,"sep",0,0,2);
	col=col+strlen(yytext);
	return mul; 
	}
"/" 	{
	ECHO;
	recherche(yytext,"sep",0,0,2);
	col=col+strlen(yytext); 
	return divi;
	}
		
"." 	{
	ECHO;
	recherche(yytext,"sep",0,0,2); 
	return point;
	col=col+strlen(yytext);
	}
	
"\"" 	{
	        ECHO;
			return quot;
			col=col+strlen(yytext); 
		}
		
{boole} {
	ECHO;
	yylval.str=strdup(yytext);
	col = col+ strlen(yytext);
	return boole; 
}

		
{idf}   {
	ECHO;
	yylval.str=strdup(yytext);	
	if (yyleng>=10){
		printf("File \"%s\" , Warning : line %d, character %d : idf trop long %s : Lexical error\n",name,nb_ligne,col,yytext);
	}else
	{    
		recherche(yytext,"idf",0,0,0);
		return idf;
		col=col+strlen(yytext);
	}
}

{cstint}  { 
    ECHO;
    yylval.entier=atoi(yytext);
	if (atoi(yytext)>=32767 || atoi(yytext)<=-32768){
		printf("File \"%s\" , Warning : line %d, character %d : cst trop long %s : Lexical error\n",name,nb_ligne,col,yytext);
	}else {
	recherche(yytext,"CstInt",0,atoi(yytext),0);
	
	return cstint;
	col=col+strlen(yytext);
	
	}
}
{cstreel}  { 
     ECHO;
    yylval.reel=atof(yytext);
	if (atof(yytext)>=32767.32767 || atof(yytext)<=-32768.32768){
		printf("File \"%s\" , Warning : line %d, character %d : cst trop long %s : Lexical error\n",name,nb_ligne,col,yytext);
	}else {
	recherche(yytext,"CstReel",atof(yytext),0,0);
	
	return cstreel;
	col=col+strlen(yytext);}
} 
{charas} {
	ECHO;
	yylval.str=strdup(yytext);
	return charas; 
	col = col+ strlen(yytext);
} 
{comment} {
	col = col+ strlen(yytext); 
} 

[ \t] {ECHO; col=col+strlen(yytext);}
\n	{ ECHO;
	nb_ligne++; 
	col=1;
}
. {printf("File \"%s\" , line %d, character %d : Lexical error in entite %s\n",name,nb_ligne,col,yytext);
    return err; }
	
	

