class apb_driver extends uvm_driver #(apb_sequence_item);
	`uvm_component_utils (apb_driver)

  
	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction

	virtual my_interface my_interface_h;
  	apb_sequence_item req;
  
	virtual function void build_phase (uvm_phase phase);
		super.build_phase (phase);
		if (! uvm_config_db #(virtual my_interface) :: get (this, "", "my_interface", my_interface_h)) 
			`uvm_fatal (get_type_name (), "Didn't get handle to virtual interface dut_if")
	endfunction
          
	task run_phase (uvm_phase phase);
		super.run_phase (phase);
      	
      	// INIT signal before stimulus
      	my_interface_h.paddr = 32'h0;
        my_interface_h.prdata = 32'h0;
      	my_interface_h.pwdata = 32'h0;
        my_interface_h.pwrite = 1'b0;
        my_interface_h.psel = 1'b0;
        my_interface_h.penable = 1'b0;
		my_interface_h.pready = 1'bZ;
			forever begin
            	seq_item_port.get_next_item (req);
            	`uvm_info (get_type_name (), $sformatf ("Recived data from sequencer"), UVM_MEDIUM)
              	drive_item (req);
				seq_item_port.item_done ();
			end
	endtask
 
	virtual task drive_item (apb_sequence_item req); // Nedostaje mi jedna transakcija, procitati sinhro D->S
		@(posedge my_interface_h.clk);
      		
      		// IDLE state (check this from diagram)
      		repeat (req.delay) 
            	@(posedge my_interface_h.clk);
      
            //SETUP WRITE Phase
      			if (req.mode == WRITE)
            	begin
					my_interface_h.pwrite <= req.mode; // Write is 1 in enum 
					my_interface_h.paddr = req.paddr;
					my_interface_h.pwdata = req.pwdata;
					my_interface_h.psel <=1;
					// ACTIVE Phase
                  	repeat (1) 
						@(posedge my_interface_h.clk);
						my_interface_h.penable <=1;
              end           	
           		
   
		endtask
  


      
  	
	

endclass:apb_driver
 