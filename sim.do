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


mem load -filltype value -filldata 0000001000001010 -fillradix binary /system/fetch/inst_ram/my_ram(0)
mem load -filltype value -filldata 0000000000000101 -fillradix binary /system/fetch/inst_ram/my_ram(1)

mem load -filltype value -filldata 0000010000110010 -fillradix binary /system/fetch/inst_ram/my_ram(2)

mem load -filltype value -filldata 0000011001001110 -fillradix binary /system/fetch/inst_ram/my_ram(3)

mem load -filltype value -filldata 0000011100000010 -fillradix binary /system/fetch/inst_ram/my_ram(4)







force -freeze sim:/system/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/system/rst 1 0
force -freeze sim:/system/En 1 0
run
run
run
force -freeze sim:/system/rst 0 0
