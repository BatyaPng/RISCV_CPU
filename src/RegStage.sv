`include "RegStage/Controller.sv"
`include "RegStage/SignExtender.sv"

module RegStage
(
    input wire reset,
    input wire clk,

    input wire [31:0] Instr,
    input wire [31:0] w_PC,
    input wire [31:0] w_PC_plus_4,
    
    //communication with RegFile
    output wire [4:0] w_R_1_num,
    output wire [4:0] w_R_2_num,
    input wire [31:0] w_R_1,
    input wire [31:0] w_R_2,


    output reg [31:0] R_1,
    output reg [31:0] R_2,
    output reg [4:0] R_1_num,
    output reg [4:0] R_2_num,
    output reg [4:0] DR_num,

    output wire [4:0] w_DR_num, //for Conflict Resolver

    output reg [31:0] ImmExt,

    output reg [31:0] PC,
    output reg [31:0] PC_plus_4,

    //cnt outputs
    output reg [1:0] ResultSrc,
    output reg MemWrite, 
    output reg ALUSrc,
    output reg RegWrite, 
    output reg Jump,
    output reg Branch,
    output reg [3:0] ALUControl

);

//RegFile
assign w_R_1_num = Instr[19:15];
assign w_R_2_num = Instr[24:20];
assign w_DR_num  = Instr[11:7 ];

always @(posedge clk) begin
    if(reset)begin
        R_1 <= 0;
        R_2 <= 0;
        R_1_num <= 0;
        R_2_num <= 0;
        DR_num <= 0;
    end else begin
        R_1 <= w_R_1;
        R_2 <= w_R_2;
        R_1_num <= w_R_1_num;
        R_2_num <= w_R_2_num;
        DR_num  <= w_DR_num;
    end
end

//PC_log
always @(posedge clk) begin
    if(reset)begin
        PC <= 0;
        PC_plus_4 <= 0;
    end else begin
        PC <= w_PC;
        PC_plus_4 <= w_PC_plus_4;
    end
end

//SIgnExtender
wire [31:0] w_immext;
extend SignExtender(
    .instr(Instr),
    .immsrc(w_ImmSrc),

    .immext(w_immext)
)

always @(posedge clk) begin
    if(reset)
        ImmExt <= 0;
    else
        ImmExt <= w_immext;
end

//Controller
wire [1:0] w_ResultSrc;
wire w_MemWrite;
wire w_PCSrc;
wire w_ALUSrc;
wire w_RegWrite;
wire w_Jump;
wire w_Branch;

wire [2:0] w_ImmSrc;
wire [3:0] w_ALUControl;

maindec Decoder(
    .op(Instr[6:0]), 
    .funct3(Instr[14:12]), 
    .funct7b5(Instr[30]), 

    .ResultSrc(w_ResultSrc),
    .MemWrite(w_MemWrite),
    .ALUSrc(w_ALUSrc),
    .RegWrite(w_RegWrite),
    .Jump(w_Jump),
    .Branch(w_Branch)
    .ImmSrc(w_ImmSrc),
    .ALUControl(w_ALUControl)
)


always @(posedge clk) begin
    if(reset)begin
        ResultSrc <= 0;
        MemWrite <= 0;
        ALUSrc <= 0;
        RegWrite <= 0;
        Jump <= 0;
        Branch <= 0;
        ALUControl <= 0;
    end else begin
        ResultSrc <= w_ResultSrc;
        MemWrite <= w_MemWrite;
        ALUSrc <= w_ALUSrc;
        RegWrite <= w_RegWrite;
        Jump <= w_Jump;
        Branch <= w_Branch;
        ALUControl <= w_ALUControl;
    end
end



endmodule