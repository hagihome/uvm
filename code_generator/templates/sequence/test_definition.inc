class <seq_name>_test extends uvm_test;
  \/\/ components
  <env_name> env;
  <seq_name>_sequence seq;
  \/\/ UVM default
  `uvm_component_utils(<seq_name>_test)

  function new ( string name="<seq_name>_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction:new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = <env_name>::type_id::create("env",this);
    seq = <seq_name>_sequence::type_id::create("<seq_name>_seq");
  endfunction:build_phase

  virtual task run_phase( uvm_phase phase );
    phase.raise_objection(this);
    \/\/ seq.randomize();
    seq.start(env.vseqr);
    phase.drop_objection(this);
  endtask:run_phase
endclass:<seq_name>_test

