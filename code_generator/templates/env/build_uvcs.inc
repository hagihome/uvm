    for( int num=0; num<<uvc_num>; num++ ) begin
      <uvc_inst_name>_cfg[num] = <uvc_name>_config::type_id::create($sformatf("<uvc_inst_name>_cfg[%0d]",num));
      uvm_config_db#(<uvc_name>_config)::set( this,"<uvc_inst_name>","cfg",<uvc_inst_name>_cfg);
      <uvc_inst_name>[num] = <uvc_name>_agent::type_id::create($sformatf("<uvc_inst_name>[%0d]",num), this);
    end
