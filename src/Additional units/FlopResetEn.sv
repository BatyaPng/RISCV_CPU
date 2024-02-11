module flopren #(parameter WIDTH = 8
)
(
    input clk, reset, en,
    input [WIDTH - 1:0] d,

    output [WIDTH - 1:0] q 
);

always_ff @(posedge clk, posedge reset ) begin
    if (reset) 
        q <= 0;
    else if (en)
        q <= d;
end

endmodule