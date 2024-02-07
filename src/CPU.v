module cpu(input clk, reset,
           input [31:0] ReadData,
           input [31:0] Instr,
           
           output MemWrite,
           output [31:0] PC,
           output [31:0] ALUResult, WriteData
);

wire ALUSrc, RegWrite, Jump, Zero;
wire [1:0] ResultSrc, ImmSrc;
wire [2:0] ALUControl;

controller cntl(Instr[6:0], Instr[14:12], 
                Instr[30], Zero,
                ResultSrc, MemWrite, PCsrc,
                ALUSrc, RegWrite, Jump,
                ImmSrc, ALUControl
);

datapath dp(clk, reset,
            ResultSrc, PCsrc,
            ALUSrc, RegWrite,
            ImmSrc, ALUControl,
            Zero, PC, Instr,
            ALUResult, WriteData,
            ReadData
);
endmodule