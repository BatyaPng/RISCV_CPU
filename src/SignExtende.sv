module extend(input [31:7] instr,
              input [1:0] immsrc,
              output [31:0] immext
);

always_comb
    case(immsrc)
        2'b00: immext = {{20{instr[31]}}, instr[31:20]};                                    // type I
        2'b01: immext = {{20{instr[31]}}, instr[31:25], instr[11:7]};                       // type S
        2'b10: immext = {{20{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0};       // type B
        2'b11: immext = {{12{instr[31]}}, instr[19:12], instr[20], instr[30:21], 1'b0};     // type J
        default: immext = 32'bx;                                                            // ub 
    endcase

endmodule