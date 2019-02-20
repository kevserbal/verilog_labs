module parity(Send,Clk,PDin,SDout,PDout,par_error);

input Send,Clk;
input [7:0] PDin;
output SDout;
output [7:0] PDout;
wire SCout;
assign SCout=Clk;
wire SDin;
reg parity;
output  par_error;

reg [7:0] regout;
always@(posedge SCout)
      begin
     
      if(counter[2:0] ==3'b1 )
        regout[7:0]<= PDin[7:0];
        
       else
          begin  
            regout[7:1]<= regout[6:0];
          if(counter[2:0] ==3'b010 )
            regout[0]<=parity;
          else 
            regout[0]<=1'b0;
        end           

       end

always@(posedge SCout)
   parity=PDin[7]^PDin[6]^PDin[5]^PDin[4]^PDin[3]^PDin[2]^PDin[1]^PDin[0];
        
assign SDout =regout[7];
assign SDin=SDout;



reg [8:0] regSout;
always@(posedge Clk)
        begin 
            regSout[8:1]<= regSout[7:0];
            regSout[0]<=SDin;
         end
         
assign PDout[6:0] = regSout[7:1];
assign PDout[7] =1'b0;  // set to zero for error





 assign par_error=(PDout[7]^PDout[6]^PDout[5]^PDout[4]^PDout[3]^PDout[2]^PDout[1]^PDout[0]==regSout[8])?1'b0:1'b1;


 
 


reg [2:0] counter;
always@(posedge Clk)
begin
   if(Send==0 & counter[2:0]==3'b0)
     counter[2:0]<=3'b0;
     
   else 
     counter[2:0]<=counter[2:0]+3'b1;
end



endmodule 