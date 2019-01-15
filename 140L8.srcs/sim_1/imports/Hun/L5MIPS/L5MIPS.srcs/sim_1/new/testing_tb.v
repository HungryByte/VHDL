`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/20/2018 07:23:03 PM
// Design Name: 
// Module Name: testing_tb
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


module testing_tb(
    input [31:0] a,
    input [31:0] b,
    output [63:0] c
    );
    
    testing DUT (a, b, c);
    
endmodule
