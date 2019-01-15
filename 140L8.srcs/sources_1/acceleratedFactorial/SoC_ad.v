`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2018 04:02:16 PM
// Design Name: 
// Module Name: SoC_AD
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


module SoC_ad(
    input [31:0]A,
    input WE,
    output reg WE2, WE1, WEM, 
    output reg [1:0]RdSel
    );
    
    initial begin
        WE2 = 1'b0;
        WE1 = 1'b0;
        WEM = 1'b0;
    end
    
    always @( WE, A ) begin
        case (A[11:8])
            4'h9:    begin { WEM, WE1, WE2 } = { 1'b0, 1'b0, WE }; RdSel = 2'b11; end // GPIO
            4'h8:    begin { WEM, WE1, WE2 } = { 1'b0, WE, 1'b0 }; RdSel = 2'b10; end // Factorial Accelerator
            default: begin { WEM, WE1, WE2 } = { WE, 1'b0, 1'b0 }; RdSel = 2'b00; end // Data Memory
        endcase
    end
    
endmodule
