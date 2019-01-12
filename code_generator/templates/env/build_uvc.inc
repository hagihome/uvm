    begin:build_<uvc_name>
      <uvc_inst_name>_cfg = <uvc_name>_config::type_id::create("<uvc_inst_name>_cfg");
      uvm_config_db#(<uvc_name>_config)::set( this, "<uvc_inst_name>", "cfg", <uvc_inst_name>_cfg);
      <uvc_inst_name> = <uvc_name>_agent::type_id::create("<uvc_inst_name>",this);
    end:build_<uvc_name>
