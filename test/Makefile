SRC = ../src/CPU/Controller/AluDecoder.sv ../src/CPU/Controller/Controller.sv ../src/CPU/Controller/MainDecoder.sv ../src/CPU/DataPath/Alu.sv ../src/CPU/DataPath/BranchLogic.sv ../src/CPU/DataPath/DataPath.sv ../src/CPU/DataPath/MemExtender.sv ../src/CPU/DataPath/Regfile.sv ../src/CPU/DataPath/SignExtend.sv ../src/CPU/CPU.sv

ASRC = $(wildcard ../src/CommonUnits/*.sv)

TST = $(wildcard *.sv)

all:
	iverilog -D RELEASE -g2009  $(SRC) $(ASRC) $(TST) 