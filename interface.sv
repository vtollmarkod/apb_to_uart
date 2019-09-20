
interface my_interface (input clk ,input rst);

	// APB part
	logic [31:0] paddr;
	logic [31:0] prdata;
	logic [31:0] pwdata; 
 	logic pwrite;
	logic psel;
	logic penable;
	logic pready;
	logic pslverr;
	// UART aprt
	logic rx;
	logic tx;


//ASSERTIONS

// PENABLE sholud go high after PSEL
  Select_Enable : assert property (@(posedge clk) disable iff(rst) psel |-> ##1 penable);
     else `uvm_error("Assert : Select_Enable","penable after more than # psel")
  
endmodule




/*

module dut_(
    input clk;
    input rst;
    input paddr;
    input prdata;
    input pwdata;
    input pwrite;
    input psel;
    input penable;
    input pslverr;
    input rx;
    output pready;
    output tx;
    );
endmodule






always @(posedge interface_dut.clk)
        begin
            // Cisto da vidim pomene na svim linijama
            `uvm_info("", $sformatf("DUT received paddr=%h", interface_dut.paddr), UVM_MEDIUM);
            `uvm_info("", $sformatf("DUT received prdata=%h", interface_dut.prdata), UVM_MEDIUM);
            `uvm_info("", $sformatf("DUT received pwdata=%h", interface_dut.pwdata), UVM_MEDIUM);
            `uvm_info("", $sformatf("DUT received pwrite=%b", interface_dut.pwrite), UVM_MEDIUM);
            `uvm_info("", $sformatf("DUT received psel=%b", interface_dut.psel), UVM_MEDIUM);
            `uvm_info("", $sformatf("DUT received penable=%b", interface_dut.penable), UVM_MEDIUM);
            `uvm_info("", $sformatf("DUT received pready=%b", interface_dut.pready), UVM_MEDIUM);
            `uvm_info("", $sformatf("DUT received pslverr=%b", interface_dut.pslverr), UVM_MEDIUM);
            `uvm_info("", $sformatf("DUT received rx=%b", interface_dut.rx), UVM_MEDIUM);
            `uvm_info("", $sformatf("DUT received tx=%b", interface_dut.tx), UVM_MEDIUM);
            // NPrejebati predy 
            dummy_pready=~dummy_pready;
        end
*/
