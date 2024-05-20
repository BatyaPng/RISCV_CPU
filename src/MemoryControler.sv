module MemoryControler(
    input wire clk,
    input wire [31:0] MemoryAdr,
    input wire [31:0] MemoryData,
    input wire wen,

    output wire [19:0] Adr,
    output wire [6:0] out_data [7:0]
);

assign Adr = {MemoryAdr[31], MemoryAdr[19:1]};
reg [31:0] LocalMem = 0;
wire [31:0] print_adr_1 = ((32'b1 << 31) | 32'h64);
wire [31:0] print_adr_2 = ((32'b1 << 31) | 32'h0);

always @(posedge clk) begin
    if (((MemoryAdr == print_adr_1) | (MemoryAdr == print_adr_2)) & wen) begin
        $display("Data %d", MemoryData);
        LocalMem <= MemoryData;
    end
end

hex_to_7seg sed_0 (LocalMem[3:0],   out_data[0]);
hex_to_7seg sed_1 (LocalMem[7:4],   out_data[1]);
hex_to_7seg sed_2 (LocalMem[11:8],  out_data[2]);
hex_to_7seg sed_3 (LocalMem[15:12], out_data[3]);
hex_to_7seg sed_4 (LocalMem[19:16], out_data[4]);
hex_to_7seg sed_5 (LocalMem[23:20], out_data[5]);
hex_to_7seg sed_6 (LocalMem[27:24], out_data[6]);
hex_to_7seg sed_7 (LocalMem[31:28], out_data[7]);

endmodule 

module hex_to_7seg
(
    input wire [3:0] hex,
    output wire [6:0] seg7
);

assign seg7 = (hex == 4'h0)? ~7'b0_111_111:
              (hex == 4'h1)? ~7'b0_000_110:
              (hex == 4'h2)? ~7'b1_011_011:
              (hex == 4'h3)? ~7'b1_001_111:
              (hex == 4'h4)? ~7'b1_100_110:
              (hex == 4'h5)? ~7'b1_101_101:
              (hex == 4'h6)? ~7'b1_111_101:
              (hex == 4'h7)? ~7'b0_000_111:
              (hex == 4'h8)? ~7'b1_111_111:
              (hex == 4'h9)? ~7'b1_101_111:
              (hex == 4'ha)? ~7'b1_110_111:
              (hex == 4'hb)? ~7'b1_111_100:
              (hex == 4'hc)? ~7'b0_111_001:
              (hex == 4'hd)? ~7'b1_011_110:
              (hex == 4'he)? ~7'b1_111_001:
				  (hex == 4'hf)? ~7'b1_110_001:
				  ~7'b0_000_000;

endmodule