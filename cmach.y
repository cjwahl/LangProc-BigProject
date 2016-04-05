
%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>


typedef struct 
{
 int ival;
 char str[500];
}tstruct ; 

#define YYSTYPE  tstruct 

%}


%token    NUM
%token    HATCH
%token    SOUP
%token    COLOR 
%token    TURTLE
%token    NOTRAIL
%token    TRAIL
%token    FORWARD
%token    RIGHT
%token    LEFT
%token    TURTLEID

%%


program
   :  input     { 
                  printf("//------------------\n");
                  printf("#include <stdio.h>\n");
                  printf("int main()\n");
                  printf("{\n");
                  printf("int x;\n");
                  printf("%s", $1.str);
                  printf("return 0;\n");
                  printf("}\n");
                  printf("//------------------\n");
                }
   ;

input
    :  /* empty */
    |  input line  
                   {
                     strcpy( $$.str, $1.str);
                     strcat( $$.str, $2.str);  
                   }
    ;

line
    : ';'
    |  cmd ';'           
                   {
                     strcpy( $$.str, $1.str);
                   }
    ;   

cmd 
  :  CLEAR {strcpy( $$.str, "x = 0;\n");             }
  |  SHOW  {strcpy( $$.str, "printf(\" %d\\n\", x);\n" ); }
  |  GET   {strcpy( $$.str, "scanf(\"%d\", &x);\n" ); }
  |  ADD NUM
           { 
            strcpy( $$.str, "x = x + ");
            strcat( $$.str, $2.str );
            strcat( $$.str, ";\n");
           } 
  |  MULT NUM
           { 
            strcpy( $$.str, "x = x * ");
            strcat( $$.str, $2.str );
            strcat( $$.str, ";\n");
           } 
  |  SUB NUM
           { 
            strcpy( $$.str, "x = x - ");
            strcat( $$.str, $2.str );
            strcat( $$.str, ";\n");
           } 
  |  MOD NUM
           { 
            strcpy( $$.str, "x = x % ");
            strcat( $$.str, $2.str );
            strcat( $$.str, ";\n");
           } 
  |  REP NUM cmd
           { 
            strcpy( $$.str, "for(i = 0; i <= ");
            strcat( $$.str, $2.str );
            strcat( $$.str, ";i++){\n");
            strcat( $$.str, $3.str"}\n");
           } 
  
  ;

%%


main ()
{
  yyparse ();
}

yyerror (char *s)  /* Called by yyparse on error */
{
  printf ("\terror: %s\n", s);
}

