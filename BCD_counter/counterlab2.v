module counterlab2(nReset,clock,enable,co1,co10,co100);

input nReset,clock,enable;
output [3:0] co1;
output [3:0] co10;
output [3:0] co100;
wire wire1,wire2,wire3;


BCDcounter  counter1(.reset(nReset),.clk(clock),.countEn(enable),.nextEn(wire1),.cout(co1));
BCDcounter  counter2(.reset(nReset),.clk(clock),.countEn(wire1&enable),.nextEn(wire2),.cout(co10));
BCDcounter  counter3(.reset(nReset),.clk(clock),.countEn(wire2&wire1&enable),.nextEn(wire3),.cout(co100));


endmodule
