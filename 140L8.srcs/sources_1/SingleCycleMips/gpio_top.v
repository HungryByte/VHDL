`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2018 04:02:47 PM
// Design Name: 
// Module Name: gpio_top
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


module gpio_top(
    input [1:0]A,
    input WE,
    input [31:0]gpi1,
    input [31:0]gpi2,
    input [31:0]WD,
    input Rst,
    input Clk,
    output [31:0]RD,
    output [31:0]gpo1,
    output [31:0]gpo2
    );
    wire WE2, WE1;
    wire [1:0]RdSel;

    gpio_ad     ad      (A, WE, WE2, WE1, RdSel);
    REG  #(32)  gpo1_reg(Clk, Rst, WE1, WD, gpo1);
    REG  #(32)  gpo2_reg(Clk, Rst, WE2, WD, gpo2);
    mux4 #(32)  toRD    (RdSel, gpi1, gpi2, gpo1, gpo2, RD);
endmodule
