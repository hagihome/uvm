`ifndef __<UVC_NAME>_MONITOR_SVH__
`define __<UVC_NAME>_MONITOR_SVH__
class <uvc_name>_monitor extends uvm_monitor;
  // properties
  <uvc_name>_config m_cfg;

  // constraints

  // components
  uvm_analysis_port#(<uvc_name>_seq_item) ap;

  // UVM default
  `uvm_component_utils(<uvc_name>_monitor)

  function new ( string name, uvm_component parent=null);
    super.new(name,parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    ap = new("ap",this);
    if(!uvm_config_db#(<uvc_name>_config)::get(this,"","cfg",m_cfg))
      m_cfg = <uvc_name>_config::type_id::create("cfg");
  endfunction:build_phase

  virtual task run_phase(uvm_phase phase);
    // TODO
  endtask:run_phase
endclass:<uvc_name>_monitor
`endif //__<UVC_NAME>_MONITOR_SVH__
