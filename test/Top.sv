module top(input logic clk, reset,
           output logic [31:0] WriteData, DataAdr,
           output logic MemWrite
);
    
wire [31:0] PC, Instr, ReadData;
logic [31:0] ReadData2;

cpu cpu(
    .clk(clk),
    .reset(reset),
    .ReadData(ReadData),
    .Instr(Instr),

    .MemWrite(MemWrite),
    .PC(PC),
    .ALUResult(DataAdr),
    .WriteData(WriteData)
);

imem imem(
    .a(PC),

    .rd(Instr)
);

dmem dmem(
    .clk(clk), 
    .we(MemWrite),
    .a(DataAdr), 
    .wd(WriteData), 
    
    .rd(ReadData)
);

endmodule