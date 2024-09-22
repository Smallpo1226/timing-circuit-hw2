module DCO(enable, alpha, dco_clk);
    input enable;
    input [3:0] alpha;
    reg [8:0] lambda;
    wire [8:0] w;
    wire t;
    output wire dco_clk;

    parameter buffer = 10'd8;
    parameter delay_group = 10'd82;
    wire [delay_group:0] d;

    always @(*) begin
        case (alpha)
            4'd1: lambda=9'b000000001;
            4'd2: lambda=9'b000000010;
            4'd3: lambda=9'b000000100;
            4'd4: lambda=9'b000001000;
            4'd5: lambda=9'b000010000;
            4'd6: lambda=9'b000100000;
            4'd7: lambda=9'b001000000;
            4'd8: lambda=9'b010000000;
	    4'd9: lambda=9'b100000000;
            default : lambda=9'b000000001;
        endcase
    end

    NAND2X2 F0( .A(enable) ,.B(t) ,.Y(d[0]));
    BUFX3 A0( .A (d[delay_group]), .Y (w[0]) );

    genvar i;    
    generate
        for (i = 0; i < buffer; i = i + 1) begin:loop1
            CLKBUFX20 A1( .A (w[i]), .Y (w[i+1]) );
            TBUFX20 D0( .A (w[i]), .Y (t) , .OE(lambda[i]) );
        end
	TBUFX20 D1( .A (w[buffer]), .Y (t) , .OE(lambda[buffer]) );
    endgenerate

    generate
        for (i = 0; i < delay_group; i = i + 1) begin:loop3
            CLKBUFX4 C1(.A(d[i]), .Y(d[i+1]));
        end
    endgenerate

    assign dco_clk=t;
endmodule
