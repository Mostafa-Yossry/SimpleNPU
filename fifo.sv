module fifo_buffer #(
    parameter N=2, // NxN matrix
    parameter M=3,//Number of operations FIFO can store
    localparam   WIDTH = 15+N, 
    localparam DEPTH = (2*N)*M
       
) (
    input clk,
    input rst,
    input wr_en,          
    input rd_en,          
    input [WIDTH-1:0] din,
    output reg [WIDTH-1:0] dout,
    output reg empty,
    output reg full
);

    reg [WIDTH-1:0] mem [DEPTH-1:0];
    reg [$clog2(DEPTH):0] rd_ptr = 0;
    reg [$clog2(DEPTH):0] wr_ptr = 0;
    reg [DEPTH-1:0] count = 0;

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            rd_ptr <= 0;
            wr_ptr <= 0;
            count <= 0;
            empty <= 1;
            full <= 0;
        end else begin
            if (wr_en && !full) begin
                mem[wr_ptr] <= din;
                wr_ptr <= wr_ptr + 1;
                count <= count + 1;
            end
            if (rd_en && !empty) begin
                dout <= mem[rd_ptr];
                rd_ptr <= rd_ptr + 1;
                count <= count - 1;
            end
            empty <= (count == 0);
            full  <= (count == DEPTH);
        end
    end
endmodule
