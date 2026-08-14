class alu_sub extends uvm_subscriber # (trans);
 `uvm_component_utils (alu_sub)

  trans sub;
 
  covergroup cg ;
    a:coverpoint sub.OA {bins b1 ={[1:20]};} 
    b:coverpoint sub.OB { bins c1 ={[1:20]};}
    c:coverpoint sub.inp_valid;
    d:coverpoint sub.cmd { bins a1 ={[0:13]};}
    e:coverpoint sub.mode ;
    g:coverpoint sub.ce;
    h:coverpoint sub.cin;
   cross d,e;
   
  endgroup
 
 function new(string name="alu_sub",uvm_component parent);
super.new(name,parent);
 cg=new();
`uvm_info(get_name,"[MONITOR]:INPUT RECIEVED",UVM_HIGH)
endfunction
 
function void report_phase(uvm_phase phase);
super.report_phase(phase);
    `uvm_info(get_name,$sformatf(" COVERAGE = %0f",cg.get_coverage()),UVM_NONE)
     
  `uvm_info("COVERAGE",$sformatf("OA  = %0.2f%%",cg.a.get_coverage()),UVM_LOW)
     `uvm_info("COVERAGE",$sformatf("OB  = %0.2f%%",cg.b.get_coverage()),UVM_LOW)
     `uvm_info("COVERAGE",$sformatf("inp_valid  = %0.2f%%",cg.c.get_coverage()),UVM_LOW)
       `uvm_info("COVERAGE",$sformatf("cmd  = %0.2f%%",cg.d.get_coverage()),UVM_LOW)
        `uvm_info("COVERAGE",$sformatf("mode  = %0.2f%%",cg.e.get_coverage()),UVM_LOW)
        `uvm_info("COVERAGE",$sformatf("ce  = %0.2f%%",cg.g.get_coverage()),UVM_LOW)
        `uvm_info("COVERAGE",$sformatf("cin  = %0.2f%%",cg.h.get_coverage()),UVM_LOW)
endfunction

 
function void write(trans t);
sub=t;
cg.sample();
endfunction
endclass





