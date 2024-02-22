module alu (
    input [3:0] ALUControl,
    input [31:0] SrcA, 
    input [31:0] SrcB,

    output Zero,
    output reg [31:0] ALUResult
);

always_comb begin
    case (ALUControl)
        //Arifmetic
        4'b1000: ALUResult = SrcA - SrcB;           // Substraction
        4'b0000: ALUResult = SrcA + SrcB;           // Addition
        //logic
        4'b0111: ALUResult = SrcA & SrcB;           // AND
        4'b0110: ALUResult = SrcA | SrcB;           // OR
        4'b0100: ALUResult = SrcA ^ SrcB;           // XOR
        //Compare
        4'b0010: ALUResult = $signed(SrcA) < $signed(SrcB)? 1 : 0;       //SLT
        4'b0011: ALUResult = $unsigned(SrcA) < $unsigned(SrcB)? 1 : 0;   //SLTU
        //shift
        4'b0001: ALUResult = SrcA << SrcB;           //SLL
        4'b0101: ALUResult = SrcA >> SrcB;           //SRL
        4'b1101: ALUResult = $signed(SrcA) >> SrcB;  //SRA
        //nothing
        4'b1111: ALUResult = SrcB;                   //imm
    endcase
end

assign Zero = (ALUResult == 32'b0);

endmodule