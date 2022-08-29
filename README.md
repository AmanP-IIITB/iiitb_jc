# iiitb_jc

# Table of contents
 - [1.JOHNSON'S COUNTER](#1-JOHNSON'S-COUNTER)
 - [2.BLOCK DIAGRAM OF JOHNSON'S COUNTER](#2-BLOCK-DIAGRAM-OF-JOHNSON'S-COUNTER)
 - [3.APPLICATIONS OF JOHNSON'S COUNTER](#3-APPLICATIONS-OF-JOHNSON'S-COUNTER)
 - [4.FUNCTIONAL SIMULATION](#4-FUNCTIONAL-SIMULATION)
    - [4.1 About iverilog and gtkwave](#41-About-iverilog-and-gtkwave)
    - [4.2 Installing iverilog and gtkwave](#42-Installing-iverilog-and-gtkwave)
    - [4.3 The output waveform](#43-The-output-waveform)
 - [5.SYNTHESIS](#5-SYNTHESIS)
    - [5.1 Synthesis](#51-Synthesis)
    - [5.2 Yosys Synthesizer](#52-Yosys-Synthesizer)
 - [6.GATE LEVEL SIMULATION](#6-GATE-LEVEL-SIMULATION-(GLS))
 - [7.PHYSICAL DESIGN](#7-PHYSICAL-DESIGN)
    - [7.1 Openlane](#71-Openlane)
    - [7.2 Installation Instructions](#72-Installation-Instructions)
    - [7.3 Magic](#73-Magic)
    - [7.4 Invoking OpenLANE and Design Preparation](#74-Invoking-OpenLANE-and-Design-Preparation)

## 1. JOHNSON'S COUNTER

A Johnson counter is a modified ring counter in which the output from the last flip flop is inverted and fed back as an input to the first. It is also called as Inverse Feedback COunter or Twisted Ring Counter. It is used in hardware logic design to create complicated Finite States Machine (FSM) eg: ASIC and FPGA design. It roughly consumes 80-100 mW of power and runs at a clock frequency of 36 MHz.

## 2. BLOCK DIAGRAM OF JOHNSON'S COUNTER
![8_bit_ring_counter_thumb 4](https://user-images.githubusercontent.com/110079634/181281038-1708f9c6-5df8-4081-8218-e5faf6324e43.gif)

## 3. APPLICATIONS OF JOHNSON'S COUNTER
~ Used as a synchronous decade counter or divider circuit.
  
~ 3 stage Johnson counter is used as a 3 phase square wave generator with 1200 phase shift.


## 4. FUNCTIONAL SIMULATION

### 4.1 About iverilog and gtkwave
- Icarus Verilog is an implementation of the Verilog hardware description language.
- GTKWave is a fully featured GTK+ v1. 2 based wave viewer for Unix and Win32 which reads Ver Structural Verilog Compiler generated AET files as well as standard Verilog VCD/EVCD files and allows their viewing.

### 4.2 Installing iverilog and gtkwave

- **For Ubuntu**

 Open your terminal and type the following to install iverilog and GTKWave
 ```
 $   sudo apt get update
 $   sudo apt get install iverilog gtkwave
 ```

- **To clone the repository and download the netlist files for simulation , enter the following commands in your terminal.**

 ```
 $ git clone https://github.com/AmanP-IIITB/iiitb_jc
 $ cd iiitb_jc
 ```
- **To simulate and run the verilog code , enter the following commands in your terminal.**

```
$ iverilog -o iiitb_jc iiitb_jc.v iiitb_jc_tb.v
$ ./iiitb_rv32i
```
- **To see the output waveform in gtkwave, enter the following commands in your terminal.**

`$ gtkwave iiitb_jc.vcd`

### 4.3 The output waveform

![first_waveform](https://user-images.githubusercontent.com/110079634/187205028-b9a54e1e-c965-49a9-80e2-9af40e598f35.png)


## 5. SYNTHESIS

### 5.1 Synthesis: 
 Synthesis transforms the simple RTL design into a gate-level netlist with all the constraints as specified by the designer. In simple language, Synthesis is a process that converts the abstract form of design to a properly implemented chip in terms of logic gates.

Synthesis takes place in multiple steps:
- Converting RTL into simple logic gates.
- Mapping those gates to actual technology-dependent logic gates available in the technology libraries.
- Optimizing the mapped netlist keeping the constraints set by the designer intact.

### 5.2 Yosys Synthesizer: 
 It is a tool we use to convert out RTL design code to netlist. Yosys is the tool I've used in this project.

The commands to get the yosys is given belw:

```
git clone https://github.com/YosysHQ/yosys.git
make
sudo make install make test
```
Now you need to create a yosys_run.sh file , which is the yosys script file used to run the synthesis.
The contents of the yosys_run file are given below:

```
read_liberty -lib lib/sky130_fd_sc_hd__tt_025C_1v80.lib
read_verilog iiitb_rv32i.v
synth -top iiitb_rv32i	
dfflibmap -liberty lib/sky130_fd_sc_hd__tt_025C_1v80.lib
proc ; opt
abc -liberty lib/sky130_fd_sc_hd__tt_025C_1v80.lib
clean
flatten
write_verilog -noattr iiitb_rv32i_synth.v
```
Now, in the terminal of your verilog files folder, run the following commands:

```
yosys
script yosys_run.sh
```
Now the synthesized netlist is written in "iiitb_jc_synth.v" file.
## 6. GATE LEVEL SIMULATION(GLS)
GLS is generating the simulation output by running test bench with netlist file generated from synthesis as design under test. Netlist is logically same as RTL code, therefore, same test bench can be used for it.We perform this to verify logical correctness of the design after synthesizing it. Also ensuring the timing of the design is met.
Folllowing are the commands to run the GLS simulation:
```
iverilog -DFUNCTIONAL -DUNIT_DELAY=#1 ../verilog_model/primitives.v ../verilog_model/sky130_fd_sc_hd.v iiitb_jc_synth.v iiitb_jc_tb.v
./a.out
gtkwave iiitb_jc.vcd
```
The gtkwave output for the netlist should match the output waveform for the RTL design file. As netlist and design code have same set of inputs and outputs, we can use the same testbench and compare the waveforms.

The output waveform of the synthesized netlist given below:
<img width="1130" alt="synth_waveform" src="![synth_waveform](https://user-images.githubusercontent.com/110079634/187184170-cedf1607-e540-4322-a87a-8c53ffcf81a4.png)">

## 7. PHYSICAL DESIGN 
### 7.1 Openlane
OpenLane is an automated RTL to GDSII flow based on several components including OpenROAD, Yosys, Magic, Netgen, CVC, SPEF-Extractor, CU-GR, Klayout and a number of custom scripts for design exploration and optimization. The flow performs full ASIC implementation steps from RTL all the way down to GDSII.

more at https://github.com/The-OpenROAD-Project/OpenLane
### 7.2 Installation instructions 
```
$   apt install -y build-essential python3 python3-venv python3-pip
```
Docker installation process: https://docs.docker.com/engine/install/ubuntu/

goto home directory->
```
$   git clone https://github.com/The-OpenROAD-Project/OpenLane.git
$   cd OpenLane/
$   sudo make
```
To test the open lane
```
$ sudo make test
```
It takes approximate time of 5min to complete. After 43 steps, if it ended with saying **Basic test passed** then open lane installed succesfully.

### 7.3 Magic
Magic is a venerable VLSI layout tool, written in the 1980's at Berkeley by John Ousterhout, now famous primarily for writing the scripting interpreter language Tcl. Due largely in part to its liberal Berkeley open-source license, magic has remained popular with universities and small companies. The open-source license has allowed VLSI engineers with a bent toward programming to implement clever ideas and help magic stay abreast of fabrication technology. However, it is the well thought-out core algorithms which lend to magic the greatest part of its popularity. Magic is widely cited as being the easiest tool to use for circuit layout, even for people who ultimately rely on commercial tools for their product design flow.

More about magic at http://opencircuitdesign.com/magic/index.html

Run following commands one by one to fulfill the system requirement.

```
$   sudo apt-get install m4
$   sudo apt-get install tcsh
$   sudo apt-get install csh
$   sudo apt-get install libx11-dev
$   sudo apt-get install tcl-dev tk-dev
$   sudo apt-get install libcairo2-dev
$   sudo apt-get install mesa-common-dev libglu1-mesa-dev
$   sudo apt-get install libncurses-dev
```
**To install magic**
goto home directory

```
$   git clone https://github.com/RTimothyEdwards/magic
$   cd magic/
$   ./configure
$   sudo make
$   sudo make install
```
type **magic** terminal to check whether it installed succesfully or not. type **exit** to exit magic.

### 7.4 Invoking OpenLANE and Design Preparation
Openlane can be invoked using docker command followed by opening an interactive session. flow.tcl is a script that specifies details for openLANE flow.
```
docker
./flow.tcl -interactive
package require openlane 0.9
```
```
prep -design picorv32a
```
![S1](https://user-images.githubusercontent.com/110079634/187185793-a4d6f783-3379-4ff3-bfcb-11feee6b3913.png)

```
set lefs [glob $::env(DESIGN_DIR)/src/*.lef]
add_lefs -src $lefs
```
![S2](https://user-images.githubusercontent.com/110079634/187187196-6c442b0f-6d93-4595-8803-316fbe2e263a.png)

### 7.5 Floorplanning
Floor plan determines the size of the design cell (or die), creates the boundary and core area, and creates wire tracks for placement of standard cells. It is also a process of positioning blocks or macros on the die.

To run the iiitb_jc floorplan in openLANE:
```
run_floorplan
```
![S3](https://user-images.githubusercontent.com/110079634/187198913-1d47bef2-4c8a-473f-a417-02f18c016d4d.png)

Post the floorplan run, a .def file will have been created within the results/floorplan directory. We may review floorplan files by checking the floorplan.tcl. The system defaults will have been overriden by switches set in conifg.tcl and further overriden by switches set in sky130A_sky130_fd_sc_hd_config.tcl.

To view the floorplan, Magic is invoked after moving to the results/floorplan directory:
```
magic -T /home/aman/ASIC/OpenLane/pdks/sky130A/libs.tech/magic/sky130A.tech lef read ../../tmp/merged.max.lef read iiitb_jc.def
```

![S4](https://user-images.githubusercontent.com/110079634/187200344-8664b8c3-9b94-4139-975a-58a8c2998fa6.png)

*One can zoom into Magic layout by selecting an area with left and right mouse click followed by pressing "z" key.
*Various components can be identified by using the what command in tkcon window after making a selection on the component.
*Zooming in also provides a view of decaps present in picorv32a chip.
*The standard cell can be found at the bottom left corner.

![S5](https://user-images.githubusercontent.com/110079634/187200922-53f5be93-722e-4731-85c9-c168cd4e9952.png)

![S6](https://user-images.githubusercontent.com/110079634/187200927-0770ef11-198d-4340-9495-766c809f7306.png)

