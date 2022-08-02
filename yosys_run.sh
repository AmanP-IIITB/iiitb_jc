  
read_verilog /home/aman/ASIC/iiitb_jc/iiitb_jc.v

# generic synthesis
synth -top iiitb_jc

# mapping to mycells.lib
dfflibmap -liberty /home/aman/ASIC/iiitb_jc/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
abc -liberty /home/aman/ASIC/iiitb_jc/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
clean
flatten
# write synthesized design
write_verilog -noattr iiitb_jc_synth.v
                                     
