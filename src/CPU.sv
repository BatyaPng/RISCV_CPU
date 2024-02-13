module cpu(
    input clk, 
    input reset,
    input [31:0] ReadData,
    input [31:0] Instr,
    
    output MemWrite,
    output [31:0] PC,
    output [31:0] ALUResult, 
    output [31:0] WriteData
);

wire ALUSrc, RegWrite, Jump, Zero;
wire [1:0] ResultSrc, ImmSrc;
wire [2:0] ALUControl;

controller cntl(
    .op(Instr[6:0]), 
    .funct3(Instr[14:12]), 
    .funct7b5(Instr[30]), 
    .Zero(Zero),

    .ResultSrc(ResultSrc),
    .MemWrite(MemWrite),
    .PCSrc(PCSrc),
    .ALUSrc(ALUSrc),
    .RegWrite(RegWrite),
    .Jump(Jump),
    .ImmSrc(ImmSrc),
    .ALUControl(ALUControl)
);

datapath dp(
    .clk(clk),
    .reset(reset),
    .ResultSrc(ResultSrc),
    .PCSrc(PCSrc),
    .ALUSrc(ALUSrc),
    .RegWrite(RegWrite),
    .ImmSrc(ImmSrc),
    .ALUControl(ALUControl),
    .Instr(Instr),
    .ReadData(ReadData),
    
    .Zero(Zero),
    .PC(PC),
    .ALUResult(ALUResult),
    .WriteData(WriteData)
);

endmodule