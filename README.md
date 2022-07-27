# iiitb_jc - Johnson Counter
A Johnson counter is a modified ring counter in which the output from the last flip flop is inverted and fed back as an input to the first. It is also called as Inverse Feedback COunter or Twisted Ring Counter. It is used in hardware logic design to create complicated Finite States Machine (FSM) eg: ASIC and FPGA design. It roughly consumes 80-100 mW of power and runs at a clock frequency of 36 MHz.

![8_bit_ring_counter_thumb 4](https://user-images.githubusercontent.com/110079634/181281038-1708f9c6-5df8-4081-8218-e5faf6324e43.gif)
![cmQ2g](https://user-images.githubusercontent.com/110079634/181285376-8db49220-f999-414a-baef-bca3db1a0470.png)

# Steps to use the Design:

1. Use the following code to download repository in LINUX OS commandline terminal:   
 
                                 git clone https://github.com/AmanP-IIITB/iiitb_jc
 
2. Go to the approriate directory and write this command to compile the verilog files and generate the .out file:
 
                                 iverilog -o jc.out iiitb_jc.v iiitb_jc_tb.v
   
3. Use this code to run the .out file: 
 
                                  ./jc.out
   
 
4. To see the output waveforms, use the following code:
 
                                  gtkwave iiitb_jc.vcd
                                  
 ![IMG_20220727_204520](https://user-images.githubusercontent.com/110079634/181284611-aebcad3c-e342-41cd-b69b-4fe2989d42b1.jpg)
 ![IMG_20220727_233411](https://user-images.githubusercontent.com/110079634/181341966-564b0f18-296e-4225-a9ba-aeecbfa03d4d.jpg)



