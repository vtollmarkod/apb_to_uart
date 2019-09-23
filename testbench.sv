`include "uvm_macros.svh"
`include "packages.sv"

module top;
	import uvm_pkg::*;
	import my_pkg::*;
  
  
  	// Generate clock
	bit clk=0;
	always #10 clk = ~clk; 
  bit pready_tb = 0;
  
  always
    begin
      repeat(4)
        @(posedge my_interface_h.clk)
      
        my_interface_h.pready = pready_tb;
        pready_tb =~pready_tb;
        my_interface_h.prdata = $urandom_range(1,100);
      
    end
  
  
  

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








