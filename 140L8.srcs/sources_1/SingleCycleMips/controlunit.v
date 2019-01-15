module controlunit (
        input  wire        zero,
        input  wire [5:0]  opcode,
        input  wire [5:0]  funct,
        output wire        pc_src,
        output wire        jump,
        output wire        reg_dst,
        output wire        we_reg,
        output wire        alu_src,
        output wire        we_dm,
        output wire        we_mul,
        output wire        dm2reg,
        output wire        jr_sel,
        output wire        ra_reg,
        output wire [2:0]  alu_ctrl,
        output wire        jal,
        output wire        shift,
        output wire        mflo,
        output wire        mfhi
    );
    
    wire [1:0] alu_op;

    assign pc_src = branch & zero;

    maindec md (
        .opcode         (opcode),
        .branch         (branch),
        .jump           (jump),
        .reg_dst        (reg_dst),
        .we_reg         (we_reg),
        .alu_src        (alu_src),
        .we_dm          (we_dm),
        .dm2reg         (dm2reg),
        .alu_op         (alu_op)
    );

    auxdec ad (
        .alu_op         (alu_op),
        .funct          (funct),
        .alu_ctrl       (alu_ctrl),
        .we_mul         (we_mul),
        .jr_sel         (jr_sel),
        .ra_reg         (ra_reg),
        .shift          (shift),
        .mflo           (mflo),
        .mfhi           (mfhi),
        .jal            (jal)
    );

endmodule