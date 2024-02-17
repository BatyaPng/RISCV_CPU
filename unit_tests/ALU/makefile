
all: a.out
	

a.out: testbench.sv ../../src/Alu.sv
	iverilog -g2005-sv ../../src/Alu.sv testbench.sv

out.vcd: a.out
	./a.out

test: 
	./a.out

gtk: out.vcd
	gtkwave out.vcd