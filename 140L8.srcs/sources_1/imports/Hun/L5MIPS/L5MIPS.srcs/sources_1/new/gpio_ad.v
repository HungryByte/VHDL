`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2018 03:40:20 PM
// Design Name: 
// Module Name: gpio_ad
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


module gpio_ad(
    input [1:0]A,
    input WE,
    output reg WE2, WE1, 
    output [1:0]RdSel
    );
    
    assign RdSel = A;
    
    always @( WE, A ) begin
        case (A)
            2'b00: {WE2, WE1} = 2'b00;
            2'b01: {WE2, WE1} = 2'b00;
            2'b10: {WE2, WE1} = {1'b0, WE};
            2'b11: {WE2, WE1} = {WE, 1'b0};
            default: {WE2, WE1} = 2'bxx ;
        endcase
    end
    
endmodule
