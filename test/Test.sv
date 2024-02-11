module testbench();

logic clk;
logic reset;
logic [31:0] WriteData, DataAdr;
logic MemWrite;

// инициализация проверяемого устройства
top dut(clk, reset, WriteData, DataAdr, MemWrite);

// запуск тестбенча
initial begin
    reset <= 1; # 22; reset <= 0;
end

// генерация тактовых импульсов
always begin
    clk <= 1; # 5; clk <= 0; # 5;
end

// проверка результата
always @(negedge clk) begin
    if(MemWrite) begin
        if(DataAdr = = = 100 & WriteData  = = = 25) begin
                $display("Проверка успешно пройдена");
                $stop;
            end else if (DataAdr != = 96) begin
                $display("Обнаружена ошибка");
                $stop;
            end
    end
end

endmodule