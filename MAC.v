module MAC #(
    parameter N = 2
  ) //N is the number of elements in a row or column
  (
    input [7:0] A,
    input [7:0] B,
    input clk,
    input rst,
    output reg [15+(N-1):0] out
  );
  reg [15:0] accumulator [N-1:0];
  reg [$clog2(N)-1:0] i;
  wallaceTreeMultiplier8Bit  wallaceTreeMultiplier8Bit_inst (accumulator[i],A,B);
  always @(posedge clk or negedge rst)
  begin
    if(rst)
    begin
      for ( i=0;i< N ;i=i+1 )
      begin
        accumulator[i]<=0;
      end
      i<=0;
      out<=0;
    end
    else 
        begin
            if(i<N) 
            i<=i+1;
            else
            begin
                for ( i=0;i< N ;i=i+1 )
                begin
                  out<=out+accumulator[i];
                end
            end
        end
  end
endmodule