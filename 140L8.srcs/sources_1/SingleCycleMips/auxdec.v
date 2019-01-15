module auxdec (
        input  wire [1:0] alu_op,
        input  wire [5:0] funct,
        output wire [2:0] alu_ctrl,
        output wire we_mul,
        output wire jr_sel,
        output wire ra_reg,
        output wire shift,
        output wire mflo,
        output wire mfhi,
        output wire jal
    );

    reg [9:0] signals;
   
    assign {alu_ctrl, we_mul, jr_sel, ra_reg, shift, mflo, mfhi, jal} = signals;
    
    always @ (alu_op, funct) begin
        case (alu_op)
            2'b00: signals = 10'b010_0_0_0_0_0_0_0; // ADD
            2'b01: signals = 10'b110_0_0_0_0_0_0_0; // SUB
            2'b11: signals = 10'b000_0_0_1_0_0_0_1; // for JAL instructions to pick register 31 
            default: case (funct)
                6'b00_0000: signals = 10'b011_0_0_0_1_0_0_0; // SLL
                6'b00_0010: signals = 10'b100_0_0_0_1_0_0_0; // SRL
                6'b00_1000: signals = 10'b010_0_1_1_0_0_0_0; // JR
                6'b01_1000: signals = 10'b101_1_0_0_0_0_0_0; // MUL
                6'b01_1001: signals = 10'b101_1_0_0_0_0_0_0; // MULU                
                6'b01_0010: signals = 10'b000_0_0_0_0_1_0_0; // MFLO
                6'b01_0000: signals = 10'b000_0_0_0_0_0_1_0; // MFHI
                6'b10_0100: signals = 10'b000_0_0_0_0_0_0_0; // AND
                6'b10_0101: signals = 10'b001_0_0_0_0_0_0_0; // OR
                6'b10_0000: signals = 10'b010_0_0_0_0_0_0_0; // ADD
                6'b10_0010: signals = 10'b110_0_0_0_0_0_0_0; // SUB
                6'b10_1010: signals = 10'b111_0_0_0_0_0_0_0; // SLT
                default:    signals = 10'bxxx_x_x_x_x_x_x_x;
            endcase
        endcase
    end

endmodule