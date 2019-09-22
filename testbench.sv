`include "uvm_macros.svh"
`include "packages.sv"

module top;
	import uvm_pkg::*;
	import my_pkg::*;
  
  
  	// Generate clock
	bit clk=0;
	always #10 clk = ~clk; 

  

// Interface
  my_interface my_interface_h (clk);

// DUT wrapper



// Database
	initial begin 									// null calling from module *= uvm_test_top
      uvm_config_db #(virtual my_interface)::set(null,"*","my_interface", my_interface_h);
      
      
      
          
      
      
      
      
     // You didn't see this Momcilo ;)
    uvm_top.finish_on_completion = 1;
    $dumpfile("dump.vcd"); $dumpvars;
      
      
		run_test("apb_write_test"); // ========================= Promeni na odgovarajuci test i vidi dal treba objections

 
      
	end

endmodule:top








