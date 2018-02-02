
module lab3(input b1, input b2, input dip, input clk, output [1:0]q);
reg [4:0] address_sig;
wire [1:0] data_sig;
ram	ram_inst (
	.address ( address_sig ),
	.clock ( clk),
	.data ( data_sig ),
	.wren ( dip ),
	.q ( q )
	);
	


assign data_sig[0] = address_sig[0];
assign data_sig[1] = address_sig[0]^address_sig[1]^address_sig[2]^address_sig[3]^address_sig[4];	

always@(negedge b1 or negedge b2) 
	begin
		if(!b2)
		begin
			
			address_sig = address_sig + 1'b1;
		end
		else if(!b1)
		begin
			address_sig = 5'b00000;
		end
	end
			

	

	
endmodule
