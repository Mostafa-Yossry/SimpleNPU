module simpleNPU #(
    parameter N=2,
    parameter M=3,//Number of operations FIFO can store
    localparam   WIDTH = 15+N, 
    localparam DEPTH = (2*N)*M
) (
    input clk,
    input rst,
    input [7:0] A [N-1:0] [N-1:0],  
    input [7:0] B [N-1:0] [N-1:0],
    input rd_en,
    output  [15+(N-1):0] out [(2*N)-1:0],  
    output PDONE,
    output [WIDTH-1:0] fifo_dout,
    output  empty,
    output  full
);

wire [7:0] A_serial [N-1:0];
wire [7:0] B_serial [N-1:0];
wire [(2*N)-1:0] PDONE_internal;  
wire [15+(N-1):0] relu_out [(2*N)-1:0];
wire [15+(N-1):0] relu_fifo_out;
wire enable;
wire ReluDONE;
ParrallelInterface # (
    .N(N)
  )
  ParrallelInterface_inst (
    .clk(clk),
    .rst(rst),
    .A(A),
    .B(B),
    .A_serial(A_serial),
    .B_serial(B_serial),
    .enable(enable)
  );

ArrayMultiplier # (
    .N(N)
  )
  ArrayMultiplier_inst (
    .clk(clk),
    .rst(rst),
    .A(A_serial),
    .B(B_serial),
    .enable(enable),
    .PDONE(PDONE_internal),
    .out(out)
  );
  
  relu_array # (
    .N(N)
  )
  relu_array_inst (
    .clk(clk),
    .din(out),
    .enable(PDONE),
    .dout(relu_out),
    .dout_fifo(relu_fifo_out),
    .ReluDONE(ReluDONE)
  );
  fifo_buffer # (
    .N(N),
    .M(M)
  )
  fifo_buffer_inst (
    .clk(clk),
    .rst(rst),
    .wr_en(ReluDONE),
    .rd_en(0),
    .din(relu_fifo_out),
    .dout(fifo_dout),
    .empty(empty),
    .full(full)
  );
assign PDONE = &PDONE_internal;

endmodule
