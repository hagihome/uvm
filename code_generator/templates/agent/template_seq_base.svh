`ifndef __<UVC_NAME>_SEQ_BASE_SVH__
`define __<UVC_NAME>_SEQ_BASE_SVH__
class <uvc_name>_seq_base extends uvm_sequence#(<uvc_name>_seq_item);
  `uvm_object_utils(<uvc_name>_seq_base)
  `uvm_declare_p_sequencer(uvm_sequencer#(<uvc_name>_seq_item))
  function new(string name="<uvc_name>_seq_base");
    super.new(name);
  endfunction:new
  task body();
  endtask:body
endclass:<uvc_name>_seq_base

`endif //__<UVC_NAME>_SEQ_BASE_SVH__

