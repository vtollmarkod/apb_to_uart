
// ONE READ SEQUENCE
class apb_read_sequence extends uvm_sequence #(apb_sequence_item);
	`uvm_object_utils (apb_read_sequence)

	function new (string name = "");
		super.new(name);
	endfunction

	task body();
		req = apb_sequence_item::type_id::create("req");
        start_item(req);
        if( !req.randomize() with {
        	// Setup phase for READ
        		pwrite =='b0; 
        		psel == 'b1; 
        		mode == READ;
        	})
        	`uvm_error("", "Randomize failed")
        finish_item(req);
	endtask:body
endclass:apb_read_sequence

// ONE WRITE SEQUENCE
class apb_write_sequence extends uvm_sequence #(apb_sequence_item);
	`uvm_object_utils(apb_write_sequence)

	function new(string name = "");
		super.new(name);
	endfunction

	task body();
		req = apb_sequence_item::type_id::create("req");
		start_item(req);

		if( !req.randomize() with {
        	// Setup phase for WRITE
        		pwrite == 'b1; 
        		psel == 'b1; 
        		mode == WRITE;
        	})
        	`uvm_error("", "Randomize failed")
        finish_item(req);
	endtask:body
endclass:apb_write_sequence


// MORE READ SEQUENCES
class more_apb_read_sequence extends uvm_sequence #(apb_sequence_item);
	`uvm_object_utils(more_apb_read_sequence)

	function new (string name = "");
		super.new(name);
	endfunction

	rand int n; // knob
	constraint n_constraint { n inside {[6:9]}; }
	
	task body();
		repeat(n);
			begin
				apb_read_sequence req;
				req = apb_read_sequence::type_id::create("req");
				req.start(TODO_SEKVENCER,this); // Zato sto sekvenca zove sekvencu
			end
	endtask:body
endclass:more_apb_read_sequence

// MORE WRITE SEQUENCES
class more_apb_write_sequence extends uvm_sequence #(apb_sequence_item);
	`uvm_object_utils(more_apb_write_sequence)

	function new(string name = "");
		super.new(name);
	endfunction

	rand int n;
	constraint n_constraint { n inside {[6:9]}; }

	task body();
		repeat(n);
			begin
				apb_write_sequence req;
				req = apb_write_sequence::type_id::create("req");
				req.start(TODO_SEKVENCER,this); // Zato sto sekvenca zove sekvencu
			end
	endtask:body
endclass:more_apb_write_sequence

// MORE READ/WRITE SEQUENCES

