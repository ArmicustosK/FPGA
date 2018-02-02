
module DE0_NANO(

	//////////// CLOCK //////////
	CLOCK_50,

	//////////// LED //////////
	LED,

	//////////// KEY //////////
	KEY,

	//////////// SW //////////
	SW,
	
	////////////ram////////
	//data,
	//address_sig,

	//////////// SDRAM //////////
	DRAM_ADDR,
	DRAM_BA,
	DRAM_CAS_N,
	DRAM_CKE,
	DRAM_CLK,
	DRAM_CS_N,
	DRAM_DQ,
	DRAM_DQM,
	DRAM_RAS_N,
	DRAM_WE_N,

	//////////// EPCS //////////
	EPCS_ASDO,
	EPCS_DATA0,
	EPCS_DCLK,
	EPCS_NCSO,

	//////////// Accelerometer and EEPROM //////////
	G_SENSOR_CS_N,
	G_SENSOR_INT,
	I2C_SCLK,
	I2C_SDAT,

	//////////// ADC //////////
	ADC_CS_N,
	ADC_SADDR,
	ADC_SCLK,
	ADC_SDAT,

	//////////// 2x13 GPIO Header //////////
	GPIO_2,
	GPIO_2_IN,

	//////////// GPIO_0, GPIO_0 connect to GPIO Default //////////
	GPIO_0,
	GPIO_0_IN,

	//////////// GPIO_1, GPIO_1 connect to GPIO Default //////////
	GPIO_1,
	GPIO_1_IN 
);

//=======================================================
//  PARAMETER declarations
//=======================================================


//=======================================================
//  PORT declarations
//=======================================================

//////////// CLOCK //////////
input 		          		CLOCK_50;

//////////// LED //////////
output		     [7:0]		LED;

//////////// KEY //////////
input 		     [1:0]		KEY;

//////////// SW //////////
input 		     [3:0]		SW;


//////////// SDRAM //////////
output		    [12:0]		DRAM_ADDR;
output		     [1:0]		DRAM_BA;
output		          		DRAM_CAS_N;
output		          		DRAM_CKE;
output		          		DRAM_CLK;
output		          		DRAM_CS_N;
inout 		    [15:0]		DRAM_DQ;
output		     [1:0]		DRAM_DQM;
output		          		DRAM_RAS_N;
output		          		DRAM_WE_N;

//////////// EPCS //////////
output		          		EPCS_ASDO;
input 		          		EPCS_DATA0;
output		          		EPCS_DCLK;
output		          		EPCS_NCSO;

//////////// Accelerometer and EEPROM //////////
output		          		G_SENSOR_CS_N;
input 		          		G_SENSOR_INT;
output		          		I2C_SCLK;
inout 		          		I2C_SDAT;

//////////// ADC //////////
output		          		ADC_CS_N;
output		          		ADC_SADDR;
output		          		ADC_SCLK;
input 		          		ADC_SDAT;

//////////// 2x13 GPIO Header //////////
inout 		    [12:0]		GPIO_2;
input 		     [2:0]		GPIO_2_IN;

//////////// GPIO_0, GPIO_0 connect to GPIO Default //////////
inout 		    [33:0]		GPIO_0;
input 		     [1:0]		GPIO_0_IN;

//////////// GPIO_1, GPIO_1 connect to GPIO Default //////////
inout 		    [33:0]		GPIO_1;
input 		     [1:0]		GPIO_1_IN;

///////////////ram single port///////
//input				[4:0]address_sig;
//input				data;
//=======================================================
//  REG/WIRE declarations
//=======================================================
wire						wSPI_CLK;
wire						wSPI_CLK_n;
wire						we;//enable
reg 				[4:0] address_sig;
reg				[7:0] data_tmp;
reg				[7:0] data_sig;
reg						count;
wire				[7:0] da_res;
//wire				[1:0]	ready_now;
//reg				[1:0]	datardy;


//assign ready_now[0] = datardy[0];	
//assign data_sig[7:0] = data[7:0];
					
//=======================================================
//  Structural coding
//=======================================================
ram ram_inst(
	.address ( address_sig ),
	.clock ( CLOCK_50 ),
	.data ( data_sig ),
	.wren ( we ),
	.q ( LED )
	);
SPIPLL		U0	(
						.inclk0(CLOCK_50),
						.c0(wSPI_CLK),
						.c1(wSPI_CLK_n)
					);

ADC_CTRL		U1	(
						.iRST(SW[3]),
						.iCLK(wSPI_CLK),
						.iCLK_n(wSPI_CLK_n),
						.iGO(SW[2]),
						.iCH(3'b000),
						.oLED(da_res),
						//.ready(ready_now[1:0]),
						.oDIN(ADCDAT),//saddr out
						.oCS_n(ADC_CS_N),//cs_n out
						.oSCLK(ADC_SCLK),//sclk out
						.iDOUT(ADC_SDAT)	//sdat input
					);



assign we = ~KEY[1];
assign da_res = data_sig;

always@(posedge KEY[0])
	begin
		
		address_sig = address_sig + 1'b1;
		
	end

always@(posedge CLOCK_50)
	begin
				count = count + 1;

				if(count == 1)
					data_tmp[7] <= da_res[7];
				else if (count == 2)
					data_tmp[6] <= da_res[7];
				else if (count == 3)
					data_tmp[5] <= da_res[7];
				else if (count == 4)
					data_tmp[4] <= da_res[7];
				else if (count == 5)
					data_tmp[3] <= da_res[7];
				else if (count == 6)
					data_tmp[2] <= da_res[7];
				else if (count == 7)
					data_tmp[1] <= da_res[7];
				else if (count == 8)
					data_tmp[0] <= da_res[7];
				else if (count == 9)
					begin
						count = 0;
					end

	end
/*always@(negedge KEY[1])
	begin
		if(!KEY[1])
			we <= 1;
		else
			we <= 0;
			
	end
/*always@(posedge CLOCK_50)
	begin
		count = count + 1;
		if(count == 9)
			begin
				count = 0;
			end
	end*/
	
endmodule
