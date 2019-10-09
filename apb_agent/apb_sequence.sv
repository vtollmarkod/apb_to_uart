class uart_write_sequence extends uvm_sequence #(apb_sequence_item);
	`uvm_object_utils(uart_write_sequence)


	function new (string name = "");
		super.new(name);
	endfunction

	task body(); // Taske krecu paralelno !!!

		req = apb_sequence_item::type_id::create("req");

		start_item(req);
		 if( !req.randomize() with {
                  // Setup phase for READ
                    mode == WRITE;
                    paddr == 32'h0000_0000;
					pwdata == 32'h000_0001;
					delay == 0;
                  })
                  `uvm_error("", "Randomize failed")
        finish_item(req);  

		repeat (20) 
			begin
				start_item(req); // Sinhronizovati pakete na neki nacin !!!
				 if( !req.randomize() with {
		                  // Setup phase for READ
		                    mode == WRITE;
		                    paddr ==  32'h4000_0000;
							delay == 0;
		                  })
		                  `uvm_error("", "Randomize failed")
		        finish_item(req);
        end//repeat            
	endtask


endclass:uart_write_sequence

/*
The second is when you are layering sequences on the same sequencer. Each sequence is modeling a particular set 
of ordered constraints on the sequence_item. You're moving some of the randomness out of the item and putting 
it into the arbitration in the sequencer or in the sequence itself. For example, you have two types of traffic 
with a specific ordering that needs to go through the same port.
https://verificationacademy.com/forums/ovm/fork/join-sequence-body
*/






 







// READ SEQUENCES 
class apb_read_sequence extends uvm_sequence #(apb_sequence_item);
	`uvm_object_utils (apb_read_sequence)

	function new (string name = "");
		super.new(name);
	endfunction

	task body();
      	repeat(1)
			begin
              req = apb_sequence_item::type_id::create("req");
              start_item(req);
              if( !req.randomize() with {
                  // Setup phase for READ
                      mode == READ;
                  })
                  `uvm_error("", "Randomize failed")
              finish_item(req);
            end
	endtask:body
endclass:apb_read_sequence

// WRITE SEQUENCE
class apb_write_sequence extends uvm_sequence #(apb_sequence_item);
	`uvm_object_utils(apb_write_sequence)

	function new(string name = "");
		super.new(name);
	endfunction

	task body();
      repeat(1)
			begin
              req = apb_sequence_item::type_id::create("req");
              start_item(req);

              if( !req.randomize() with {
                  // Setup phase for WRITE
                      mode == WRITE;
                  })
                  `uvm_error("", "Randomize failed")
              finish_item(req);
            end
	endtask:body
endclass:apb_write_sequence

/* OVO TESTIRATI PREKO VIRTUELNOG SEKVENCERA
//  READ/WRITE SEQUENCES
class apb_read_write_sequence extends uvm_sequence #(apb_sequence_item);
	`uvm_object_utils(apb_read_write_sequence)

	function new(string name = "");
		super.new(name);
	endfunction

	rand int n;
	constraint n_constraint { n inside {[10:15]}; }

	task body();
		apb_read_sequence req_read;
		apb_write_sequence req_write;
		`uvm_info("", $sformatf("UKUPAN BROJ SEKVENCI=%d", n), UVM_MEDIUM);
		for (int i=0; i<n; i++)
			begin
				if (i%2 == 0)
					begin
						req_read = apb_read_sequence::type_id::create("req_read");
						req_read.start(m_sequencer,this);
					end
      			else
      				begin
						req_write = apb_write_sequence::type_id::create("req_write");
						req_write.start(m_sequencer,this);
      				end
      		end//for
	endtask:body
endclass:apb_read_write_sequence


*/