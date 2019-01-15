module mips (
        input  wire        clk,
        input  wire        rst,
        input  wire [4:0]  ra3, // why?
        input  wire [31:0] instr,
        input  wire [31:0] rd_dm,
        output wire        we_dm,
        output wire [31:0] pc_current,
        output wire [31:0] alu_out,
        output wire [31:0] wd_dm,
        output wire [31:0] rd3  // why?
    );
    
    wire       pc_src;
    wire       jump;
    wire       reg_dst;
    wire       we_reg;
    wire       alu_src;
    wire       dm2reg;
    wire [2:0] alu_ctrl;
    wire       zero;
    wire       jr_sel;
    wire       jal;
    wire       ra_reg;
    wire       shift;
    wire       we_mul;
    wire       mflo;
    wire       mfhi;

    datapath dp (
            .clk            (clk),
            .rst            (rst),
            .pc_src         (pc_src),
            .jump           (jump),
            .reg_dst        (reg_dst),
            .we_reg         (we_reg),
            .alu_src        (alu_src),
            .dm2reg         (dm2reg),
            .alu_ctrl       (alu_ctrl),
            .ra3            (ra3),
            .instr          (instr),
            .rd_dm          (rd_dm),
            .jr_sel         (jr_sel),
            .jal            (jal),
            .ra_reg         (ra_reg),
            .shift          (shift),
            .we_mul         (we_mul),
            .mflo           (mflo),
            .mfhi           (mfhi),
            .zero           (zero),
            .pc_current     (pc_current),
            .alu_out        (alu_out),
            .wd_dm          (wd_dm),
            .rd3            (rd3)
        );

    controlunit cu (
            .zero           (zero),
            .opcode         (instr[31:26]),
            .funct          (instr[5:0]),
            .pc_src         (pc_src),
            .jump           (jump),
            .reg_dst        (reg_dst),
            .we_reg         (we_reg),
            .alu_src        (alu_src),
            .we_dm          (we_dm),
            .we_mul         (we_mul),
            .dm2reg         (dm2reg),
            .jr_sel         (jr_sel),
            .ra_reg         (ra_reg),
            .alu_ctrl       (alu_ctrl),
            .jal            (jal),
            .shift          (shift),
            .mflo           (mflo),
            .mfhi           (mfhi)
        );
endmodule