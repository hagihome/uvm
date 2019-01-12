`ifndef __<UVC_NAME>_AGNET_SVH__
`define __<UVC_NAME>_AGENT_SVH__

class <uvc_name>_agent extends uvm_agent;
  // properties
  <uvc_name>_config  m_cfg;

  // constraints

  // components
  <uvc_name>_driver  drv;
  <uvc_name>_monitor mon;
  uvm_sequencer#(<uvc_name>_seq_item) seqr;
  uvm_analysis_port#(<uvc_name>_seq_item) ap; 

  // UVM functions
  `uvm_component_utils(<uvc_name>_agent)

  function new ( string name, uvm_component parent=null);
    super.new(name,parent);
    is_active = UVM_ACTIVE;
  endfunction:new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if(!uvm_config_db#(<uvc_name>_config)::get(this,"","cfg",m_cfg))
      m_cfg = <uvc_name>_config::type_id::create("cfg");
    
    mon = <uvc_name>_monitor::type_id::create("mon",this);
    ap = new("ap",this);
    if(is_active==UVM_ACTIVE) begin
      drv = <uvc_name>_driver::type_id::create("drv",this);
      seqr = uvm_sequencer#(<uvc_name>_seq_item)::type_id::create("seqr",this);
    end
    // drv and mon build configuration
  endfunction:build_phase

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    mon.ap.connect(ap); 
    if(is_active==UVM_ACTIVE) begin
      drv.seq_item_port.connect(seqr.seq_item_export);
    end
  endfunction:connect_phase

  virtual function void start_of_simulation_phase(uvm_phase phase);
    // uvc configuraiton
  endfunction:start_of_simulation_phase

endclass:<uvc_name>_agent

`endif // __<UVC_NAME>_AGNET_SVH__

