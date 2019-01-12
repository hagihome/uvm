`ifndef __<UVC_NAME>_CONFIG_SVH__
`define __<UVC_NAME>_CONFIG_SVH__
class <uvc_name>_config extends uvm_object;
  // properties
  // TODO: 

  // UVM default
  `uvm_object_utils(<uvc_name>_config)
  function new (string name="<uvc_name>_config");
    super.new(name);
  endfunction:new
endclass:<uvc_name>_config
`endif //__<UVC_NAME>_CONFIG_SVH__

