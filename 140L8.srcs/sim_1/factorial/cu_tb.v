`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/03/2018 12:38:36 PM
// Design Name: 
// Module Name: cu_tb
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


module cu_tb;
    reg GT, GT12, clk, GO, rst;
    wire sel, ld_cnt, en, ld_reg, OE, DONE, ERR;
    wire [3:0] state;  

    task tick;
    begin
    #5 clk = ~clk;
    #5 clk = ~clk;
    end
    endtask
    
    cu DUT (GT, GT12, clk, GO, rst, sel, ld_cnt, en, ld_reg, OE, DONE, ERR, state);
    
    initial begin
        GT=0; GT12=0; clk=0; GO=0; rst=0; #100
        rst=1; tick; rst=0; tick;  // tick goes to state 0
    
        if({sel, ld_cnt, en, ld_reg, OE, DONE, ERR} != 7'b0000000) begin
            $display("State 0 error"); $stop; end
            
        GO=1; GT12=1; tick; // tick goes to state 5
        
        if({sel, ld_cnt, en, ld_reg, OE, DONE, ERR} != 7'b0000001) begin
            $display("State 1 error"); $stop; end      
           
        tick; // tick goes to state 0
        GO=1; GT=1; GT12=0; tick; tick; tick; tick; GT=0; tick; tick; 
        $display("Testbench Successful");
    end   
    
endmodule
