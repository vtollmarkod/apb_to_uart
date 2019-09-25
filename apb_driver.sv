class apb_driver extends uvm_driver #(apb_sequence_item);
	`uvm_component_utils (apb_driver)

  
	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction

	virtual apb_interface apb_interface_h;
  	//apb_sequence_item req;
  
	virtual function void build_phase (uvm_phase phase);
		super.build_phase (phase);
		if (! uvm_config_db #(virtual apb_interface) :: get (this, "", "apb_interface", apb_interface_h)) 
			`uvm_fatal (get_type_name (), "Didn't get handle to virtual interface dut_if")
	endfunction
          
	task run_phase (uvm_phase phase);
		super.run_phase (phase);
      	
      	// INIT signal before stimulus
      	apb_interface_h.paddr = 32'h0;
        apb_interface_h.prdata = 32'h0;
      	apb_interface_h.pwdata = 32'h0;
        apb_interface_h.pwrite = 1'b0;
        apb_interface_h.psel = 1'b0;
        apb_interface_h.penable = 1'b0;
		apb_interface_h.pready = 1'bZ;
			forever begin
            	seq_item_port.get_next_item (req);
            	//`uvm_info (get_type_name (), $sformatf ("Recived data from sequencer"), UVM_MEDIUM)
              	drive_item (req);
				seq_item_port.item_done ();
			end
	endtask
 
	virtual task drive_item (apb_sequence_item req); // Nedostaje mi jedna transakcija, procitati sinhro D->S
      	repeat (req.delay)
           	@(posedge apb_interface_h.clk iff apb_interface_h.rst == 0);
				
      	if (req.mode == WRITE && apb_interface_h.rst == 0)
	    	begin //SETUP WRITE Phase
				apb_interface_h.pwrite <= WRITE; // Write is 1 in enum
				apb_interface_h.psel <= 1; 
				apb_interface_h.paddr <= req.paddr;
				apb_interface_h.pwdata <= req.pwdata;
				// ACTIVE WRITE Phase
				@(posedge apb_interface_h.clk iff apb_interface_h.rst == 0);
					apb_interface_h.penable <= 1;
				// Whait for PREADY
              	@(posedge apb_interface_h.clk iff (apb_interface_h.pready && !apb_interface_h.rst))
						apb_interface_h.psel <= 0;
						apb_interface_h.penable <= 0;
	    	end

	    if(req.mode == READ && apb_interface_h.rst == 0)
	    	begin
	    		apb_interface_h.pwrite <= READ; // Read is 0 in enum
	    		apb_interface_h.psel <= 1;
	    		apb_interface_h.paddr <= req.paddr;
	    		@(posedge apb_interface_h.clk iff apb_interface_h.rst == 0 )
	    			apb_interface_h.penable <=1;
	    		@(posedge apb_interface_h.clk iff (apb_interface_h.pready && !apb_interface_h.rst))
	    				req.prdata <= apb_interface_h.prdata; // Put valid data in req
						apb_interface_h.psel <= 0;
						apb_interface_h.penable <= 0;
			end	   
	endtask

endclass:apb_driver
