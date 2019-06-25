module vud_small(clk, ctrl, value);
    input clk;
    input [3:0] ctrl;
    
    parameter [3:0] idx_upper_bound = 6;
    parameter [idx_upper_bound:0] min = 0, max = 127;

    output [idx_upper_bound:0] value;
    reg [idx_upper_bound:0] value;

    wire rst, lock, flag_dir;
    wire flag_delta;
    assign {rst, lock, flag_dir, flag_delta} = ctrl;

    reg [idx_upper_bound:0] delta;
    always@(posedge clk or negedge rst or negedge lock) begin
        if(!lock) ;
        else begin
            if(!rst) begin
                value <= 0;
            end
            else begin
                if(flag_delta == 1'b1) delta <= 10;
                else delta <= 1;

                if(flag_dir == 1'b1) begin
                    if(value <= max - delta)
						      value <= value + delta;
                end
                else begin
                    if(value <= min + delta)
						      value <= value - delta;
                end
            end
        end
    end

endmodule