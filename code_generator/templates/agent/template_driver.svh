`ifndef __<UVC_NAME>_DRIVER_SVH__
`define __<UVC_NAME>_DRIVER_SVH__
class <uvc_name>_driver extends uvm_driver#(<uvc_name>_seq_item);
  // properties
  <uvc_name>_config m_cfg;

  // constraints

  // components
  virtual <uvc_name>_if vif;

  // UVM default
  `uvm_component_utils(<uvc_name>_driver)
  
  function new( string name, uvm_component parent=null);
    super.new(name,parent);
  endfunction:new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(<uvc_name>_config)::get(this,"","cfg",m_cfg))
      m_cfg = <uvc_name>_config::type_id::create("cfg");
  endfunction:build_phase 

  function void reset_if();
    // TODO:reset interface
  endfunction:reset_if

  virtual task run_phase(uvm_phase phase);
    reset_if();
    forever begin
      seq_item_port.try_next_item(req);
      if(req==null) begin
        reset_if();
        seq_item_port.get_next_item(req);
      end
      asset($cast(rsp,req));
      // TODO:

      // ----
      seq_item_port.item_done(rsp);
    end
  endtask

endclass:<uvc_name>_driver

`endif //__<UVC_NAME>_DRIVER_SVH__
