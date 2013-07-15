OBJECTS =linenoise.o
LIB=liblinenoise.a

%.o: %.c Makefile linenoise.h
	$(CC) -c -o $@ $<

$(LIB): $(OBJECTS)
	$(AR) rcs $(LIB) $(OBJECTS)

linenoise_example: linenoise.h linenoise.c

linenoise_example: linenoise.c example.c
	$(CC) -Wall -W -Os -g -o linenoise_example linenoise.c example.c

clean:
	rm -f linenoise_example
	rm -f $(OBJECTS) $(LIB)

all: $(LIB) 


