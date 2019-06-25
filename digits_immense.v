module digits_immense(value, out100000, out10000, out1000, out100, out10, out1, len);
    input [16:0] value;

    output [3:0] out100000, out10000, out1000, out100, out10, out1;
    output [2:0] len;



    assign out100000 = value / 100000;
    assign out10000 = (value % 100000) / 10000;
    assign out1000 = (value % 10000) / 1000;
    assign out100 = (value % 1000) / 100;
    assign out10 = (value % 100) / 10;
    assign out1 = value % 10;
    assign len = (out100000 == 4'b0000) ? ( (out10000 == 4'b0000) ? ( (out1000 == 4'b0000) ? ( (out100 == 4'b0000) ? ( (out10 == 4'b0000) ? 3'b001 : 3'b010 ) : 3'b011 ) : 3'b100 ) : 3'b101 ) : 3'b110;
endmodule