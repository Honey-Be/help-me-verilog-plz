module vm_control(clk, ctrl_cn, ctrl_qty, fix, switches, cn_now, qty_now, total_sum, mode);
    input clk;
    input [3:0] ctrl_cn;
    input [4:0] ctrl_qty;
    input fix;
    input [3:0] switches;

    wire out_clk;
    output [2:0] mode;
    assign mode = m;
    wire [9:0] c;
    wire [16:0] item_price;

    output [9:0] cn_now = c;
    output [6:0] qty_now;
    output [16:0] total_sum;
    reg [16:0] total_sum;

    reg [2:0] m;
    initial m = 3'b000;
    always@(m, switches) begin
        if(switches == 4'b0111) m <= 3'b000;
        else if(switches == 4'b1011) m <= 3'b001;

        else if(switches == 4'b1101) m <= 3'b010;
        else if(switches == 4'b1110) begin
            if(fix == 1'b1) m <= 3'b100;
            else begin
                total_sum <= total_sum + (item_price * qty_now);
                m <= 3'b011;
            end;
        end
		  if(m == 3'b000) total_sum <= 0;
    end


    clk_div cdiv(clk, out_clk);

    vud_large vud_cn(out_clk, ctrl_cn, c);
    vud_small vud_qty(out_clk, ctrl_qty, qty_now);
    item_dic dic(c, item_price);
    
endmodule