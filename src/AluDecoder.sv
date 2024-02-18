module aludec(
    input op5,
    input [2:0] funct3,
    input funct7b5,
    input [1:0] ALUOp,
    
    output reg [3:0] ALUControl
);

wire [3:0] std_comand;
assign std_comand = {funct7b5, funct3};

wire [3:0] I_comand;
assign I_comand = {1'b0, funct3};

always_comb begin
    case (ALUOp)
        2'b00: ALUControl = 4'b0000;                     // addition
        2'b01: ALUControl = 4'b1000;                     // subtraction
        default: case(op5)                               // type R or I
                    1'b0: ALUControl = (funct3 == 3'b101)? std_comand: I_comand; //I type comands or SRAI
                    1'b1: ALUControl = std_comand;
        endcase
    endcase
end

endmodule