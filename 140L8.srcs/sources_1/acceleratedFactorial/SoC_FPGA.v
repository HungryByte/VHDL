`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2018 04:27:58 PM
// Design Name: 
// Module Name: SoC_FPGA
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


module SoC_fpga(
    input        clk, rst, button,
    input  [4:0] sw,
    output       sel, err,
    output [7:0] LEDSEL, LEDOUT);   
    
    wire        clk_5KHz, clk_pb, DONT_USE;
    wire [3:0]  hex   [0:7];
    wire [7:0]  digit [0:7];
    wire [31:0] gpi1, gpi2, gpo1, gpo2;
    wire [4:0]  rf_ra3 = 0;
    wire [31:0] rf_rd3 = 0;

    assign gpi1 = { 27'b0, sw };
    assign gpi2 = gpo1;
    assign sel  = gpo1[4];
    assign err  = gpo1[0];
    assign { hex[7], hex[6], hex[5], hex[4], hex[3], hex[2], hex[1], hex[0] } = gpo2;
    
    clk_gen           clk_gen (clk, rst, DONT_USE, clk_5KHz);
    button_debouncer  bd      (clk_5KHz, button, clk_pb);
    
    
    SoC               SoC     ( .clk(clk_pb), .rst(rst),
                              .ra3(rf_ra3), .gpi1(gpi1),
                              .gpi2(gpi2), .rd3(rf_rd3), 
                              .gpo1(gpo1), .gpo2(gpo2) );
                              
    
    bcd_to_7seg bcd7    ( hex[7], digit[7] );
    bcd_to_7seg bcd6    ( hex[6], digit[6] );
    bcd_to_7seg bcd5    ( hex[5], digit[5] );
    bcd_to_7seg bcd4    ( hex[4], digit[4] );
    bcd_to_7seg bcd3    ( hex[3], digit[3] );
    bcd_to_7seg bcd2    ( hex[2], digit[2] );
    bcd_to_7seg bcd1    ( hex[1], digit[1] );
    bcd_to_7seg bcd0    ( hex[0], digit[0] );
    
    
    
    led_mux     led_mux ( .clk(clk_5KHz), .rst(rst),
                          .LED7(digit[7]), .LED6(digit[6]), .LED5(digit[5]), .LED4(digit[4]),
                          .LED3(digit[3]), .LED2(digit[2]), .LED1(digit[1]), .LED0(digit[0]),
                          .LEDSEL(LEDSEL), .LEDOUT(LEDOUT) );
    
endmodule