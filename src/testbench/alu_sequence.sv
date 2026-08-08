class seq extends uvm_sequence #(trans);
	`uvm_object_utils(seq) 

 function new(string name="seq");
	super.new(name);
 endfunction

 task body();
     
      trans req;
       req=trans::type_id::create("req");
	begin
		for(int i=0;i<=8 ;i=i+1) begin
		   start_item(req);
		   assert(req.randomize() with {mode==1'b1;cmd==i;OA=='d3;OB=='d3; inp_valid ==2'b11;});
		   finish_item(req);  end
	end  
 endtask

 endclass

class seq_1 extends uvm_sequence #(trans);
	`uvm_object_utils(seq_1) 

 function new(string name="seq_1");
	super.new(name);
 endfunction

 task body();
	 trans req;
       req=trans::type_id::create("req");
	begin
		for(int i=0;i<=13;i=i+1) begin
		   start_item(req);
		   assert(req.randomize() with {mode==1'b0;cmd==i;OA=='d10;OB=='d5;inp_valid ==2'b11;});
		   finish_item(req);  end
	end
 endtask

 endclass

class mul_seq extends uvm_sequence #(trans);
	`uvm_object_utils(mul_seq) 

 function new(string name="mul_seq");
	super.new(name);
 endfunction

 task body();
        trans req;
       req=trans::type_id::create("req");
	begin
		for(int i=9 ;i<=10;i=i+1) begin
		   start_item(req);
		   assert(req.randomize() with {mode==1'b1;cmd==i;OA=='d10;OB=='d5;inp_valid==3'd3;});
		   finish_item(req); #30;end
	end
 endtask

 endclass


class err_seq extends uvm_sequence #(trans);
	`uvm_object_utils(err_seq) 

 function new(string name="err_seq");
	super.new(name);
 endfunction

 task body();
        trans req;
       req=trans::type_id::create("req");
	begin
		   start_item(req);
		   assert(req.randomize() with {mode==1'b0;cmd==4'b1100;OA=='d100;OB=='b10000001;inp_valid ==3'd3;});
		   finish_item(req);
	end
 endtask

 endclass

class wait_seq extends uvm_sequence #(trans);
	`uvm_object_utils(wait_seq) 

 function new(string name="wait_seq");
	super.new(name);
 endfunction

 task body();
        trans req;
       req=trans::type_id::create("req");
	begin
		for(int j=0;j<=8;j=j+1)begin
		for(int i=0;i<=2;i=i+1) begin
		   start_item(req);
		   assert(req.randomize() with {mode==1'b1;cmd==j;OA=='d5;OB=='b10;inp_valid ==i;});
		   finish_item(req);#50;end end
	end
 endtask
endclass

 class wait_seq_err extends uvm_sequence #(trans);
	`uvm_object_utils(wait_seq_err) 

 function new(string name="wait_seq_err");
	super.new(name);
 endfunction

 task body();
        trans req;
       req=trans::type_id::create("req");
	begin
		for(int j=0;j<=8;j=j+1)begin
		for(int i=0;i<=2;i=i+1) begin
		   start_item(req);
		   assert(req.randomize() with {mode==1'b1;cmd==j;OA=='d5;OB=='b10;inp_valid ==i;});
		   finish_item(req);#170;end end
	end
 endtask
 endclass

class wait_seq_logical extends uvm_sequence #(trans);
	`uvm_object_utils(wait_seq_logical) 

 function new(string name="wait_seq_logical");
	super.new(name);
 endfunction

 task body();
        trans req;
       req=trans::type_id::create("req");
	begin
		for(int j=0;j<=13;j=j+1)begin
		for(int i=0;i<=2;i=i+1) begin
		   start_item(req);
		   assert(req.randomize() with {mode==1'b0;cmd==j;OA=='d5;OB=='b10;inp_valid ==i;});
		   finish_item(req);#50;end end
	end
 endtask
endclass

class wait_seq_logical_err extends uvm_sequence #(trans);
	`uvm_object_utils(wait_seq_logical_err) 

 function new(string name="wait_seq_logical_err");
	super.new(name);
 endfunction

 task body();
        trans req;
       req=trans::type_id::create("req");
	begin
		for(int j=0;j<=13;j=j+1)begin
		for(int i=0;i<=2;i=i+1) begin
		   start_item(req);
		   assert(req.randomize() with {mode==1'b0;cmd==j;OA=='d5;OB=='b10;inp_valid ==i;});
		   finish_item(req);#50;end end
	end
 endtask
endclass

class wait_seq_mul extends uvm_sequence #(trans);
	`uvm_object_utils(wait_seq_mul) 

 function new(string name="wait_seq_mul");
	super.new(name);
 endfunction

 task body();
        trans req;
       req=trans::type_id::create("req");
	begin
		for(int j=9;j<=10;j=j+1)begin
		for(int i=0;i<=2;i=i+1) begin
		   start_item(req);
		   assert(req.randomize() with {mode==1'b1;cmd==j;OA=='d5;OB=='b10;inp_valid ==i;});
		   finish_item(req);#50;end end
	end
 endtask
endclass

 class wait_seq_mul_err extends uvm_sequence #(trans);
	`uvm_object_utils(wait_seq_mul_err) 

 function new(string name="wait_seq_mul_err");
	super.new(name);
 endfunction

 task body();
        trans req;
       req=trans::type_id::create("req");
	begin
		for(int j=9;j<=10;j=j+1)begin
		for(int i=0;i<=2;i=i+1) begin
		   start_item(req);
		   assert(req.randomize() with {mode==1'b1;cmd==j;OA=='d5;OB=='b10;inp_valid ==i;});
		   finish_item(req);#170;end end
	end
 endtask
 endclass

class wait_seq_logical1 extends uvm_sequence #(trans);
	`uvm_object_utils(wait_seq_logical1) 

 function new(string name="wait_seq_logical1");
	super.new(name);
 endfunction

 task body();
        trans req;
       req=trans::type_id::create("req");
	begin
		for(int j=0;j<=13;j=j+1)begin
		for(int i=1;i>=0;i=i-1) begin
		   start_item(req);
		   assert(req.randomize() with {mode==1'b0;cmd==j;OA=='d5;OB=='b10;inp_valid ==i;});
		   finish_item(req);#50;end end
	          
		  
	end
 endtask
endclass

class wait_seq1 extends uvm_sequence #(trans);
	`uvm_object_utils(wait_seq1) 

 function new(string name="wait_seq1");
	super.new(name);
 endfunction

 task body();
        trans req;
       req=trans::type_id::create("req");
	begin
		for(int j=0;j<=8;j=j+1)begin
		for(int i=1;i>=0;i=i-1) begin
		   start_item(req);
		   assert(req.randomize() with {mode==1'b1;cmd==j;OA=='d5;OB=='b10;inp_valid ==i;});
		   finish_item(req);#50;end end
	end
 endtask
endclass

class wait_seq_11 extends uvm_sequence #(trans);
`uvm_object_utils(wait_seq_11)

function new(string name="wait_seq_11");
super.new(name);
endfunction

task body();
	trans req;
	req=trans::type_id::create("req");
		begin
			for(int j=0;j<=8;j=j+1)begin
				start_item(req);
				assert(req.randomize() with {mode==1'b1;cmd==j;OA=='d5;OB=='d10;inp_valid==2'b11;});
				finish_item(req);#170;
			end
		end
endtask
endclass


class wait_seq_oprd1 extends uvm_sequence #(trans);
`uvm_object_utils(wait_seq_oprd1)

function new(string name="wait_seq_oprd1");
super.new(name);
endfunction

task body();
	trans req;
	req=trans::type_id::create("req");
		begin
			for(int j=0;j<=8;j=j+1)begin
			start_item(req);
			assert(req.randomize() with {mode==1'b1;cmd==j;OA=='d5;OB=='d10;inp_valid==2'b10;});
			finish_item(req);#170;
		end
	end
endtask
endclass


class wait_seq_oprd2 extends uvm_sequence #(trans);
`uvm_object_utils(wait_seq_oprd2)

function new(string name="wait_seq_oprd2");
super.new(name);
endfunction

task body();
	trans req;
	req=trans::type_id::create("req");
		begin
		for(int j=0;j<=8;j=j+1)begin
			start_item(req);
			assert(req.randomize() with {mode==1'b1;cmd==j;OA=='d5;OB=='d10;inp_valid==2'b01;});
			finish_item(req);#170;
		end
	end
endtask
endclass


class wait_seq_none_valid extends uvm_sequence #(trans);
`uvm_object_utils(wait_seq_none_valid)

function new(string name="wait_seq_none_valid");
super.new(name);
endfunction

task body();
	trans req;
	req=trans::type_id::create("req");
		begin
		for(int j=0;j<=8;j=j+1)begin
			start_item(req);
			assert(req.randomize() with {mode==1'b1;cmd==j;OA=='d5;OB=='d10;inp_valid==2'b00;});
			finish_item(req);#170;
			end
		end
endtask
endclass


class wait_seq_logical_11 extends uvm_sequence #(trans);
`uvm_object_utils(wait_seq_logical_11)

function new(string name="wait_seq_logical_11");
super.new(name);
endfunction

task body();
	trans req;
	req=trans::type_id::create("req");
	begin

	for(int j=0;j<=13;j=j+1)begin
	for(int i=0;i<=3;i=i+1) begin
		start_item(req);
		assert(req.randomize() with {mode==1'b0;cmd==j;OA=='d5;OB=='d10;inp_valid==i;});
		finish_item(req);#50;end 

		end
		end
endtask
endclass


class wait_seq_mul_11 extends uvm_sequence #(trans);
`uvm_object_utils(wait_seq_mul_11)

function new(string name="wait_seq_mul_11");
super.new(name);
endfunction

task body();
	trans req;
	req=trans::type_id::create("req");
	begin
	for(int j=9;j<=10;j=j+1)begin
	for (int i=0;i<=3;i=i+1) begin
		start_item(req);
		assert(req.randomize() with {mode==1'b1;cmd==j;OA=='d5;OB=='d10;inp_valid==i;});
		finish_item(req);#50;end

		end
	end
endtask
endclass

/*
class high_bit_ob_seq extends uvm_sequence #(trans);
`uvm_object_utils(high_bit_ob_seq)

function new(string name="high_bit_ob_seq");
super.new(name);
endfunction

task body();
	trans req;
	req=trans::type_id::create("req");
	begin

	for (int i=12;i<=13;i=i+1) begin
	
		start_item(req);
		assert(req.randomize() with {mode==1'b1;cmd==i;OA=='d5;OB==8'b00010000;inp_valid==2'b11;});
		finish_item(req);#50;end


	end
endtask
endclass */





