module PipelineCPU
(
    input wire clk,
    input wire reset,

    input wire [31:0] ReadMemory,
    output wire ReadMemEN,
    output wire [31:0] ReadMemoryAdr, 
    
    output wire [31:0] WriteMemory, 
    output wire WriteMemEN,
    output wire WriteMemoryAdr,

    output wire [4:0] R1_adr,
    output wire [4:0] R2_adr,
    output wire [4:0] DR_adr,

    input wire [31:0] R1,
    input wire [31:0] R2,
    output wire [31:0] DR,

    output wire RegWEN

);





endmodule