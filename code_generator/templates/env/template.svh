`ifndef __<ENV_NAME>_SVH__
`define __<ENV_NAME>_SVH__
class <env_name> extends uvm_env;
  // properties

  // constraints

  // components
<declare_uvcs>

  <env_name>_virtual_sequencer vseqr;

  // uvm_default
  `uvm_component_utils(<env_name>)

  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction:new

  virtual function void build_phase( uvm_phase phase);
    super.build_phase(phase);
    vseqr = <env_name>_virtual_sequencer::type_id::create("vseqr",this);
<build_uvcs>
  endfunction:build_phase

  virtual function void connect_phase( uvm_phase phase);
    super.connect_phase(phase);
<connect_vseqr>
  endfunction:connect_phase

  virtual function void end_of_elaboration_phase( uvm_phase phase);
    super.end_of_elaboration_phase(phase);
  endfunction:end_of_elaboration_phase
endclass:<env_name>
`endif //__<ENV_NAME>_SVH__

