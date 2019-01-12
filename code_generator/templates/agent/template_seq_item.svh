`ifndef __<UVC_NAME>_SEQ_ITEM_SVH__
`define __<UVC_NAME>_SEQ_ITEM_SVH__
class <uvc_name>_seq_item extends uvm_sequence_item;
  // properties

  // constraints

  // UVM default
  function new(string name="<uvc_name>_seq_item");
    super.new(name);
  endfunction:new

  function void do_print(uvm_printer printer);
    if(printer.knobs.sprint==0) begin
      `uvm_info(get_name(),convert2string(),UVM_LOW);
    end
    else begin
      printer.m_string = convert2string();
    end
  endfunction:do_print

  function void do_copy(uvm_object rhs);
    <uvc_name>_seq_item _rhs;
    if(!$cast(_rhs,rhs)) begin
      `uvm_error(get_name(),"Cast failed in do_copy()")
      return;
    end
    super.do_copy(rhs);
    // TODO: copy item-specific fiedlds
  endfunction:do_copy
endclass:<uvc_name>_seq_item
`endif //__<UVC_NAME>_SEQ_ITEM_SVH__

