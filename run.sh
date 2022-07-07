clear
if flex ruby_scanner.l ; then
    if yacc -d ruby_parser.y ; then
        if gcc lex.yy.c y.tab.c -o compiler -lfl ; then
             ./compiler < entrada

            cat python_output.py
        fi
    fi
fi
rm lex.yy.c compiler y.tab.c y.tab.h