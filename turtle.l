

%{

typedef struct
{
 int ival;
 char str[100];
}tstruct ;

#define YYSTYPE  tstruct

#include "turtle.tab.h"

%}

DIGIT  [0-9]
L      [A-Za-z]

%%


hatch    {return HATCH; }
soup     {return SOUP; }
turtle   {return TURTLE; }
notrail  {return NOTRAIL; }
trail    {return TRAIL; }
forward  {return FORWARD; }
color    {return TURTLECOLOR; }
right    {return RIGHT; }
left     {return LEFT; }
turn     {return TURN; }

blue   {strcpy(yylval.str, yytext); return COLOR; }
red    {strcpy(yylval.str, yytext); return COLOR; }
black  {strcpy(yylval.str, yytext); return COLOR; }
white  {strcpy(yylval.str, yytext); return COLOR; }
yellow {strcpy(yylval.str, yytext); return COLOR; }
orange {strcpy(yylval.str, yytext); return COLOR; }
purple {strcpy(yylval.str, yytext); return COLOR; }
pink   {strcpy(yylval.str, yytext); return COLOR; }
green  {strcpy(yylval.str, yytext); return COLOR; }

{L}+      {strcpy(yylval.str, yytext);return ID; }
{DIGIT}+  {yylval.ival = atoi(yytext); strcpy(yylval.str, yytext); return NUM; }


[ \t\n]     /* ignore whitespace */


<<EOF>>   yyterminate();  /* signal end of dialogue */

;       return yytext[0];
.        /* return yytext[0]; */

%%

