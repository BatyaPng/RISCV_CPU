`include "ALUStage/Alu.sv"
`include "ALUStage/BranchLogic.sv"
`include "AdditionalUnits/Multiplexer3.sv"
`include "AdditionalUnits/Multiplexer2.sv"

module ExecuteStage
(
    input wire reset,
    input wire clk,
    input wire EN,

    input wire [31:0] w_PC,
    input wire [31:0] w_PC_plus_4,
    
    input wire [31:0] w_R_1,
    input wire [31:0] w_R_2,
    input wire [31:0] w_ImmExt,
    
    input wire [4:0] w_R_1_num,
    input wire [4:0] w_R_2_num,
    input wire [4:0] w_DR_num,
    
    input wire [31:0] ALUResData,
    input wire [31:0] DataReadData,

    input wire [1:0] R_1_solve,
    input wire [1:0] R_2_solve,

    output reg [31:0] DR,
    output reg [4:0] DR_num,

    output reg [31:0] WriteData,

    output reg [31:0] PC,
    output reg [31:0] PC_plus_4,
    output wire [31:0] PCTarget,
    output wire PCSrc,

    //cnt inputs
    input wire [1:0] w_ResultSrc,
    input wire w_MemWrite, 
    input wire w_ALUSrc,
    input wire w_RegWrite, 
    input wire w_Jump,
    input wire w_Branch,
    input wire [3:0] w_ALUControl,
    input wire w_MemRead,
    input wire [2:0] w_funct3,


    output reg [1:0] ResultSrc,
    output reg MemWrite, 
    output reg RegWrite,
    output reg MemRead,
    output reg [2:0] funct3

);

//ALU
wire [31:0] w_ALUResult;

wire [31:0] w_SrcA;
wire [31:0] w_PreSrcB;
wire [31:0] w_SrcB;

mux3 #(32) SrcAmux
(
    .d0(w_R_1),
    .d1(DataReadData),
    .d2(ALUResData),
    .s(R_1_solve),

    .y(w_SrcA)
);

mux3 #(32) PreSrcBmux
(
    .d0(w_R_2),
    .d1(DataReadData),
    .d2(ALUResData),
    .s(R_2_solve),

    .y(w_PreSrcB)
);

mux2 #(32) srcBmux
(
    .d0(w_PreSrcB),
    .d1(w_ImmExt),
    .s(w_ALUSrc),

    .y(w_SrcB)
);

alu ALU
(
    .ALUControl(w_ALUControl),
    .SrcA(w_SrcA),
    .SrcB(w_SrcB),

    .ALUResult(w_ALUResult)
);

always @(posedge clk) begin
    if(reset)begin
        DR <= 0;
        DR_num <= 0;
        WriteData <= 0;
    end else if(EN) begin
        DR <= w_ALUResult;
        DR_num <= w_DR_num;
        WriteData <= w_PreSrcB;
    end
end


//PC logic
assign PCTarget = w_PC + w_ImmExt;

wire w_LogOut;

BranchLogic BranchLogic
(
    .ALUControl(w_ALUControl),
    .SrcA(w_SrcA),
    .SrcB(w_SrcB),

    .LogOut(w_LogOut)
);

always @(posedge clk) begin
    if(reset)begin
        PC <= 0;
        PC_plus_4 <= 0;
    end else if(EN) begin
        PC <= w_PC;
        PC_plus_4 <= w_PC_plus_4;
    end
end

assign PCSrc = (w_Branch & w_LogOut) | w_Jump;

//Controller
always @(posedge clk) begin
    if(reset)begin
        RegWrite <= 0;
        ResultSrc <= 0;
        MemWrite <= 0;
        MemRead <= 0;
        funct3 <= 0;
    end else if(EN) begin
        RegWrite <= w_RegWrite;
        ResultSrc <= w_ResultSrc;
        MemWrite <= w_MemWrite;
        MemRead <= w_MemRead;
        funct3 <= w_funct3;
    end
end

endmodule