`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/05/2018 12:01:26 PM
// Design Name: 
// Module Name: factorial_tb
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


module factorial_tb;
    reg [3:0] n;
    reg GO, clk, rst;
    wire [3:0] state;
    wire [31:0] result;
    wire DONE, ERR;
    
    task tick;
    begin
        #5 clk = ~clk;
        #5 clk = ~clk;
    end
    endtask
    
    factorial DUT (n, GO, clk, rst, state, result, DONE, ERR);
    
    initial begin
        n=0; GO=0; clk=0; rst=0; #100;
        rst=1; tick; rst=0; #5
        
        GO=1;
        for(integer i=0; i<15; i=i+1) begin
            n=i;
            while(!DONE && (!ERR)) begin
                tick;
            end
            tick; // go back to state 0
        end
        $display("Testbench Successful");
    end
endmodule
