
go: lex.yy.c turtle.tab.c 
	gcc turtle.tab.c lex.yy.c -lfl -ly -o go 

lex.yy.c: turtle.l
	flex -i turtle.l

turtle.tab.c: turtle.y
	bison -dv turtle.y

clean:
	rm -f lex.yy.c 
	rm -f turtle.output
	rm -f turtle.tab.h
	rm -f turtle.tab.c
	rm -f go 

