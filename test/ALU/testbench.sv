module testbench ();

reg clk;

initial begin
    $dumpfile("out.vcd");
    $dumpvars(0, testbench);
    
    clk = 0;
end

always begin
    #10 clk <= ~clk;
end

reg [3:0] ALUControl;
reg [31:0] SrcA, SrcB;
wire Zero;
wire [31:0] ALUResult;

alu test_alu( ALUControl, SrcA, SrcB, Zero, ALUResult);

reg [31:0]real_res;

reg correct;


initial begin

@(posedge clk);

    //ADD
    ALUControl = 4'b0000;
    
    SrcA = 32'b1;
    SrcB = 32'b1;
    real_res = SrcA + SrcB;
    #1

    correct = ALUResult == real_res;

    $display("%b | %d + %d = %d(%d)", correct, $signed(SrcA), $signed(SrcB), $signed(ALUResult), $signed(real_res));
    
@(posedge clk);    
    
    //SUB
    ALUControl = 4'b1000;
    
    SrcA = 3;
    SrcB = 1;
    real_res = SrcA - SrcB;
    #1

    correct = ALUResult == real_res;

    $display("%b | %d - %d = %d(%d)", correct, $signed(SrcA), $signed(SrcB), $signed(ALUResult), $signed(real_res));

@(posedge clk);    
    
    //AND
    ALUControl = 4'b0111;
    
    SrcA = 3;
    SrcB = 1;
    real_res = SrcA & SrcB;
    #1

    correct = ALUResult == real_res;

    $display("%b | %b & %b = %b(%b)", correct, $unsigned(SrcA), $unsigned(SrcB), $unsigned(ALUResult), $unsigned(real_res));
@(posedge clk);    
    
    //OR
    ALUControl = 4'b0110;
    
    SrcA = 3;
    SrcB = 1;
    real_res = SrcA | SrcB;
    #1

    correct = ALUResult == real_res;

    $display("%b | %b | %b = %b(%b)", correct, $unsigned(SrcA), $unsigned(SrcB), $unsigned(ALUResult), $unsigned(real_res));
@(posedge clk);    
    
    //XOR
    ALUControl = 4'b0100;
    
    SrcA = 3;
    SrcB = 1;
    real_res = SrcA ^ SrcB;
    #1

    correct = ALUResult == real_res;

    $display("%b | %b ^ %b = %b(%b)", correct, $unsigned(SrcA), $unsigned(SrcB), $unsigned(ALUResult), $unsigned(real_res));
@(posedge clk);    
    
    //SLT
    ALUControl = 4'b0010;
    
    SrcA = -3;
    SrcB = 1;
    real_res = $signed(SrcA) < $signed(SrcB);
    #1

    correct = ALUResult == real_res;

    $display("%b | %b < %b = %b(%b)", correct, $signed(SrcA), $signed(SrcB), $signed(ALUResult), $signed(real_res));

@(posedge clk);    
    
    //SLTU
    ALUControl = 4'b0011;
    
    SrcA = -3;
    SrcB = 1;
    real_res = $unsigned(SrcA) < $unsigned(SrcB);
    #1

    correct = ALUResult == real_res;

    $display("%b | %b < %b = %b(%b)", correct, $unsigned(SrcA), $unsigned(SrcB), $unsigned(ALUResult), $unsigned(real_res));

@(posedge clk);    
    
    //SLL
    ALUControl = 4'b0001;
    
    SrcA = -133;
    SrcB = 2;
    real_res = SrcA << SrcB;
    #1

    correct = ALUResult == real_res;

    $display("%b | %b << %d = %b(%b)", correct, $unsigned(SrcA), $unsigned(SrcB), $unsigned(ALUResult), $unsigned(real_res));

@(posedge clk);    
    
    //SRL
    ALUControl = 4'b0101;
    
    SrcA = -1000;
    SrcB = 2;
    real_res = SrcA >> SrcB;
    #1

    correct = ALUResult == real_res;

    $display("%b | %b >> %d = %b(%b)", correct, $unsigned(SrcA), $unsigned(SrcB), $unsigned(ALUResult), $unsigned(real_res));

@(posedge clk);    
    
    //SRA
    ALUControl = 4'b1101;
    
    SrcA = -1000;
    SrcB = 3;
    real_res = $signed(SrcA) >> SrcB;
    #1

    correct = ALUResult == real_res;

    $display("%b | %b >> %d = %b(%b)", correct, $unsigned(SrcA), $unsigned(SrcB), $unsigned(ALUResult), $unsigned(real_res));

@(posedge clk);    
    $finish;

end

endmodule