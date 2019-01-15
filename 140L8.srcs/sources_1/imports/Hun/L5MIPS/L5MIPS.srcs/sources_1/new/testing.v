`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/20/2018 07:21:14 PM
// Design Name: 
// Module Name: testing
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module testing(
    input [31:0] a,
    input [31:0] b,
    output [63:0] c
    );
    
    assign a = 0'hFFFF;
    assign b = 0'h0002;
    assign c = a * b;
    
endmodule
