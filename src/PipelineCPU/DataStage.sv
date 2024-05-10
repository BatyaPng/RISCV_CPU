module DataStage
(
    input wire reset,
    input wire clk,

    input wire EN,

    input wire [4:0] w_DR_num,
    input wire [31:0] w_PC_plus_4,

    input wire [31:0] w_ALUResData,

    output wire MemAssert,

    input wire [31:0] w_ReadData,
    output reg [31:0] ReadData,

    output reg [31:0] ALUResData,
    output reg [31:0] PC_plus_4,
    output reg [4:0] DR_num,

    //cnt inputs
    input wire [1:0] w_ResultSrc,
    input wire w_MemWrite, 
    input wire w_RegWrite, 
    input wire w_MemRead,

    output reg [1:0] ResultSrc,
    output reg RegWrite
);


//PC
always @(posedge clk) begin
    if(reset)begin
        PC_plus_4 <= 0;
    end else if(EN) begin
        PC_plus_4 <= w_PC_plus_4;
    end
end

//Mem
assign MemAssert = w_MemWrite | w_MemRead;

always @(posedge clk) begin
    if(reset)
        ReadData <= 0;
    else if(EN)
        ReadData <= w_ReadData;
end

always @(posedge clk) begin
    if(reset) begin
        ALUResData <= 0;
        DR_num <= 0;
    end else if(EN) begin
        ALUResData <= w_ALUResData;
        DR_num <= w_DR_num;
    end
end

//Controller
always @(posedge clk) begin
    if(reset)begin
        RegWrite <= 0;
        ResultSrc <= 0;
    end else if(EN) begin
        RegWrite <= w_RegWrite;
        ResultSrc <= w_ResultSrc;
    end
end



endmodule