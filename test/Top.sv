module top(input logic clk, reset,
           output logic [31:0] WriteData, DataAdr,
           output logic MemWrite
);
    
logic [31:0] PC, Instr, ReadData;
logic [31:0] ReadData2;

cpu cpu(clk, reset, PC, Instr, 
                     MemWrite, DataAdr, 
                     WriteData, ReadData);

imem imem(PC, Instr);
dmem dmem(clk, MemWrite, DataAdr, WriteData, ReadData2);

endmodule