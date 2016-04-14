
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
   :  HATCH IL DL SL SOUP     {  printf("%s", $1.str); }
   ;

IL
   : 
   | INSTINCT ISL ENDINSTINCT 
   ;
DL 
   : DL D
   | D
   ;
D
   : TURTLE ID ';' { 
            strcpy( $$.str, "var ");
            strcat( $$.str, $2.str );
            strcat( $$.str, " = jQuery.extend(true, {}, turtle);\n");
            }
   | 'num' ID ';' 
            strcpy( $$.str, "var ");
            strcat( $$.str, $2.str );
            strcat( $$.str, ";\n");
            }
   ;
ISL
   : IS ISL 
   | IS    {strcpy($$.str, $1.str);}
   ;   

IS 
  :  FORWARD NUM  
            {
            strcpy( $$.str, "obj.forward(")
            strcat( $$.str, $3.str);
            strcat( $$.str, ");\n");
            }
  |  NOTRAIL
            {
            strcpy( $$.str, "obj.penDown = false;\n");
            }
  |  TRAIL
            {
            strcpy( $$.str, "obj.penDown = true;\n");
            }
  |  TURTLECOLOR COLOR 
            {
            strcpy( $$.str, "obj.penColor = color.");
            strcat( $$.str, $3.str);
            strcat( $$.str, ";\n");
            }
  |  RIGHT
            {
            strcpy( $$.str, "obj.right();\n");
            }
  |  LEFT
            {
            strcpy( $$.str, "obj.left();\n");
            }
  |  TURN NUM
            {
            strcpy( $$.str, "obj.turn(");
            strcat( $$.str, $3.str);
            strcat( $$.str, ");\n");
            }         
  ;

SL
    : S SL 
    | S     {strcpy($$.str, $1.str);}
    ;   

S 
  :  ID FORWARD NUM  
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
  |  ID 'is' E 
            {
            strcpy( $$.str, "var ")
            strcat( $$.str, $1.str)
            strcat( $$.str, " = ")
            strcat( $$.str, $3.str)
            }        
  ;

E : E '+' T   {strcpy($$.str, $1.str);}
  | T         {strcpy($$.str, $1.str);}
  ;
T : T '*' F
  | F         {strcpy($$.str, $1.str);}
  ;
F : F '-' C
  | C         {strcpy($$.str, $1.str);}
  ;
C : C '/' M
  | M         {strcpy($$.str, $1.str);}
  ;
M : NUM       {strcpy($$.str, $1.str);}
  | ID        {strcpy($$.str, $1.str);}
  | '(' E ')' {strcpy($$.str, $2.str);}

%%


main ()
{
  yyparse ();
}

yyerror (char *s)  /* Called by yyparse on error */
{
  printf ("\terror: %s\n", s);
}

