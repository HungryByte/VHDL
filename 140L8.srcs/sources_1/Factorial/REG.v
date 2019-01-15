module REG #(parameter WIDTH = 8)(
    input clk,
    input rst,                  
    input ld,                  
    input [WIDTH-1:0] d,                   
    output reg [WIDTH-1:0] q);  
    // asynchronous, active HIGH reset w. enable input  
    initial begin
        q = 0;
    end
    always @(posedge rst, posedge clk) begin     
        if (rst) q = 0;
        else if (ld) q <= d;      
        else q <= q; 
    end
endmodule 
