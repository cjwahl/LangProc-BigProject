

%{

typedef struct
{
 int ival;
 char str[100];
}tstruct ;

#define YYSTYPE  tstruct

#include "cmach.tab.h"

%}

DIGIT  [0-9]

%%

{DIGIT}+  {
          yylval.ival = atoi(yytext); 
          strcpy(yylval.str, yytext);
          return NUM; }


hatch    {return HATCH; }
soup     {return SOUP; }
turtle   {return TURTLE; }
a | b    {return TURTLEID;}
notrail  {return NOTRAIL; }
trail    {return TRAIL; }
forward  {return FORWARD; }
color    {return COLOR; }
right    {return RIGHT; }
left     {return LEFT; }

mod    {return MOD; }
rep    {return REP; }



[ \t\n]     /* ignore whitespace */


<<EOF>>   yyterminate();  /* signal end of dialogue */

;       return yytext[0];
.        /* return yytext[0]; */

%%

