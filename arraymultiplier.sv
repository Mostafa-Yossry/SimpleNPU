module ArrayMultiplier #(
    parameter N = 2
) (
    input clk,
    input rst,
    input [7:0] A [N-1:0],  
    input [7:0] B [N-1:0],
    output reg [(2*N)-1:0] PDONE,
    output [15:0] out [(2*N)-1:0]  // Standardized output size
);
    
    wire [7:0] A_buff [N-1:0][N-1:0]; // 2D array for buffer
    wire [7:0] B_buff [N-1:0][N-1:0];

    genvar i, j;
    generate
        for (i = 0; i < N; i = i + 1) begin : row
            for (j = 0; j < N; j = j + 1) begin : col
                ProcessingElement #(
                    .N(N)
                ) PE (
                    .A((j == 0) ? A[i] : A_buff[i][j - 1]),  
                    .B((i == 0) ? B[j] : B_buff[i - 1][j]),  
                    .clk(clk),
                    .rst(rst),
                    .out(out[i * N + j]),
                    .PDONE(PDONE[i * N + j]),
                    .A_buff(A_buff[i][j]),
                    .B_buff(B_buff[i][j])
                );
            end
        end
    endgenerate
    
endmodule
