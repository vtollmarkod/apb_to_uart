class uart_monitor extends uvm_monitor;
	`uvm_component_utils (uart_monitor)

	virtual uart_interface uart_interface_h;
	uvm_analysis_port #(uart_sequence_item)  uart_monitor_analysis_port; 
	
	int data_lenght=30; // Koliko sistemskih klokova traje simbol
	bit [7:0] data; // Recived data
	bit reciving_data_progres =0;
  	enum {VALID, CORRUPTED} recived_data_check;

	function new (string name, uvm_component parent= null);
    	super.new (name, parent);
	endfunction

	virtual function void build_phase (uvm_phase phase);
		super.build_phase (phase);

		uart_monitor_analysis_port = new("uart_monitor_analysis_port",this);
		if (! uvm_config_db #(virtual uart_interface) :: get (this, "", "uart_interface", uart_interface_h)) 
				begin `uvm_fatal (get_type_name (), "Didn't get handle to virtual interface apb_interface") end
    endfunction

    virtual task run_phase(uvm_phase phase);
      	uart_sequence_item uart_data = uart_sequence_item::type_id::create ("uart_data",this);
      	recived_data_check = CORRUPTED; // Just to ensure not to send data before check START and STOP bit
    	forever begin
			//Reciving data
            @(posedge uart_interface_h.tx iff reciving_data_progres == 0) // Transimition started
                begin
                    reciving_data_progres = 1; // Block reciving data

                    // Wait START bit
                    repeat(data_lenght/2) 
                        @(posedge uart_interface_h.clk)

           			// Check START bit
                    if (uart_interface_h.clk == 0)
                    	recived_data_check = VALID;
                    else
                    	recived_data_check = CORRUPTED;

                    // Sample DATA bits MSB -> LSB
                    for (int i=0 ; i<8 ; i++)
                        begin
                            repeat(data_lenght)
                                @(posedge uart_interface_h.clk) // ==== Proveriti ovaj deo !
                        data[i] = uart_interface_h.tx; 
                        end
                    // Wait STOP bit
                    repeat(data_lenght)
                        @(posedge uart_interface_h.clk)

                    // Check STOP bit
                    if (uart_interface_h.clk == 1)
                    	recived_data_check = VALID;
                  	else
                      recived_data_check = CORRUPTED;

                    // STOP bit is 1, now it is safe to enable detecting new START bit
                  if (recived_data_check == VALID)
					begin
						uart_data.frame <= data;
                    	reciving_data_progres <= 0;
						recived_data_check <= CORRUPTED;
                    end
                end//posedge
    		
        end//forever
    endtask
endclass:uart_monitor