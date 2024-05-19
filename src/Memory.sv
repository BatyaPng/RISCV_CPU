module dmem(
    input clk, 
    input we,
    input re,
    input [19:0] a,
    inout [15:0] data
);

reg [15:0] RAM [$pow(2, 20):0];
assign rd = RAM[a[19:1]]; // выравнивание по слову

always @(posedge clk)
    if (we)
        RAM[a[19:1]] <= data;

initial
    $readmemh("../test/riscvtest", RAM, 0, 41);

assign data = (re)? RAM[a[19:1]]: 32'bz; // word aligned

endmodule