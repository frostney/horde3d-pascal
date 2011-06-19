FPC = fpc
LIB = ./Bindings
DEPS = ./Dependencies
BIN = ./Bin

KNIGHT_SRC = KnightPas.lpr
CHICAGO_SRC = ChicagoPas.lpr

default_target: all

all:
	make Knight Chicago

Knight:
	$(FPC) -Mdelphi -Fi$(LIB) -Fu$(LIB) -Fi$(DEPS) -Fu$(DEPS) -FU$(BIN) -FE$(BIN) $(KNIGHT_SRC)

Chicago:
	$(FPC) -Mdelphi -Fi$(LIB) -Fu$(LIB) -Fi$(DEPS) -Fu$(DEPS) -FU$(BIN) -FE$(BIN) $(CHICAGO_SRC)

clean:
	chmod +x clean.sh && ./clean.sh
