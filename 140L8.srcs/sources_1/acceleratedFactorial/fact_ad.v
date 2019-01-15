`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2018 08:48:40 PM
// Design Name: 
// Module Name: fact_ad
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


module fact_ad(
    input [1:0]A,
    input WE,
    output reg WE2, WE1, 
    output [1:0]RdSel
    );
    
    assign RdSel = A;
    
    always @( WE, A ) begin
        case (A)
            2'b00: {WE2, WE1} = {1'b0, WE};
            2'b01: {WE2, WE1} = {WE, 1'b0};
            2'b10: {WE2, WE1} = 2'b00;
            2'b11: {WE2, WE1} = 2'b00;
            default: {WE2, WE1} = 2'bxx ;
        endcase
    end
    
endmodule
