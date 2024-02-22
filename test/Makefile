SRC = $(wildcard ../src/*.sv) 

ASRC = $(wildcard ../src/AdditionalUnits/*.sv)

TST = $(wildcard *.sv)

all:
	iverilog -g2009 -pfileline=1 $(SRC) $(ASRC) $(TST)