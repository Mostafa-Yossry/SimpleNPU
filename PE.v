module ProcessingElement 
#( parameter N = 2)
(
    input [7:0] A,
    input [7:0] B,
    input clk,
    input rst,
    input enable,
    output  [15+(N-1):0] out,
    output PDONE,
    output [7:0] A_buff,
    output [7:0] B_buff
);
    assign A_buff = A;
    assign B_buff = B;

    
    MAC # (
        .N(N)
    ) MAC_inst (
        .A(A),
        .B(B),
        .clk(clk),
        .rst(rst),
        .enable(enable),
        .out(out),
        .PDONE(PDONE)
    );
endmodule
