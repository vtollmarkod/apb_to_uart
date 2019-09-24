`include "uvm_macros.svh"
`include "packages.sv"


module top;
	import uvm_pkg::*;
	import my_pkg::*;
  
  
  	// Generate clock
	bit clk = 0;
  bit rst = 1;
	always #10 clk = ~clk; 


  // Generate Reset signal
  always  #10 rst=0;

// Za test APB-a
bit pready_tb = 0;
always
  begin
    apb_interface_h.pready <=pready_tb;
    #70;
    pready_tb =~ pready_tb;
    apb_interface_h.pready <= pready_tb;
    apb_interface_h.prdata <= $urandom_range(100,1000);
  end

  
  
  
  
  

// Interface
  apb_interface apb_interface_h (clk,rst);

// DUT wrapper



// Database
	initial begin 									// null calling from module *= uvm_test_top
      uvm_config_db #(virtual apb_interface)::set(null,"*","apb_interface", apb_interface_h);
      
      
      
          
      
      
      
      
     // You didn't see this Momcilo ;)
    uvm_top.finish_on_completion = 1;
    $dumpfile("dump.vcd"); $dumpvars;
      
      
		run_test("apb_write_test"); // ========================= Promeni na odgovarajuci test i vidi dal treba objections

 
      
	end

endmodule:top








