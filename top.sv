module simpleNPU #(
    parameter N=2
) (
    input clk,
    input rst,
    input [7:0] A [N-1:0] [N-1:0],  
    input [7:0] B [N-1:0] [N-1:0],
    output  [15+(N-1):0] out [(2*N)-1:0]
);
wire [7:0] A_serial [N-1:0];
wire [7:0] B_serial [N-1:0];

ParrallelInterface # (
    .N(N)
  )
  ParrallelInterface_inst (
    .clk(clk),
    .rst(rst),
    .A(A),
    .B(B),
    .A_serial(A_serial),
    .B_serial(B_serial)
  );
  ArrayMultiplier # (
    .N(N)
  )
  ArrayMultiplier_inst (
    .clk(clk),
    .rst(rst),
    .A(A_serial),
    .B(B_serial),
    .PDONE(PDONE),
    .out(out)
  );
endmodule