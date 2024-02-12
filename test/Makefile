SRC = $(wildcard ../src/*.sv) 

ASRC = $(wildcard ../src/AdditionalUnits/*.sv)

TST = $(wildcard *.sv)

all:
	iverilog -g2005-sv $(SRC) $(ASRC) $(TST)