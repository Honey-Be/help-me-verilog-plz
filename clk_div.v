module clk_div(clk, out_clk);
  input clk;

  output out_clk;

  reg out_clk = 0;
  reg [24:0]cnt_clk = 0;
  
  always@(posedge clk) begin
    cnt_clk <= cnt_clk+1;
    if(cnt_clk == 12499999)
      cnt_clk <=0;
    else if(cnt_clk==0)
      out_clk = !out_clk;     
  end    
endmodule