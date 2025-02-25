module MAC #(
    parameter N = 2
  ) (
    input [7:0] A,
    input [7:0] B,
    input clk,
    input rst,
    input enable,
    output reg PDONE,
    output  reg  [15+(N-1):0] out
  );
  wire signed [15:0]  accumulator;
  reg [$clog2(N):0] i;
  wallaceTreeMultiplier8Bit mult_inst (accumulator, A, B);

  always @(posedge clk or negedge rst) begin
    if (!rst) begin
      // Reset all registers
      i <= 0;
      out <= 0;
      PDONE <= 0;
    end else if (enable) begin
      if (i < N) begin
        // Accumulation phase
        if (i == 0)
          out <= accumulator;
        else
          out <= out + accumulator; 
        i <= i + 1;
        if(i==N-1)
        PDONE <= 1;
          else
            PDONE <= 0;
      end else begin
        i <= 0;
        PDONE <= 0;
      end

    end
    else
      PDONE <= 0;
  end
endmodule