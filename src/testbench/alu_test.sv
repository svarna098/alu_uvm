

class test extends uvm_test;
	`uvm_component_utils(test)

 env env_h;
 alu_config m_cfg;

 function new(string name="test",uvm_component parent);
	super.new(name,parent);
 endfunction

 function void build_phase(uvm_phase phase);
	super.build_phase(phase);

  m_cfg=alu_config::type_id::create("m_cfg");
  //virtual_get
  if(!uvm_config_db#(virtual alu_if)::get(this,"","alu_if",m_cfg.vif))
	`uvm_fatal(get_type_name,"Can't get the interface")
  m_cfg.input_agent_is_active=UVM_ACTIVE;
  m_cfg.output_agent_is_active=UVM_PASSIVE;

  uvm_config_db#(alu_config)::set(this,"*","alu_config",m_cfg);

  env_h=env::type_id::create("env_h",this);

 endfunction

 function void end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
   uvm_top.print_topology();
endfunction



endclass


class test1 extends test;
  `uvm_component_utils(test1)

  seq s1;
  seq_1 s2;
  mul_seq s3;
  err_seq e1;
  wait_seq s4;
  wait_seq_err s5;
  wait_seq_logical s6;
  wait_seq_logical_err s7;
  wait_seq_mul s8;
  wait_seq_mul_err s9;
  wait_seq_logical1 s10;
  wait_seq1 s11;
  wait_seq_11 s12;
  wait_seq_oprd1 s13;
  wait_seq_oprd2 s14;
  wait_seq_none_valid s15;
  wait_seq_logical_11 s16;
  wait_seq_mul_11 s17;
  ce_low_mul s18;
   seq_ce_low s19;
  seq_1_ce_low s20;
  fec_xor_seq s21;
  fec_valid_01 s22;
  wait_seq_oprd s23;

  function new(string name="test1", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    s1  = seq::type_id::create("s1");
    s2  = seq_1::type_id::create("s2");
    s3  = mul_seq::type_id::create("s3");
    e1  = err_seq::type_id::create("e1");
    s4  = wait_seq::type_id::create("s4");
    s5  = wait_seq_err::type_id::create("s5");
    s6  = wait_seq_logical::type_id::create("s6");
    s7  = wait_seq_logical_err::type_id::create("s7");
    s8  = wait_seq_mul::type_id::create("s8");
    s9  = wait_seq_mul_err::type_id::create("s9");
    s10 = wait_seq_logical1::type_id::create("s10");
    s11 = wait_seq1::type_id::create("s11");
    s12 = wait_seq_11::type_id::create("s12");
    s13 = wait_seq_oprd1::type_id::create("s13");
    s14 = wait_seq_oprd2::type_id::create("s14");
    s15 = wait_seq_none_valid::type_id::create("s15");
    s16 = wait_seq_logical_11::type_id::create("s16");
    s17 = wait_seq_mul_11::type_id::create("s17");
    s18 = ce_low_mul::type_id::create("s18");
     s19 = seq_ce_low::type_id::create("s19");
     s20 = seq_1_ce_low::type_id::create("s20");
     s21 = fec_xor_seq::type_id::create("s21");
      s22 = fec_valid_01 ::type_id::create("s22");
      s23 = wait_seq_oprd::type_id::create("s23");

    fork
      begin
        s1.start(env_h.inp_agt_h.seqr_h);
        s2.start(env_h.inp_agt_h.seqr_h);
        s3.start(env_h.inp_agt_h.seqr_h);
        e1.start(env_h.inp_agt_h.seqr_h);
        s4.start(env_h.inp_agt_h.seqr_h);
        s5.start(env_h.inp_agt_h.seqr_h);
        s6.start(env_h.inp_agt_h.seqr_h);
        s7.start(env_h.inp_agt_h.seqr_h);
        s8.start(env_h.inp_agt_h.seqr_h);
        s9.start(env_h.inp_agt_h.seqr_h);
        s10.start(env_h.inp_agt_h.seqr_h);
        s11.start(env_h.inp_agt_h.seqr_h);
        s12.start(env_h.inp_agt_h.seqr_h);
        s13.start(env_h.inp_agt_h.seqr_h);
        s14.start(env_h.inp_agt_h.seqr_h);
        s15.start(env_h.inp_agt_h.seqr_h);
        s16.start(env_h.inp_agt_h.seqr_h);
        s17.start(env_h.inp_agt_h.seqr_h);
        s18.start(env_h.inp_agt_h.seqr_h);
          s19.start(env_h.inp_agt_h.seqr_h);
          s20.start(env_h.inp_agt_h.seqr_h);
        s21.start(env_h.inp_agt_h.seqr_h);
	 s22.start(env_h.inp_agt_h.seqr_h);
	 s23.start(env_h.inp_agt_h.seqr_h);


     
      end
    join

    #50;
    phase.drop_objection(this);
  endtask
endclass

