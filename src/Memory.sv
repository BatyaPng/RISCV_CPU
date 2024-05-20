module dmem(
    input clk, 
    input we,
    input re,
    input [5:0] a,
    inout [15:0] data
);

reg [15:0] RAM [1 << 7:0];
assign rd = RAM[a[7:1]]; // выравнивание по слову

always @(posedge clk)
    if (we)
        RAM[a[7:1]] <= data;

initial begin
    $readmemh("../test/tests/memtest", RAM, 0, 27*2 - 1);
end

assign data = (re)? RAM[a[7:1]]: 32'bz; // word aligned

endmodule