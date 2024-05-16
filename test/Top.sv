`include "../src/Memory.sv"
`include "../src/MemoryControler.sv"
`include "../src/PipelineCPU.sv"
`include "../src/Regfile.sv"

module top(input logic clk, reset,
           output wire [31:0] DataAdr,
           output wire [19:0] New_adr,
           output wire  [31:0] MemData,
           output wire WriteMemEN, ReadMemEN
);

wire [4:0] R1_adr;
wire [4:0] R2_adr;
wire [4:0] DR_adr;

wire [31:0]R1;
wire [31:0]R2;
wire [31:0]DR;

wire reg_wen;

PipelineCPU PipelineCPU(
    .clk(clk),
    .reset(reset),

    .MemData(MemData),
    .ReadMemEN(ReadMemEN),
    .WriteMemEN(WriteMemEN),
    .MemoryAdr(DataAdr),
    
    .R1_adr(R1_adr),
    .R2_adr(R2_adr),
    .DR_adr(DR_adr),

    .R1(R1),
    .R2(R2),
    .DR(DR),

    .RegWEN(reg_wen)
);

MemoryControler cont(
    .MemoryAdr(DataAdr),
    .Adr(New_adr)
);

regfile reg_f(
    .clk(clk),
    .we3(reg_wen),

    .a1(R1_adr),
    .a2(R2_adr),
    .a3(DR_adr),

    .wd3(DR),

    .rd1(R1),
    .rd2(R2)
);

dmem dmem(
    .clk(clk),
    .we(WriteMemEN),
    .re(ReadMemEN),
    .a(New_adr),
    .data(MemData)
);

endmodule