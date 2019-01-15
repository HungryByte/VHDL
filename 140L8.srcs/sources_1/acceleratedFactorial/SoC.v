module SoC(
    // ra3 and rd3 will not be used 
    input         clk, rst,    
    input  [4:0]  ra3,  
    input  [31:0] gpi1, gpi2, 
    output [31:0] rd3, gpo1, gpo2 
    );

    //Mips wire
    wire [31:0] PC; 
    wire        MemWrite;
    wire [31:0] Address;
    wire [31:0] WriteData, Instruction;
    
    //outputs of Address Decoder
    wire        WE2, WE1, WEM;
    wire [1:0]  RdSel;
    
    //outputs of DataMem, Factorial Acc, General Purpose
    wire [31:0] DMemData, FactData, GPIOData;
    wire  [31:0] ReadData;
    
   // wire [31:0] DONT_USE[0:2];

    mips mips (
            .clk            (clk),
            .rst            (rst),
            .ra3            (ra3),
            .instr          (Instruction),
            .rd_dm          (ReadData),
            .we_dm          (MemWrite),
            .pc_current     (PC),
            .alu_out        (Address),
            .wd_dm          (WriteData),
            .rd3            (rd3)
        );

    imem imem (
            .a              (PC[7:2]),
            .y              (Instruction)
        );

    dmem dmem (
            .clk            (clk),
            .we             (WEM),
            .a              (Address[7:2]),
            .d              (WriteData),
            .q              (DMemData)
        );
    
    SoC_ad Soc_ad(
            .A              (Address),
            .WE             (MemWrite),
            .WE2            (WE2),
            .WE1            (WE1),
            .WEM            (WEM), 
            .RdSel          (RdSel)
        );
    
    fact_top fact_top(
            .A              (Address[3:2]),
            .WE             (WE1),
            .WD             (WriteData[3:0]),
            .Rst            (rst),
            .Clk            (clk),
            .RD             (FactData)
        );
        
    gpio_top gpio_top(
            .A              (Address[3:2]),
            .WE             (WE2),
            .gpi1           (gpi1),
            .gpi2           (gpi2),
            .WD             (WriteData),
            .Rst            (rst),
            .Clk            (clk),
            .RD             (GPIOData),
            .gpo1           (gpo1),
            .gpo2           (gpo2)
        );
        
    mux4 #(32) mux4(
            RdSel,
            DMemData,
            DMemData,
            FactData,
            GPIOData,
            ReadData
        );

endmodule