module dmem(
    input clk, 
    input WE,
    input CE,
    input OE,
    input LB,
    input UB,
    input [19:0] a,
    inout [15:0] data
);

wire [4:0] access_status = {WE, CE, OE, LB, UB};

reg [15:0] RAM [(1 << 20) - 1:0];
wire [15:0] rd;
assign rd = RAM[a]; // выравнивание по слову

wire [4:0] write_list = {WE, CE, 1'b0, LB, UB};

wire [31:0] data_A = {RAM[20'h80030], RAM[20'h80031]};

always @(posedge clk)
    if (write_list == 5'b00001)
        RAM[a][15:8] <= data[15:8];
    else if (write_list == 5'b00010)
        RAM[a][15:8] <= data[7:0];
    else if (write_list == 5'b00000)
        RAM[a] <= data[15:0];

initial begin
    $readmemh("../test/riscvtest", RAM, 0, 24*2 - 1);
end

assign data = ((write_list == 5'b00001) | (write_list == 5'b00010) | (write_list == 5'b00000))? 32'bz:
              (access_status == 5'b10001)? {rd[15:8], 8'bz}:
              (access_status == 5'b10010)? {8'bz, rd[8:0]}:
              (access_status == 5'b10000)? rd: 8'bz;
endmodule