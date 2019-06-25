module display_mux(mode, cn_now, qty_now, total_sum, seg5, seg4, seg3, seg2, seg1, seg0);
    input [2:0] mode;
    input [9:0] cn_now;
    input [6:0] qty_now;
    input [16:0] total_sum;

    wire [3:0] num_q100, num_q10, num_q1;
    wire [3:0] num_c1000, num_c100, num_c10, num_c1;
    wire [3:0] num_t100000, num_t10000, num_t1000, num_t100, num_t10, num_t1;
    wire [6:0] seg_q100, seg_q10, seg_q1;
    wire [6:0] seg_c1000, seg_c100, seg_c10, seg_c1;
    wire [6:0] seg_t100000, seg_t10000, seg_t1000, seg_t100, seg_t10, seg_t1;
    wire [1:0] len_qty;
    wire [2:0] len_cn, len_total;

    output [6:0] seg5, seg4, seg3, seg2, seg1, seg0;

    parameter [6:0] disp_bar = 7'b0111111,
                    disp_c = 7'b0100111,
                    disp_f = 7'b0001110,
                    disp_h = 7'b0001001,
                    disp_i = 7'b1111001,
                    disp_small_n = 7'b0101011,
                    disp_big_n = 7'b1001000,
                    disp_q = 7'b0011000,
                    disp_s = 7'b0010010,
                    disp_t = 7'b0000111,
                    disp_y = 7'b0010001,
                    disp_null = 7'b1111111;


    digits_small digits_qty(qty_now, num_q100, num_q10, num_q1, len_qty);
    digits_large digits_cn(cn_now, num_c1000, num_c100, num_c10, num_c1, len_cn);
    digits_immense digits_ts(total_sum, num_t100000, num_t10000, num_t1000, num_t100, num_t10, num_t1, len_total);


    decoder dc_q100(num_q100, seg_q100);
    decoder dc_q10(num_q10, seg_q10);
    decoder dc_q1(num_q1, seg_q1);
    decoder dc_c1000(num_c1000, seg_c1000);
    decoder dc_c100(num_c100, seg_c100);
    decoder dc_c10(num_c10, seg_c10);
    decoder dc_c1(num_c1, seg_c1);
    decoder dc_t100000(num_t100000, seg_t100000);
    decoder dc_t10000(num_t10000, seg_t10000);
    decoder dc_t1000(num_t1000, seg_t1000);
    decoder dc_t100(num_t100, seg_t100);
    decoder dc_t10(num_t10, seg_t10);
    decoder dc_t1(num_t1, seg_t1);

    assign seg5 = (mode[2] == 1'b1) ? disp_f
                                    : ( (mode[1] == 1'b1) ? ( (mode[0] == 1'b1) ? ( (len_total == 3'b110) ? seg_t100000 : disp_null ) : disp_q)
                                                        : ( (mode[0] == 1'b1) ? disp_c : disp_bar ) );
    assign seg4 = (mode[2] == 1'b1) ? disp_i
                                    : ( (mode[1] == 1'b1) ? ( (mode[0] == 1'b1) ? ( (len_total == 3'b101 || len_total == 3'b110) ? seg_t10000 : disp_null ) : disp_t)
                                                        : ( (mode[0] == 1'b1) ? disp_small_n : disp_bar ) );
    assign seg3 = (mode[2] == 1'b1) ? disp_big_n
                                    : ( (mode[1] == 1'b1) ? ( (mode[0] == 1'b1) ? ( (len_total == 3'b100 || len_total == 3'b101 || len_total == 3'b110) ? seg_t1000 : disp_null ) : disp_y)
                                                        : ( (mode[0] == 1'b1) ? ( (len_cn == 3'b100) ? seg_c1000 : disp_null ) : disp_bar ) );
    assign seg2 = (mode[2] == 1'b1) ? disp_i
                                    : ( (mode[1] == 1'b1) ? ( (mode[0] == 1'b1) ? ( (len_total == 3'b011 || len_total == 3'b100 || len_total == 3'b101 || len_total == 3'b110) ? seg_t100 : disp_null ) : ( (len_qty == 2'b11) ? seg_q100 : disp_null ) )
                                                        : ( (mode[0] == 1'b1) ? ( (len_cn == 3'b011 || len_cn == 3'b100) ? seg_c100 : disp_null ) : disp_bar ) );
    assign seg1 = (mode[2] == 1'b1) ? disp_s
                                    : ( (mode[1] == 1'b1) ? ( (mode[0] == 1'b1) ? ( (len_total == 3'b010 || len_total == 3'b011 || len_total == 3'b100 || len_total == 3'b101 || len_total == 3'b110) ? seg_t10 : disp_null ) : ( (len_qty == 2'b10 || len_qty == 2'b11) ? seg_q10 : disp_null ) )
                                                        : ( (mode[0] == 1'b1) ? ( (len_cn == 3'b010 || len_cn == 3'b011 || len_cn == 3'b100) ? seg_c10 : disp_null ) : disp_bar ) );
    assign seg0 = (mode[2] == 1'b1) ? disp_h
                                    : ( (mode[1] == 1'b1) ? ( (mode[0] == 1'b1) ? seg_t1 : seg_q1)
                                                        : ( (mode[0] == 1'b1) ? seg_c1 : disp_bar ) );



    
endmodule