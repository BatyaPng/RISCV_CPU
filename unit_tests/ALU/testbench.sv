module testbench ();

reg clk;

initial begin
    clk = 0;
end

forever begin
    #10 clk = ~clk
end

reg [2:0] ALUControl;
reg [31:0] SrcA, SrcB;
wire Zero;
wire [31:0] ALUResult

alu test_alu( ALUControl, SrcA, SrcB, Zero, ALUResult)


initial begin



@(posedge clk)

    //ADD
    ALUControl = 3'b000;
    
    SrcA = 1;
    SrcB = 1;
    $display("");

end

endmodule