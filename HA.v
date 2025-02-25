module HA (
    output carry, 
    output sum,
     input A, 
     input B
);
    
assign sum = A ^ B;  
assign carry = A & B; 

endmodule