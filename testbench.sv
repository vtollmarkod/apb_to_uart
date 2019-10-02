`include "uvm_macros.svh"
`include "apb_packages.sv"
`include "uart_packages.sv"
//`include "my_virtual_sequencer.sv"

module top;
  import uvm_pkg::*;
  import apb_agent_pkg::*;
  import uart_agent_pkg::*;

  `include "my_enviroment.sv"
  `include "apb_tests.sv" 
  
  // Clock & Reset
  bit clk = 0;
  bit rst = 1;

  // Interface
  apb_interface apb_interface_h (clk,rst);
  uart_interface uart_interface_h (clk,rst); 

  initial begin
     #500 rst = 0;
     #400 rst = 1;
     #500 rst = 0;
end
 
  initial begin				
    // Set APB virtual interface to apb test only
    uvm_config_db #(virtual apb_interface)::set(uvm_root::get(),"uvm_test_top","apb_interface", apb_interface_h); //uvm_root::get()
    
    // Set UART virtual interface to all subcomponent it is hardcoded to be passive
    uvm_config_db #(virtual uart_interface)::set(uvm_root::get(),"*","uart_interface", uart_interface_h); 
    
      
    // Dump database
    //uvm_config_db #(int)::dump();

    
    
    uvm_top.finish_on_completion = 1;
    $dumpfile("dump.vcd"); $dumpvars;
    run_test("apb_write_test"); //
  end
// Togle clock
  always #10 clk = ~clk; 
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


endmodule:top
