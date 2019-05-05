vsim -gui work.system
add wave -position insertpoint sim:/system/*
add wave -position insertpoint sim:/system/fetch/*
add wave -position insertpoint sim:/system/IR_BUFFER/*
add wave -position insertpoint sim:/system/pc/*
add wave -position insertpoint sim:/system/deocode/*
add wave -position insertpoint sim:/system/dec_exec_BUFFER/*
add wave -position insertpoint sim:/system/Execute/*
add wave -position insertpoint sim:/system/deocode/hazard/*
add wave -position insertpoint sim:/system/IR_BUFFER/*
add wave -position insertpoint sim:/system/exec_mem_BUFFER/*
add wave -position insertpoint sim:/system/MEM/*
add wave -position insertpoint sim:/system/mem_writeback/*
add wave -position insertpoint sim:/system/deocode/controli1_unit/*
add wave -position insertpoint sim:/system/deocode/controli2_unit/*
add wave -position insertpoint sim:/system/deocode/Register_file/*
add wave -position insertpoint sim:/system/deocode/Register_file/SP_1/*
add wave -position insertpoint sim:/system/Execute/alu1/*
add wave -position insertpoint sim:/system/Execute/alu2/*
add wave -position insertpoint sim:/system/Execute/fu/*
add wave -position insertpoint sim:/system/Execute/mux1/*
add wave -position insertpoint sim:/system/Execute/mux2/*
add wave -position insertpoint sim:/system/Execute/mux3/*
add wave -position insertpoint sim:/system/Execute/mux4/*


mem load -i {instruction_ram.mem} /system/fetch/inst_ram/my_ram

force -freeze sim:/system/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/system/rst 1 0
force -freeze sim:/system/En 1 0
run
run
run
force -freeze sim:/system/rst 0 0
force -freeze sim:/system/IN_bus 0019 0
run
run
run
run
run
force -freeze sim:/system/IN_bus ffff 0
run
run
run
run
force -freeze sim:/system/IN_bus F320 0
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
# ** Error: (vsim-86) Argument value -1 is not in bounds of subtype NATURAL.
#    Time: 1200 ps  Iteration: 0  Instance: /system/deocode/Register_file/SP_1
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

