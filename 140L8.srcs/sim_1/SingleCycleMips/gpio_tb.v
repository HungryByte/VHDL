`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2018 04:38:17 PM
// Design Name: 
// Module Name: gpio_tb
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


module gpio_tb;
    reg [1:0]A;
    reg WE;
    reg [31:0]gpi1;
    reg [31:0]gpi2;
    reg [31:0]WD;
    reg Rst;
    reg Clk;
    wire [31:0]RD;
    wire [31:0]gpo1;
    wire [31:0]gpo2;
    
    gpio_top DUT(
        A, WE, gpi1, gpi2, WD, Rst, Clk, RD, gpo1, gpo2);
    
    task tick; 
    begin 
        Clk = 1'b0; #5;
        Clk = 1'b1; #5;
    end
    endtask
        
    initial begin
        A=0; WE=0; gpi1=0; gpi2=0; WD=0; Rst=0; Clk=0; #100
        
        A=2'b10; WE=1; gpi1=4; gpi2=5; WD=6; tick; // RD = A=2'bxx
        WE=0; WD=7; tick; tick; WE=1; tick; // will hold 6 until WE=1
        Rst=1; tick; Rst=0; tick;
    end
endmodule
