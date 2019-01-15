`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2018 09:09:10 PM
// Design Name: 
// Module Name: fact_top
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


module fact_top(
    input [1:0] A,
    input WE,
    input [3:0] WD,
    input Rst,
    input Clk,
    output [31:0] RD
    );
    
    wire [3:0] state;
    wire WE2, WE1;
    wire [1:0] RdSel;
    wire [3:0] n;
    wire Go, GoPulse, GoPulseCmb;
    wire Done, Err, ResDone, ResErr;
    wire [31:0] nf;
    wire [31:0] Result;
    
    assign GoPulseCmb = (WD[0] & WE2);
    
    fact_ad     F_AD      (A, WE, WE2, WE1, RdSel);
    REG #(4)    n_REG     (Clk, Rst, WE1, WD, n);
    REG #(1)    Go_REG    (Clk, Rst, WE2, WD[0], Go);
    REG #(1)    GoPulse_R (Clk, Rst, 1'b1, GoPulseCmb, GoPulse);
    REG #(32)   result_R  (Clk, Rst, Done, nf, Result); 
    factorial   FA        (n, GoPulse, Clk, Rst, state, nf, Done, Err);
    SR_FF #(1)  SR_Done   (Clk, GoPulseCmb, Done, ResDone);
    SR_FF #(1)  SR_Err    (Clk, GoPulseCmb, Err, ResErr);
    mux4 #(32)  toRD      (RdSel, {28'b0, n}, {31'b0, Go}, {30'b0, ResErr, ResDone}, Result, RD);
endmodule
