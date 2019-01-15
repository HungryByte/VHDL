`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/29/2018 12:47:39 PM
// Design Name: 
// Module Name: dp
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


module dp(
    input [3:0] n,
    input sel, ld_cnt, en, ld_reg, OE, clk, rst,
    output [31:0] out,
    output wire GT, GT12);
    
    wire [31:0] mux2_out;
    wire [31:0] mul_out;
    wire [31:0] Q_reg;
    wire [31:0] Q_cnt;
    
    assign GT12 = (n>4'b1100) ? 1'b1 : 1'b0;
    
    FMUX2 #(32)     U1(mul_out, 32'b0000_0000_0000_0000_0000_0000_0000_0001, sel, mux2_out);
    REG #(32)      U2(clk, rst, ld_reg, mux2_out, Q_reg);
    CNT #(32)      U3(ld_cnt, en, clk, rst, {28'b0000_0000_0000_0000_0000_0000_0000 ,n}, Q_cnt);
    CMP #(32)      U4(Q_cnt, 32'b0000_0000_0000_0000_0000_0000_0000_0001, GT);
    MUL #(32)      U5(Q_reg, Q_cnt, mul_out);
    BUFFER #(32)   U6(OE, Q_reg, out);
      
endmodule
