class apb_driver extends uvm_driver #(apb_sequence_item);
	`uvm_component_utils (apb_driver)
  	
  	apb_cfg driver_cfg_h; // Holds vitrual interface
	virtual apb_interface apb_interface_h;			// Mogao bih da dodam initial reset u drajveru, RESET pronaci u UVM cookbook
  
	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction

  
	virtual function void build_phase (uvm_phase phase);
		super.build_phase (phase);
		
      	if (! uvm_config_db #(apb_cfg) :: get (this, "", "apb_agent_cfg_h", driver_cfg_h)) 
          `uvm_fatal (get_type_name (), "Didn't get configuration object")
          apb_interface_h = driver_cfg_h.apb_interface_h;
	endfunction
         
	task init_driver();
		// INIT signal before stimulus
      	apb_interface_h.paddr <= 32'h0;
      	apb_interface_h.pwdata <= 32'h0;
        apb_interface_h.pwrite <= 1'b0;
        apb_interface_h.psel <= 1'b0;
        apb_interface_h.penable <= 1'b0;
    endtask

	task run_phase (uvm_phase phase);
		super.run_phase (phase);
      	init_driver();

			forever begin
            	seq_item_port.get_next_item (req);
              	drive_item ();
				seq_item_port.item_done ();
			end
	endtask
 
	virtual task drive_item (); 
/*
		@(posedge apb_interface_h.rst) // Reset se drugacije hendluje
			begin 
				apb_interface_h.paddr <= 32'h0;
				apb_interface_h.pwdata <= 32'h0;

			end
*/
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
