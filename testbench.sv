`include "uvm_macros.svh"
`include "packages.sv"

module top;
	import uvm_pkg::*;
	import my_pkg::*;
// Clock
	bit clk=0
// Reset
	bit rst=1;
// Interface
	my_interface my_interface_h (clk , rst);
// DUT wrapper
	// TODO
	
// Clock
	initial begin    
		forever #5 clk =~ clk;
		// ============================== Proveriti kako da handlujem reset
	end

// Database
	initial begin 									// null calling from module
		uvm_config_db #(virtual my_interface)::set(null,"uvm_test_top","virtual_interface", my_interface_h);
		run_test("apb_write_test"); // ========================= Promeni na odgovarajuci test i vidi dal treba objections

// You didn't see this Momcilo ;)
    uvm_top.finish_on_completion = 1;
    $dumpfile("dump.vcd"); $dumpvars;
	end

endmodule:top









