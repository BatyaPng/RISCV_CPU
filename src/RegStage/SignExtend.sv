module extend(
    input [31:7] instr,
    input logic [2:0] immsrc,
    
    output reg [31:0] immext
);


wire [31:0] type_i;
wire [31:0] type_s;
wire [31:0] type_b;
wire [31:0] type_j;

assign type_i = {{20{instr[31]}}, instr[31:20]};
assign type_s = {{20{instr[31]}}, instr[31:25], instr[11:7]};
assign type_b = {{20{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0};
assign type_j = {{12{instr[31]}}, instr[19:12], instr[20], instr[30:21], 1'b0};
assign type_u = {instr[31], instr[30:20], instr[19:12], {11{1'b0}}};


always_comb
    case (immsrc)
        3'b000: immext = type_i;     // type I
        3'b001: immext = type_s;     // type S
        3'b010: immext = type_b;     // type B
        3'b011: immext = type_j;     // type J
        3'b100: immext = type_u;     // type U     
        default: immext = 32'bx;    // ub 
    endcase

endmodule