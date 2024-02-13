module testbench();

logic clk;
logic reset;
logic [31:0] WriteData, DataAdr;
logic MemWrite;

reg [32:0] cnt;

// инициализация проверяемого устройства
top dut(clk, reset, WriteData, DataAdr, MemWrite);

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
    
    $display("%d", cnt);
    
    if(cnt == 1000) begin
        $finish;
    end
    
    if(MemWrite) begin
        if(DataAdr === 100 & WriteData  === 25) begin
                $display("Проверка успешно пройдена");
                $finish;
            end else if (DataAdr !== 96) begin
                $display("Обнаружена ошибка");
                $finish;
            end
    end
end

endmodule