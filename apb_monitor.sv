class apb_monitor extends uvm_monitor;
	`uvm_component_utils (apb_monitor)

  	virtual my_interface my_interface_h;
  	uvm_analysis_port #(apb_sequence_item)   monitor_analysis_port;
  
  
	function new (string name, uvm_component parent= null);
    	super.new (name, parent);
	endfunction
  	
  virtual function void build_phase(uvm_phase phase);
		super.build_phase (phase);
    
		monitor_analysis_port = new("monitor_analysis_port",this);
		if (! uvm_config_db #(virtual my_interface) :: get (this, "", "my_interface", my_interface_h)) 
			`uvm_fatal (get_type_name (), "Didn't get handle to virtual interface my_interface")
     endfunction
          
	virtual task run_phase(uvm_phase phase);
		// Kreiraj paket pokupi sa magistrale sta treba
      	apb_sequence_item  monitor_data =  apb_sequence_item::type_id::create("monitor_data",this);
      	forever begin
			   @(posedge my_interface_h.clk);
          		begin
                monitor_data.paddr<=32'h0;
                monitor_data.pwdata=32'h0;
                monitor_data.mode=NONE;
                  @(negedge my_interface_h.penable); // Select, Penable,Pready
                    	begin
                          monitor_data.paddr = my_interface_h.paddr;
                          monitor_data.prdata = my_interface_h.prdata;
                          monitor_data.pwdata = my_interface_h.pwdata;
							// Sada ovde ne znam delay i koje je operacija to opeglati
                          if (my_interface_h.pwrite)
                            begin
                              monitor_data.mode = WRITE;
                          	 monitor_data.delay = 0; // Do I need delay for scoreboard? For now it is 0
                          	 monitor_data.print();
                            end

                          if(!my_interface_h.pwrite)
                            begin
                              monitor_data.mode = READ;
                              monitor_data.delay = 0;
                              monitor_data.print();
                            end
                      end//negedege  
              end//posedge
            end//forever
      endtask
      
      

  
  
endclass:apb_monitor