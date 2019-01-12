`ifndef __<ENV_NAME>_VIRTUAL_SEQUENCE_SVH__
`define __<ENV_NAME>_VIRTUAL_SEQUENCE_SVH__
class <env_name>_virtual_sequence extends uvm_sequence;
  // properties

  // constrains

  // UVM default

  `uvm_object_utils(<env_name>_virtual_sequence)
  `uvm_declare_p_sequencer(<env_name>_virtual_sequencer)

  function new ( string name="<env_name>_virtual_sequence");
    super.new(name);
  endfunction:new

  virtual task pre_body();
    if(starting_phase!=null) begin
      starting_phase.raise_objection(this);
    end
  endtask:pre_body

  virtual task post_body();
    if(starting_phase!=null) begin
      starting_phase.drop_objection(this);
    end
  endtask:post_body
endclass:<env_name>_virtual_sequence
`endif//__<ENV_NAME>_VIRTUAL_SEQUENCE_SVH__
