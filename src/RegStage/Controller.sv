`include "Controller/AluDecoder.sv"
`include "Controller/MainDecoder.sv"


module controller(
    input [6:0] op,
    input [2:0] funct3,
    input funct7b5,

    output [1:0] ResultSrc,
    output MemWrite,
    output PCSrc, 
    output ALUSrc,
    output RegWrite, 
    output Jump,
    output Branch,
    output [2:0] ImmSrc,
    output [3:0] ALUControl
);

wire [1:0] ALUOp;
//wire Branch;

maindec md(
    .op(op),

    .ResultSrc(ResultSrc),
    .MemWrite(MemWrite),
    .Branch(Branch),
    .ALUSrc(ALUSrc),
    .RegWrite(RegWrite),
    .Jump(Jump),
    .ImmSrc(ImmSrc),
    .ALUOp(ALUOp)
);

aludec ad(
    .op5(op[5]),
    .funct3(funct3),
    .funct7b5(funct7b5),
    .ALUOp(ALUOp),

    .ALUControl(ALUControl)
);

//assign PCSrc = Branch & LogOut | Jump;



endmodule