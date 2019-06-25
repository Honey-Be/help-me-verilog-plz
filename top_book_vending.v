module top_book_vending(clk, sw9, sw8, sw7, sw6, sw5, sw4, sw3, sw2, sw1 , sw0, btn3, btn2, btn1, btn0 , seg5, seg4, seg3, seg2, seg1, seg0);
    input sw0, sw1, sw2, sw3, sw4, sw5, sw6, sw7, sw8, sw9;
    input btn0, btn1, btn2, btn3;
    input clk;

    output [6:0] seg0, seg1, seg2, seg3, seg4, seg5;
    wire [9:0] cn_now;
    wire [6:0] qty_now;
    wire [16:0] total_sum;
    wire [2:0] mode;



    vm_control ctrl(clk, { sw9, sw8, sw7, sw6 }, { sw5, sw4, sw3, sw2, sw1 }, sw0, { btn3, btn2, btn1, btn0 }, cn_now, qty_now, total_sum, mode);

    display_mux mux(mode, cn_now, qty_now, total_sum, seg5, seg4, seg3, seg2, seg1, seg0);

endmodule