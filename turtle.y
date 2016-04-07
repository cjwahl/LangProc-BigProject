
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
%token    TURTLECOLOR
%token    COLOR 
%token    TURTLE
%token    NOTRAIL
%token    TRAIL
%token    FORWARD
%token    RIGHT
%token    LEFT
%token    ID
%token    TURN

%%


program
   :  input     { 
                  printf("//------------------\n");
                  printf("%s", $1.str);
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
    : cmd           
                   {
                     strcpy( $$.str, $1.str);
                   }
    ;   

cmd 
  :  TURTLE ID
  			{ 
            strcpy( $$.str, "var ");
            strcat( $$.str, $2.str );
            strcat( $$.str, " = jQuery.extend(true, {}, turtle);\n");
            }             
  |  ID FORWARD NUM  
            {
            strcpy( $$.str, $1.str);
            strcat( $$.str, ".forward(");
            strcat( $$.str, $3.str);
            strcat( $$.str, ");\n");
            }
  |  ID NOTRAIL
            {
            strcpy( $$.str, $1.str);
            strcat( $$.str, ".penDown = false;\n");
            }
  |  ID TRAIL
            {
            strcpy( $$.str, $1.str);
            strcat( $$.str, ".penDown = true;\n");
            }
  |  ID TURTLECOLOR COLOR 
            {
            strcpy( $$.str, $1.str);
            strcat( $$.str, ".penColor = color.");
            strcat( $$.str, $3.str);
            strcat( $$.str, ";\n");
            }
  |  ID RIGHT
            {
            strcpy( $$.str, $1.str);
            strcat( $$.str, ".right();\n");
            }
  |  ID LEFT
            {
            strcpy( $$.str, $1.str);
            strcat( $$.str, ".left();\n");
            }
  |  ID TURN NUM
            {
            strcpy( $$.str, $1.str);
            strcat( $$.str, ".turn(");
            strcat( $$.str, $3.str);
            strcat( $$.str, ");\n");
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

