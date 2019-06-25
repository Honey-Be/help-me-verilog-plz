module vud_large(clk, ctrl, value);
    input clk;
    input [4:0] ctrl;
    
    parameter [3:0] idx_upper_bound = 9;
    parameter [idx_upper_bound:0] min = 0, max = 1023;

    output [idx_upper_bound:0] value;
    reg [idx_upper_bound:0] value;

    wire rst, lock, flag_dir;
    wire [1:0] flag_delta;
    assign {rst, lock, flag_dir, flag_delta} = ctrl;

    reg [idx_upper_bound:0] delta;
    always@(posedge clk or negedge rst or negedge lock) begin
        if(!lock) ;
        else begin
            if(!rst) begin
                value <= 0;
            end
            else begin
                if(flag_delta == 2'b11) delta <= 1000;
                else if(flag_delta == 2'b10) delta <= 100;
                else if(flag_delta == 2'b01) delta <= 10;
                else delta <= 1;

                if(flag_dir == 1'b1) begin
                    if(value > max - delta) ;
                    else value <= value + delta;
                end
                else begin
                    if(value < min + delta) ;
                    else value <= value - delta;
                end
            end
        end
    end

endmodule