PREFIX ?= /usr/local
OBJECTS = linenoise.o
STATIC_LIB = liblinenoise.a
PLATFORM=$(shell uname -s)


ifeq ($(PLATFORM),Darwin) # OSX

# I have no idea if this is correct..
SHARED_LIB = liblinenoise.1.dylib

all: $(STATIC_LIB) $(SHARED_LIB)

$(SHARED_LIB): $(OBJECTS)
	$(CC) -dynamiclib -Wl,-headerpad_max_install_names,-undefined,dynamic_lookup,-compatibility_version,1.0,-current_version,1.0,-install_name,/usr/local/lib/$@ -o $@ $(OBJECTS)

else # Linux

SHARED_LIB=liblinenoise.so

all: $(STATIC_LIB) $(SHARED_LIB)

$(SHARED_LIB): $(OBJECTS)
	$(CC) -shared -Wl,-soname,$@.1 -o $@.1.0.1 $(OBJECTS) -lc

endif


%.o: %.c Makefile linenoise.h
	$(CC) -fPIC -c -o $@ $<

$(STATIC_LIB): $(OBJECTS)
	$(AR) rcs $(STATIC_LIB) $(OBJECTS)

linenoise_example: linenoise.h linenoise.c
linenoise_example: linenoise.c example.c
	$(CC) -Wall -W -Os -g -o linenoise_example linenoise.c example.c





clean:
	rm -f linenoise_example
	rm -f $(OBJECTS) $(STATIC_LIB) *.so* *.dylib*



