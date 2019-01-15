module datapath (
        input  wire        clk,
        input  wire        rst,
        input  wire        pc_src,
        input  wire        jump,
        input  wire        reg_dst,
        input  wire        we_reg,
        input  wire        alu_src,
        input  wire        dm2reg,
        input  wire [2:0]  alu_ctrl,
        input  wire [4:0]  ra3,
        input  wire [31:0] instr,
        input  wire [31:0] rd_dm,
        input  wire        jr_sel,
        input  wire        jal,
        input  wire        ra_reg,
        input  wire        shift,
        input  wire        we_mul,
        input  wire        mflo,
        input  wire        mfhi,
        output wire        zero,
        output wire [31:0] pc_current,
        output wire [31:0] alu_out,
        output wire [31:0] wd_dm,
        output wire [31:0] rd3
    );

    wire [4:0]  rf_wa;
    wire [31:0] pc_plus4;
    wire [31:0] pc_pre;
    wire [31:0] pc_next;
    wire [31:0] jmp2jr;
    wire [31:0] sext_imm;
    wire [31:0] ba;
    wire [31:0] bta;
    wire [31:0] jta;
    wire [31:0] reg2shift;
    wire [31:0] alu_pa;
    wire [31:0] alu_pb;
    wire [31:0] wd_rf;
    wire [31:0] dm2jal;
    wire [4:0]  ins2ra; 
    wire [63:0] mulout;
    wire [31:0] jal2mflo;
    wire [31:0] mflo2mfhi;
    wire [31:0] mulhi2mux;
    wire [31:0] mullo2mux;
    
    assign ba = {sext_imm[29:0], 2'b00};
    assign jta = {pc_plus4[31:28], instr[25:0], 2'b00};
    
    // --- PC Logic --- //
    dreg pc_reg (
            .clk            (clk),
            .rst            (rst),
            .d              (pc_next),
            .q              (pc_current)
        );

    adder pc_plus_4 (
            .a              (pc_current),
            .b              (32'd4),
            .y              (pc_plus4)
        );

    adder pc_plus_br (
            .a              (pc_plus4),
            .b              (ba),
            .y              (bta)
        );

    mux2 #(32) pc_src_mux (
            .sel            (pc_src),
            .a              (pc_plus4),
            .b              (bta),
            .y              (pc_pre)
        );

    mux2 #(32) pc_jmp_mux (
            .sel            (jump),
            .a              (pc_pre),
            .b              (jta),
            .y              (jmp2jr)
        );
        
    mux2 #(32) pc_jr_mux (
            .sel            (jr_sel),
            .a              (jmp2jr),
            .b              (alu_out),
            .y              (pc_next)
        ); 

    // --- RF Logic --- //
    mux2 #(5) rf_wa_mux (
            .sel            (reg_dst),
            .a              (instr[20:16]),
            .b              (instr[15:11]),
            .y              (ins2ra)
        );
        
    mux2 #(5) ra_wa_mux (
                .sel            (ra_reg),
                .a              (ins2ra),
                .b              (5'b11111),
                .y              (rf_wa)
        );

    regfile rf (
            .clk            (clk),
            .we             (we_reg),
            .ra1            (instr[25:21]),
            .ra2            (instr[20:16]),
            .ra3            (ra3),
            .wa             (rf_wa),
            .wd             (wd_rf),
            .rd1            (reg2shift),
            .rd2            (wd_dm),
            .rd3            (rd3)
        );

    signext se (
            .a              (instr[15:0]),
            .y              (sext_imm)
        );

    // --- ALU Logic --- //
    mux2 #(32) alu_pb_mux (
            .sel            (alu_src),
            .a              (wd_dm),
            .b              (sext_imm),
            .y              (alu_pb)
        );
        
    mux2 #(32) alu_pa_mux (
            .sel            (shift),
            .a              (reg2shift),
            .b              ({27'b0000_0000_0000_0000_0000_0000_000,instr[10:6]}),
            .y              (alu_pa)
        );
    alu alu (
            .op             (alu_ctrl),
            .a              (alu_pa),
            .b              (alu_pb),
            .zero           (zero),
            .y              (alu_out)
        );
        
    multiplier mult (
            .a              (reg2shift),
            .b              (wd_dm),
            .y              (mulout)
        );

    wedreg mfloreg (
            .clk            (clk),
            .we             (we_mul),
            .wd             (mulout[31:0]),
            .rd             (mullo2mux)
        );
    
    wedreg mfhireg (
            .clk            (clk),
            .we             (we_mul),
            .wd             (mulout[63:32]),
            .rd             (mulhi2mux)
        );

    // --- MEM Logic --- //
    mux2 #(32) rf_wd_mux (
            .sel            (dm2reg),
            .a              (alu_out),
            .b              (rd_dm),
            .y              (dm2jal)
        );
    
    mux2 #(32) jal_pc4_mux (
            .sel            (jal),
            .a              (dm2jal),
            .b              (pc_plus4),
            .y              (jal2mflo)
        );
          
     mux2 #(32) mflo_mux (
            .sel            (mflo),
            .a              (jal2mflo),
            .b              (mullo2mux),
            .y              (mflo2mfhi)
        ); 

     mux2 #(32) mfhi_mux (
            .sel            (mfhi),
            .a              (mflo2mfhi),
            .b              (mulhi2mux),
            .y              (wd_rf)
        ); 
endmodule