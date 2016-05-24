%{
    void yyerror(int);
%}

%start program
%token ID
%token NUM

%%

program:
    varDeclList funDeclList
    ;
varDeclList:
    varDecl varDeclList
    | /* empty */
    ;
varDecl:
    type ID ';'
    | type ID '[' NUM ']' ';'
    ;
funDeclList:
    funDecl
    | funDecl funDeclList
    ;
funDecl:
    type ID '(' paramDeclList ')' block
    ;
paramDeclList:
    paramDeclListTail
    | /* empty */
    ;
paramDeclListTail:
    paramDecl
    ;
paramDecl:
    type ID 
    | type ID '[' ']'
    ;
block:
    '{' varDeclList stmtList '}' ;
type:
    "int"
    | "char"
    ;
stmtList:
    stmt
    | stmt stmtList
    ;
stmt:
    ';'
    | expr ';'
    | "return" expr ';'
    | "break" ';'
    | "if" '(' expr ')' stmt "else" stmt
    | "while" '(' expr ')' stmt
    | block
    | "print" ID ';'
    | "read" ID ';'
    ;
expr:
    primary
    | unaryOp expr
    | expr binOp expr
    | ID '=' expr
    | ID '[' expr ']' '=' expr
    ;
primary:
    ID
    | NUM
    | '(' expr ')'
    | ID '(' exprList ')'
    | ID '[' expr ']'
    ;
exprList:
    exprListTail
    | /* empty */
    ;
exprListTail:
    expr
    | expr ',' exprListTail
    ;
unaryOp:
    '-'
    | '!'
    ;
binOp:
    '+'
    | '-'
    | '*'
    | '/'
    | "=="
    | "!="
    | '<'
    | "<="
    | '>'
    | ">="
    | "&&"
    | "||"
    ;

%%

