module FA(output Cout, output sum, input A, input B, input Cin);
wire sum1, carry1, carry2;
    
HA ha1(.A(A), .B(B), .sum(sum1), .carry(carry1));
HA ha2(.A(sum1), .B(Cin), .sum(sum), .carry(carry2));

assign Cout = carry1 | carry2;

endmodule