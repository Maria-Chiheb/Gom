%{
  int yyerror(char *msg);
  int nb_ligne=1, col;
  char sauvType[20];
  char* name;
  
  #include <stdio.h>
  #include <stdlib.h>
%}

%union{
int     entier;
char*   str;
float reel;}

%token mc_dimension mc_routine mc_endr <str>mc_logical <str>mc_integer <str>mc_reel <str>mc_character mc_program
mc_end mc_read mc_write mc_if mc_else mc_endif mc_dowhile mc_enddo mc_call mc_then pvg comma paouv pafer
point <str>idf <entier>cstint <reel>cstreel aff <str>charas boole mc_equivalence  err ou et quot
%token ore ande 
%token gt ge eq ne le lt 
%token plus minus 
%token mul divi  
%%
S: FONCS S
|PROGRAM
{printf("\nCORRECT SYNTAX\n");
YYACCEPT;}
;
PROGRAM: mc_program idf  LIST_DEC LIST_INST mc_end
;
FONCS: TYPE mc_routine idf paouv LIST_PAR pafer LIST_DEC LIST_INST mc_endr
;
TYPE: mc_integer {strcpy(sauvType,$1);}
| mc_character {strcpy(sauvType,$1);}
| mc_logical {strcpy(sauvType,$1);}
| mc_reel {strcpy(sauvType,$1);}
;
LIST_DEC: DEC LIST_DEC
|
;
DEC: //DECSIMPLE| 
  DECVAR                          
| DECTAB
| DECMAT
;
//DECSIMPLE: TYPE idf pvg {insererTYPE($2,sauvType);}
//;
DECVAR: TYPE LIST_PAR pvg
;
DECTAB: TYPE idf mc_dimension paouv cstint pafer pvg
;
DECMAT: TYPE idf mc_dimension paouv cstint comma cstint pafer pvg
;
LIST_PAR: idf comma LIST_PAR { insererTYPE($1,sauvType);}   // entite , type
         |idf { insererTYPE($1,sauvType);} 
		 |idf mul cstint comma LIST_PAR 
		 |idf mul cstint  
		 
;

INST: idf aff EXP pvg 
|mc_read paouv idf pafer pvg  
|mc_write paouv charas pafer pvg   
|mc_write paouv charas comma idf comma charas pafer pvg
|mc_if paouv EXPCONDI pafer mc_then LIST_INST mc_else LIST_INST mc_endif  
|mc_dowhile EXPCONDI LIST_INST mc_enddo  pvg
|idf aff mc_call idf paouv LIST_PAR pafer pvg
|mc_equivalence paouv EXP pafer comma paouv EXP pafer pvg
; 
// EXPEQ: LIST_PAR 
// |idf paouv cstint pafer comma EXPEQ
// |idf paouv cstint pafer
// ;




LIST_INST: INST LIST_INST
|INST 
;
EXP: cstint Z  
|cstreel Z 
|charas
|boole 
|idf paouv cstint comma cstint pafer Z
|idf paouv cstint pafer Z
|idf Z                                                         //IF(((A.GT.(B+1)).OR. (C.EQ.TRUE) ))
|paouv EXP pafer Z                                             
;                                                           
Z: OPER cstreel Z
|OPER cstint Z
|OPER idf Z
|OPER idf paouv cstint comma cstint pafer Z
|OPER idf paouv cstint pafer Z
|OPER paouv EXP pafer
|comma EXP
|
;

OPER: plus
|minus
|mul
|divi
;

EXPCONDI: paouv EXPCONDI point IFSEP point EXPCONDI pafer 
|EXP
;
IFSEP: ou
|et
|gt
|ge
|eq
|ne
|le
|lt
;
%%
int main(int argc, char *argv[]){
  name = argv[1];
  yyparse();
  free(name);
  affiche_list();
}
yywrap ()
{}
int yyerror ( char *msg )  {
  printf("File \"%s\" line %d,character %d: syntax error\n",name,nb_ligne,col);
  //exit(EXIT_FAILURE);
}


