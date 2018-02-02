/*lab3
 Kai Kang
*/


module lab3(input button1, input button2, input dip, input clk, output [1:0]led);
ram	ram_inst (
	.address ( address_sig ),
	.clock ( clk),
	.data ( data_sig ),
	.wren ( dip ),
	.q ( led )
	);
	

reg [4:0] address_sig;
reg [1:0] data_sig;
//wire [4:0] address_tmp;
//wire [1:0] data_tmp;
	
always@(negedge button1 or posedge button2) //clear and increase address
		begin
			
			if(!button1)
			address_sig = 5'b00000;
			
			else
			address_sig = address_sig + 1'b1;
			
		end
		
		
always@(posedge dip or negedge button2) //write and read, dip =1 write, =0 read
	begin
		if(!button2)
		begin
			if (dip ) 
			begin//write
				data_sig[0] = address_sig[0];	//LSB
				data_sig[1] = address_sig[0]^address_sig[1]^address_sig[2]^address_sig[3]^address_sig[4];	//XOR
				//address_sig = {data_sig[1],data_sig[0]};
			end
			
			/*else 	
			begin//read
				//data_sig = address_sig[4:0];
				//led <= data_sig[1:0];	//object "led" on left-hand side of assignment must have a variable data type

			end*/
			
		end
	end
			
//assign address_tmp = {data_sig[1], data_sig[0]};

	
		
endmodule
