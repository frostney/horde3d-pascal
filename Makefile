FPC = fpc
LIBS = ./Bindings,./Dependencies
BIN = ./Bin

default_target: all

Knight:
	$(FPC) -Mdelphi -Fi$(LIBS) -Fu$(LIBS) -FU$(BIN) -FE$(BIN) KnightPas.lpr
	
clean:
	chmod +x clean.sh && ./clean.sh
