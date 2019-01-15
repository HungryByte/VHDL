module wedreg (
        input  wire        clk,
        input  wire        we,
        input  wire [31:0] wd,
        output wire [31:0] rd
    );

    reg [31:0] rf;

    integer n;
    
    initial begin
        rf = 32'h0;
    end
    
    always @ (posedge clk) begin
        if (we) rf <= wd;
    end

    assign rd = rf;

endmodule