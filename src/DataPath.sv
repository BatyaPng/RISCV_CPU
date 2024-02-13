module datapath(
    input clk, 
    input reset,
    input [1:0] ResultSrc,
    input PCSrc, 
    input ALUSrc,
    input RegWrite,
    input [1:0] ImmSrc,
    input [2:0] ALUControl,
    input [31:0] Instr,
    input [31:0] ReadData,

    output Zero,
    output [31:0] PC,
    output [31:0] ALUResult, 
    output [31:0] WriteData
);

wire [31:0] PCNext, PCPlus4, PCTarget;
wire [31:0] ImmExt;
wire [31:0] SrcA, SrcB;
wire [31:0] Result;

// PC logic
flopr #(32) pcreg(
    .clk(clk),
    .reset(reset), 
    .d(PC),

    .q(PCNext)
);

adder pcadd4(
    .a(PC), 
    .b(32'd4), 
    
    .y(PCPlus4)
);

adder pcaddbranch(
    .a(PC),
    .b(ImmExt),
    
    .y(PCTarget)
);

mux2 #(32) pcmux(
    .d0(PCPlus4), 
    .d1(PCTarget), 
    .s(PCSrc),

    .y(PCNext)
);

// Register file logic
regfile rf(
    .clk(clk), 
    .we3(RegWrite), 
    .a1(Instr[19:15]),
    .a2(Instr[24:20]),
    .a3(Instr[11:7]),
    .wd3(Result), 
    
    .rd1(SrcA),
    .rd2(WriteData)
);

extend ext(
    .instr(Instr[31:7]), 
    .immsrc(ImmSrc),
    
    .immext(ImmExt)
);

// ALU logic
mux2 #(32) srcbmux(
    .d0(WriteData),
    .d1(ImmExt),
    .s(ALUSrc),
    
    .y(SrcB)
);

alu alu(
    .ALUControl(ALUControl),
    .SrcA(SrcA),
    .SrcB(SrcB),
    
    .Zero(Zero),
    .ALUResult(ALUResult)
);

mux3 #(32) resultmux(
    .d0(ALUResult),
    .d1(ReadData),
    .d2(PCPlus4),
    .s(ResultSrc),
    
    .y(Result)
);

endmodule