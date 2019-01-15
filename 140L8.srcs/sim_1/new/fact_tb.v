`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2018 09:47:20 PM
// Design Name: 
// Module Name: fact_tb
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


module fact_tb;
    reg [1:0] A;
    reg WE;
    reg [3:0] WD;
    reg Rst;
    reg Clk;
    reg [3:0] n;
    wire [31:0] RD;
    
    fact_top DUT(A, WE, WD, Rst, Clk, RD);
    
    task tick; 
    begin 
        Clk = 1'b0; #5;
        Clk = 1'b1; #5;
    end
    endtask 
    
    initial begin
        A=0; WE=0; WD=0; Rst=0; Clk=0; n=12; #100 // n = #! 
        
        Rst=1; tick; Rst=0; tick;
        A=2'b00; WE=1; WD=n; tick;
        A=2'b01; WE=1; WD=1; tick; 
        A=2'b10; WE=0; WD=0; //A=2'b11 = result, A=2'b10 = Done bit
        for(integer i=0; i<(n+2); i=i+1)begin
            tick; // takes n+2 ticks
        end
        
        $display("Testbench Successful");
    end   
endmodule
