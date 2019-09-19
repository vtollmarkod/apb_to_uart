
interface my_interface (input clk ,input rst);

	// APB interface
	logic [31:0] paddr;
	logic [31:0] pdata; 
 	logic pwrite;
	logic psel;
	logic penable;
	logic pready;
	logic pslverr;
	// UART interface
	logic rx;
	logic tx;


//ASSERTIONS

// PENABLE sholud go high after PSEL
  Select_Enable : assert property (@(posedge clk) disable iff(rst) psel |-> ##1 penable);
     else `uvm_error("Assert : Select_Enable","penable after more than # psel")




endinterface

