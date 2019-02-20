module Debouncer1(Swout,clk1ms,SwoutDb1);


input Swout,clk1ms;
output SwoutDb1;

wire [4:0] wires;



flipflop f1 (.d(Swout),.q(wires[0]),.clk(clk1ms));
flipflop f2 (.d(wires[0]),.q(wires[1]),.clk(clk1ms));
flipflop f3 (.d(wires[1]),.q(wires[2]),.clk(clk1ms));


 
decision(.q({Swout,wires[2],wires[1],wires[0]}),.out(wires[3]));
flipflop f4 (.d(wires[3]),.q(SwoutDb1),.clk(clk1ms));




endmodule 