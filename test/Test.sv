`include "Top.sv"

module testbench();

logic clk;
logic reset;
wire [31:0] WriteData;
logic MemWrite, MemRead;

reg [32:0] cnt;

wire [31:0] DataAdr;
wire [19:0] New_adr;

// инициализация проверяемого устройства
top dut(clk, reset, DataAdr, New_adr, WriteData, MemWrite, MemRead);

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

wire [18:0] ADR = New_adr[18:0];

// проверка результата
always @(negedge clk) begin
    
    cnt <= cnt + 32'b1;
    
    //$display("%d", cnt);
    
    if(cnt == 1000) begin
        $finish;
    end
    
    if(MemWrite) begin
        if(New_adr === {1'b1, 19'd100} & WriteData  === 25) begin
                $display("Проверка успешно пройдена");
                $finish;
            end else if (New_adr !== {1'b1, 19'd96}) begin
                $display("Обнаружена ошибка");
                $finish;
            end
    end
end

endmodule