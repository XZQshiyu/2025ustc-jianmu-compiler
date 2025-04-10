%option noyywrap
%{
/*****************声明和选项设置  begin*****************/
#include <stdio.h>
#include <stdlib.h>

#include "syntax_tree.h"
#include "syntax_analyzer.h"

int lines=1;
int pos_start=1;
int pos_end=1;

void pass_node(char *text){
     yylval.node = new_syntax_tree_node(text);
}

/*****************声明和选项设置  end*****************/

%}

%x COMMENT

%%
 /* to do for students */
 /* two cases for you, pass_node will send flex's token to bison */
\+ 	{pos_start = pos_end; pos_end += 1; pass_node(yytext); return ADD;}

 /****请在此补全所有flex的模式与动作  end******/

\-	{pos_start = pos_end; pos_end += 1; pass_node(yytext); return SUB;}
\*	{pos_start = pos_end; pos_end += 1; pass_node(yytext); return MUL;}
\/	{pos_start = pos_end; pos_end += 1; pass_node(yytext); return DIV;}
\<	{pos_start = pos_end; pos_end += 1; pass_node(yytext); return LT;}
\<=	{pos_start = pos_end; pos_end += 2; pass_node(yytext); return LTE;}
\>	{pos_start = pos_end; pos_end += 1; pass_node(yytext); return GT;}
\>=	{pos_start = pos_end; pos_end += 2; pass_node(yytext); return GTE;}
==	{pos_start = pos_end; pos_end += 2; pass_node(yytext); return EQ;}
!=	{pos_start = pos_end; pos_end += 2; pass_node(yytext); return NEQ;}
=	{pos_start = pos_end; pos_end += 1; pass_node(yytext); return ASSIN;}
;	{pos_start = pos_end; pos_end += 1; pass_node(yytext); return SEMICOLON;}
,	{pos_start = pos_end; pos_end += 1; pass_node(yytext); return COMMA;}
\(	{pos_start = pos_end; pos_end += 1; pass_node(yytext); return LPARENTHESE;}
\)	{pos_start = pos_end; pos_end += 1; pass_node(yytext); return RPARENTHESE;}
\[	{pos_start = pos_end; pos_end += 1; pass_node(yytext); return LBRACKET;}
\]	{pos_start = pos_end; pos_end += 1; pass_node(yytext); return RBRACKET;}
\{	{pos_start = pos_end; pos_end += 1; pass_node(yytext); return LBRACE;}
\}	{pos_start = pos_end; pos_end += 1; pass_node(yytext); return RBRACE;}
else	{pos_start = pos_end; pos_end += 4; pass_node(yytext); return ELSE;}
if	{pos_start = pos_end; pos_end += 2; pass_node(yytext); return IF;}
int	{pos_start = pos_end; pos_end += 3; pass_node(yytext); return INT;}
float   {pos_start = pos_end; pos_end += 5; pass_node(yytext); return FLOAT;}
return 	{pos_start = pos_end; pos_end += 6; pass_node(yytext); return RETURN;}
void 	{pos_start = pos_end; pos_end += 4; pass_node(yytext); return VOID;}
while 	{pos_start = pos_end; pos_end += 5; pass_node(yytext); return WHILE;}
[a-zA-Z]+	{pos_start = pos_end; pos_end += strlen(yytext); pass_node(yytext); return IDENTIFIER;}
[0-9]+	{pos_start = pos_end; pos_end += strlen(yytext); pass_node(yytext); return INTEGER;}
[0-9]+\.[0-9]*|[0-9]*\.[0-9]+ { pos_start = pos_end; pos_end += strlen(yytext); pass_node(yytext); return FLOATPOINT;}

\n 	{lines++; pos_start = 1; pos_end = 1;}
[ \t] 	{pos_start = pos_end; pos_end += 1;}

"/*"             { pos_start = pos_end; pos_end += 2; BEGIN(COMMENT); }
<COMMENT>"*/"    { pos_start = pos_end; pos_end += 2; BEGIN(INITIAL); }
<COMMENT>.  { pos_start = pos_end; pos_start += 1; }
<COMMENT>\n { pos_start = 1; pos_end = 1; lines++; }

. { pos_start = pos_end; pos_end++; return ERROR; }

%%
