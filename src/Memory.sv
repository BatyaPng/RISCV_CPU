module dmem(
    input clk, 
    input we,
    input re,
    input [19:0] a,
    inout [31:0] data
);

reg [31:0] RAM [2000:0];
assign rd = RAM[a[19:2]]; // выравнивание по слову

always @(posedge clk)
    if (we)
        RAM[a[31:2]] <= data;

initial
    $readmemh("../test/riscvtest", RAM, 0, 19);

assign data = (rd)? RAM[a[11:2]]: 32'bz; // word aligned

endmodule