`timescale 1ns/100ps
module DCO_tb();
    reg en;
    wire dco_clk;
    reg [3:0] alpha;

    DCO U0(
      .enable(en),
      .alpha(alpha),
      .dco_clk(dco_clk)
    );

    initial begin
      en = 0;
      alpha = 4'd1;
      #10
      en = 1;
      #50
      @(negedge dco_clk);
      alpha = 4'd2;
      #50
      @(negedge dco_clk);
      alpha = 4'd3;
      #50
      @(negedge dco_clk);
      alpha = 4'd4;
      #50
      @(negedge dco_clk);
      alpha = 4'd5;
      #50
      @(negedge dco_clk);
      alpha = 4'd6;
      #50
      @(negedge dco_clk);
      alpha = 4'd7;
      #50
      @(negedge dco_clk);
      alpha = 4'd8;
      #50
      @(negedge dco_clk);
      alpha = 4'd9;
      #50
      
      
      $finish;
    end

      
    initial begin
        $sdf_annotate("./DCO_syn.sdf", U0);
        $fsdbDumpfile("../4.Simulation_Result/DCO_syn.fsdb");
        $fsdbDumpvars;
    end



endmodule