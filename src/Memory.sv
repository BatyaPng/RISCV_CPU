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

reg [15:0] RAM [1 << 19:0];
assign rd = RAM[a[19:1]]; // выравнивание по слову

always @(posedge clk)
    if ((access_status & 5'b11011) == 5'b00001)
        RAM[a[5:1]][15:8] <= data[15:8];
    else if ((access_status & 5'b11011) == 5'b00010)
        RAM[a[5:1]][15:8] <= data[7:0];
    else if ((access_status & 5'b11011) == 5'b00011)
        RAM[a[5:1]][15:0] <= data[15:0];

initial begin
    $readmemh("../test/tests/memtest", RAM, 0, 27*2 - 1);
end

assign data = (((access_status & 5'b11011) == 5'b00001) | ((access_status & 5'b11011) == 5'b00010) | ((access_status & 5'b11011) == 5'b00011))? 32'bz:
              (access_status == 5'b10001)? {RAM[a][15:8], 8'bz}:
              (access_status == 5'b10010)? {8'bz, RAM[a][8:0]}
              
              `\
            \\             (access_status == 5'b10011)? RAM
endmodule