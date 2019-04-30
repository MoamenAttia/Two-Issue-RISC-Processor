vsim -gui work.system
# vsim -gui work.system 
# Start time: 11:32:14 on Apr 30,2019
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.numeric_std(body)
# Loading work.system(my_system)
# Loading work.fetch(a_fetch)
# Loading work.inst_ram(a_inst_ram)
# Loading work.ir_buffer(my_ir_buffer)
# Loading work.my_ndff(b_my_ndff)
# Loading work.my_dff(a_my_dff)
# Loading work.pc(my_pc)
# Loading work.nadder(a_nadder)
# Loading work.my_adder(a_my_adder)
# Loading work.decode(a_decode)
# Loading work.control_unit(a_control_unit)
# Loading work.register_file(my_register_file)
# Loading work.decode_execute_buffer(my_decode_execute_buffer)
# Loading work.execute(a_execute)
# Loading work.forwarding_unit(a_forwarding_unit)
# Loading work.mux(behavioural)
# Loading work.alu(a_alu)
# Loading work.addoperations(addbehavioral)
# Loading work.execute_memory_buffer(my_execute_memory_buffer)
# Loading work.memory(a_memory)
# Loading work.data_ram(a_data_ram)
# Loading work.memory_write_back_buffer(my_memory_write_back_buffer)
# ** Warning: (vsim-8683) Uninitialized out port /system/deocode/i1_branch_taken has no driver.
# This port will contribute value (U) to the signal network.
# ** Warning: (vsim-8683) Uninitialized out port /system/deocode/i1_load_use has no driver.
# This port will contribute value (U) to the signal network.
# ** Warning: (vsim-8683) Uninitialized out port /system/deocode/i1_stall_long has no driver.
# This port will contribute value (U) to the signal network.
# ** Warning: (vsim-8683) Uninitialized out port /system/deocode/i2_branch_taken has no driver.
# This port will contribute value (U) to the signal network.
# ** Warning: (vsim-8683) Uninitialized out port /system/deocode/i2_load_use has no driver.
# This port will contribute value (U) to the signal network.
# ** Warning: (vsim-8683) Uninitialized out port /system/deocode/i2_stall_long has no driver.
# This port will contribute value (U) to the signal network.
# ** Warning: (vsim-8683) Uninitialized out port /system/deocode/OUT_bus(15 downto 0) has no driver.
# This port will contribute value (UUUUUUUUUUUUUUUU) to the signal network.
# ** Warning: (vsim-8683) Uninitialized out port /system/Execute/i1_Rdst_Exec_out(3 downto 0) has no driver.
# This port will contribute value (UUUU) to the signal network.
# ** Warning: (vsim-8683) Uninitialized out port /system/Execute/i1_WB_Exec_out has no driver.
# This port will contribute value (U) to the signal network.
# ** Warning: (vsim-8683) Uninitialized out port /system/Execute/i1_stall_long_Exec_out has no driver.
# This port will contribute value (U) to the signal network.
# ** Warning: (vsim-8683) Uninitialized out port /system/Execute/i1_MR_Exec_out has no driver.
# This port will contribute value (U) to the signal network.
# ** Warning: (vsim-8683) Uninitialized out port /system/Execute/i1_MW_Exec_out has no driver.
# This port will contribute value (U) to the signal network.
# ** Warning: (vsim-8683) Uninitialized out port /system/Execute/i2_Rdst_Exec_out(3 downto 0) has no driver.
# This port will contribute value (UUUU) to the signal network.
# ** Warning: (vsim-8683) Uninitialized out port /system/Execute/i2_WB_Exec_out has no driver.
# This port will contribute value (U) to the signal network.
# ** Warning: (vsim-8683) Uninitialized out port /system/Execute/i2_stall_long_Exec_out has no driver.
# This port will contribute value (U) to the signal network.
# ** Warning: (vsim-8683) Uninitialized out port /system/Execute/i2_MR_Exec_out has no driver.
# This port will contribute value (U) to the signal network.
# ** Warning: (vsim-8683) Uninitialized out port /system/Execute/i2_MW_Exec_out has no driver.
# This port will contribute value (U) to the signal network.
# ** Warning: (vsim-8683) Uninitialized out port /system/MEM/instr_1_Rdst_out(3 downto 0) has no driver.
# This port will contribute value (UUUU) to the signal network.
# ** Warning: (vsim-8683) Uninitialized out port /system/MEM/instr_1_write_back_out has no driver.
# This port will contribute value (U) to the signal network.
# ** Warning: (vsim-8683) Uninitialized out port /system/MEM/instr_1_mem_read_out has no driver.
# This port will contribute value (U) to the signal network.
# ** Warning: (vsim-8683) Uninitialized out port /system/MEM/instr_1_stall_long_out has no driver.
# This port will contribute value (U) to the signal network.
# ** Warning: (vsim-8683) Uninitialized out port /system/MEM/instr_2_Rdst_out(3 downto 0) has no driver.
# This port will contribute value (UUUU) to the signal network.
# ** Warning: (vsim-8683) Uninitialized out port /system/MEM/instr_2_write_back_out has no driver.
# This port will contribute value (U) to the signal network.
# ** Warning: (vsim-8683) Uninitialized out port /system/MEM/instr_2_mem_read_out has no driver.
# This port will contribute value (U) to the signal network.
# ** Warning: (vsim-8683) Uninitialized out port /system/MEM/instr_2_stall_long_out has no driver.
# This port will contribute value (U) to the signal network.
add wave -position insertpoint  \
sim:/system/clk \
sim:/system/rst \
sim:/system/En \
sim:/system/IN_bus \
sim:/system/OUT_bus \
sim:/system/interupt \
sim:/system/clk_inv \
sim:/system/i1 \
sim:/system/i2 \
sim:/system/pc_out \
sim:/system/ir_input \
sim:/system/i1_opcode \
sim:/system/i1_function \
sim:/system/i1_Rsrc \
sim:/system/i1_Rdst \
sim:/system/i2_opcode \
sim:/system/i2_function \
sim:/system/i2_Rsrc \
sim:/system/i2_Rdst \
sim:/system/i1_Rdst_DEC_out \
sim:/system/i1_Rsrc_DEC_out \
sim:/system/i1_branch_taken_DEC_out \
sim:/system/i1_load_use_DEC_out \
sim:/system/i1_Rsrc_data_DEC_out \
sim:/system/i1_Rdst_data_DEC_out \
sim:/system/i1_stall_long_DEC_out \
sim:/system/i1_WB_DEC_out \
sim:/system/i1_MR_DEC_out \
sim:/system/i1_MW_DEC_out \
sim:/system/i1_alu_op_DEC_out \
sim:/system/i2_Rdst_DEC_out \
sim:/system/i2_Rsrc_DEC_out \
sim:/system/i2_branch_taken_DEC_out \
sim:/system/i2_load_use_DEC_out \
sim:/system/i2_Rsrc_data_DEC_out \
sim:/system/i2_Rdst_data_DEC_out \
sim:/system/i2_stall_long_DEC_out \
sim:/system/i2_WB_DEC_out \
sim:/system/i2_MR_DEC_out \
sim:/system/i2_MW_DEC_out \
sim:/system/i2_alu_op_DEC_out \
sim:/system/i1_Rdst_Exec_in \
sim:/system/i1_Rsrc_Exec_in \
sim:/system/i1_branch_taken_Exec_in \
sim:/system/i1_load_use_Exec_in \
sim:/system/i1_Rsrc_data_Exec_in \
sim:/system/i1_Rdst_data_Exec_in \
sim:/system/i1_stall_long_Exec_in \
sim:/system/i1_WB_Exec_in \
sim:/system/i1_MR_Exec_in \
sim:/system/i1_MW_Exec_in \
sim:/system/i1_alu_op_Exec_in \
sim:/system/i2_Rdst_Exec_in \
sim:/system/i2_Rsrc_Exec_in \
sim:/system/i2_branch_taken_Exec_in \
sim:/system/i2_load_use_Exec_in \
sim:/system/i2_Rsrc_data_Exec_in \
sim:/system/i2_Rdst_data_Exec_in \
sim:/system/i2_stall_long_Exec_in \
sim:/system/i2_WB_Exec_in \
sim:/system/i2_MR_Exec_in \
sim:/system/i2_MW_Exec_in \
sim:/system/i2_alu_op_Exec_in \
sim:/system/ex_mem_regWrite_1_Exec_in \
sim:/system/ex_mem_registerRd_1_Exec_in \
sim:/system/mem_wb_regWrite_1_Exec_in \
sim:/system/mem_wb_registerRd_1_Exec_in \
sim:/system/ex_mem_regWrite_2_Exec_in \
sim:/system/ex_mem_registerRd_2_Exec_in \
sim:/system/mem_wb_regWrite_2_Exec_in \
sim:/system/mem_wb_registerRd_2_Exec_in \
sim:/system/ex_mem_Rd_data_out_1_Exec_in \
sim:/system/mem_wb_Rd_data_out_1_Exec_in \
sim:/system/ex_mem_Rd_data_out_2_Exec_in \
sim:/system/mem_wb_Rd_data_out_2_Exec_in \
sim:/system/i1_Rdst_Exec_out \
sim:/system/i1_WB_Exec_out \
sim:/system/i1_stall_long_Exec_out \
sim:/system/i1_MR_Exec_out \
sim:/system/i1_MW_Exec_out \
sim:/system/i1_alu_result_Exec_out \
sim:/system/i2_Rdst_Exec_out \
sim:/system/i2_WB_Exec_out \
sim:/system/i2_stall_long_Exec_out \
sim:/system/i2_MR_Exec_out \
sim:/system/i2_MW_Exec_out \
sim:/system/i2_alu_result_Exec_out \
sim:/system/MEM_sel \
sim:/system/MEM_data \
sim:/system/i1_Rdst_Mem_in \
sim:/system/i1_WB_Mem_in \
sim:/system/i1_stall_long_Mem_in \
sim:/system/i1_MR_Mem_in \
sim:/system/i1_MW_Mem_in \
sim:/system/i1_alu_result_Mem_in \
sim:/system/i2_Rdst_Mem_in \
sim:/system/i2_WB_Mem_in \
sim:/system/i2_stall_long_Mem_in \
sim:/system/i2_MR_Mem_in \
sim:/system/i2_MW_Mem_in \
sim:/system/i2_alu_result_Mem_in \
sim:/system/i1_Rdst_MEM_out \
sim:/system/i1_WB_MEM_out \
sim:/system/i1_MR_MEM_out \
sim:/system/i1_stall_long_MEM_out \
sim:/system/i1_result_MEM_out \
sim:/system/i2_Rdst_MEM_out \
sim:/system/i2_WB_MEM_out \
sim:/system/i2_MR_MEM_out \
sim:/system/i2_stall_long_MEM_out \
sim:/system/i2_result_MEM_out \
sim:/system/i1_Rdst_WB_out \
sim:/system/i1_WB_WB_out \
sim:/system/i1_MR_WB_out \
sim:/system/i1_stall_long_WB_out \
sim:/system/i1_result_WB_out \
sim:/system/i2_Rdst_WB_out \
sim:/system/i2_WB_WB_out \
sim:/system/i2_MR_WB_out \
sim:/system/i2_stall_long_WB_out \
sim:/system/i2_result_WB_out
mem load -filltype value -filldata 0000001000010000 -fillradix binary /system/fetch/inst_ram/my_ram(0)
mem load -filltype value -filldata 0000010000010000 -fillradix binary /system/fetch/inst_ram/my_ram(1)
force -freeze sim:/system/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/system/rst 1 0
force -freeze sim:/system/En 1 0
run
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Instance: /system/fetch
run
run
force -freeze sim:/system/rst 0 0
run