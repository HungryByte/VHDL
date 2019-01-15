`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/03/2018 07:09:28 PM
// Design Name: 
// Module Name: factorial
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


module factorial(
    input wire [3:0] n, 
    input wire GO, clk, rst, 
    output wire [3:0] state,
    output wire [31:0] result,
    output wire DONE, ERR
    );
    
    wire sel, ld_cnt, en, ld_reg, OE, GT, GT12;
    
    dp DUT (n, sel, ld_cnt, en, ld_reg, OE, clk, rst, result, GT, GT12);
    cu DDT (GT, GT12, clk, GO, rst, sel, ld_cnt, en, ld_reg, OE, DONE, ERR, state);
    
endmodule
