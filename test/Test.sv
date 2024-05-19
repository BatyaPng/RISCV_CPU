`include "Top.sv"

module testbench();

logic clk;
logic reset;

reg [31:0] cnt;

wire [19:0] New_adr;
wire [15:0] MemData;
wire MemWrite;
wire MemRead;

wire [6:0] seg [7:0];

wire CE;
wire UB;
wire LB;

// инициализация проверяемого устройства
top dut(clk, reset, New_adr, MemData, MemWrite, MemRead, seg, CE, UB, LB);

// запуск тестбенча
initial begin
    $dumpfile("out.vcd");
    $dumpvars(0, testbench);
    
    cnt <= 32'b0;
    #1 reset <= 0; #1 reset <= 1; # 22; reset <= 0;
end

// генерация тактовых импульсов
always begin
    clk <= 1; # 5; clk <= 0; # 5;
end

// проверка результата
always @(negedge clk) begin
    
    cnt <= cnt + 32'b1;
    
    //$display("%d", cnt);
    
    if(cnt == 1000) begin
        $finish;
    end
end

dmem dmem (
    .clk(clk),
    .we(MemWrite),
    .re(MemRead),
    .a(New_adr),
    .data(MemData)
);

endmodule
