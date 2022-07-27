# iiitb_jc - Johnson Counter
A Johnson counter is a modified ring counter in which the output from the last flip flop is inverted and fed back as an input to the first. It is also called as Inverse Feedback COunter or Twisted Ring Counter. It is used in hardware logic design to create complicated Finite States Machine (FSM) eg: ASIC and FPGA design. It roughly consumes 80-100 mW of power and runs at a clock frequency of 36 MHz.

![Screenshot_2022_0727_202327](https://user-images.githubusercontent.com/110079634/181279890-9a271248-a5c5-4835-ac2a-260d401092c0.jpg)


# Steps to use the Design:

1. Use the following code to download repository in LINUX OS commandline terminal:
 git clone https://github.com/AmanP-IIITB/iiitb_jc
 
2. Go to the approriate directory and write this command to compile the verilog files and generate the .out file:
   iverilog -o jc.out iiitb_jc.v iiitb_jc_tb.v
   
3. Use this code to run the .out file:
   ./jc.out
   
4. To see the output waveforms, use the following code:
   gtkwave iiitb_jc.vcd
