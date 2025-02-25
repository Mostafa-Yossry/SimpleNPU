module simpleNPU_tb;
    parameter N = 2;
    reg clk;
    reg rst;
    reg [(2*N)-1:0] enable;
    reg [7:0] A [N-1:0][N-1:0];
    reg [7:0] B [N-1:0][N-1:0];
    wire [15+(N-1):0] out [(2*N)-1:0];
    wire PDONE;
    // Instantiate the DUT (Device Under Test)
    simpleNPU #(
        .N(N)
    ) dut (
        .clk(clk),
        .rst(rst),
        .A(A),
        .B(B),
        .out(out),
        .PDONE(PDONE)
    );
    
    // Clock generation
    always #5 clk = ~clk;
    
    initial begin
        // Initialize signals
        clk = 0;
        rst = 0;
        enable=0;
        // Apply reset
        
        // Assign test values to matrices
        A[0][0] = 8'd1; A[0][1] = 8'd2;
        A[1][0] = 8'd3; A[1][1] = 8'd4;
        
        B[0][0] = 8'd5; B[0][1] = 8'd6;
        B[1][0] = 8'd7; B[1][1] = 8'd8;
        @(negedge clk ) 
        rst=1;
        enable=1;
        
        @(negedge clk ) 
        @(negedge clk ) 
        @(negedge clk ) 
        @(negedge clk ) 
        @(negedge clk ) 
        @(negedge clk ) 
        @(negedge clk ) 
        @(negedge clk ) 
        @(negedge clk ) 
        @(negedge clk ) 
        @(negedge clk ) 
        
        $display("Output matrix:");
        $display("%d %d", out[0], out[1]);
        $display("%d %d", out[2], out[3]);
        
        // End simulation
        #10 $finish;
    end
endmodule
