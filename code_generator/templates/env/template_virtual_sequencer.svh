`ifndef __<ENV_NAME>_VIRTUAL_SEQUENCER_SVH__
`define __<ENV_NAME>_VIRTUAL_SEQUENCER_SVH__
class <env_name>_virtual_sequencer extends uvm_sequencer;
  // component handle
<declare_uvc_handle>

  // uvc sequencer

  // UVM default
  `uvm_component_utils(<env_name>_virtual_sequencer)

  function new ( string name, uvm_component parent);
    super.new(name,parent);
  endfunction:new

endclass
`endif //__<ENV_NAME>_VIRTUAL_SEQUENCER_SVH__
