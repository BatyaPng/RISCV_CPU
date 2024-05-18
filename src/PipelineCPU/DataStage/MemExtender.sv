module MemExtender (
    input wire [31:0] MemWrite,
    input wire [31:0] MemRead,

    input wire [2:0] funct3,

    output wire [31:0] MemWriteEx,
    output wire [31:0] MemReadEx
);


assign MemWriteEx = (funct3 == 3'b000)? {24'b0, MemWrite[7:0] }:
                    (funct3 == 3'b001)? {16'b0, MemWrite[15:0]}:
                    (funct3 == 3'b010)?  MemWrite:
                                         32'b0;

assign MemReadEx  = ((funct3 & 3'b011) == 3'b000)? {{24{MemRead[7] & funct3[2]}}, MemRead[7:0] }:
                    ((funct3 & 3'b011) == 3'b001)? {{16{MemRead[7] & funct3[2]}}, MemRead[15:0]}:
                    ((funct3 & 3'b011) == 3'b010)?  MemRead:
                                                    32'b0;
    
endmodule