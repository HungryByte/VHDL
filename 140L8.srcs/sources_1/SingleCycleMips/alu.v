module alu (
        input  wire [2:0]  op,
        input  wire [31:0] a,
        input  wire [31:0] b,
        output wire        zero,
        output reg  [31:0] y
    );

    assign zero = (y == 0);

    always @ (op, a, b) begin
        case (op)
            3'b000: y = a & b;
            3'b001: y = a | b;
            3'b010: y = a + b;
            3'b011: y = b * (2**a); // SLL
            3'b100: y = b / (2**a); // SRL
            3'b101: y = 0; // mul, data written to rd=0 is zero
            3'b110: y = a - b;
            3'b111: y = (a < b) ? 1 : 0;
        endcase
    end

endmodule