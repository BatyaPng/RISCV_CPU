`include "../src/Memory.sv"
`include "../src/MemoryControler.sv"
`include "../src/PipelineCPU.sv"
`include "../src/Regfile.sv"

module top(input logic clk, reset,
           output wire [19:0] New_adr,
           inout  wire [15:0] MemData,
           output wire WriteMemEN, ReadMemEN //,

            /*
           output wire [6:0] seg [7:0],
           output wire CE,
           output wire UB,
           output wire LB
            */
);

assign CE = 1;
assign UB = 1;
assign LB = 1;

wire [4:0] R1_adr;
wire [4:0] R2_adr;
wire [4:0] DR_adr;

wire [31:0]R1;
wire [31:0]R2;
wire [31:0]DR;

wire reg_wen;

reg i;
wire clk_div_2 = ~i;

wire conf_reset = reset;
reg good_reset;
wire [31:0] out_MemData;

always @(posedge clk) begin
    if(conf_reset)
        i <= 0;
    else 
        i <= 1;
end

reg [15:0] r_data;

always @(posedge clk) begin
    if(conf_reset)
        i <= 0;
    else 
        i <= i + 1;
end

always @(posedge clk) begin
    if(conf_reset) begin
        r_data <= 0;
        good_reset <= conf_reset;
    end else if(i == 0) begin
        r_data <= MemData;
    end else if (i == 1)
        good_reset <= conf_reset;
end

assign MemData = (WriteMemEN)? (i)? out_MemData[15:0]: out_MemData[31:16] : 16'bz;

assign out_MemData = (ReadMemEN)? {{r_data}, {MemData}}: 32'bz;

assign New_adr = out_New_adr + (i << 1);

PipelineCPU PipelineCPU(
    .clk(clk_div_2),
    .reset(good_reset),

    .MemData(out_MemData),
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

wire [19:0] out_New_adr;

wire [31:0] DataAdr;

MemoryControler cont(
    .clk(clk_div_2),
    .MemoryAdr(DataAdr),
    .MemoryData(out_MemData),
    .wen(WriteMemEN),
    .Adr(out_New_adr)
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

/*
dmem dmem(
    .clk(clk),
    .we(WriteMemEN),
    .re(ReadMemEN),
    .a(New_adr),
    .data(MemData)
);
*/

endmodule