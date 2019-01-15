`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/05/2018 12:22:31 PM
// Design Name: 
// Module Name: factorial_fpga
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


module factorial_fpga (
    input clk100MHz, rst, button_go, button_clk, 
    input [3:0] n, 
    output DONE, ERR,
    output [3:0] n_out,
    output [7:0] LEDSEL, LEDOUT);  
	
	supply1 [7:0] vcc;  
	wire clk_4sec; 
	wire clk_5KHz;    
	wire [31:0] out;
	wire [3:0] dig [7:0]; 
	wire [7:0] s [7:0];
    
	wire [3:0] state; 
	wire button_go_out;
	wire button_clk_out;
	
    assign n_out = n; 

    clk_gen     CLK (clk100MHz, rst, clk_4sec, clk_5KHz); 
    button_debouncer DEBOUNCE0(clk_5KHz, button_go, button_go_out);
    button_debouncer DEBOUNCE1(clk_5KHz, button_clk, button_clk_out);
    
    factorial DUT (.n(n), .GO(button_go_out), .clk(button_clk_out), .rst(rst),
                 .state(state), .result(out), .DONE(DONE), .ERR(ERR));
    
    //bin2bcd32 DDT (out, dig[0], dig[1], dig[2], dig[3], dig[4], dig[5], dig[6], dig[7]);
    
    bcd_to_7seg DUTSEG0 (out[3:0], s[0]);
    bcd_to_7seg DUTSEG1 (out[7:4], s[1]);
    bcd_to_7seg DUTSEG2 (out[11:8], s[2]);
    bcd_to_7seg DUTSEG3 (out[15:12], s[3]);
    bcd_to_7seg DUTSEG4 (out[19:16], s[4]);
    bcd_to_7seg DUTSEG5 (out[23:20], s[5]);
    bcd_to_7seg DUTSEG6 (out[27:24], s[6]);
    bcd_to_7seg DUTSEG7 (out[31:28], s[7]);
                
    led_mux     LED (clk_5KHz, rst, s[7], s[6], s[5], s[4], s[3], s[2], s[1], s[0], LEDSEL, LEDOUT);
endmodule 