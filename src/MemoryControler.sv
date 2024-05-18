module MemoryControler(
    input wire [31:0] MemoryAdr,
    input wire [31:0] MemoryData,

    output wire [19:0] Adr
);

assign Adr = {MemoryAdr[31], MemoryAdr[18:0]};

reg [31:0] LocalMem = 0;
initial begin
    if (MemoryAdr == 1 << 31) begin
        $display("Data %b", MemoryData);
        LocalMem = MemoryData;
    end
end

endmodule 