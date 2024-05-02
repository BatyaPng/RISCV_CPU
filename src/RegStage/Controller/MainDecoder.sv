module maindec(
    input [6:0] op,

    output [1:0] ResultSrc,
    output MemWrite,
    output Branch, 
    output ALUSrc,
    output RegWrite, 
    output Jump,
    output [2:0] ImmSrc,
    output [1:0] ALUOp,
    output MemRead
);

reg [12:0] controls;

assign {RegWrite, ImmSrc, ALUSrc, MemWrite,
        ResultSrc, Branch, ALUOp, Jump, MemRead} = controls;



always_comb begin
    case (op)
        7'b0000011: controls = 13'b1_000_1_0_01_0_00_0_1; // LOAD
        7'b0100011: controls = 13'b0_001_1_1_00_0_00_0_0; // STORE
        7'b0110011: controls = 13'b1_xxx_0_0_00_0_10_0_0; // OP
        7'b1100011: controls = 13'b0_010_0_0_00_1_10_0_0; // BRANCH
        7'b0010011: controls = 13'b1_000_1_0_00_0_10_0_0; // OP-IMM
        7'b1101111: controls = 13'b1_011_0_0_10_0_00_1_0; // JAL
        
        7'b1100111: controls = 13'b1_000_0_0_10_0_00_1_0; // JALR
        7'b0010111: controls = 13'b1_100_0_0_11_0_00_0_0; // AUIPC
        7'b0110111: controls = 13'b1_100_1_0_00_0_11_0_0; // LUI
        //some another time
        7'b1110011: controls = 13'b1_011_0_0_10_0_00_1_0; // SYSTEM
        7'b0001111: controls = 13'b1_011_0_0_10_0_00_1_0; // MISC-MEM

        default: controls = 13'bx_xxx_x_x_xx_x_xx_x_x; // ???
    endcase
end

endmodule