package <env_name>_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"

<import_uvcs>

  `include "<env_name>_virtual_sequencer.svh"
  `include "<env_name>_virtual_sequence.svh"
  `include "<env_name>.svh"
endpackage
