module extend(
    input [31:7] instr,
    input logic [1:0] immsrc,
    
    output reg [31:0] immext
);


wire type_i;
wire type_s;
wire type_b;
wire type_j;

assign type_i = {{20{instr[31]}}, instr[31:20]};
assign type_s = {{20{instr[31]}}, instr[31:25], instr[11:7]};
assign type_b = {{20{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0};
assign type_j = {{12{instr[31]}}, instr[19:12], instr[20], instr[30:21], 1'b0};


always_comb
    case (immsrc)
        2'b00: immext = type_i;     // type I
        2'b01: immext = type_s;     // type S
        2'b10: immext = type_b;     // type B
        2'b11: immext = type_j;     // type J
        default: immext = 32'bx;    // ub 
    endcase

endmodule