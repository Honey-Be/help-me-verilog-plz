module digits_small(value, out100, out10, out1, len);
    input [6:0] value;

    output [3:0] out100, out10, out1;
    output [1:0] len;

    assign out100 = value / 100;
    assign out10 = (value % 100) / 10;
    assign out1 = value % 10;
    assign len = (out100 == 4'b0000) ? ( (out10 == 4'b0000) ? 2'b01 : 2'b10 ) : 2'b11;
endmodule