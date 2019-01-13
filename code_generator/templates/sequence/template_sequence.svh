`ifndef __<SEQ_NAME>_SEQUENCE_SVH__
`define __<SEQ_NAME>_SEQUENCE_SVH__
class <seq_name>_sequence extends <base_name>_sequence;
  // properties

  // constraints

  // UVM default

  `uvm_object_utils(<seq_name>_sequence)
<declare_sequencer>

  function new ( string name="<seq_name>_sequence");
    super.new(name);
  endfunction:new

  virtual task body();
  endtask:body
endclass:<seq_name>_sequence

<test_definition>

`endif //__<SEQ_NAME>_SEQUENCE_SVH__

