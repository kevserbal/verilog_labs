module BCDcounter(reset,clk,countEn,nextEn,cout);

input reset,clk,countEn;
output nextEn;
output reg [3:0] cout;



always@( posedge clk or negedge reset)
begin 
    if(reset==1'b0)
    cout[3:0]=4'b0;
    
    else
     if(countEn==1'b1)
     
		
		if (cout[3:0]==4'b1001)
		  cout[3:0]=4'b0;
		else
		  cout[3:0]=cout[3:0]+4'b1;
     else 
      cout[3:0]=cout[3:0];
   

end


assign nextEn=(cout[3:0]==4'b1001)? 1'b1:1'b0;


endmodule 