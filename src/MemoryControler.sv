module MemoryControler(
    input wire [31:0] MemoryAdr,

    output wire [19:0] Adr
);

assign Adr = {MemoryAdr[31], MemoryAdr[18:0]};

endmodule 