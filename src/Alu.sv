module alu (
    input [2:0] ALUControl,
    input [31:0] SrcA, SrcB,

    output Zero,
    output reg [31:0] ALUResult
);

always_comb begin
    case (ALUControl)
        3'b000: ALUResult = SrcA + SrcB;            // Addition
        3'b001: ALUResult = SmrcA - SrcB;            // Substraction
        3'b010: ALUResult = SrcA & SrcB;            // And
        3'b011: ALUResult = SrcA | SrcB;            // Or
        3'b101: ALUResult = 1 ? SrcA < SrcB : 0;    //SLT 
    endcase
end

assign Zero = (ALUResult == 32'b0);

endmodule