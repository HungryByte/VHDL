`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/31/2018 03:05:58 PM
// Design Name: 
// Module Name: CNT_tb
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


module CNT_tb;
    reg LD, EN, clk;
    reg [31:0] D;
    wire [31:0] Q;
    
    task tick;
    begin
    #5 clk = ~clk;
    #5 clk = ~clk;
    end
    endtask
    
    CNT #(32) DUT (LD, EN, clk, D, Q);
    
    initial begin
        D=0; LD=0; EN=0; clk=0; #100;
        D=3; LD=1; EN=1; tick;
        D=0; LD=0; EN=1; tick;
        EN=1; tick; 
        tick; 
    end
    
endmodule
