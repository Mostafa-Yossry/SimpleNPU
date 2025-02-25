module relu_array #(
    parameter N = 2
) (
    input clk,
    input rst,
    input  [15+(N-1):0] din [(2*N)-1:0],
    input enable,
    output reg [15+(N-1):0] dout [(2*N)-1:0], // parallel output
    output reg [15+(N-1):0] dout_fifo, // output for FIFO
    output reg ReluDONE
);

  reg  [15+(N-1):0] din_reg [(2*N)-1:0]; // Register for input values
  reg processing; // Flag to indicate processing mode
  integer i;

  always @(posedge clk or negedge rst)
  begin
    if (!rst)
    begin
      for (int j = 0; j < 2*N; j = j + 1)
      begin
        dout[j] <= 0;
        din_reg[j] <= 0; // Clear registered values
      end
      ReluDONE <= 0;
      dout_fifo <= 0;
      i = 0;
      processing = 0;
    end
    else 
    begin
      if (enable) // Register new input values on enable
      begin
        for (int j = 0; j < 2*N; j = j + 1)
        begin
          din_reg[j] <= din[j]; 
        end
        processing <= 1; // Start processing mode
        i <= 0; // Reset processing index
        ReluDONE <= 0;
      end

      if (processing) // Process only after inputs are registered
      begin
        if (i < 2*N)
        begin
          dout[i] <= (din_reg[i][15+(N-1)] == 1) ? 0 : din_reg[i];
          dout_fifo <= (din_reg[i][15+(N-1)] == 1) ? 0 : din_reg[i];
          i <= i + 1;
          ReluDONE <= 1; // Indicate completion of one relu operation
        end
        else
        begin
          processing <= 0; // Stop processing
          ReluDONE <= 0;
        end
      end
    end
  end

endmodule
