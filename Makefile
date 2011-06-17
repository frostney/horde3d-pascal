FPC = fpc
LIB = ./Bindings
DEPS = ./Dependencies
BIN = ./Bin

default_target: all

all:
	make Knight

Knight:
	$(FPC) -Mdelphi -Fi$(LIB) -Fu$(LIB) -Fi$(DEPS) -Fu$(DEPS) -FU$(BIN) -FE$(BIN) KnightPas.lpr
	
clean:
	chmod +x clean.sh && ./clean.sh
