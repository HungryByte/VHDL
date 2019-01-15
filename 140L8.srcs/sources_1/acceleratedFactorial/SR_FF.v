`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2018 09:21:07 PM
// Design Name: 
// Module Name: SR_FF
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


module SR_FF #(parameter WIDTH=32) (
    input clk, rst,
    input [WIDTH-1:0] S,
    output reg [WIDTH-1:0] Q );

    initial Q <= 0;
    always @ ( posedge clk, posedge rst ) begin
        if(rst) begin 
            Q <= 0;
        end else if(S) begin
            Q <= S;
        end 
    end

endmodule
