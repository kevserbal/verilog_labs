module decision(q,out);

input  [3:0] q;

output reg out;
  
  
           
 always@(q[3:0])
 
 if (q[0]&q[1]&q[2]&q[3])
         out=1'b1;
         
 else if ((~q[0])&(~q[1])&(~q[2])&(~q[3]))
         out=1'b0;
 else 
      out=out;
  
  
  
endmodule 