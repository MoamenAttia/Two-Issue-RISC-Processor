vsim -gui work.system
# vsim -gui work.system 
# Start time: 23:37:23 on May 06,2019
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
# Loading work.decode(a_decode)
# Loading work.control_unit(a_control_unit)
# Loading work.register_file(my_register_file)
# Loading work.sp(my_sp)
# Loading work.hazard_unit(a_hazard_unit)
# Loading work.decode_execute_buffer(my_decode_execute_buffer)
# Loading work.execute(a_execute)
# Loading work.forwarding_unit(a_forwarding_unit)
# Loading work.mux(behavioural)
# Loading work.alu(a_alu)
# Loading work.addoperations(addbehavioral)
# Loading work.nadder(a_nadder)
# Loading work.my_adder(a_my_adder)
# Loading work.execute_memory_buffer(my_execute_memory_buffer)
# Loading work.memory(a_memory)
# Loading work.data_ram(a_data_ram)
# Loading work.memory_write_back_buffer(my_memory_write_back_buffer)
# ** Warning: (vsim-8683) Uninitialized out port /system/deocode/i1_branch_taken has no driver.
# This port will contribute value (U) to the signal network.
# ** Warning: (vsim-8683) Uninitialized out port /system/deocode/i1_load_use has no driver.
# This port will contribute value (U) to the signal network.
# ** Warning: (vsim-8683) Uninitialized out port /system/deocode/i2_branch_taken has no driver.
# This port will contribute value (U) to the signal network.
# ** Warning: (vsim-8683) Uninitialized out port /system/deocode/i2_load_use has no driver.
# This port will contribute value (U) to the signal network.
add wave -position insertpoint  \
sim:/system/clk \
sim:/system/rst \
sim:/system/IN_bus \
sim:/system/OUT_bus_data \
sim:/system/interupt
add wave -position insertpoint sim:/system/deocode/Register_file/*
add wave -position insertpoint sim:/system/deocode/Register_file/R0/*
add wave -position insertpoint sim:/system/deocode/Register_file/*

mem load -i {instruction_ram_one_operand.mem} /system/fetch/inst_ram/my_ram

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
run
run
run
run
run
run
run
run
force -freeze sim:/system/IN_bus 0000000000000101 0
run
run
run
run
force -freeze sim:/system/IN_bus 0000000000001010 0
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run


