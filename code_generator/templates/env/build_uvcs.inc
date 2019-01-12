    for( int num=0; num<<uvc_num>; num++ ) begin
      string cfg_name = \$sformatf("<uvc_inst_name>_cfg[%0d]",num);
      string inst_name= \$sformatf("<uvc_inst_name>[%0d]",num);
      <uvc_inst_name>_cfg[num] = <uvc_name>_config::type_id::create(cfg_name);
      uvm_config_db#(<uvc_name>_config)::set( this,inst_name,"cfg",<uvc_inst_name>_cfg[num]);
      <uvc_inst_name>[num] = <uvc_name>_agent::type_id::create(inst_name, this);
    end
