
class scoreboard extends uvm_scoreboard;
	`uvm_component_utils(scoreboard)
	uvm_tlm_analysis_fifo #(trans)inp_mon_fifo;
	uvm_tlm_analysis_fifo #(trans)out_mon_fifo;

	trans inp_mon_xn;
	trans out_mon_xn;
	
 function new(string name="scoreboard",uvm_component parent);
	super.new(name,parent);
	inp_mon_fifo=new("inp_mon_fifo",this);
	out_mon_fifo=new("out_mon_fifo",this);
 endfunction

 task run_phase(uvm_phase phase);
	forever
		begin
		inp_mon_fifo.get(inp_mon_xn);
		out_mon_fifo.get(out_mon_xn);
				
		ref_model(inp_mon_xn);
	   	`uvm_info("REFERENCE_MODEL",$sformatf("REFERENCE_MODEL  : OA =%d  | OB =%d |cin=%d  |ce=%d  | inp_valid=%d | cmd=%d  | mode=%d  |",inp_mon_xn.OA ,inp_mon_xn.OB ,inp_mon_xn.cin,inp_mon_xn.ce ,inp_mon_xn.inp_valid ,inp_mon_xn.cmd ,inp_mon_xn.mode ),UVM_NONE)

		check_Data(out_mon_xn);
		
		 
		end
 endtask




 task check_Data(trans ch);
	begin
	   if(inp_mon_xn.res == ch.res)
		$display("\n RES IS  MATCHING  : dut_res=%d  | ref_res =%d", ch.res , inp_mon_xn.res);
	   else
		$display("\n RES IS NOT MATCHING : dut_res=%d  | ref_res =%d", ch.res , inp_mon_xn.res);

           if(inp_mon_xn.err == ch.err)
		$display("\n ERR IS MATCHING : dut_err=%d  | ref_err =%d", ch.err , inp_mon_xn.err);
	   else
		$display("\n ERR IS NOT MATCHING : dut_err=%d  | ref_err =%d", ch.err , inp_mon_xn.err);

	   if(inp_mon_xn.cout == ch.cout)
		$display("\n COUT IS MATCHING  : dut_cout=%d  | ref_cout =%d", ch.cout , inp_mon_xn.cout);
	   else
		$display("\n COUT IS NOT MATCHING  : dut_cout=%d  | ref_cout =%d", ch.cout , inp_mon_xn.cout);

	    if(inp_mon_xn.oflow == ch.oflow)
		$display("\n OFLOW IS MATCHING  : dut_oflow=%d  | ref_oflow =%d", ch.oflow , inp_mon_xn.oflow);
	   else
		$display("\n OFLOW IS NOT MATCHING  : dut_oflow=%d  | ref_oflow =%d", ch.oflow , inp_mon_xn.oflow);

            if(inp_mon_xn.G == ch.G)
		$display("\n Greater IS MATCHING  : dut_G=%d  | ref_G =%d", ch.G , inp_mon_xn.G);
	   else
		$display("\n Greater IS NOT MATCHING : dut_G=%d  | ref_G =%d", ch.G , inp_mon_xn.G);

	   if(inp_mon_xn.L == ch.L)
		$display("\n Lesser IS MATCHING  : dut_L=%d  | ref_L =%d", ch.L , inp_mon_xn.L);
	   else
		$display("\n Lesser IS NOT MATCHING : dut_L=%d  | ref_L =%d", ch.L , inp_mon_xn.L);

            if(inp_mon_xn.E == ch.E)
		$display("\n Equal IS MATCHING : dut_E=%d  | ref_E =%d", ch.E , inp_mon_xn.E);
	   else
		$display("\n Equal IS NOT MATCHING : dut_E=%d  | ref_E =%d", ch.E , inp_mon_xn.E);
	end
 endtask
	

 virtual task ref_model(trans t);
     bit[7:0]oprd1,oprd2;
     bit[3:0]CMD_tmp;
     bit[7:0]AU_out_tmp1,AU_out_tmp2,OPA_1,OPB_1;
     static int wait_cnt = 0;
     static bit oprd1_valid = 0;
     static bit oprd2_valid = 0;

       if(t.rst) begin
        oprd1=0;
        oprd2=0;
        CMD_tmp=0;
        wait_cnt=0;
        oprd1_valid=0;
        oprd2_valid=0;
      end
      else if (t.inp_valid==2'b01)  begin    
        oprd1=t.OA;
        CMD_tmp=t.cmd;
        oprd1_valid=1;
        if(!oprd2_valid) wait_cnt=0;
      end
      else if (t.inp_valid==2'b10)  begin    
        oprd2=t.OB;
        CMD_tmp=t.cmd;
        oprd2_valid=1;
        if(!oprd1_valid) wait_cnt=0;
      end
      else if (t.inp_valid==2'b11)  begin    
        oprd1=t.OA;
	oprd2=t.OB;
        CMD_tmp=t.cmd;
        oprd1_valid=1;
        oprd2_valid=1;
        wait_cnt=0;
      end
      else begin    
        if ((oprd1_valid ^ oprd2_valid)) begin
          wait_cnt++;
        end
      end 

     if(t.ce)                   
        begin
         if(t.rst)                
          begin
            t.res=9'd0;
            t.cout=1'b0;
            t.oflow=1'b0;
            t.G=1'b0;
            t.E=1'b0;
            t.L=1'b0;
            t.err=1'b0;
	    AU_out_tmp1=0;
            AU_out_tmp2=0;
	  end
         else if (wait_cnt > 16) begin
            t.res=9'd0;
            t.cout=1'b0;
            t.oflow=1'b0;
            t.G=1'b0;
            t.E=1'b0;
            t.L=1'b0;
            t.err=1'b1;
            oprd1_valid=0;
            oprd2_valid=0;
            wait_cnt=0;
         end

         else if(t.mode)          
         begin
            t.res=9'd0;
            t.cout=1'b0;
            t.oflow=1'b0;
            t.G=1'b0;
            t.E=1'b0;
            t.L=1'b0;
            t.err=1'b0;
	case(CMD_tmp)             
    4'b0000: begin        
	     
	              t.res=oprd1+oprd2;
	      t.cout=t.res[8]?1:0; 
            end
     4'b0001 :begin
                 
             t.oflow=(oprd1<oprd2)?1:0;
             t.res=oprd1-oprd2; 
            end
     4'b0010:            
            begin
             t.res=oprd1+oprd2+t.cin;
             t.cout=t.res[8]?1:0;
            end
     4'b0011:             
            begin
             t.oflow=(oprd1<oprd2)?1:0;
             t.res=oprd1-oprd2-t.cin;
            end
     4'b0100:t.res=oprd1+1;     
     4'b0101:t.res=oprd1-1;    
     4'b0110:t.res=oprd2+1;     
     4'b0111:t.res=oprd2-1; 
     4'b1000:             
            begin
             t.res=9'b0;
             if(oprd1==oprd2)
              begin
                t.E=1'b1;
                t.G=1'b0;
                t.L=1'b0;
              end
             else if(oprd1>oprd2)
              begin
                t.E=1'b0;
                t.G=1'b1;
                t.L=1'b0;
              end
             else 
              begin
                t.E=1'b0;
                t.G=1'b0;
                t.L=1'b1;
              end
            end

	4'b1001: begin   
                    AU_out_tmp1 = oprd1 + 1;
                    AU_out_tmp2 = oprd2 + 1;
                    t.res =AU_out_tmp1 * AU_out_tmp2;
                  end
	4'b1010: begin   
                    AU_out_tmp1 = oprd1 << 1;
                    AU_out_tmp2 = oprd2;
                    t.res =AU_out_tmp1 * AU_out_tmp2; 
                  end

	default:   
            begin
            t.res=9'b0;
            t.cout=1'b0;
            t.oflow=1'b0;
            t.G=1'b0;
            t.E=1'b0;
            t.L=1'b0;
            t.err=1'b0;
           end
          endcase
         end

	else          
        begin 
            t.res=9'b0;
            t.cout=1'b0;
            t.oflow=1'b0;
            t.G=1'b0;
            t.E=1'b0;
            t.L=1'b0;
            t.err=1'b0;
	case(CMD_tmp)    
             4'b0000:t.res={1'b0,oprd1&oprd2};     
             4'b0001:t.res={1'b0,~(oprd1&oprd2)};
	     4'b0010:t.res={1'b0,oprd1|oprd2};  
	     4'b0011:t.res={1'b0,~(oprd1|oprd2)};
	     4'b0100:t.res={1'b0,oprd1^oprd2};     
             4'b0101:t.res={1'b0,~(oprd1^oprd2)};  
	     4'b0110:t.res={1'b0,~oprd1};       
             4'b0111:t.res={1'b0,~oprd2};       
	     4'b1000:t.res={1'b0,oprd1>>1};       
             4'b1001:t.res={1'b0,oprd1<<1};
	     4'b1010:t.res={1'b0,oprd2>>1};      
             4'b1011:t.res={1'b0,oprd2<<1};      
	     4'b1100:                        
             begin 
               if(oprd2[0])
                 OPA_1 = {oprd1[6:0], oprd1[7]};
               else
                 OPA_1 = oprd1;
 
               if(oprd2[1])
                 OPB_1 =  {OPA_1[5:0], OPA_1[7:6]}; 
               else
                 OPB_1= OPA_1;
 
               if(oprd2[2])
                 t.res =  {OPB_1[3:0], OPB_1[7:4]} ;
               else
                 t.res = OPB_1;
 
               if(oprd2[4] | oprd2[5] | oprd2[6] | oprd2[7])
                 t.err=1'b1;
             end

	4'b1101:                        
             begin
               if(oprd2[0])
                 OPA_1 = {oprd1[0], oprd1[7:1]};
               else
                 OPA_1 = oprd1;
               if(oprd2[1])
                 OPB_1 =  {OPA_1[1:0], OPA_1[7:2]}; 
               else
                 OPB_1= OPA_1;
               if(oprd2[2])
                 t.res =  {OPB_1[3:0], OPB_1[7:4]} ;
               else
                 t.res = OPB_1;
               if(oprd2[4] | oprd2[5] | oprd2[6] | oprd2[7])
                 t.err=1'b1;
             end
             default:    
               begin
               t.res=9'b0;
               t.cout=1'b0;
               t.oflow=1'b0;
               t.G=1'b0;
               t.E=1'b0;
               t.L=1'b0;
               t.err=1'b0;
               end
          endcase
     end
    end
endtask 

endclass


