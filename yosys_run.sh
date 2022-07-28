‌‌# read design
  
read_verilog iiitb_jc.v

# generic synthesis
synth -top iiitb_jc

# mapping to mycells.lib
dfflibmap -liberty /home/aman/ASIC/iiitb_jc/lib/sky130_fd_sc_hd__tt_025C_1v80
abc -liberty /home/aman/ASIC/iiitb_jc/lib/sky130_fd_sc_hd__tt_025C_1v80
clean
flatten
# write synthesized design
write_verilog -assert iiitb_jc_synth.v
~                                         
