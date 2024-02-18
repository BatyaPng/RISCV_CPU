module aludec(
    input [2:0] funct3,
    input funct7b5,
    input [1:0] ALUOp,
    
    output reg [3:0] ALUControl
);

wire [3:0] std_comand;
assign std_comand = {funct7b5, funct3};

always_comb begin
    case (ALUOp)
        2'b00: ALUControl = 4'b0000;                     // addition
        2'b01: ALUControl = 4'b1000;                     // subtraction
        default: ALUControl = std_comand;                // type R or I
                    
    endcase
end

endmodule