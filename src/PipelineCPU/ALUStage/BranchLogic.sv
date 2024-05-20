module BranchLogic (
    input [3:0] ALUControl,
    input [31:0] SrcA, 
    input [31:0] SrcB,

    output LogOut
);

reg Out;
assign LogOut = Out;

always_comb begin
    case(ALUControl)
        3'b000: Out = SrcA == SrcB; //BEQ
        3'b001: Out = SrcA != SrcB; //BNE
        3'b100: Out = $signed(SrcA) < $signed(SrcB); //BLT
        3'b101: Out = $signed(SrcA) > $signed(SrcB); //BGE
        3'b110: Out = $unsigned(SrcA) < $unsigned(SrcB); //BLTU
        3'b111: Out = $unsigned(SrcA) > $unsigned(SrcB); //BGEU
        default: Out = 0;
    endcase
end

endmodule