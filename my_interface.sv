
interface apb_interface (input clk ,input rst);

	logic [31:0] paddr;
	logic [31:0] prdata;
	logic [31:0] pwdata; 
 	logic pwrite;
	logic psel;
	logic penable;
	logic pready;
	logic pslverr;
    
endinterface
