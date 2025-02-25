vlib work
vlog -f srclist.list
vsim -voptargs=+acc work.simpleNPU_tb 
add wave *
add wave -position insertpoint  \
sim:/simpleNPU_tb/dut/fifo_buffer_inst/mem
run -all