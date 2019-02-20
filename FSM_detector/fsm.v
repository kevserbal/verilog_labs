module fsm(d1,d2,clk,dirout,rst,counterout);


input d1,d2,clk;
input rst;
output [2:0] dirout;
output [2:0] counterout;
reg [2:0] regin;
reg [2:0] regout;

parameter s0=3'b0, s1=3'b1,s2=3'b010,s3=2'b011,s4=3'b100,s5=3'b101,s6=3'b110,s7=3'b111;

always@(regin)
begin
   case(regin[2:0]) 

     s1: regout[2:0] =s1;
     s2: regout[2:0] =s2;
     s3: regout[2:0] =s3;
     s5: regout[2:0] =s5;
     s6: regout[2:0] =s6;
     s7: regout[2:0] =s7;  
     s0: regout[2:0] =s0;
      default  :regout[2:0] =s4;
     endcase 
end




always@(posedge clk or negedge rst)
begin
  if (rst==1'b0)   
    regin[2:0]<=s4;  
  else if (regout[2:0] == s4)
    regin[2:0]<=s0;
  else 
    case (regout)
      s0:
         if(d1==1'b0 & d2==1'b0)
           regin[2:0]<=s0;
         else if (d1==1'b1 & d2==1'b0)
           regin[2:0]<=s1;
         else // 01 
           regin[2:0]<=s5;
           
      s1:
         if(d1==1'b0 & d2==1'b0)
           regin[2:0]<=s0;
         else if(d1==1'b1 & d2==1'b0)
           regin[2:0]<=s1;     
         else 
           regin[2:0]<=s2;  
            
      s2:
         if(d1==1'b0 & d2==1'b1)
           regin[2:0]<=s3;
         else if(d1==1'b1 & d2==1'b0)
           regin[2:0]<=s1;     
         else 
           regin[2:0]<=s2;   

      s3:
         if(d1==1'b0 & d2==1'b1)
           regin[2:0]<=s3;
         else if(d1==1'b1 & d2==1'b1)
           regin[2:0]<=s2;     
         else 
           regin[2:0]<=s4;   
      s4:
           regin[2:0]<=s0;
      s5:
          if(d1==1'b0 & d2==1'b0)
           regin[2:0]<=s0;
         else // 11 
           regin[2:0]<=s6;  
      s6: 
         if(d1==1'b1 & d2==1'b0)
           regin[2:0]<=s7;
         else // 01 
           regin[2:0]<=s5;  
       s7:
         if(d1==1'b0 & d2==1'b0)
           regin[2:0]<=s0;
         else // 11 
           regin[2:0]<=s6;              
      
        default regin[2:0]<=s4;     
       endcase           
end  

assign dirout[2:0]= regout[2:0] ;
 
reg cntrl;

always @ (posedge clk or negedge rst)
     if (rst==1'b0)
       cntrl=1'b0;
     else if (regout == s3 & d1==1'b0 & d2==1'b0)   
       cntrl=1'b1;
     else
       cntrl=1'b0;
      
      
reg [2:0] count ;
always @ (posedge clk or negedge rst)
	begin
		if (rst==1'b0)
			count[2:0] <= 3'b0;
		else if (cntrl == 1'b1)
			count[2:0] <= count[2:0]+ 3'b1;
	    else 
	     	count[2:0] <= count[2:0] ;
	end
assign counterout[2:0]=count[2:0] ;


endmodule 