vsim -gui work.system
# vsim -gui work.system 
# Start time: 17:03:08 on May 01,2019
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
add wave -position insertpoint  \
sim:/system/clk \
sim:/system/rst \
sim:/system/En \
sim:/system/IN_bus \
sim:/system/OUT_bus_data \
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
sim:/system/flags \
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
sim:/system/i2_result_WB_out \
sim:/system/i1_immediate \
sim:/system/i2_immediate \
sim:/system/immediate_op \
sim:/system/i1_source_dec_out \
sim:/system/OUT_bus
add wave -position insertpoint sim:/system/Execute/fu/*
add wave -position insertpoint sim:/system/Execute/mux1/*
add wave -position insertpoint sim:/system/Execute/mux2/*
add wave -position insertpoint sim:/system/Execute/alu1/*
add wave -position insertpoint sim:/system/deocode/Register_file/*

mem load -filltype value -filldata 0000000000001000 -fillradix binary /system/fetch/inst_ram/my_ram(0)
mem load -filltype value -filldata 0000010000000100 -fillradix binary /system/fetch/inst_ram/my_ram(1)
mem load -filltype value -filldata 0000000000000000 -fillradix binary /system/fetch/inst_ram/my_ram(2)
mem load -filltype value -filldata 0000000000000000 -fillradix binary /system/fetch/inst_ram/my_ram(3)
mem load -filltype value -filldata 0000101000010000 -fillradix binary /system/fetch/inst_ram/my_ram(4)
mem load -filltype value -filldata 0000110000010000 -fillradix binary /system/fetch/inst_ram/my_ram(5)
mem load -filltype value -filldata 0000111000001100 -fillradix binary /system/fetch/inst_ram/my_ram(6)
mem load -filltype value -filldata 0001000000000000 -fillradix binary /system/fetch/inst_ram/my_ram(7)
mem load -filltype value -filldata 0000110000010101 -fillradix binary /system/fetch/inst_ram/my_ram(8)
mem load -filltype value -filldata 0000000000000010 -fillradix binary /system/fetch/inst_ram/my_ram(9)

force -freeze sim:/system/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/system/rst 1 0
force -freeze sim:/system/En 1 0
run
run
run
force -freeze sim:/system/rst 0 0
run