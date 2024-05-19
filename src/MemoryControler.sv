module MemoryControler(
    input wire clk,
    input wire [31:0] MemoryAdr,
    input wire [31:0] MemoryData,
    input wire wen,

    output wire [19:0] Adr,
    output wire [6:0] out_data [7:0]
);

assign Adr = {MemoryAdr[31], MemoryAdr[18:0]};

reg [31:0] LocalMem = 0;
wire [31:0] print_adr = ((32'b1 << 31) | 32'h64);

always @(posedge clk) begin
    if ((MemoryAdr == print_adr) & wen) begin
        $display("Data %d\n", MemoryData);
        LocalMem <= MemoryData;
    end
end

endmodule 