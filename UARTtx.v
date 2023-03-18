module UARTtx(
input clk0, reset_sel, reset_in,
output reg en_in,TX 
);


reg [3:0]counter_sel;
reg [7:0]counter_in; 
wire clk;

pll pll(
	.inclk0(clk0),
	.c0(clk));


always @ (posedge clk or negedge reset_sel) begin
if(!reset_sel)
counter_sel <=0;
else
begin
counter_sel <= counter_sel+1;
if(counter_sel == 9)
begin
counter_sel<=0;
en_in <=1;
end
if(counter_sel ==0)
en_in <= 0;
end
end


always @ (posedge clk or negedge reset_in) begin
if(!reset_in)
begin
counter_in <=0; 
end
else if(en_in)
begin
counter_in <= counter_in+1;
end
end

always@(*)
begin
case(counter_sel)
4'b0000: TX = 1;
4'b0001: TX = 0;
4'b0010: TX = counter_in[0];
4'b0011: TX = counter_in[1];
4'b0100: TX = counter_in[2];
4'b0101: TX = counter_in[3];
4'b0110: TX = counter_in[4];
4'b0111: TX = counter_in[5];
4'b1000: TX = counter_in[6];
4'b1001: TX = counter_in[7];
default: TX = 1;
endcase


end

endmodule
