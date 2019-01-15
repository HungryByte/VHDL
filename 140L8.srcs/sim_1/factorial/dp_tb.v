`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/29/2018 07:21:24 PM
// Design Name: 
// Module Name: dp_tb
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


module dp_tb;
    reg [3:0] n;
    reg sel, ld_cnt, en, ld_reg, OE, clk, rst;
    wire [31:0] out;
    wire GT;
    
    task tick;
    begin
    #5 clk = ~clk;
    #5 clk = ~clk;
    end
    endtask
    
    dp DUT(n, sel, ld_cnt, en, ld_reg, OE, clk, rst, out, GT);
    
    initial begin
        n=0; sel=0; ld_cnt=0; en=0; ld_reg=0; OE=0; clk=0; rst=0; #100;
        rst=1; tick; rst=0; tick;
        n=12; sel = 1'b0; ld_cnt=1'b1; en=1'b1; ld_reg=1'b1; OE=1'b0; tick; 
         
        for(integer i=0; i<32; i=i+1)begin
            if(GT == 1)begin
                sel = 1'b1; ld_cnt=1'b0; en=1'b1; ld_reg=1'b1; OE=1'b0; tick;
            end else begin
                sel = 1'b1; ld_cnt=1'b0; en=1'b0; ld_reg=1'b0; OE=1'b1; tick; 
            end    
        end
        //sel = 1'b0; ld_cnt=1'b0; en=1'b0; ld_reg=1'b0; OE=1'b0; tick; 
        //sel = 1'b1; ld_cnt=1'b0; en=1'b1; ld_reg=1'b1; OE=1'b0; tick;
        //sel = 1'b1; ld_cnt=1'b0; en=1'b1; ld_reg=1'b1; OE=1'b1; tick;
        $display("Testbench Successful");
    end
endmodule
