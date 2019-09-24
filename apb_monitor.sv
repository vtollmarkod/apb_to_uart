class apb_monitor extends uvm_monitor;
	`uvm_component_utils (apb_monitor)

  	virtual apb_interface apb_interface_h;
  	uvm_analysis_port #(apb_sequence_item)   monitor_analysis_port;
  
  
	function new (string name, uvm_component parent= null);
    	super.new (name, parent);
	endfunction
  	
  virtual function void build_phase(uvm_phase phase);
		super.build_phase (phase);
    
		monitor_analysis_port = new("monitor_analysis_port",this);
		if (! uvm_config_db #(virtual apb_interface) :: get (this, "", "apb_interface", apb_interface_h)) 
			`uvm_fatal (get_type_name (), "Didn't get handle to virtual interface apb_interface")
     endfunction
          
	virtual task run_phase(uvm_phase phase);
		// Kreiraj paket pokupi sa magistrale sta treba
      	apb_sequence_item  monitor_data =  apb_sequence_item::type_id::create("monitor_data",this);
      	forever begin
			   @(posedge apb_interface_h.clk);
          		begin
                monitor_data.paddr<=32'h0;
                monitor_data.pwdata=32'h0;
                monitor_data.mode=NONE;
                  @(negedge apb_interface_h.penable); // Select, Penable,Pready
                    	begin
                          monitor_data.paddr = apb_interface_h.paddr;
                          monitor_data.prdata = apb_interface_h.prdata;
                          monitor_data.pwdata = apb_interface_h.pwdata;
							// Sada ovde ne znam delay i koje je operacija to opeglati
                          if (apb_interface_h.pwrite)
                            begin
                              monitor_data.mode = WRITE;
                          	 monitor_data.delay = 0; // Do I need delay for scoreboard? For now it is 0
                          	 `uvm_info (get_type_name (), $sformatf ("Monitor WRITE packet"), UVM_MEDIUM)
                             monitor_data.print();
                            end

                          if(!apb_interface_h.pwrite)
                            begin
                              monitor_data.mode = READ;
                              monitor_data.delay = 0;
                              `uvm_info (get_type_name (), $sformatf ("Monitor READ packet"), UVM_MEDIUM)
                              monitor_data.print();
                            end
                      end//negedege  
              end//posedge
            end//forever
      endtask
      
      // PREBACITI PODATKAK KOJI NE CITAN NA FFFF

  
  
endclass:apb_monitor