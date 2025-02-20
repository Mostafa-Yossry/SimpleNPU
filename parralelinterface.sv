module ParrallelInterface #(
    parameter N = 2
  ) (
    input clk,
    input rst,
    input [7:0] A [N-1:0] [N-1:0],
    input [7:0] B [N-1:0] [N-1:0],
    output reg [7:0] A_serial [N-1:0],
    output reg [7:0] B_serial [N-1:0]
  );
  reg [$clog2(N)-1:0] i;  

  always @(posedge clk or negedge rst)
  begin
    if (!rst)
    begin
      i <= 0;
    end
    else
    begin
      if (i < N)
      begin
        for (int j = 0; j < N; j = j + 1)
        begin
          A_serial[j] <= A[j][i];
          B_serial[j] <= B[i][j];
        end
        i <= i + 1;
      end
    end
  end
endmodule
