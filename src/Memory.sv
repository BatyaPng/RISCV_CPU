
module dmem #(
    parameter ADR_LEN = 20
    )
(
    input clk, 
    input reset,
    input we,
    input re,
    input [ADR_LEN - 1:0] a,
    inout [15:0] data
);

reg [15:0] RAM [1 << ADR_LEN :0];
assign rd = RAM[a[ADR_LEN - 1:1]]; // выравнивание по слову

wire [671:0] comand = 672'h0050_0113_00C0_0193_FF71_8393_0023_E233_0041_F2B3_0042_82B3_0272_8863_0041_A233_0002_0463_0000_0293_0023_A233_0052_03B3_4023_83B3_0471_AA23_0600_2103_0051_04B3_0080_01EF_0010_0113_0091_0133_0221_A023_0021_0063;

always @(posedge clk)
    if (we)
        RAM[a[ADR_LEN -1:1]] <= data;

/*
initial
    $readmemh("../test/tests/memtest", RAM, 0, 27*2 - 1);
*/

wire [ADR_LEN - 1:0] new_adr ;
assign new_adr = (671 - (a[ADR_LEN -1:1] << 4));
wire new_adr_shift4;
assign new_adr_shift4 = new_adr << 4; 

now comand ;

wire []

assign data = (re)? (a[ADR_LEN -1:1] < 42)?comand[new_adr_shift4:new_adr] :RAM[a[ADR_LEN -1:1]]: 32'bz; // word aligned

endmodule