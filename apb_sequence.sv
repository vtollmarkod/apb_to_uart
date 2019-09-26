
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


/*
read_modify_write je osnovna sekvenca
*/
